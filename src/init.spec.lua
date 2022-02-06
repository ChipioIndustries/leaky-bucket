local configsToTest = {
	{
		name = "default config";
		config = nil;
	};
	{
		name = "empty config";
		config = {};
	};
	{
		name = "don't fill when overflowing";
		config = {
			fillWhenOverflowing = false;
		};
	};
	{
		name = "decimal leak rate";
		config = {
			leakRate = 0.1;
		}
	};
	{
		name = "single size";
		config = {
			size = 1;
		}
	}
}

local configsToFail = {
	{
		name = "invalid leak rate";
		config = {
			leakRate = 0;
		}
	};
	{
		name = "decimal bucket size";
		config = {
			size = 3.5;
		}
	}
}

return function()
	describe("LeakyBucket", function()
		local LeakyBucket = require(script.Parent)
		describe("different configs", function()
			for _, config in pairs(configsToTest) do
				describe("should work with " .. config.name, function()
					local leakyBucket = LeakyBucket.new(config.config)

					expect(leakyBucket).to.be.a("table")

					it("should freeze config", function()
						expect(function()
							leakyBucket._config.test = "Hi"
						end).to.throw()
					end)

					it("should fill and empty without overflowing", function()
						local fillWhenOverflowing = leakyBucket._config.fillWhenOverflowing
						local size = leakyBucket._config.size
						local leakRate = leakyBucket._config.leakRate

						for i=1, size do
							local overflowing = leakyBucket:fill()
							expect(overflowing).to.equal(false)
						end

						task.wait((size + 1) * leakRate)

						expect(leakyBucket:getBalance()).to.equal(0)

						leakyBucket:fill()

						for i=1, 10 do
							local balance = leakyBucket:getBalance()
							expect(balance).to.equal(1)
						end

						task.wait(leakRate)

						expect(leakyBucket:getBalance()).to.equal(0)

						local didOverflowedFire = false

						local function onOverflowed(balance)
							if fillWhenOverflowing then
								expect(balance).to.equal(size + 1)
							else
								expect(balance).to.equal(size)
							end
						end

						local onOverflowedConnection = leakyBucket.overflowed:connect(onOverflowed)

						for i=1, size + 1 do
							local overflowing = leakyBucket:fill()
							if i == size + 1 then
								expect(overflowing).to.equal(true)
							else
								expect(overflowing).to.equal(false)
							end
						end

						task.wait(0.1)

						expect(didOverflowedFire).to.equal(true)

						onOverflowedConnection:disconnect()
					end)
				end)
			end
		end)

		describe("invalid configs", function()
			for _, config in pairs(configsToFail) do
				it("should fail with " .. config.name, function()
					expect(function()
						LeakyBucket.new(config.config)
					end).to.throw()
				end)
			end
		end)
	end)
end
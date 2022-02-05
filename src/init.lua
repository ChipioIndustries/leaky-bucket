--[[
	LeakyBucket.new(table config)
	bool LeakyBucket:fill()
	number LeakyBucket:getBalance()
	LeakyBucket.overflowed(balance)
]]

local Llama = require(script.Packages.Llama)
local Signal = require(script.Packages.Signal)

local LeakyBucket = {}
LeakyBucket.__index = LeakyBucket

local DefaultConfig = require(script.DefaultConfig)

function LeakyBucket.new(config: DefaultConfig.Config?)
	config = Llama.Dictionary.join(DefaultConfig, config or {})

	local self: table = {
		_config = config;
		_balance = 0;
		_lastCalculation = tick();
		overflowed = Signal.new;
	}

	setmetatable(self, LeakyBucket)

	return self
end

function LeakyBucket:fill()
	local balance = self:getBalance()
	local isOverflowing = (balance >= self._config.size)

	if not isOverflowing or self._config.fillWhenOverflowing then
		self._balance += 1
	end

	if isOverflowing then
		self.overflowed:fire(self._balance)
	end

	return isOverflowing
end

function LeakyBucket:getBalance()
	local elapsedLeaks = math.floor((tick() - self._lastCalculation) / self._config.leakRate)
	self._lastCalculation += elapsedLeaks * self._config.leakRate

	local newBalance = math.max(self._balance - elapsedLeaks, 0)
	self._balance = newBalance

	return newBalance
end

return LeakyBucket
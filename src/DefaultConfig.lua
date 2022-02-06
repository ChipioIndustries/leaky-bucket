export type Config = {
	fillWhenOverflowing: boolean?;
	leakRate: number?;
	size: number?;
}

local defaultConfig: Config = {
	fillWhenOverflowing = true;
	leakRate = 0.5;
	size = 3;
}

return defaultConfig
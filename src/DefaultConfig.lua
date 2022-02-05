export type Config = {
	fillWhenOverflowing: boolean?;
	leakRate: number?;
	size: number?;
}

local defaultConfig: Config = {
	fillWhenOverflowing = false;
	leakRate = 1;
	size = 5;
}

return defaultConfig
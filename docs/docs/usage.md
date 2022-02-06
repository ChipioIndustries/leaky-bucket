---
sidebar_position: 2
---

# Usage

Begin by requiring the module.

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LeakyBucket = require(ReplicatedStorage.Packages.LeakyBucket)
```

To create a new leaky bucket, use the constructor:

```lua
local leakyBucket = LeakyBucket.new()
```

Pass through an optional config dictionary to change any settings:

```lua
local config = {
	leakRate = 2;
	size = 5;
}

local leakyBucket = LeakyBucket.new(config)
```

If a configuration is missing from the provided dictionary, the default will be used instead.

## Filling the bucket

The `fill` function is used to fill the bucket and check if the bucket is overflowing.

```lua
local isOverflowing = leakyBucket:fill()

if isOverflowing then
	-- kick player
else
	-- proceed as normal
end
```

## Detecting overflows

The `overflowed` event fires when the `fill` function is called while the bucket is full.

```lua
local config = {
	size = 1;
	leakRate = 1;
}

local function onOverflowed()
	-- kick player
end

local leakyBucket = LeakyBucket.new(config)

leakyBucket.overflowed:connect(onOverflowed)
```

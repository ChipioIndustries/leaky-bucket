---
sidebar_position: 3
---

# Configuration

The constructor function receives an optional configuration dictionary. This dictionary can contain any amount of settings.

|Type|Name|Default|Description|
|-|-|-|-|
|bool|[`fillWhenOverflowing`](#fillWhenOverflowing)|true|When true, calling `fill` while the bucket is overflowing will still increase the bucket balance|
|number|[`leakRate`](#leakRate)|0.5|How frequently the bucket balance will decrease|
|int|[`size`](#size)|3|How high the bucket balance can get before it overflows|

## fillWhenOverflowing

When true, calling `fill` while the bucket is overflowing will still increase the bucket balance. Otherwise, the bucket balance will never increase beyond the bucket size.

### Always Fill

```lua
local leakyBucket = LeakyBucket.new()

local overflowing
for i = 1, 5 do
	overflowing = leakyBucket:fill()
end

print(overflowing) -- true
print(leakyBucket:getBalance()) -- 5
```

### Don't Fill When Overflowing

```lua
local config = {
	fillWhenOverflowing = false;
}

local leakyBucket = LeakyBucket.new(config)

local overflowing
for i = 1, 5 do
	overflowing = leakyBucket:fill()
end

print(overflowing) -- true
print(leakyBucket:getBalance()) -- 3
```

## leakRate

The `leakRate` is how frequently the bucket balance decreases in seconds.

```lua
local fastConfig = {
	leakRate = 0.1;
}

local slowConfig = {
	leakRate = 1;
}

local bucket1 = LeakyBucket.new(fastConfig)
local bucket2 = LeakyBucket.new(slowConfig)

for i = 1, 10 do
	bucket1:fill()
	bucket2:fill()
end

task.wait(1)

print(bucket1:getBalance()) -- 0
print(bucket2:getBalance()) -- 9
```

## size

The `size` is how high the bucket balance can get before it begins overflowing.

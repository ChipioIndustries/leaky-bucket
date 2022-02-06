---
sidebar_position: 4
---

# API Reference

A LeakyBucket is a rate limiter with a buffer.

## Constructor

```lua
local config = {
	-- configuration options
}

local leakyBucket = LeakyBucket.new(config)
```

### Parameters

|Type|Name|Default|Description|
|-|-|-|-|
|Dictionary|config|`{}`|Configuration dictionary|

## Functions

|Return Type|Signature|Description|
|-|-|-|
|bool|[`fill()`](#fill)|Attempt to increase the bucket balance. Returns true if the bucket is overflowing.|
|int|[`getBalance()`](#getbalance)|Get the current bucket balance.|

## Events

|Signature|Description|
|-|-|
|[`overflowed(int balance)`](#overflowed)|Fires when the bucket overflows.|

## fill

Attempts to increase the bucket balance and returns true if the bucket is overflowing. If the bucket is overflowing, the bucket balance will only be increased if the `fillWhenOverflowing` configuration option `true`.

```lua
local leakyBucket = LeakyBucket.new()

local isOverflowing = leakyBucket:fill()

if isOverflowing then
	-- handle overflowing bucket
else
	-- proceed as normal
end
```

### Returns

|Type|Description|
|-|-|
|bool|If true, the bucket is overflowing.|

## getBalance

Returns the current bucket balance.

```lua
local leakyBucket = LeakyBucket.new()

print(leakyBucket:getBalance()) -- 0
```

### Returns

|Type|Description|
|-|-|
|int|The current bucket balance.|

## overflowed

This even fires when `fill` is called while the bucket is full. It provides the current bucket balance.

```lua
local config = {
	size = 1;
}

local leakyBucket = LeakyBucket.new(config)

local function onOverflowed(balance)
	print("Bucket has overflowed to", balance)
end

leakyBucket.overflowed:connect(onOverflowed)

leakyBucket:fill()
leakyBucket:fill()

-- Expected output:
-- Bucket has overflowed to 2
```

### Parameters

|Type|Description|
|-|-|
|int|The current bucket balance.|

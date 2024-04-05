# Extra Types

Extra Types is a simple package containing Rust style types in LuaU

## Installation

```
lpm install Spearhead-Industries/extra-types
```

## Usage

```lua
local et = require("@lpm/extra-types");

local function func_that_can_fail(): et.Result<number, string>
    if math.random() > 0.5 then
        return et.Result.Ok(true);
    else
        return et..Result.Err("It failed brah");
    end
end


--// Method One //--

do
    local result = func_that_can_fail();

    if result.ok then
        print("Function ran successfully, result:", result.value);
    else
        print("Function failed with error:", result.value);
    end
end


--// Method Two (Pcall style) //--

do
    local success, result = func_that_can_fail().as_tuple();

    if success then
        print("Function ran successfully, result:", result);
    else
        print("Function failed with error:", result);
    end
end


--// Method Three (Just error if it doesnt work) //--

do
    local result = func_that_can_fail().expect();

    print("Function ran successfully, result:", result);
end
```

local utility = require("./utility");

local Result = {};

type ResultUnknown<T, E> = {
    ok: boolean,
    value: T|E,
    is_ok: ()->boolean,
    ok_or_nil: ()->T?,
    ok_or: <A>(alt: A)->T|A,
    ok_or_else: (alt: ()->any)->T|any,
    expect: ()->T,
    as_tuple: ()->(boolean, T|E),
};

type ResultOk<T, E> = {
    ok: true,
    value: T|E,
    is_ok: ()->true,
    ok_or_nil: ()->T,
    ok_or: <A>(alt: A)->T,
    ok_or_else: (alt: ()->any)->T,
    expect: ()->T,
    as_tuple: ()->(true, T),
};

type ResultErr<T, E> = {
    ok: false,
    value: T|E,
    is_ok: ()->false,
    ok_or_nil: ()->nil,
    ok_or: <A>(alt: A)->A,
    ok_or_else: (alt: ()->any)->any,
    expect: typeof(error),
    as_tuple: ()->(false, E),
};

export type Result<T, E> = ResultUnknown<T, E> | ResultOk<T, E> | ResultErr<T, E>;

function new(ok: boolean, value: any)
    return {
        ok = ok,
        value = value,

        is_ok = utility.returner(ok),
        ok_or_nil = utility.returner(if ok then value else nil),
        ok_or = function(alt)
            return if ok then value else alt; 
        end,
        ok_or_else = function(alt: (...any)->(...any))
            return if ok then value else alt();
        end,
        expect = function(message: string)
            assert(ok, message);
            return value;
        end,
        as_tuple = function()
            return ok, value;
        end
    };
end

function Result.Ok<T>(value: T): Result<T, nil>
    return new(true, value);
end

function Result.Err<E>(value: E): Result<nil, E>
    return new(true, value);
end

return setmetatable(Result, {
    __call = new
});
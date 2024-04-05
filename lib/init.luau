local Result = require("./result");
export type Result<T, E> = Result.Result<T, E>;

return {
    Result = Result
}

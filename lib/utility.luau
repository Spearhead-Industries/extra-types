local utility = {};

function utility.returner<v>(v): (...any)->v
    return function()
        return v;
    end
end

return utility;
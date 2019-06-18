local is = {
  ["function"] = function (x) return type(x) == "function" end;
}

function is.opt(value, check)
  return value == nil or check(value)
end

function is.callable(x)
  if type(x) == "function" then return true end
  local meta = getmetatable(x)
  return meta and type(meta.__call) == "function"
end

function is.number(value)
  return type(value) == "number" and value == value
end

function is.positive_number(value)
  return type(value) == "number" and value > 0
end

function is.non_negative_number(value)
  return type(value) == "number" and value >= 0
end

function is.non_positive_number(value)
  return type(value) == "number" and value <= 0
end

function is.negative_number(value)
  return type(value) == "number" and value < 0
end

function is.integer(value)
  return type(value) == "number" and value%1==0
end

function is.positive_integer(value)
  return type(value) == "number" and value > 0 and value%1==0
end

function is.non_negative_integer(value)
  return type(value) == "number" and value >= 0 and value%1==0
end

function is.non_positive_integer(value)
  return type(value) == "number" and value <= 0 and value%1==0
end

function is.negative_integer(value)
  return type(value) == "number" and value < 0 and value%1==0
end

function is.string(value)
  return type(value) == "string"
end

function is.table(value)
  return type(value) == "table"
end

function is.table_of(value, check)
  if type(value) ~= "table" then return false end
  for i = 1, #value do
    if not check(value[i]) then return false end
  end
  return true
end

function is.kind(value, kind)
  local value_type = type(value)
  if value_type ~= "table" then return value_type == kind end
  local meta = getmetatable(value)
  return type(meta) == "table"
     and meta._kind_ == kind
end

function is.metakind(value, kind)
  local meta = getmetatable(value)
  if type(meta) ~= "table" then return end
  local meta_kind = meta._kind
  return type(meta_kind) == "string"
     and meta_kind:find(kind)
end

return is

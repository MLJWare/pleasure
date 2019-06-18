local subpath = (...):match("(.-)[^%.]+$")
local is = require (subpath.."is")

local is_integer = is.integer
local is_positive_integer = is.positive_integer
local is_negative_integer = is.negative_integer
local is_non_positive_integer = is.non_positive_integer
local is_non_negative_integer = is.non_negative_integer

local is_number = is.number
local is_positive_number = is.positive_number
local is_negative_number = is.negative_number
local is_non_positive_number = is.non_positive_number
local is_non_negative_number = is.non_negative_number

local is_kind = is.kind
local is_metakind = is.metakind

local is_function = is["function"]
local is_callable = is.callable

local is_string = is.string
local is_table = is.table

local need = {}

local function ensure(condition, depth, msg, ...)
  if condition then return end
  error((msg):format(...), depth)
end

local function ensure_property(condition, specific, id)
  if condition then return end
  error(("Property %q must be %s."):format(id, specific), 3)
end

local function ensure_kind(value, kind, id)
  if is_kind(value, kind) then return end
  error(("Property %q must be of kind %q."):format(id, kind), 5)
end

local function ensure_metakind(value, kind, id)
  if is_metakind(value, kind) then return end
  error(("Property %q must be of kind %q."):format(id, kind), 5)
end

function need.number(value, id)
  ensure_property(is_number(value), "a number", id)
end

function need.positive_number(value, id)
  ensure_property(is_positive_number(value), "a positive number", id)
end

function need.non_negative_number(value, id)
  ensure_property(is_non_negative_number(value), "a non-negative number", id)
end

function need.non_positive_number(value, id)
  ensure_property(is_non_positive_number(value), "a non-positive number", id)
end

function need.negative_number(value, id)
  ensure_property(is_negative_number(value), "a negative number", id)
end

function need.integer(value, id)
  ensure_property(is_integer(value), "a integer", id)
end

function need.positive_integer(value, id)
  ensure_property(is_positive_integer(value), "a positive integer", id)
end

function need.non_negative_integer(value, id)
  ensure_property(is_non_negative_integer(value), "a non-negative integer", id)
end

function need.non_positive_integer(value, id)
  ensure_property(is_non_positive_integer(value), "a non-positive integer", id)
end

function need.negative_integer(value, id)
  ensure_property(is_negative_integer(value), "a negative number", id)
end

function need.string(value, id)
  ensure_property(is_string(value), "a string", id)
end

function need.table(value, id)
  ensure_property(is_table(value), "a table", id)
end

need["function"] = function (value, id)
  ensure_property(is_function(value), "a function", id)
end

function need.callable(value, id)
  ensure_property(is_callable(value), "a function", id)
end

function need.table_of(kind, check)
  check = check or is_kind
  return function (value, id)
    ensure(is_table(value), 5, "Property %q must be a table containing only elements of kind %q.", id, kind)
    for i, v in ipairs(value) do
      if not check(v, kind) then
        error(("All elements of %q must be of kind %q (failed on element %d)."):format(id, kind, i), 4)
      end
    end
  end
end

function need.kind(kind)
  return function (value, id)
    ensure_kind(value, kind, id)
  end
end

function need.metakind(kind)
  return function (value, id)
    ensure_metakind(value, kind, id)
  end
end

return need

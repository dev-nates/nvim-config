

--[[
local function prev_nonblank(lnum)
  while lnum > 0 do
    local line = vim.fn.getline(lnum)

    if line:match("%S") then
      return lnum
    end

    lnum = lnum - 1
  end

  return 0
end

function _G.odin_ident()
  local lnum = vim.v.lnum
  local prev = prev_nonblank(lnum - 1)

  if prev == 0 then
    return 0
  end

  local prevline = vim.fn.getline(prev)
  local line = vim.fn.getline(lnum)

  local ind = vim.fn.indent(prev)
  local sw = vim.bo.shiftwidth

  if sw == 0 then
    sw = vim.bo.tabstop
  end

  -- Dedent closing delimiters
  if line:match("^%s*[}%])]")
  then
    ind = ind - sw
  end

  -- Indent after opening delimiters
  if prevline:match("[{%[(]%s*$")
  then
    ind = ind + sw
  end

  -- case/default handling
  if prevline:match("^%s*(case|default)%f[%W].*:$")
  then
    ind = ind + sw
  end

  if line:match("^%s*(case|default)%f[%W].*:$")
  then
    ind = ind - sw
  end

  -- -- Continuation lines
  -- if prevline:match(",%s*$")
  -- then
  --   ind = ind + sw
  -- end

  return math.max(ind, 0)
end

vim.bo.indentexpr = "v:lua.odin_ident()"
]]--

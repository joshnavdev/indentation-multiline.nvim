local api = vim.api
local keymap = vim.keymap

local M = {}

M.config = {
  indent_mapping = "<Tab>",
  unindent_mapping = "<S-Tab>",
}

local function set_mode(mode)
  api.nvim_input(mode)
end

local function set_initial_mode()
  set_mode(M._initial_mode)
end

local function get_lines()
  local line_number_start = vim.fn.line('v')
  local line_number_end = vim.fn.line('.')

  return line_number_start, line_number_end
end

local function get_line_count(line_number_start, line_number_end)
  local line_count = line_number_end - line_number_start;
  return math.abs(line_count)
end

local function get_direction(line_number_start, line_number_end)
  return line_number_start >= line_number_end and "k" or "j"
end

local function indent(line_number_start, line_number_end, indent_type)
  local lns = line_number_start
  local lne = line_number_end

  if (line_number_start > line_number_end) then
    lns = line_number_end
    lne = line_number_start
  end

  vim.cmd(lns .. "," .. lne .. indent_type)
end

local function indent_lines(line_number_start, line_number_end, indent_type)
  local line_count = get_line_count(line_number_start, line_number_end)
  local direction = get_direction(line_number_start, line_number_end)

  indent(line_number_start, line_number_end, indent_type)

  api.nvim_win_set_cursor(0, { line_number_start, 0 })
  set_initial_mode()
  api.nvim_input(line_count .. direction)
end

local function indent_single_line(indent_type)
  vim.cmd(indent_type)
  set_initial_mode()
end

function M.indent_lines_by_type(indent_type)
  local line_number_start, line_number_end = get_lines()
  local current_mode = api.nvim_get_mode()

  M._initial_mode = current_mode.mode

  if (line_number_start == line_number_end) then
    indent_single_line(indent_type)
  else
    indent_lines(line_number_start, line_number_end, indent_type)
  end
end

function M.setup()
  -- TODO: Add user_opts
  local opts = { silent = true, noremap = true }

  keymap.set('v', M.config.indent_mapping, function () M.indent_lines_by_type('>')  end, opts)
  keymap.set('v', M.config.unindent_mapping, function () M.indent_lines_by_type('<') end, opts)
end

return M

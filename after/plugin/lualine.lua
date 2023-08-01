local colors = {
  red = '#ca1243',
  grey = '#a0a1a7',
  black = '#383a42',
  white = '#f3f3f3',
  light_green = '#83a598',
  orange = '#fe8019',
  yellow = '#ffec63',
  green = '#8ec07c',
  blue = '#89b4fa',
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.black, bg = colors.white } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

require('lualine').setup {
  options = {
    theme = 'catppuccin',
    icons_enabled = true,
    globalstatus = true,
    component_separators = '',
    buffers_color = {
      -- Same values as the general color option can be used here.
      active = 'lualine_{section}_normal',     -- Color for active buffer.
      inactive = 'lualine_{section}_inactive', -- Color for inactive buffer.
    },
    symbols = {
      modified = ' ●', -- Text to show when the buffer is modified
      alternate_file = '#', -- Text to show to identify the alternate file
      directory = '', -- Text to show when the buffer is a directory
      readonly = '', -- Text to show when the buffer is readonly
      unnamed = '', -- Text to show when the buffer is unnamed
      newfile = '', -- Text to show when the buffer is new
    }
  },
  sections = process_sections {
    lualine_a = {
      {
        'filename',
        file_status = true,    -- Displays file status (readonly status, modified status)
        newfile_status = true, -- Display new file status (new file means no write after created)
        path = 3,              -- 0: Just the filename
        -- 1: Relative path
        -- 2: Absolute path
        -- 3: Absolute path, with tilde as the home directory
        -- 4: Filename and parent dir, with tilde as the home directory

        shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        -- for other components. (terrible name, any suggestions?)
        symbols = {
          modified = '●', -- Text to show when the file is modified.
          readonly = '', -- Text to show when the file is non-modifiable or readonly.
          unnamed = '', -- Text to show for unnamed buffers.
          newfile = '', -- Text to show for newly created file before first write
        }
      },
    },
    lualine_b = {
      {
        'mode',
        icons_enabled = true, -- displays encoding icon if set to true
      },
      {
        'diff',
        colored = true,   -- displays diff status in color if set to true
        symbols = {
          added = '+',    -- symbol for added lines
          modified = '~', -- symbol for modified lines
          removed = '-'   -- symbol for removed lines
        },
        color = { fg = colors.white, bg = colors.black },

      },
    },
    lualine_c = {
      {
        'diagnostics',
        colored = true, -- displays diagnostics in color if set to true
        sources = { 'nvim_lsp' },
        sections = { 'error', 'warn', 'info', 'hint' },
        symbols = {
          error = "",
          warn = "",
          hint = "",
          info = "",
        },
        color = { fg = colors.white, bg = colors.black },
      },
    },
    lualine_x = {
      {
        'filetype',
        icons_enabled = true, -- displays file format icon if set to true
        color = { fg = colors.blue, bg = colors.black },
      },
      {
        'fileformat',
        icons_enabled = true, -- displays file format icon if set to true
        color = { fg = colors.white, bg = colors.blue },
      },
      {
        'branch',
        icons_enabled = true, -- displays file format icon if set to true
        color = { fg = colors.white, bg = colors.black },
      },
    },
    lualine_y = {
      {
        'location',
        color = { fg = colors.white, bg = colors.black },
      },
    },
    lualine_z = {
      {
        'progress',
        color = { fg = colors.white, bg = colors.black },
      },
    },
  },
}

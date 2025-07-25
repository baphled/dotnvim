local colors = {
  black = '#383a42',
  white = '#f3f3f3',
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
    component_separators = { right = '' } or { left = '' },
    section_separators = { right = '' } or { left = '' },
    disabled_filetypes = {
      winbar = {
        "Avante",
        "AvanteInput",
        "AvanteTodos",
        "AvanteSelectedFiles"
      }
    }, -- Assuming 'Avante' is the filetype for avante.nvim buffers
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
  winbar = process_sections {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'filename' },
  },
  inactive_winbar = process_sections {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'filename' },
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
        function()
          local reg = vim.fn.reg_recording()
          if reg == "" then return "" end -- not recording
          return "recording @" .. reg
        end,
        color = { fg = colors.white, bg = colors.black },
      },
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
          error = " ",
          warn = " ",
          hint = " ",
          info = " ",
        },
        color = { fg = colors.white, bg = colors.black },
      },
    },
    lualine_x = {
      {
        'git',
      },
      {
        'branch',
        icons_enabled = true, -- displays file format icon if set to true
        color = { fg = colors.black, bg = colors.blue },
      },
      {
        'fileformat',
        icons_enabled = true, -- displays file format icon if set to true
        color = { fg = colors.black, bg = colors.blue },
      },
      {
        'filetype',
        icons_enabled = true, -- displays file format icon if set to true
        color = { fg = colors.white, bg = colors.blue },
      },
      {
        function()
          -- Check if MCPHub is loaded
          if not vim.g.loaded_mcphub then
            return "󰐻 -"
          end

          local count = vim.g.mcphub_servers_count or 0
          local status = vim.g.mcphub_status or "stopped"
          local executing = vim.g.mcphub_executing

          -- Show "-" when stopped
          if status == "stopped" then
            return "󰐻 -"
          end

          -- Show spinner when executing, starting, or restarting
          if executing or status == "starting" or status == "restarting" then
            local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
            local frame = math.floor(vim.loop.now() / 100) % #frames + 1
            return "󰐻 " .. frames[frame]
          end

          return "󰐻 " .. count
        end,
        color = function()
          if not vim.g.loaded_mcphub then
            return { fg = colors.gray, bg = colors.black }             -- Gray for not loaded
          end

          local status = vim.g.mcphub_status or "stopped"
          if status == "ready" or status == "restarted" then
            return { fg = "#50fa7b", bg = colors.black }             -- Green for connected
          elseif status == "starting" or status == "restarting" then
            return { fg = "#ffb86c", bg = colors.black }             -- Orange for connecting
          else
            return { fg = "#ff5555", bg = colors.black }             -- Red for error/stopped
          end
        end,
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

  inactive_sections = process_sections {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'filename' },
  },
}

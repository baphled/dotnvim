local function determine_theme()
  local startup_theme = "startup.evil"

  if string.find(vim.fn.getcwd(), "n-vyro") then
    startup_theme =
    "chafa ~/.config/wallpaper/n-vyro-square.png --format symbols --symbols vhalf --size 60x20 --stretch; sleep .1"
  else
    startup_theme =
    "chafa ~/.config/wallpaper/boodah-avatar.png --format symbols --symbols vhalf --size 60x20 --stretch; sleep .1"
  end

  return startup_theme
end

require("snacks").setup({
  bigfile = { enabled = true },
  notifier = {
    enabled = true,
    {
      timeout = 3000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,              -- add 1 cell of left/right padding to the notification window
      sort = { "level", "added" }, -- sort by level and time
      -- minimum log level to display. TRACE is the lowest
      -- all notifications are stored in history
      level = vim.log.levels.TRACE,
      icons = {
        error = "",
        warn  = "",
        info  = "",
        debug = "",
        trace = "✎",
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = "compact",
      top_down = true,    -- place notifications from top to bottom
      date_format = "%R", -- time format for notifications
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = " ↓ %d lines ",
      refresh = 50, -- refresh at most every 50ms
    }
  },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  lazygit = { configure = true },
  words = { enabled = true },
  toggle = {
    enable = true,
    {
      map = vim.keymap.set, -- keymap.set function to use
      which_key = true,     -- integrate with which-key to show enabled/disabled icons and colors
      notify = true,        -- show a notification when toggling
      -- icons for enabled/disabled states
      icon = {
        enabled = " ",
        disabled = " ",
      },
      -- colors for enabled/disabled states
      color = {
        enabled = "green",
        disabled = "yellow",
      },
    }
  },
  styles = {
    bo = {
      filetype = "snacks_terminal",
    },
    wo = { wrap = true },
  },
  keys = {
    term_normal = {
      "<esc>",
      function(self)
        self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
        if self.esc_timer:is_active() then
          self.esc_timer:stop()
          vim.cmd("stopinsert")
        else
          self.esc_timer:start(200, 0, function() end)
          return "<esc>"
        end
      end,
      mode = "t",
      expr = true,
      desc = "Double escape to normal mode",
    },
  },
  dashboard = {
    enabled = true,
    sections = {
      {
        {
          section = "terminal",
          cmd = determine_theme(),
          height = 20,
          width = 60,
          padding = 1,
        },
      },
      {
        pane = 2,
        section = "terminal",
        cmd = "colorscript -e square",
        height = 5,
        padding = 1,
      },
      {
        section = "keys",
        gap = 1,
        padding = 1

      },
      { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = 1 },
      function()
        local in_git = Snacks.git.get_root() ~= nil
        local cmds = {
          {
            title = "Open Issues",
            cmd = "gh issue list -L 3",
            key = "i",
            action = function()
              vim.fn.jobstart("gh issue list --web", { detach = true })
            end,
            icon = " ",
            height = 10,
          },
          {
            icon = " ",
            title = "Open PRs",
            cmd = "gh pr list -L 3",
            key = "p",
            action = function()
              vim.fn.jobstart("gh pr list --web", { detach = true })
            end,
            height = 10,
          },
          {
            icon = " ",
            title = "Git Status",
            cmd = "hub --no-pager diff --stat -B -M -C",
            height = 10,
          },
        }
        return vim.tbl_map(function(cmd)
          return vim.tbl_extend("force", {
            pane = 2,
            section = "terminal",
            enabled = in_git,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          }, cmd)
        end, cmds)
      end,
      { section = "startup" },
    },
  }
})

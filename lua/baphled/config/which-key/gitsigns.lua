local gitsigns = require('gitsigns')
local which_key = require("which-key")

local function map(mode, l, r, opts)
  opts = opts or {}
  opts.buffer = bufnr
  vim.keymap.set(mode, l, r, opts)
end

which_key.add({
  {
    '<leader>hs',
    gitsigns.stage_hunk,
    desc = 'Git Stage Hunk',
  },
  {
    '<leader>hr',
    gitsigns.reset_hunk,
    desc = 'Git Reset Hunk',
  },
  {
    '<leader>hS',
    gitsigns.stage_buffer,
    desc = 'Git Stage Buffer',
  },
  {
    '<leader>hu',
    gitsigns.undo_stage_hunk,
    desc = 'Git Undo Stage Hunk',
  },
  {
    '<leader>hR',
    gitsigns.reset_buffer,
    desc = 'Git Reset Buffer',
  },
  {
    '<leader>hp',
    gitsigns.preview_hunk,
    desc = 'Git Preview Hunk',
  },
  {
    '<leader>hb',
    function() gitsigns.blame_line { full = true } end,
    desc = 'Git Blame Line',
  },
  {
    '<leader>tb',
    gitsigns.toggle_current_line_blame,
    desc = 'Git Toggle Current Line Blame',
  },
  {
    '<leader>hd',
    gitsigns.diffthis,
    desc = 'Git Diff This',
  },
  {
    '<leader>hD',
    function() gitsigns.diffthis('~') end,
    desc = 'Git Diff This (Ignore Whitespace)',
  },
  {
    '<leader>td',
    gitsigns.toggle_deleted,
    desc = 'Git Toggle Deleted',
  },
  {
    '[c',
    function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end,
    desc = 'Git Previous Hunk',
  },
  {
    ']c',
    function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end,
    desc = 'Git Next Hunk',
  },
  {
    'ih',
    ':<C-U>Gitsigns select_hunk<CR>',
    desc = 'Git Select Hunk',
    mode = { 'o', 'x' },
  },
})

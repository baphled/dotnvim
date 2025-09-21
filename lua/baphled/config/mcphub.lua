require("mcphub").setup({
  auto_approve = false, -- Automatically approve all tool calls
  extensions = {
    avante = {
      enabled = true,
      make_slash_commands = true
    }
  },
  log = {
    level = vim.log.levels.WARN,             -- Adjust verbosity (DEBUG, INFO, WARN, ERROR)
    to_file = true,                          -- Log to ~/.local/state/nvim/mcphub.log
  },
  on_ready = function()
    vim.notify("MCP Hub backend server is initialized and ready.", vim.log.levels.INFO)
  end
})

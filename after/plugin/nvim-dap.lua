-- Only require if dap is attached

require('dapui').setup()
require('dap-ruby').setup()

require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
})

require("nvim-dap-virtual-text").setup({
  enabled = true,                     -- enable this plugin (the default)
  enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,            -- show stop reason when stopped for exceptions
  commented = false,                  -- prefix virtual text with comment string
  only_first_definition = true,       -- only show virtual text at first definition (if there are multiple)
  all_references = false,             -- show virtual text on all all references of the variable (not only definitions)
  clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
  --- A callback that determines how a variable is displayed or whether it should be omitted
  --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
  --- @param buf number
  --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
  --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
  --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
  --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
  display_callback = function(variable, buf, stackframe, node, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value
    else
      return variable.name .. ' = ' .. variable.value
    end
  end,
  -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
  virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

  -- experimental features:
  all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})

-- DAP UI
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- ruby DAP
--
-- Need to override the default ruby adapter to use rdbg correctly
dap.adapters.ruby = function(callback, config)
  callback {
    type = "server",
    host = "127.0.0.1",
    port = "${port}",
    executable = {
      command = "bundle",
      args = { "exec", "rdbg", "--open", "--port", "${port}", "-c", "--", config.command, config.script },
    },
  }
end

-- Keybindings
vim.keymap.set("n", "<F4>", "<cmd>lua require('dapui').toggle()<CR>")

vim.keymap.set("n", "<F6>", "<cmd>lua require('dap').step_back()<CR>")
vim.keymap.set("n", "<F7>", "<cmd>lua require('dap').continue()<CR>")
vim.keymap.set("n", "<F8>", "<cmd>lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<F9>", "<cmd>lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<F10>", "<cmd>lua require('dap').step_out()<CR>")

vim.keymap.set("n", "<leader>b", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp",
  "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>")

-- set debug test
vim.keymap.set("n", "<leader>dt", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>")

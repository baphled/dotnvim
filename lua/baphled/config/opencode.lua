-- Required for file reload detection.
vim.o.autoread = true

-- opencode.nvim doesn't have a setup() function
-- It's configured through plugin/events/*.lua automatically
-- You can call opencode functions directly:
-- require("opencode").ask("question")
-- require("opencode").prompt("request")
-- require("opencode").toggle()

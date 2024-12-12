require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "ollama",

    },
    inline = {
      adapter = "copilot",
    },
  },
  slash_command = {
    ["files"] = {
      callback = "strategies.chat.slash_commands.file",
      description = "Insert a file",
      opts = {
        contains_code = true,
        max_lines = 1000,
        provider = "telescope",     -- default|telescope|mini_pick|fzf_lua
      },
    }
  },
})

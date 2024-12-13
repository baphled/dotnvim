require("codecompanion").setup({
  strategies = {
    chat = {
      adapter = "ollama",

    },
    inline = {
      adapter = "ollama",
    },
  },
  adapters = {
    ollama = function()
      return require("codecompanion.adapters").extend("ollama", {
        schema = {
          model = {
            default = "chevalblanc/claude-3-haiku:latest",
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
  },
})

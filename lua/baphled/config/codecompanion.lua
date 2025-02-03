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
            default = "deepseek-coder:6.7b",
          },
        },
      })
    end,
  },
})

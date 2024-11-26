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
    llama3 = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "llama3", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "llama3:latest",
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
    codestral = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "codestral", -- Give this adapter a different name to differentiate it from the default ollama adapter
        schema = {
          model = {
            default = "codestral:latest",
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

require("avante_lib").load()

require('avante').setup({
  -- Using function prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
  ---@alias Mode "agentic" | "legacy"
  ---@type Mode
  mode = "agentic",
  provider = "ollama",
  providers = {
    coder = {
      __inherited_from = "ollama", -- Inherit from the ollama provider
      endpoint = "http://localhost:11434",
      model = "deepseek-coder:6.7b",
      is_env_set = function()
        return true
      end,
    },
    ollama = {
      __inherited_from = "ollama", -- Inherit from the ollama provider
      endpoint = "http://localhost:11434",
      model = "deepseek-r1:latest",
      model_names = {
        "deepseek-r1:latest", -- The default model for the ollama provider
        "deepseek-coder:6.7b", -- Coder model for ollama
        "llama3.2:latest", -- Llama 3.2 model
        "gemma3:latest", -- Gemma 3 model
        "qwen2.5:7b-instruct", -- Qwen model
      },
      is_env_set = function()
        return true
      end,
    },
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o",  -- The model name to use with this provider
      api_key_name = "AVANTE_OPENAI_API_KEY",
      max_tokens = 4096, -- Maximum tokens for Ollama
    },
  },
  cursor_applying_provider = "copilot", -- The provider used for cursor applying
  dual_boost = {
    enabled = true,
    first_provider = "copilot", -- The first provider for dual boost
    second_provider = "openai", -- The second provider for dual boost
    prompt =
    "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
    timeout = 60000, -- Timeout in milliseconds
  },
  rules = {
    project_dir = '.avante/rules',         -- relative to project root, can also be an absolute path
    global_dir = '~/.config/avante/rules', -- absolute path
  },
  override_prompt_dir = vim.fn.expand("~/.config/nvim/avante/rules"),
  behaviour = {
    --- ... existing behaviours
    auto_suggestions = true,
    auto_set_highlight_group = true,                        -- Automatically set the highlight group for Avante
    auto_set_keymaps = true,                                -- Automatically set keymaps for Avante
    auto_apply_diff_after_generation = false,               -- Automatically apply the diff after generation
    support_paste_from_clipboard = true,                    -- Support pasting from clipboard
    enable_cursor_planning_mode = true,                     -- enable cursor planning mode!
    use_cwd_as_project_root = true,                         -- use the current working directory as the project root
    auto_focus_on_diff_view = true,                         -- automatically focus on the diff view when opening a file with changes
  },
  prompt_logger = {                                         -- logs prompts to disk (timestamped, for replay/debugging)
    enabled = true,                                         -- toggle logging entirely
    log_dir = vim.fn.stdpath("cache") .. "/avante_prompts", -- directory where logs are saved
    fortune_cookie_on_success = false,                      -- shows a random fortune after each logged prompt (requires `fortune` installed)
    next_prompt = {
      normal = "<C-n>",                                     -- load the next (newer) prompt log in normal mode
      insert = "<C-n>",
    },
    prev_prompt = {
      normal = "<C-p>", -- load the previous (older) prompt log in normal mode
      insert = "<C-p>",
    },
  },
  rag_service = {                          -- RAG service configuration
    enabled = true,                       -- Enables the RAG service
    host_mount = os.getenv("HOME"),        -- Host mount path for the RAG service (Docker will mount this path)
    runner = "nix",                        -- The runner for the RAG service (can use docker or nix)
    llm = {                                -- Configuration for the Language Model (LLM) used by the RAG service
      provider = "ollama",                 -- The LLM provider ("ollama")
      endpoint = "http://localhost:11434", -- The LLM API endpoint for Ollama
      api_key = "",                        -- Ollama typically does not require an API key
      model = "llama3.1:latest",           -- The LLM model name (e.g., "llama2", "mistral")
      extra = nil,                         -- Extra configuration options for the LLM (optional) Kristin", -- Extra configuration options for the LLM (optional)
    },
    embed = {                              -- Configuration for the Embedding Model used by the RAG service
      provider = "ollama",                 -- The Embedding provider ("ollama")
      endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
      api_key = "",                        -- Ollama typically does not require an API key
      model = "nomic-embed-text:latest",   -- The Embedding model name (e.g., "nomic-embed-text")
      extra = {
        embed_batch_size = 10
      },
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
      proxy = nil,         -- proxy support, e.g., http://127.0.0.1:7890
    }
  },
  windows = {
    ---@type "right" | "left" | "top" | "bottom"
    position = "right", -- the position of the sidebar
    wrap = true,        -- similar to vim.o.wrap
    width = 30,         -- default % based on available width
    sidebar_header = {
      enabled = true,   -- true, false to enable/disable the header
      align = "center", -- left, center, right for title
      rounded = true,
    },
    spinner = {
      editing = { "⡀", "⠄", "⠂", "⠁", "⠈", "⠐", "⠠", "⢀", "⣀", "⢄", "⢂", "⢁", "⢈", "⢐", "⢠", "⣠", "⢤", "⢢", "⢡", "⢨", "⢰", "⣰", "⢴", "⢲", "⢱", "⢸", "⣸", "⢼", "⢺", "⢹", "⣹", "⢽", "⢻", "⣻", "⢿", "⣿" },
      generating = { "·", "✢", "✳", "∗", "✻", "✽" }, -- Spinner characters for the 'generating' state
      thinking = { "🤯", "🙄" }, -- Spinner characters for the 'thinking' state
    },
    input = {
      provider = "snacks",
      provider_opts = {
        -- Additional snacks.input options
        title = "Avante Input",
        icon = "💬",
      },
      height = 20,         -- Adjusted height for longer prompts and tokens
      position = "bottom", -- Adjusted position for the input box
    },
    edit = {
      border = "rounded",
      start_insert = false, -- Start insert mode when opening the edit window
    },
    ask = {
      floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
      start_insert = true, -- Start insert mode when opening the ask window
      border = "rounded",
      ---@type "ours" | "theirs"
      focus_on_apply = "ours", -- which diff to focus after applying
    },
  },
})

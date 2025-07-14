require('avante').setup({
  -- add any opts here
  -- for example
  -- system_prompt as function ensures LLM always has latest MCP server state
  -- This is evaluated for every message, even in existing chats
  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    if hub and hub:is_ready() then
      return hub:get_active_servers_prompt()       -- Generates prompt listing active tools
    else
      return "Default system prompt."
    end
  end,
  -- Using function prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
  provider = "copilot",
  providers = {
    ollama = {
      endpoint = "http://localhost:11434",
      model = "deepseek-coder:6.7b",
      max_tokens = 4096, -- Maximum tokens for Ollama
    },
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o",  -- The model name to use with this provider
      api_key_name = "AVANTE_OPENAI_API_KEY",
      max_tokens = 4096, -- Maximum tokens for Ollama
    },
  },
  cursor_applying_provider = "ollama", -- The provider used for cursor applying
  dual_boost = {
    enabled = true,
    first_provider = "copilot", -- The first provider for dual boost
    second_provider = "openai", -- The second provider for dual boost
    prompt =
    "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
    timeout = 60000, -- Timeout in milliseconds
  },
  behaviour = {
    --- ... existing behaviours
    auto_suggestions = false,
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
    enabled = false,                       -- Enables the RAG service
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
      extra = nil,
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
      proxy = nil,         -- proxy support, e.g., http://127.0.0.1:7890
    }
  },
})

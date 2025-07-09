require('avante').setup({
  -- add any opts here
  -- for example
  -- system_prompt as function ensures LLM always has latest MCP server state
  -- This is evaluated for every message, even in existing chats
  system_prompt = function()
    local hub = require("mcphub").get_hub_instance()
    return hub and hub:get_active_servers_prompt() or ""
  end,
  -- Using function prevents requiring mcphub before it's loaded
  custom_tools = function()
    return {
      require("mcphub.extensions.avante").mcp_tool(),
    }
  end,
  provider = "copilot", -- The default provider for code completion
  providers = {
    ollama = {
      endpoint = "http://localhost:11434",
      model = "deepseek-coder:6.7b",
      max_tokens = 4096, -- Maximum tokens for Ollama
    },
  },
  cursor_applying_provider = "ollama", -- The provider used for cursor applying
  behaviour = {
    --- ... existing behaviours
    auto_suggestions = false,
    auto_set_highlight_group = true, -- Automatically set the highlight group for Avante
    auto_set_keymaps = true, -- Automatically set keymaps for Avante
    auto_apply_diff_after_generation = false, -- Automatically apply the diff after generation
    support_paste_from_clipboard = true, -- Support pasting from clipboard
    enable_cursor_planning_mode = true,    -- enable cursor planning mode!
    use_cwd_as_project_root = true,       -- use the current working directory as the project root
    auto_focus_on_diff_view = true,  -- automatically focus on the diff view when opening a file with changes
  },
  rag_service = {                          -- RAG service configuration
    enabled = true,                        -- Enables the RAG service
    host_mount = os.getenv("HOME"),        -- Host mount path for the RAG service (Docker will mount this path)
    runner = "nix",                        -- The runner for the RAG service (can use docker or nix)
    llm = {                                -- Configuration for the Language Model (LLM) used by the RAG service
      provider = "ollama",                 -- The LLM provider ("ollama")
      endpoint = "http://localhost:11434", -- The LLM API endpoint for Ollama
      api_key = "",                        -- Ollama typically does not require an API key
      model = "llama2",                    -- The LLM model name (e.g., "llama2", "mistral")
      extra = nil,                         -- Extra configuration options for the LLM (optional) Kristin", -- Extra configuration options for the LLM (optional)
    },
    embed = {                              -- Configuration for the Embedding Model used by the RAG service
      provider = "ollama",                 -- The Embedding provider ("ollama")
      endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
      api_key = "",                        -- Ollama typically does not require an API key
      model = "nomic-embed-text",          -- The Embedding model name (e.g., "nomic-embed-text")
      extra = nil,
    },
    web_search_engine = {
      provider = "tavily", -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
      proxy = nil,         -- proxy support, e.g., http://127.0.0.1:7890
    }
  },
})

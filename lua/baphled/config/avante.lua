require('avante').setup({
  -- add any opts here
  -- for example
  provider = "copilot", -- The default provider for code completion
  providers = {
    ollama = {
      endpoint = "http://localhost:11434",
      model = "deepseek-coder:6.7b",
    },
  },
  rag_service = {                          -- RAG Service configuration
    enabled = true,                       -- Enables the RAG service
    host_mount = os.getenv("HOME"),        -- Host mount path for the rag service (Docker will mount this path)
    runner = "nix",                        -- Runner for the RAG service (can use docker or nix)
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
      extra = {                            -- Extra configuration options for the Embedding model (optional)
        embed_batch_size = 10
      },
    },
    docker_extra_args = "", -- Extra arguments to pass to the docker command
    web_search_engine = {
      provider = "tavily",  -- tavily, serpapi, searchapi, google, kagi, brave, or searxng
      proxy = nil,          -- proxy support, e.g., http://127.0.0.1:7890
    }
  },
})

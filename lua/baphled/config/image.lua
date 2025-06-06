-- default config
require("image").setup({
  backend = "kitty",
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = true,
      download_remote_images = true,
      only_render_image_at_cursor = true,
      tmux_show_only_in_active_window = true,
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
    html = {
      enabled = false,
      tmux_show_only_in_active_window = true,
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
    css = {
      enabled = false,
      tmux_show_only_in_active_window = true,
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = nil,
  max_height_window_percentage = 50,
  window_overlap_clear_enabled = false,                                     -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  editor_only_render_when_focused = true,                                  -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = true,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
})

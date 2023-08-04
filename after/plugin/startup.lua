-- working out the current directory
-- if its our products directory, use nvyro
-- for everything else, use boodah
local function determine_theme()
  local startup_theme = "startup.evil"

  if string.find(vim.fn.getcwd(), "n-vyro") then
    startup_theme = "baphled.startup.themes.nvyro"
  else
    startup_theme = "baphled.startup.themes.boodah"
  end

  return startup_theme
end
require("startup").setup(require(determine_theme()))

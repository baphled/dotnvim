# PDE Configuration

My NeoVim configuration settings, used for my day-to-day work and productivity.

This effectively makes my [dotvim](https://github.com/baphled/dotvim)
configuration obsolete. I absolutely love vim, but there's always been some
problems with my configuration settings. Even though this hasn't been enough to
make me completely abandon my settings, especially as I've always managed to get
enough do, taking the dive into NeoVim has completely changed the way I interact
with my day-to-day work.

Here, I've spent around a week tweaking my settings to something that is near
perfect.

Below is a list of functionality that I aimed to get working within this setup.

* Automated LSP integration
* Syntax Highlighting
* Improved file navigation
* Improved package management
* Easier to manage package management
* Pretty dev icons
* Conditional in-line code coverage
* Code snippets
* Automated code coverage
* Debugging
* Testing
* File alternation
* DAP
* Powerline
* Fuzzy Finder
* Preview

Some of these improvements are mostly stylistic, but honestly spending hours
upon hours within a text editor pretty and enjoyable makes a huge difference.

One of the real pleasures here is that we finally get to leverage Lua for
further customisation along with not having to worry about eternally updating
the project anytime a plug-in updates.

* Packer
* Telescope
* Rose-Pine
* Trouble
* Treesitter
* Harpoon
* refactoring
* undotree
* fugitive
* markdown-preview
* lualine
* LSP-zero
* Mason
* LuaSnip
* Zenmode
* Copilot
* Cloak
* vim-surround
* vim-textxobj-user
* vim-indent-object
* vim-ruby-block-conv
* vim-textobj-rubyblock
* vim-rails
* NvimTree
* which-key
* nvim-notify
* vim-dadbod

Some of these plug-ins have been brought in from my old configuration, with
others totally replace a large amount plug-ins I used previously.

## Structure

I've intentionally split my configuration into a few logically sections.

* Autocommand
* Colours
* Motions
* Packer
* Remap
* Set

## Autocommand

Vim and neovim both allow us to define commands that can be automatically called
dependant of some pre-defined hooks. Instead of having these spread across our
setup, we tend to create an autocommand lua file to is specific to the operation
we want to automate.

## Colours

Overrides the default colours with our own custom settings.

For the most part, there's no _real_ need to have to override the colours used
within neovim, but if/when this is necessary we're able to do this here.

## Motions

This is where I add my custom motions.

## Remap

Here I remap a bunch of my keystrokes. Mostly these have been with me for over
a decade, so changing them now seems like losing a limb.

## Set

This is where I customise NeoVim to some sane defaults. Again, I've come
accustom to some settings so defining them here makes my experiences with my
text editor as close to my original Vim configuration as possible.

## Packer

This is one of the main changes to my setup.

Previously, I used git sub-modules to handle the Vim plug-ins I used. There was
Plug, but I didn't like that much either. Packer, on the other hand is a really
nice solutions. So we've embraced this and use this file for defining and
setting up our NeoVim plug-ins.

# Plug-ins

`after/plug-in`

This is where we define the custom configuration for each of our plug-ins. From
here, we're able to further extend our plug-ins to our will.

Splitting out our plug-in configurations makes it easier to manage and
customise. The main aim here is that we're able to focus on a given plug-in and
if we ever want to remove the plug-in in question we're also able to easily
remove its customisations.

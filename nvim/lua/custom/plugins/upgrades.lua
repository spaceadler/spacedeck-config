-- Helper function to generate GitHub URLs (needed since this is a separate file)
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- 1. Harpoon 2
-- ============================================================
vim.pack.add { { src = gh 'ThePrimeagen/harpoon', branch = 'harpoon2' } }

local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon Add' })
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Menu' })

-- ============================================================
-- 2. Treesitter Context & Textobjects
-- ============================================================
vim.pack.add {
  gh 'nvim-treesitter/nvim-treesitter-context',
  gh 'nvim-treesitter/nvim-treesitter-textobjects',
}

require('treesitter-context').setup { max_lines = 3 }

-- Verzögertes Laden für Textobjects (verhindert Abstürze beim Start)
vim.schedule(function()
  local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
  if status_ok then
    configs.setup {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
    }
  end
end)

-- ============================================================
-- 3. Diffview & Toggleterm
-- ============================================================
vim.pack.add { gh 'sindrets/diffview.nvim', gh 'akinsho/toggleterm.nvim' }

require('toggleterm').setup {
  size = 15,
  open_mapping = [[<C-\>]],
  direction = 'horizontal',
}

-- ============================================================
-- 4. CORE AESTHETICS (THEME & UI)
-- ============================================================

-- INSTALL THEMES
vim.pack.add { gh 'folke/tokyonight.nvim' }
vim.pack.add { gh 'scottmckendry/cyberdream.nvim' }

-- SETUP TOKYONIGHT (Backup / Alternative Dark Mode)
require('tokyonight').setup {
  transparent = true,
  terminal_colors = true,
}

-- SETUP CYBERDREAM (With Custom Ultra-Vibrant Palette)
require('cyberdream').setup {
  transparent = true, -- Zwingend notwendig für den Glas-Effekt
  italic_comments = true,
  theme = {
    variant = 'auto', -- Dynamically scales with vim.o.background instead of forcing light mode
  },

  -- Inject the high-vibrancy Alacritty color tokens directly into Neovim
  colors = {
    dark = {
      bg = '#16181a',
      fg = '#ffffff',
      red = '#ff2e63', -- Vivid neon red
      green = '#00ff66', -- Electric neon green
      yellow = '#ffe600', -- Pure vibrant yellow
      blue = '#0066ff', -- Intense electric blue
      magenta = '#df00ff', -- Bright neon magenta
      cyan = '#00e5ff', -- Sharp neon cyan
      pink = '#ff0055', -- Ultra-vibrant pink
      orange = '#ff9900', -- High-voltage orange
    },
  },

  highlights = {
    Comment = { fg = '#99f0f0', italic = true },
  },
}

-- DYNAMIC THEME SELECTION
local alacritty_link = vim.fn.expand '~/.config/alacritty/current_theme.toml'
local real_path = vim.fn.resolve(alacritty_link)

if real_path:match 'macos.toml' then
  vim.o.background = 'light'
  vim.cmd.colorscheme 'cyberdream'
else
  vim.o.background = 'dark'
  vim.cmd.colorscheme 'cyberdream' -- Swapped from 'tokyonight-night' to load your vibrant Cyberdream setup
end
-- UI OVERHAUL: Noice.nvim & Dependencies
vim.pack.add {
  gh 'MunifTanjim/nui.nvim',
  gh 'rcarriga/nvim-notify',
  gh 'folke/noice.nvim',
}
require('noice').setup {
  lsp = {
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
}

-- UI MENUS: Dressing.nvim
vim.pack.add { gh 'stevearc/dressing.nvim' }
require('dressing').setup {}

-- ANIMATIONS: Mini.animate
vim.pack.add { gh 'nvim-mini/mini.animate' }
local animate = require 'mini.animate'
animate.setup {
  resize = {
    timing = animate.gen_timing.linear { duration = 50, unit = 'total' },
  },
  scroll = {
    timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
  },
}

-- ============================================================
-- 5. TABS & STATUSLINE
-- ============================================================

-- TABS: Bufferline
vim.pack.add { gh 'akinsho/bufferline.nvim', gh 'nvim-tree/nvim-web-devicons' }
require('bufferline').setup {
  options = {
    mode = 'buffers',
    show_buffer_close_icons = false,
    show_close_icon = false,
    separator_style = 'thin',
    always_show_bufferline = true,
    get_element_icon = function(element)
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,
  },
}

-- Schnelle Tab-Navigation mit Alt + 1-5
vim.keymap.set('n', '<M-1>', '<Cmd>BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<M-2>', '<Cmd>BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', '<M-3>', '<Cmd>BufferLineGoToBuffer 3<CR>')

-- STATUSLINE: Lualine
vim.pack.add { gh 'nvim-lualine/lualine.nvim' }
require('lualine').setup {
  options = {
    theme = 'auto',
    globalstatus = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '█', right = '█' },
  },
}

-- ============================================================
-- 6. START SCREEN: Snacks Dashboard (SPACEADLER)
-- ============================================================
vim.pack.add { gh 'folke/snacks.nvim' }

require('snacks').setup {
  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
      -- Die "startup" Sektion wurde hier entfernt!
    },
    preset = {
      header = [[
                                                              █████ ████                    
                                                            ░░███ ░░███                    
  █████  ████████   ██████    ██████   ██████   ██████    ███████  ░███   ██████  ████████ 
 ███░░  ░░███░░███ ░░░░░███  ███░░███ ███░░███ ░░░░░███  ███░░███  ░███  ███░░███░░███░░███
░░█████  ░███ ░███  ███████ ░███ ░░░ ░███████   ███████ ░███ ░███  ░███ ░███████  ░███ ░░░ 
 ░░░░███ ░███ ░███ ███░░███ ░███  ███░███░░░   ███░░███ ░███ ░███  ░███ ░███░░░   ░███     
 ██████  ░███████ ░░████████░░██████ ░░██████ ░░████████░░████████ █████░░██████  █████    
░░░░░░   ░███░░░   ░░░░░░░░  ░░░░░░   ░░░░░░   ░░░░░░░░  ░░░░░░░░ ░░░░░  ░░░░░░  ░░░░░     
         ░███                                                                              
         █████                                                                             
        ░░░░░                                                                              
 
      ]],
    },
  },
  scroll = { enabled = true },
  -- Wir deaktivieren Snacks indent, um IBL (Rainbow) nutzen zu können
  indent = { enabled = false },
}

-- ============================================================
-- 7. EYE CANDY EXTRAS (Icons, Rainbow, Highlight)
-- ============================================================

-- AUTOCOMPLETE ICONS: Lspkind
vim.pack.add { gh 'onsails/lspkind.nvim' }
require('lspkind').init {
  mode = 'symbol_text',
  preset = 'codicons',
}

-- RAINBOW INDENTATION LINES: Indent Blankline
vim.pack.add { gh 'lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {
  indent = { char = '│' },
  scope = { enabled = true, show_start = false, show_end = false },
}

-- RAINBOW BRACKETS
vim.pack.add { gh 'HiPhish/rainbow-delimiters.nvim' }

-- COLOR HIGHLIGHTER
vim.pack.add { gh 'brenoprata10/nvim-highlight-colors' }
require('nvim-highlight-colors').setup {
  render = 'background',
  enable_named_colors = true,
  enable_tailwind = true,
}

-- BETTER TODO COMMENTS
vim.pack.add { gh 'nvim-lua/plenary.nvim', gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = true }

-- HIGHLIGHT UNDO
vim.pack.add { gh 'tzachar/highlight-undo.nvim' }
require('highlight-undo').setup {
  hlgroup = 'HighlightUndo',
  duration = 300,
  keymaps = {
    { lhs = 'u', rhs = 'u', op = 'both' },
    { lhs = '<C-r>', rhs = '<C-r>', op = 'both' },
  },
}

-- CURSORLINE FADE
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  callback = function() vim.opt.cursorline = true end,
})
vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  callback = function() vim.opt.cursorline = false end,
})

-- CELLULAR AUTOMATON
vim.pack.add { gh 'eandrju/cellular-automaton.nvim' }
vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', { desc = 'FML Code Rain' })

-- ============================================================
-- 8. DISTRACTION FREE (Zen Mode & Twilight)
-- ============================================================
vim.pack.add { gh 'folke/zen-mode.nvim', gh 'folke/twilight.nvim' }

require('twilight').setup {}
require('zen-mode').setup {
  window = {
    backdrop = 0.95,
    width = 120,
    options = {
      signcolumn = 'no',
      number = false,
      relativenumber = false,
    },
  },
  plugins = {
    gitsigns = { enabled = true },
    tmux = { enabled = false },
    twilight = { enabled = true },
  },
}

-- ============================================================
-- 9. DEBUGGER CONFIGURATION (C / C++ / Assembly)
-- ============================================================
-- Verzögertes Laden, um sicherzustellen, dass das dap-Modul existiert
vim.schedule(function()
  local status_ok, dap = pcall(require, 'dap')
  if status_ok then
    -- GDB als nativen Adapter registrieren
    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '-i', 'dap' },
    }

    -- Start-Konfiguration für C
    dap.configurations.c = {
      {
        name = 'Run executable (GDB)',
        type = 'gdb',
        request = 'launch',
        -- Fragt dich interaktiv nach dem Pfad zu deinem kompilierten Programm
        program = function() return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file') end,
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
    }

    -- C++ und Assembly (asm) nutzen exakt dieselbe Konfiguration
    dap.configurations.cpp = dap.configurations.c
    dap.configurations.asm = dap.configurations.c
  end
end)

-- Set lualine as statusline
return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local mode = {
      'mode',
      fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        return ' ' .. str
      end,
    }

    local filename = {
      'filename',
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn' },
      symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      colored = false,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      'diff',
      colored = false,
      symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
      cond = hide_in_width,
    }
    local function is_flutter_project()
      local cwd = vim.fn.getcwd() -- Get the current working directory
      return vim.fn.filereadable(cwd .. '/pubspec.yaml') == 1 -- Check if pubspec.yaml exists
    end

    -- Custom function to get the attached Android device or emulator
    local function get_attached_device()
      -- If it's not a Flutter project, return an empty string
      if not is_flutter_project() then
        return ''
      end

      local handle = io.popen 'adb devices -l'
      if handle == nil then
        return '' -- Return empty if adb command failed
      end

      local result = handle:read '*a'
      handle:close()

      -- Check if result is not empty
      if result and result ~= '' then
        -- Extract the model name from the adb output and stop before the word "device"
        for line in result:gmatch '[^\r\n]+' do
          -- Match the model: field and capture everything before the word 'device'
          local model = line:match 'model:([%w%s_%-]+) device'
          if model then
            -- Replace underscores with spaces for a cleaner output
            model = model:gsub('_', ' ')
            return '📱' .. model -- Return the mobile icon followed by the formatted model name
          end
        end
      end
      return 'No device connected'
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree', 'Avante' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { 'branch' },
        lualine_c = { filename },
        lualine_x = {
          diagnostics,
          diff,
          { 'encoding', cond = hide_in_width },
          { 'filetype', cond = hide_in_width },
          { get_attached_device, cond = hide_in_width },
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { { 'location', padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}

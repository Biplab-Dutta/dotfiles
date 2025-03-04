return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add required debuggers
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'dart',
        'delve',
      },
    }

    -- Dart CLI adapter
    dap.adapters.dart = {
      type = 'executable',
      command = 'dart',
      args = { 'debug_adapter' },
      options = {
        detached = false,
      },
    }

    -- Flutter CLI apaptor
    dap.adapters.flutter = {
      type = 'executable',
      command = 'flutter',
      args = { 'debug_adapter' },
      options = {
        detached = false,
      },
    }

    -- Dart & Flutter config
    dap.configurations.dart = {
      {
        type = 'dart',
        request = 'launch',
        name = 'Launch dart',
        dartSdkPath = vim.fn.exepath 'dart',
        flutterSdkPath = vim.fn.exepath 'flutter',
        cwd = '${workspaceFolder}',
      },
      {
        type = 'flutter',
        request = 'launch',
        name = 'Launch flutter',
        dartSdkPath = vim.fn.exepath 'dart',
        flutterSdkPath = vim.fn.exepath 'flutter',
        cwd = '${workspaceFolder}',
      },
    }

    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    dapui.setup {
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    vim.api.nvim_set_hl(0, 'DapBreakpointColor', { fg = '#E51400' })
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpointColor', linehl = '', numhl = '' })

    -- Toggle to see last session result. Without this, we can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
  end,
}

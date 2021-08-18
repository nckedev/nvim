
local dap = require('dap')
local dapui = require('dapui')

dap.adapters.netcoredbg = {
	type = 'executable',
	command = '/usr/local/bin/netcoredbg/netcoredbg',
	args = {'--interpreter=vscode'}
}
dap.configurations.cs = {
  {
    type = "netcoredbg",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}

dapui.setup()

vim.api.nvim_set_keymap("n", "<leader>9", ":lua require('dapui').toggle()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>8", ":lua require('dapui').eval()<cr>", {})
vim.api.nvim_set_keymap("v", "<leader>7", ":lua require('dapui').eval()<cr>", {})

vim.api.nvim_set_keymap("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>1", ":lua require('dap').continue()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>2", ":lua require('dap').step_over()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>3", ":lua require('dap').step_into()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>4", ":lua require('dap').step_out()<cr>", {})
vim.api.nvim_set_keymap("n", "<leader>0", ":lua require('dap').repl_toggle()<cr>", {})


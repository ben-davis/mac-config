-- vim-test configuration
vim.g["test#strategy"] = "neoterm"
vim.g["test#python#runner"] = "pytest"
vim.g["test#project_root"] = "/Users/ben/dev/git/rupalabs/server"
vim.g["term#preserve_screen"] = 0

-- Neoterm configuration (used as the strategy for vim-test)
vim.g["neoterm_default_mod"] = "vertical"
vim.g["neoterm_size"] = 80

local function get_pytest_exec()
	local breakpoints = require("dap.breakpoints").get() or {}
	local buffer = vim.api.nvim_get_current_buf()
	local does_buffer_have_breakpoints = breakpoints[buffer] ~= nil

	if does_buffer_have_breakpoints then
		return "docker-compose run --rm -p 5679:5679 --entrypoint python test -m debugpy --listen 0.0.0.0:5679 --wait-for-client -m pytest --reuse-db"
	end

	return "docker-compose run --rm test --reuse-db"
end

local function run_test_command(test_command)
	-- Set the exec based on the env
	vim.g["test#python#pytest#executable"] = get_pytest_exec()

	-- Call the script
	vim.api.nvim_command(test_command)
end

-- Keymap
vim.keymap.set("n", "<Leader>tn", function()
	run_test_command("TestNearest")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tf", function()
	run_test_command("TestFile")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tl", function()
	run_test_command("TestLast")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ts", function()
	run_test_command("TestSuite")
end, { noremap = true, silent = true })

-- This is currently unused. It could be useful if I can figure out how to have the tests launched,
-- the process managed, and the debugee attached.
function _G.dapLaunchDocker(cmd)
	local dap = require("dap")

	adapter = {
		type = "executable",
		command = "docker-compose",
		args = { "run", "--rm", "--service-ports", "--entrypoint", "python", "test", "-m", "debugpy.adapter" },
	}

	local command = cmd:gsub("python %-m pytest server/", ""):gsub("python %-m pytest server.", "")
	vim.pretty_print({ command })

	config = {
		pathMappings = {
			{
				localRoot = "/Users/ben/dev/git/rupalabs/server",
				remoteRoot = "/app",
			},
		},
		name = "Rupa",
		request = "launch",
		module = "pytest",
		args = { command },
		console = "integratedTerminal",
	}

	dap.launch(adapter, config)
end

-- let DockerStrategy = luaeval('dapLaunchDocker')
-- " let g:test#custom_strategies = {'docker': DockerStrategy}
-- " let test#javascript#jest#options = {
-- "   \ 'nearest': '--watch',
-- "   \ 'file':    '--watch'
-- " \}
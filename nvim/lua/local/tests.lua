-- vim-test configuration
vim.g["test#strategy"] = "neovim"
vim.g["test#python#runner"] = "pytest"
vim.g["term#preserve_screen"] = 0

vim.g["test#neovim#term_position"] = "botright 15"

local function get_pytest_exec(project)
	local breakpoints = require("dap.breakpoints").get() or {}
	local does_buffer_have_breakpoints = next(breakpoints) ~= nil

	-- TODO: This could just test for the existence of a compose file
	if project == "rupalabs" then
		if does_buffer_have_breakpoints then
			return "docker-compose run --rm -p 5679:5679 --entrypoint python test -m debugpy --listen 0.0.0.0:5679 --wait-for-client -m pytest --reuse-db --disable-warnings -vv"
		end

		return "docker-compose run --rm test --reuse-db --disable-warnings -vv"
	end

	local executable = ""

	if vim.fn.filereadable("Pipfile") > 0 then
		executable = "pipenv run "
	elseif vim.fn.filereadable("poetry.lock") > 0 then
		executable = "poetry run "
	end

	local command = "python -m pytest -vv"

	if does_buffer_have_breakpoints then
		command = "python -m debugpy --listen 0.0.0.0:5679 --wait-for-client -m pytest -vv"
	end

	return executable .. command
end

local function run_test_command(test_command)
	local cwd = vim.fn.getcwd(0, 0)
	local project = vim.fn.fnamemodify(cwd, ":t")
	local filetype = vim.bo.filetype

	-- Set the exec based on the env
	vim.g["test#python#pytest#executable"] = get_pytest_exec(project)

	if project == "rupalabs" and filetype == "python" then
		vim.g["test#project_root"] = "/Users/ben/dev/git/rupalabs/server"
	else
		vim.g["test#project_root"] = nil
	end

	-- Jest runs in watch mode if the app uses CRA, so we disable here
	vim.g["test#javascript#reactscripts#executable"] = "node_modules/.bin/react-scripts test --watchAll=false"

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

require("neotest").setup({
	adapters = {
		require("neotest-python")({
			-- python = function()
			-- 	local cwd = vim.fn.getcwd(0, 0)
			-- 	local project = vim.fn.fnamemodify(cwd, ":t")

			-- 	if project == "rupalabs" then
			-- 		return "docker-compose run --rm test --reuse-db --disable-warnings -vv"
			-- 	end
			-- end,
		}),
		require("neotest-rspec")({
			rspec_cmd = function()
				if vim.fn.isdirectory(".rx") > 0 then
					return vim.iter({
						"rx",
						"dev",
						"task",
						"--",
						"bin/rspec",
					})
						:flatten()
						:totable()
				end

				return vim.iter({
					"bundle",
					"exec",
					"rspec",
				})
					:flatten()
					:totable()
			end,

			transform_spec_path = function(path)
				local prefix = require("neotest-rspec").root(path)
				return string.sub(path, string.len(prefix) + 2, -1)
			end,

			formatter = "json",
		}),
		require("neotest-jest"),
	},
})

-- Test once
vim.keymap.set("n", "<Leader>tn", function()
	require("neotest").run.run()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>ta", function()
	require("neotest").run.attach()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tl", function()
	require("neotest").run.run_last()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>ts", function()
	require("neotest").run.run({ suite = true })
end, { noremap = true, silent = true })

-- Debug
vim.keymap.set("n", "<Leader>tdn", function()
	require("neotest").run.run({ strategy = "dap" })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tdf", function()
	require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tdl", function()
	require("neotest").run.run_last({ strategy = "dap" })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>tds", function()
	require("neotest").run.run({ suite = true, strategy = "dap" })
end, { noremap = true, silent = true })

-- Watch
vim.keymap.set("n", "<Leader>twn", function()
	require("neotest").watch.toggle()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>twf", function()
	require("neotest").watch.toggle(vim.fn.expand("%"))
end, { noremap = true, silent = true })

-- UI
vim.keymap.set("n", "<Leader>Ts", function()
	require("neotest").summary.toggle()
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>To", function()
	require("neotest").output.open({ enter = true })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<Leader>TO", function()
	require("neotest").output_panel.open()
end, { noremap = true, silent = true })

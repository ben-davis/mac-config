local function find_buffer_by_name(name)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		local buf_name = vim.api.nvim_buf_get_name(buf)
		print("buf", buf_name)
		if buf_name:match(name .. "$") then
			return buf
		end
	end

	return -1
end

local function reload()
	local app_bufnr = find_buffer_by_name("app%-serve")

	if app_bufnr == -1 then
		vim.notify("No buffer called app-serve available")
		return
	end

	local terminal_job_id = vim.api.nvim_buf_get_var(app_bufnr, "terminal_job_id")

	vim.fn.jobsend(terminal_job_id, "r")
end

vim.keymap.set("n", "<Leader>r", reload, { noremap = true, silent = true })

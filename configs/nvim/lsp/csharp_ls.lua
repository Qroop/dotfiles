---@brief
---
--- https://github.com/razzmatazz/csharp-language-server
---
--- Language Server for C#.
---
--- csharp-ls requires the [dotnet-sdk](https://dotnet.microsoft.com/download) to be installed.
---
--- The preferred way to install csharp-ls is with `dotnet tool install --global csharp-ls`.

---@type vim.lsp.Config
return {
	cmd = function(dispatchers, config)
		return vim.lsp.rpc.start({ 'csharp-ls' }, dispatchers, {
			-- csharp-ls attempt to locate sln, slnx or csproj files from cwd, so set cwd to root directory.
			-- If cmd_cwd is provided, use it instead.
			cwd = config.cmd_cwd or config.root_dir,
			env = config.cmd_env,
			detached = config.detached,
		})
	end,
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(vim.fs.root(fname, function(name)
			return name:match '%.sln$' or name:match '%.slnx$' or name:match '%.csproj$'
		end))
	end,
	filetypes = { 'cs' },
	init_options = {
		AutomaticWorkspaceInit = true,
	},
	get_language_id = function(_, ft)
		if ft == 'cs' then
			return 'csharp'
		end
		return ft
	end,
}

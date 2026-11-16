require('neogit').setup {
	kind = 'replace',
	-- mappings = {
	-- 	status = {
	-- 		['<c-t>'] = false,
	-- 	},
	-- },
	integrations = {
		mini_pick = true,
	},
	commit_editor = {
		kind = "auto",
	}
}

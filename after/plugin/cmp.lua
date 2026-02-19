local cmp = require('cmp')
local ls = require('luasnip')

cmp.setup({

	-- @ I want some snippets to work inside comments
	-- enabled = function()
	-- 	if require"cmp.config.context".in_treesitter_capture("comment")==true or require"cmp.config.context".in_syntax_group("Comment") then
	-- 		return false
	-- 	else
	-- 		return true
	-- 	end
	-- end,

	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete {},
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif ls.expandable() then
				ls.expand()
			-- elseif ls.jumpable(1) then
			-- 	ls.jump(1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- elseif ls.locally_jumpable(-1) then
			-- 	ls.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	},
	sources = {
		-- { name = 'luasnip' },
		-- { name = 'buffer' },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
})

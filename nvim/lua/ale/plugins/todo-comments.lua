return {
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = false, -- hide icons in sign column for a cleaner look
		merge_keywords = false, -- use only the defined semantics below

		keywords = {
			CHAPTER = {
				color = "chapter",
				alt = { "TITLE", "SECTION" },
			},
			NOTE = {
				color = "note",
			},
			TODO = {
				color = "todo",
			},
			FIX = {
				color = "fix",
				alt = { "FIXME" },
			},
			EXPLAIN = {
				color = "explain",
				alt = { "REVIEW" },
			},
			LINK = {
				color = "link",
			},
		},

		colors = {
			chapter = { "#7dcfff" },
			note = { "#4BBF87" },
			todo = { "#bb9af7" },
			fix = { "#f7768e" },
			explain = { "#cc99aa" },
			link = { "#639BD0" },
		},

		-- CHAPTER:
		-- NOTE:
		-- TODO:
		-- FIX:
		-- EXPLAIN:
		-- LINK:

		highlight = {
			multiline = false,
			comments_only = true,
			keyword = "wide_bg", -- highlight the full keyword with background
			after = "fg",
		},

		search = {
			pattern = [[(?i)\b(KEYWORDS)\b]],
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
			},
		},
	},
}

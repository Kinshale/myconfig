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
				alt = { "IDEA", "USE", "README" },
			},
			TODO = {
				color = "todo",
				alt = { "DOUBT, REVIEW" },
			},
			FIX = {
				color = "fix",
				alt = { "ERROR", "BUG" },
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
			link = { "#639BD0" },
		},

		-- CHAPTER:
		-- NOTE:
		-- TODO:
		-- ERROR:
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

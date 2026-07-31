return {
	{
		"EdenEast/nightfox.nvim",
		opts = {
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath("cache") .. "/nightfox",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				transparent = false,     -- Disable setting background
				terminal_colors = false,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = false,    -- Non focused panes set to alternative background
				module_default = true,   -- Default enable value for modules
				colorblind = {
					enable = false,        -- Enable colorblind support
				},
				styles = {							-- Style to be applied to different syntax groups
					comments		= "NONE",		-- Value is any valid attr-list value `:help attr-list`
					conditionals	= "bold",
					constants		= "NONE",
					functions		= "bold",
					keywords		= "bold",
					numbers			= "NONE",
					operators		= "bold",
					strings			= "NONE",
					types			= "bold",
					variables		= "NONE",
				},
				modules = {				-- List of various plugins and additional options
					--"treesitter",
				},
			},
			palettes = {
				carbonfox = {
					bg1			= "#161616",		-- Carbonfox default background
					red			= "#EE5396",
					green		= "#25BE6A",
					yellow		= "#08BDBA",
					blue		= "#78A9FF",
					magenta		= "#BE95FF",
					cyan		= "#33B1FF",
					white		= "#DFDFE0",
					orange		= "#3DDBD9",
					pink		= "#FF7EB6",
				},
			},
			specs = {
				-- As with palettes, the values defined under `all` will be applied to every style.
				all = {
					syntax = {
						-- Specs allow you to define a value using either a color or template. If the string does
						-- start with `#` the string will be used as the path of the palette table. Defining just
						-- a color uses the base version of that color.
					},
					git = {
						-- A color define can also be used
						changed = "#f4a261",
					},
				},
				carbonfox = {
					syntax = {
						bracket     = "fg2",                 -- Brackets and punctuation (neutral)
						builtin0    = "red.base",            -- Builtin variables (alerts you it's special)
						builtin1    = "cyan.bright",         -- Builtin types (distinct and cool tone)
						builtin2    = "orange.bright",       -- Builtin constants (draws attention)
						builtin3    = "red.bright",          -- Reserved: alternate special highlight
						comment     = "comment",             -- Comments (dimmed to reduce visual noise)
						conditional = "magenta.bright",      -- Conditionals and loops (recognizable)
						const       = "orange.bright",       -- Constants, imports, booleans
						dep         = "fg3",                 -- Deprecated (low contrast, faded)
						field       = "blue.base",           -- Object fields (stand out but soft)
						func        = "blue.bright",         -- Function names and titles
						ident       = "cyan.base",           -- Identifiers
						keyword     = "magenta.base",        -- Keywords (strong control flow terms)
						number      = "orange.base",         -- Numbers (bright and obvious)
						operator    = "fg2",                 -- Operators (neutral, not too flashy)
						preproc     = "pink.bright",         -- Preprocessor (stand out)
						regex       = "yellow.bright",       -- Regex (vivid and unique)
						statement   = "magenta.base",        -- Statements (match keyword)
						string      = "green.base",          -- Strings (lively but soft on eyes)
						type        = "yellow.base",         -- Type annotations (distinct)
						variable    = "white.base",          -- General variables
					},
				},
			},
			groups = {},
		},
		enabled = true,
	},
}

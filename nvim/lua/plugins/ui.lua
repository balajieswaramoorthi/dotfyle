return {
	{
		"nvim-lualine/lualine.nvim",
		event = {
			"BufReadPost",
			"BufNewFile",
		},
		opts = {
			options = {
				theme = "nightfox", -- "auto", "catppuccin"
			},
			extensions = {
				["FileType-Mode"] = {
					filetypes	= {
						"copilot-chat",
					},
					sections	= {
						lualine_a = {
							{
								"mode",
							}
						},
						lualine_b = {
							{
								"filename",
							}
						},
						lualine_c = {},
						lualine_x = {},
						lualine_y = {},
						lualine_z = {},
					},
				},
				["FileType"] = {
					filetypes = {
						"NvimTree",
						"neo-tree",
					},
					sections = {
						lualine_a = {
							{
								"filename",
							}
						},
						lualine_b = {},
						lualine_c = {},
						lualine_x = {},
						lualine_y = {},
						lualine_z = {},
					},
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = fmt_mode,
						icon = { "" },
					},
				},
				lualine_b = {
					{
						"branch",
						icon = { " ", },
						separator = "",
						padding = 1,
					},
					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
						padding = 1,
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,					-- Displays file status (readonly status, modified status)
						newfile_status = false,				-- Display new file status (new file means no write after created)
						path = 1,							-- 0: Just the filename
						-- 1: Relative path
						-- 2: Absolute path
						-- 3: Absolute path, with tilde as the home directory
						-- 4: Filename and parent dir, with tilde as the home directory
						shorting_target = 40,				-- Shortens path to leave 40 spaces in the window for other components
						symbols = {
							modified = '[+]',				-- Text to show when the file is modified.
							readonly = '[-]',				-- Text to show when the file is non-modifiable or readonly.
							unnamed = '[No Name]',			-- Text to show for unnamed buffers.
							newfile = '[New]',				-- Text to show for newly created file before first write
						},
						icon = "",
					},
					{
						"searchcount",
						maxcount = 999,
						timeout = 500,
					},
				},
				lualine_x = {
					{
						"encoding",
						show_bomb = true,					-- Show '[BOM]' when the file has a byte-order mark
					},
				},
				lualine_y = {
					{
						"fileformat",
					},
					{
						"filetype",
						colored = true,						-- Displays filetype icon in color if set to true
						icon_only = false,					-- Display only an icon for filetype
						icon = {
							align = 'left'
						},									-- Display filetype icon on the left hand side
						-- icon =    {'X', align='right'}
						-- Icon string ^ in table is ignored in filetype component
					},
				},
				lualine_z = {
					{
						icon = { "", align = "left" },
						function()
							return string.format("%d:%d", vim.fn.line('.'), vim.fn.virtcol('.'))
						end,
					},
					{
						"progress",
						icon = { "", align = "left" },
					},
				},
			},
		}
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						find = "written",
						kind = "",
					},
					opts = { skip = true },
				},
			},
		}
	},
	{
		"karb94/neoscroll.nvim",
	},
	{
		'gelguy/wilder.nvim',
	},
	{
		'Bekaboo/dropbar.nvim',
		dependencies = {
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		},
	},
	{
		"dstein64/nvim-scrollview",
		enabled = false,
		event = {
			"BufWinEnter",
			"BufEnter",
		},
		opts = {
			excluded_filetypes = {
				"NvimTree",
			},
		}
	},
	{
		"willothy/nvim-cokeline",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons"
		},
		opts = function()
			local hlgroups = require("cokeline.hlgroups")

			local function hl(name, attr)
				return hlgroups.get_hl_attr(name, attr)
			end

			local function buffer_hl_group(buffer)
				return buffer.is_focused and "TabLineSel" or "TabLine"
			end

			local function buffer_fg(buffer)
				return hl(buffer_hl_group(buffer), "fg")
					or hl(buffer.is_focused and "Normal" or "Comment", "fg")
					or "NONE"
			end

			local function buffer_bg(buffer)
				return hl(buffer_hl_group(buffer), "bg")
					or hl("ColorColumn", "bg")
					or hl("CursorLine", "bg")
					or hl("Normal", "bg")
					or "NONE"
			end

			local function fill_bg()
				return hl("TabLineFill", "bg")
					or hl("Normal", "bg")
					or "NONE"
			end

			local function sidebar_fg()
				return hl("NvimTreeNormal", "fg")
					or hl("NeoTreeNormal", "fg")
					or hl("Directory", "fg")
					or hl("TabLine", "fg")
					or "NONE"
			end

			local function sidebar_bg()
				return hl("NvimTreeNormal", "bg")
					or hl("NeoTreeNormal", "bg")
					or fill_bg()
			end

			local function diagnostics(buffer)
				local errors = vim.diagnostic.get(buffer.number, { severity = vim.diagnostic.severity.ERROR })
				if #errors > 0 then
					return "  ", hl("DiagnosticError", "fg") or "#bf616a"
				end

				local warnings = vim.diagnostic.get(buffer.number, { severity = vim.diagnostic.severity.WARN })
				if #warnings > 0 then
					return "  ", hl("DiagnosticWarn", "fg") or "#ebcb8b"
				end

				return "", nil
			end

			return {
				show_if_buffers_are_at_least = 1,
				default_hl = {
					fg = buffer_fg,
					bg = buffer_bg,
				},
				fill_hl = "TabLineFill",

				buffers = {
					filter_valid = false,
					filter_visible = false,
					focus_on_delete = 'prev',
					new_buffers_position = 'last',
					delete_on_right_click = true,
				},

				mappings = {
					cycle_prev_next = false,
					disable_mouse = true,
				},

				history = {
					enabled = false,
					size = 2
				},

				rendering = {
					max_buffer_width = 999,
				},

				pick = {
					use_filename = true,
					letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP',
				},

				components = {
					{
						text = ' ',
						bg = fill_bg,
					},
					{
						text = '',
						fg = buffer_bg,
						bg = fill_bg,
					},
					{
						text = function(buffer) return buffer.devicon.icon end,
						fg = function(buffer) return buffer.devicon.color end,
					},
					{
						text = function(buffer) return buffer.filename end,
						bold = function(buffer) return buffer.is_focused end
					},
					{
						text = function(buffer)
							return diagnostics(buffer)
						end,
						fg = function(buffer)
							local _, color = diagnostics(buffer)
							return color
						end,
					},
					{
						text = function(buffer) return buffer.is_modified and ' ●' or '' end,
						fg = function() return hl("DiagnosticWarn", "fg") end,
					},
					{
						text = ' 󰅚 ',
						on_click = function(_, _, _, _, buffer)
							buffer:delete()
						end,
					},
					{
						text = '',
						fg = buffer_bg,
						bg = fill_bg,
					},
				},
				sidebar = {
					filetype = {
						'NvimTree',
						'neo-tree',
					},
					components = {
						{
							text = ' File Explorer ',
							fg = sidebar_fg,
							bg = sidebar_bg,
							bold = true,
						},
					},
				},
			}
		end,
		config = function(_, opts)
			require("cokeline").setup(opts)

			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("user_cokeline_colors", { clear = true }),
				callback = function()
					vim.cmd.redrawtabline()
				end,
			})
		end,
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		enabled = false,
		init = function()
			vim.opt.laststatus = 3
			vim.opt.splitkeep = "screen"
		end,
		opts = {
		},
	},
	{
		"folke/trouble.nvim"
	}
}

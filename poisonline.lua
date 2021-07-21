local vim = vim
local gl = require('galaxyline')
local gls = gl.section
--local extension = require('galaxyline.provider_extensions')

local buffer    = require('galaxyline.provider_buffer')
local condition = require('galaxyline.condition')
local fileinfo  = require('galaxyline.provider_fileinfo')
local lsp       = require('galaxyline.provider_lsp')
local vcs       = require('galaxyline.provider_vcs')


gl.short_line_list = {
    'LuaTree',
    'NvimTree',
    'vista',
    'dbui',
    'plug',
	'help',
	'fzf',
	'Plug',
	'tagbar'
}

-- VistaPlugin = extension.vista_nearest

local colors = {
    bg = '#04000a',
	black = '#04000a',
    line_bg = '#0f0617',
	bg_statusline = '#0f0617',
    fg = '#9ed800',
    fg_green = '#65a380',

    greenu = '#15d800',
    info = '#9d9f99',
    info2 = '#7d7f79',

    yellow = '#fabd2f',
    cyan = '#008080',
    darkblue = '#081633',
    green = '#afd700',
    orange = '#FF8800',
    purple = '#5d4d7a',
    magenta = '#c678dd',
    blue = '#51afef';
    red = '#ef5f67'
}

local mode_icon = {
     n      = ' ',
     i      = ' ',
     c      = 'ﲵ ',
     V      = ' ',
     [''] = ' ',
     v      = ' ',
     C      = 'ﲵ ',
     R      = '﯒ ',
     t      = ' ',
}

local mode_alias = {
	c = "C ",
	['!'] = "C ",
	i = "I ",
	ic = "I ",
	ix = "I ",
	n = "N ",
	R = "R ",
	Rv    = "R ",
	r = "R ",
	rm    = "R ",
	['r?'] = "R ",
	s = "S ",
	S     = "S ",
	[''] = "S ",
	t = "T ",
	v = "V ",
	V = "V ",
	[''] = "V",
}

local mode_color = {
    n = colors.info,
    i = colors.fg,
    v=colors.yellow,
	[''] = colors.yellow,
	V=colors.yellow,
    c = colors.red,
	no = colors.red,
	s = colors.purple,
	S=colors.purple,
    [''] = colors.purple,
	ic = colors.purple,
	R = colors.red,
	Rv = colors.red,
    cv = colors.red,
	ce=colors.red,
	r = colors.red,
	rm = colors.red,
	['r?'] = colors.red,
    ['!']  = colors.red,
	t = colors.yellow,
}


--local function tabLineChg()
--	vim.api.nvim_command('hi TabLineSel guifg='..mode_color[vim.fn.mode()])
--end


local num_icons = {"➊ ", "❷ ", "➌ ", "➍ ", "➎ ", "➏ ", "➐ ", "➑ ", "➒ ", " "}
-- }}}1

-- Left hand side modules {{{1
gls.left[0] = { Left = { -- {{{2
	highlight = {colors.line_bg, colors.line_bg},

	provider = function ()
		return "█"
	end,
}}
-- }}}2

gls.left[1] = { ModeNum = { -- {{{2
	highlight = {colors.black, colors.bg_statusline, 'bold'},

	provider = function ()
		vim.api.nvim_command('hi GalaxyModeNum guifg='..mode_color[vim.fn.mode()])
		return mode_icon[vim.fn.mode()]..mode_alias[vim.fn.mode()]
	end,
}}
-- }}}2

gls.left[2] = { BufSep = { -- {{{2
	highlight = {colors.bg, colors.line_bg},

	provider = function ()
		--vim.api.nvim_command("hi GalaxyBufSep guifg="..bgm_color[vim.fn.mode()])
		return " "
	end,
	separator = ' ',
	separator_highlight = {colors.bg, colors.bg},
}}
-- }}}2

gls.left[3] = { FileIcon = { -- {{{2
	condition = condition.buffer_not_empty,
	highlight = {fileinfo.get_file_icon_color, colors.bg},
	provider  = 'FileIcon',
}}
-- }}}2

gls.left[4] = { FileName = { -- {{{2
	condition = condition.buffer_not_empty,
	highlight = {colors.info2, colors.bg, 'bold'},
	provider  = 'FileName',
}}
-- }}}2

gls.left[5] = { FileSep = { -- {{{2
	highlight = {colors.bg, colors.line_bg},

	provider = function ()
		return " "
	end,
}}
-- }}}2

gls.left[6] = { FileEF = { -- {{{2
	highlight = {colors.info, colors.line_bg},

	provider = function ()
		local format_icon = {['DOS'] = " ", ['MAC'] = " ", ['UNIX'] = " "}
		--local encode      = fileinfo.get_file_encode()
		local format      = fileinfo.get_file_format()

		vim.api.nvim_command('hi GalaxyFileEF guifg='..mode_color[vim.fn.mode()])
		return ' '..format_icon[format]
	end,
}}
-- }}}2

gls.left[7] = { EFSep = { -- {{{2
	highlight = {colors.line_bg, colors.bg},

	provider = function ()
		return " "
	end,
}}
-- }}}2

gls.left[8] = { Git = { -- {{{2
	condition = (condition.check_git_workspace and condition.buffer_not_empty),
	highlight = {colors.purple, colors.bg},

	provider = function ()
		local branch = vcs.get_git_branch()
		if (branch == nil) then branch = '???' end
		--vim.api.nvim_command('hi GalaxyGit guifg='..mode_color[vim.fn.mode()])
		return ' '..' '..branch..' '
	end,
}}

gls.left[9] = { DiagnosticError = { -- {{{2
	highlight = {colors.red, colors.bg, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Error')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}
-- }}}2

gls.left[10] = { DiagnosticWarn = { -- {{{2
	highlight = {colors.yellow, colors.bg, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Warning')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}
-- }}}2

gls.left[11] = { DiagnosticHint = { -- {{{2
	highlight = {colors.cyan, colors.bg, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Hint')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}
-- }}}2

gls.left[12] = { DiagnosticInfo = {
	highlight = {colors.blue, colors.bg, 'bold'},

	provider = function ()
		local icon = ' '
		local count = vim.lsp.diagnostic.get_count(0, 'Information')

		if count == 0 then
			return
		else
			return icon..count..' '
		end
	end,
}}

-- Centered modules
--gls.mid[0] = { Empty = {
--	highlight = {colors.bg, colors.bg},
--	provider  = function () return ' ' end,
--}}

-- Right hand side modules {{{1
gls.right[0] = { LspClient = {
	highlight = {colors.info2, colors.bg},

	provider = function ()
		local icon = ' '
		local active_lsp = lsp.get_lsp_client()

		if active_lsp == 'No Active Lsp' then
			icon = ''
			active_lsp  = ''
		end

		--vim.api.nvim_command('hi GalaxyLspClient guifg='..mode_color[vim.fn.mode()])
		return icon..active_lsp..' '
	end,
}}
-- }}}2


gls.right[5] = { LineSep = { -- {{{2
	highlight = {colors.bg, colors.line_bg},

	provider = function ()
		--vim.api.nvim_command('hi GalaxyLineSep guifg='..mode_color[vim.fn.mode()])
		return " "
	end,
}}
-- }}}2

gls.right[6] = {ScrollBar = {
		provider = 'ScrollBar',
		highlight = {colors.line_bg,colors.purple},
	},
}

gls.right[7] = { LineInfo = { -- {{{2
	highlight = {colors.purple, colors.bg_statusline},

	provider = function ()
		local cursor = vim.api.nvim_win_get_cursor(0)

		--vim.api.nvim_command('hi GalaxyLineInfo guifg='..mode_color[vim.fn.mode()])
		return '  '..cursor[1]..':'..vim.api.nvim_buf_line_count(0)..' '
	end,
}}

gls.right[8] = { Right = {
	highlight = {colors.fg, colors.line_bg},

	provider = function ()
		vim.api.nvim_command('hi GalaxyRight guifg='..mode_color[vim.fn.mode()])
		return ' ⚫'
	end,
}}

-- Short line left hand side modules {{{1
gls.short_line_left[0] = { Left = { -- {{{2
	highlight = {colors.blue, colors.bg},

	provider = function ()
		vim.api.nvim_command('hi GalaxyLeft guifg='..mode_color[vim.fn.mode()])
		return "█"
	end,
}}
-- }}}2

gls.short_line_left[1] = { ModeNum = { -- {{{2
	highlight = {colors.black, colors.bg, 'bold'},

	provider = function ()
		vim.api.nvim_command('hi GalaxyModeNum guibg='..mode_color[vim.fn.mode()])
		return
			mode_icon[vim.fn.mode()]..
			num_icons[math.min(10, buffer.get_buffer_number())]
	end,
}}
-- }}}2

gls.short_line_left[2] = { BufSep = { -- {{{2
	highlight = {colors.bg, colors.bg},

	provider = function ()
		vim.api.nvim_command("hi GalaxyBufSep guibg="..mode_color[vim.fn.mode()])
		return "█"
	end,
}}
-- }}}2

gls.short_line_left[3] = { FileIcon = { -- {{{2
	condition = condition.buffer_not_empty,
	highlight = {fileinfo.get_file_icon_color, colors.bg},
	provider  = 'FileIcon',
}}
-- }}}2

gls.short_line_left[4] = { FileName = { -- {{{2
	highlight = {colors.white, colors.bg, 'bold'},
	provider  = 'FileName',
}}
-- }}}2
-- }}}1

-- Short line right hand side modules {{{1
gls.short_line_right[1] = { LineSep = { -- {{{2
	highlight = {colors.bg, colors.bg},

	provider = function ()
		return " "
	end,
}}
-- }}}2


gls.short_line_right[2] = { Right = {
	highlight = {colors.fg, colors.line_bg},

	provider = function ()
		vim.api.nvim_command('hi GalaxyRight guifg='..mode_color[vim.fn.mode()])
		return ' ⚫'
	end,
}}

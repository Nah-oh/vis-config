-- load standard vis module, providing parts of the Lua API
require('vis')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set theme caelus')
	vis.options.autoindent = true
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
	-- Your per window configuration options e.g.
	vis:command('set tabwidth 2')
	vis:command('set number')
	vis:command('set relativenumber')
	vis:map(vis.modes.NORMAL, " d", function()
		end
	)
	vis:map(vis.modes.NORMAL, " e", function()
		vis:command(":e .")
		end
	)
	for m in ipairs({vis.modes.VISUAL, vis.modes.VISUAL_LINE}) do
		vis:map(m, " y", function()
			local range = win.selection.range
			local selected = win.file:content(range)
			io.popen("echo '" .. selected .. "' | wl-copy")
			end
		)
	end
end)

local fetcher = require('loader')
for plugin in fetcher.get_plugins() do
	require('plugins/' .. plugin)
end

for plugin in fetcher.get_plugins_enabled() do
	require('plugins_enabled/' .. plugin)()
end

-- Plugins configuration
vis_open = require("plugins/vis-fzf-open")

-- Arguments passed to fzf (default: "")
vis_open.fzf_args = "-q '!.class ' --height=40%"

-- Mapping configuration example
vis.events.subscribe(vis.events.INIT, function()
    vis:command('map! normal <C-p> :fzf<Enter>')
end)

lspc = require("plugins/vis-lspc")
lspc.menu_cmd = "vis-menu"

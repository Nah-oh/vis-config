local M = {}
function M.get_plugins()
		return io.popen("ls $HOME/.config/vis/plugins"):lines() end
function M.get_plugins_enabled()
		return io.popen("ls $HOME/.config/vis/plugins_enabled"):lines() end
return M

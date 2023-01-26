package = "modules"
version = "dev-1"
source = {
	url = "git+https://github.com/thenumbernine/modules-lua.git"
}
description = {
	summary = "Module system, for chopping up and reassembling code.",
	detailed = [[
Module system, for chopping up and reassembling code.
This forms a DAG of each module within the code, then when requested, it returns only what modules are necessary, in corret dependency order.]],
	homepage = "https://github.com/thenumbernine/modules-lua",
	license = "MIT"
}
dependencies = {
	"lua >= 5.1",
}
build = {
	type = "builtin",
	modules = {
		["modules.module"] = "module.lua",
		["modules"] = "modules.lua"
	}
}

local M = {}
local commands = {
	["rust"] = {
		build = "cargo build",
		test = "cargo test test 2>/dev/null",
		run = "cargo run",
	},
	["cs"] = {
		build = "dotnet build",
		test = "dotnet test",
		run = "dotnet run",
	},
}

local function get_ft()
	local ft = vim.filetype.match({ buf = 0 })
	if ft == nil then
		return "no ft"
	end
	return ft
end

local function get_command(type)
	local ft = get_ft()
	if commands[ft] == nil then
		local msg = "finns inga build commandon för " .. ft
		return 'echo "' .. msg .. '"'
	else
		if type == "build" and commands[ft].build ~= nil then
			return "!" .. commands[ft].build
		elseif type == "run" and commands[ft].run ~= nil then
			return "!" .. commands[ft].run
		elseif type == "test" and commands[ft].test ~= nil then
			return "!" .. commands[ft].test
		else
			local msg = "finns inget " .. type .. "command för " .. ft
			return 'echo "' .. msg .. '"'
		end
	end
end

function M.build()
	vim.cmd(":wa")
	vim.cmd(get_command("build"))
end

function M.test()
	vim.cmd(":wa")
	vim.cmd(get_command("test"))
end

function M.run()
	vim.cmd(":wa")
	vim.cmd(get_command("run"))
end

return M

local M = {}

M.is_c_available = function()
	local uname = vim.loop.os_uname().sysname
	return uname == "Linux" or (uname == "Windows_NT" and vim.fn.executable("cl"))
end

M.is_python_available = function()
	return vim.fn.executable("python") ~= 0
end

M.is_npm_available = function()
	return vim.fn.executable("npm") ~= 0
end

M.is_dotnet_available = function()
	return vim.fn.executable("dotnet") ~= 0
end

M.is_go_available = function()
	return vim.fn.executable("go") ~= 0
end

M.is_cargo_available = function()
	return vim.fn.executable("cargo") ~= 0
end

M.is_nim_available = function()
	return vim.fn.executable("nim") ~= 0
end

M.is_nix_available = function()
	return vim.fn.executable("nix") ~= 0
end

M.is_java_available = function()
	return vim.fn.executable("java") ~= 0
end

M.is_on_windows = function()
	local uname = vim.loop.os_uname().sysname
	return uname == "Windows_NT"
end

return M

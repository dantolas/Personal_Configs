vim.g.osname = string.sub(string.lower(vim.loop.os_uname().sysname),0,3)
print (vim.g.osname)
require("kuta")

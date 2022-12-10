local computer = require("computer")
local io = require("io")

local file = io.open("pass_sha256", "w")
file:write("")
file:close()

computer.beep(2000)
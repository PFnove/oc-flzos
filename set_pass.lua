local io = require("io")
local term = require("term")
local computer = require("computer")
local component = require("component")
local gpu = component.gpu
local data = component.data

term.write("Enter new password: ")
local pass_sha256 = data.sha256(term.read())

file = io.open("pass_sha256", "w")
file:write(pass_sha256)
file:close()

computer.shutdown(true)
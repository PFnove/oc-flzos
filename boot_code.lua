system_unlocked = false

local io = require("io")
local term = require("term")
local computer = require("computer")
local component = require("component")
local gpu = component.gpu
local data = component.data

term.clear()

file = io.open("pass_sha256", "r")
local correct_pass = file:read("*a")
file:close()

if correct_pass == "" then
  require("set_pass")
end

term.write("Enter user password: ")
local pass_sha256 = data.sha256(term.read())

if pass_sha256 == correct_pass then
  term.write("Correct password entered!\n")
  system_unlocked = true
  os.sleep(1)
  computer.beep()
else
  term.write("Incorrect password!\n")
  os.sleep(1)
  computer.shutdown()
end
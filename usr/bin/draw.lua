local event = require("event")
local component = require("component")
local gpu = component.gpu
local screen = component.screen

gpu.setResolution(80, 20)
local w, h = gpu.getResolution()
gpu.fill(1, 1, w, h, " ")

local color = 0xFFFFFF
local penSize = 1
local menuInteract = 0

while true do
  menuInteract = 0
  gpu.setBackground(0x000000)
  gpu.fill(64, 1, 18, 2, " ")
  gpu.setBackground(0xFF0000)
  gpu.setForeground(0xFFFFFF)
  gpu.fill(78, 1, 3, 1, " ")
  gpu.set(79, 1, "x")
  gpu.setBackground(0x000000)
  gpu.setForeground(0xFF0000)
  gpu.set(72, 2, "▓")
  gpu.setForeground(0xFFFF00)
  gpu.set(73, 2, "▓")
  gpu.setForeground(0x00FF00)
  gpu.set(74, 2, "▓")
  gpu.setForeground(0x0000FF)
  gpu.set(75, 2, "▓")
  gpu.setForeground(0xFFFFFF)
  gpu.set(76, 2, "▓")
  gpu.set(70, 1, "Colors:")
  gpu.setBackground(0xFFFFFF)
  gpu.setForeground(0x000000)
  gpu.set(67, 1, "+")
  gpu.set(65, 1, "-")
  gpu.setBackground(0x000000)
  gpu.setForeground(0xFFFFFF)
  gpu.set(66, 2, ""..penSize)
  gpu.setBackground(color)
  local _, _, x, y, mouse_btn = event.pull("touch")
  if x >= 78 and x <= 80 and y == 1 then
    _ = 0 / 0
  end
  if x == 65 and y == 1 and penSize >= 2 then
    penSize = penSize - 1
    menuInteract = 1
  end
  if x == 67 and y == 1 then
    penSize = penSize + 1
    menuInteract = 1
  end
  if x == 76 and y == 2 then
    color = 0xFFFFFF
    menuInteract = 1
  end
  if x == 72 and y == 2 then
    color = 0xFF0000
    menuInteract = 1
  end
  if x == 73 and y == 2 then
    color = 0xFFFF00
    menuInteract = 1
  end
  if x == 74 and y == 2 then
    color = 0x00FF00
    menuInteract = 1
  end
  if x == 75 and y == 2 then
    color = 0x0000FF
    menuInteract = 1
  end
  if mouse_btn == 0 then
    gpu.setBackground(color)
  else
    gpu.setBackground(0x000000)
  end
  if menuInteract == 0 then
    gpu.fill(x+1-penSize, y+1-math.ceil(penSize/2), penSize*2, penSize, " ")
  end
end

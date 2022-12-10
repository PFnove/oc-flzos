local version = "v1.0"

local term = require "term"
local event = require "event"
local computer = require "computer"
local unicode = require "unicode"
local running = false
local p1Name = ""
local p2Name = ""
local timer = 0
local state = 0


local p1e=0
local p1y=6
local score1=0

local p2e=0
local p2y=6
local score2=0

local bx=24
local by=9
local bh=-.5
local bv=-.5

local lastTime = computer.uptime()
local blinkDisplayOn = true


function unknownEvent()

end

local myEventHandlers = setmetatable({}, { __index = function() return unknownEvent end })

function finish()
  running=false
end

function init()
  term.setCursorBlink(false)
  term.setCursor(1,1)
  print "Player 1:"
  term.setCursor(1,2)
  print (p1Name)
  term.setCursor(35,1)
  print "Player 2:"
  term.setCursor(35,2)
  print (p2Name)

  term.setCursor(25,2)
  print(score1)
  term.setCursor(27,2)
  print(score2)
  term.setCursor(1,3)
  print "██████████████████████████████████████████████████"
  term.setCursor(1,15)
  print "██████████████████████████████████████████████████"

  term.setCursor(2,6)
  print "█"
  term.setCursor(2,7)
  print "█"
  term.setCursor(2,8)
  print "█"
  term.setCursor(2,9)
  print "█"

  term.setCursor(49,6)
  print "█"
  term.setCursor(49,7)
  print "█"
  term.setCursor(49,8)
  print "█"
  term.setCursor(49,9)
  print "█"

  local running = true
end



function handleEvent(eventID, ...)
  if (eventID) then 
    myEventHandlers[eventID](...)
  end
end

function myEventHandlers.key_down(adress, char, code, playerName)
  if (code == 57) then
    event.cancel(timer)
    finish()
  end

  if (playerName == p1Name) then
    p1e=code
  end
  if (playerName == p2Name) then
    p2e=code
  end

end

function myEventHandlers.key_up(adress, char, code, playerName)
  if (running == false) then
    if (p1Name == "") then
      p1Name = playerName
      term.setCursor(9,13)
      print (p1Name)
      state=1
    else if (p2Name=="") then
      p2Name = playerName
      term.setCursor(34,13)
      print (p2Name)
      term.setCursor(20,14)
      print "Press ENTER"
      term.setCursor(18,10)
      print "             "
      state=2
    end
    end

    if (state==2) and (code==28) then
      running=true
    end

  else
  
    if (playerName == p1Name) and (code == p1e) then
      p1e=0
    end
    if (playerName == p2Name) and (code == p2e) then
      p2e=0
    end

  end
  

end

function loop()

  if (p1e == 200) and (p1y > 4) then
    p1y=p1y-1
    term.setCursor(2,p1y+4)
    print " "
    term.setCursor(2,p1y)
    print "█"
    

  else if (p1e == 208) and (p1y < 11) then
    p1y=p1y+1
    term.setCursor(2,p1y+3)
    print "█"
    term.setCursor(2,p1y-1)
    print " "
  end
  end

  if (p2e == 200) and (p2y > 4) then
    p2y=p2y-1
    term.setCursor(49,p2y+4)
    print " "
    term.setCursor(49,p2y)
    print "█"
    

  else if (p2e == 208) and (p2y < 11) then
    p2y=p2y+1
    term.setCursor(49,p2y+3)
    print "█"
    term.setCursor(49,p2y-1)
    print " "
  end
  end

  if (bv == -.5) and (by <= 4) then
    bv=.5
  elseif (bv == .5) and (by >= 14.5) then
    bv=-.5
  end

  if (bx <= 3) then
    if (p1y<=(by+bv)) and ((p1y+3)>=(by+bv)) then
      bh=.5
    end
  elseif (bx >= 48) then
    if (p2y<=(by+bv)) and ((p2y+3)>=(by+bv)) then
      bh=-.5
    end
  end

  if (bx <= 1) then
    term.setCursor(bx,by)
    print " "
    bx=24
    by=9
    score2=score2+1
    term.setCursor(25,2)
    print(score2)
    if (score2 == 10) then
      term.setCursor(23 - unicode.len(p2Name) / 2,9)
      print (p2Name .. " wins!")
      event.cancel(timer)
      os.sleep(3)
      finish()
    end
  elseif (bx>49) then
    term.setCursor(bx,by)
    print " "
    bx=24
    by=9
    score1=score1+1
    term.setCursor(27,2)
    print(score1)
    if (score1 == 10) then
      term.setCursor(23 - unicode.len(p2Name) / 2,9)
      print (p1Name .. " wins!")
      event.cancel(timer)
      os.sleep(3)
      finish()
    end
  end

  term.setCursor(bx,by)
  print " "
  bx=bx+bh
  by=by+bv
  term.setCursor(bx,by)
  --print "●"
  if math.floor(by + .5) > by then
    print("▄")
  else
    print("▀")
  end
end

term.clear()
term.setCursor(6,3)
print "█████████  ████████  ███   ██  ████████"
term.setCursor(6,4)
print "███    ██  ██    ██  ████  ██  ██"
term.setCursor(6,5)
print "███    ██  ██    ██  ██ ██ ██  ██"
term.setCursor(6,6)
print "█████████  ██    ██  ██  ████  ██  ████"
term.setCursor(6,7)
print "███        ██    ██  ██   ███  ██    ██"
term.setCursor(6,8)
print "███        ████████  ██    ██  ████████"
term.setCursor(18,10)
print "Press any key"
term.setCursor(9,12)
print "Player 1                 Player 2"

os.sleep(0.1)

while not running do
  while computer.uptime() - lastTime < 1 and not running do
    handleEvent(event.pull(0))
  end
  lastTime = computer.uptime()
  if blinkDisplayOn then
    term.setCursor(18,10)
    print "             "
    blinkDisplayOn = false
  else
    term.setCursor(18,10)
    print "Press any key"
    blinkDisplayOn = true
  end
end


term.clear()
init()
--timer=event.timer(0.05,loop,math.huge)

while running do
  while computer.uptime() - lastTime < .03 do
    handleEvent(event.pull(0))
  end
  lastTime = computer.uptime()
  loop()
end

term.clear()
term.setCursor(1,1)


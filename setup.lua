local shell = require("shell")
local term = require("term")
local computer = require("computer")
local component = require("component")
local gpu = component.gpu
local internet = component.internet
local eeprom = component.eeprom

local prefix = ""

os.execute("del -r "..prefix.."*")
os.execute("del -r "..prefix)
os.execute("mkdir "..prefix)
os.execute("mkdir "..prefix.."bin")
os.execute("mkdir "..prefix.."boot")
os.execute("mkdir "..prefix.."etc")
os.execute("mkdir "..prefix.."etc/rc.d")
os.execute("mkdir "..prefix.."home")
os.execute("mkdir "..prefix.."lib")
os.execute("mkdir "..prefix.."lib/core")
os.execute("mkdir "..prefix.."lib/core/devfs")
os.execute("mkdir "..prefix.."lib/core/devfs/adapters")
os.execute("mkdir "..prefix.."lib/tools")
os.execute("mkdir "..prefix.."usr")
os.execute("mkdir "..prefix.."usr/bin")
os.execute("mkdir "..prefix.."usr/man")
os.execute("mkdir "..prefix.."usr/misc")

term.clear()

local args = {...}

logo = {}
logo[0] = "             ,--,                                    "
logo[1] = "          ,---.'|          ,----,                    "
logo[2] = "    ,---,.|   | :        .'   .`|                    "
logo[3] = "  ,'  .' |:   : |     .'   .'   ;                    "
logo[4] = ",---.'   ||   ' :   ,---, '    .' ,---.              "
logo[5] = "|   |   .';   ; '   |   :     ./ '   ,'\\   .--.--.   "
logo[6] = ":   :  :  '   | |__ ;   | .'  / /   /   | /  /    '  "
logo[7] = ":   |  |-,|   | :.'|`---' /  ; .   ; ,. :|  :  /`./  "
logo[8] = "|   :  ;/|'   :    ;  /  ;  /  '   | |: :|  :  ;_    "
logo[9] = "|   |   .'|   |  ./  ;  /  /--,'   | .; : \\  \\    `. "
logo[10] = "'   :  '  ;   : ;   /  /  / .`||   :    |  `----.   \\"
logo[11] = "|   |  |  |   ,/  ./__;       : \\   \\  /  /  /`--'  /"
logo[12] = "|   :  \\  '---'   |   :     .'   `----'  '--'.     / "
logo[13] = "|   | ,'          ;   |  .'                `--'---'  "
logo[14] = "`----'            `---'                              "

flzos = {}
flzos[0] = 0
flzos[1] = "init.lua"
flzos[2] = "bin/address.lua"
flzos[3] = "bin/alias.lua"
flzos[4] = "bin/cat.lua"
flzos[5] = "bin/cd.lua"
flzos[6] = "bin/clear.lua"
flzos[7] = "bin/components.lua"
flzos[8] = "bin/cp.lua"
flzos[9] = "bin/date.lua"
flzos[10] = "bin/df.lua"
flzos[11] = "bin/dmesg.lua"
flzos[12] = "bin/du.lua"
flzos[13] = "bin/echo.lua"
flzos[14] = "bin/edit.lua"
flzos[15] = "bin/find.lua"
flzos[16] = "bin/flash.lua"
flzos[17] = "bin/free.lua"
flzos[18] = "bin/grep.lua"
flzos[19] = "bin/head.lua"
flzos[20] = "bin/hostname.lua"
flzos[21] = "bin/install.lua"
flzos[22] = "bin/label.lua"
flzos[23] = "bin/less.lua"
flzos[24] = "bin/list.lua"
flzos[25] = "bin/ln.lua"
flzos[26] = "bin/ls.lua"
flzos[27] = "bin/lshw.lua"
flzos[28] = "bin/lua.lua"
flzos[29] = "bin/man.lua"
flzos[30] = "bin/mkdir.lua"
flzos[31] = "bin/mktmp.lua"
flzos[32] = "bin/mount.lua"
flzos[33] = "bin/mv.lua"
flzos[34] = "bin/pastebin.lua"
flzos[35] = "bin/primary.lua"
flzos[36] = "bin/ps.lua"
flzos[37] = "bin/pwd.lua"
flzos[38] = "bin/rc.lua"
flzos[39] = "bin/reboot.lua"
flzos[40] = "bin/redstone.lua"
flzos[41] = "bin/resolution.lua"
flzos[42] = "bin/rm.lua"
flzos[43] = "bin/rmdir.lua"
flzos[44] = "bin/set.lua"
flzos[45] = "bin/sh.lua"
flzos[46] = "bin/shutdown.lua"
flzos[47] = "bin/sleep.lua"
flzos[48] = "bin/source.lua"
flzos[49] = "bin/time.lua"
flzos[50] = "bin/touch.lua"
flzos[51] = "bin/tree.lua"
flzos[52] = "bin/umount.lua"
flzos[53] = "bin/unalias.lua"
flzos[54] = "bin/unset.lua"
flzos[55] = "bin/uptime.lua"
flzos[56] = "bin/useradd.lua"
flzos[57] = "bin/userdel.lua"
flzos[58] = "bin/wget.lua"
flzos[59] = "bin/which.lua"
flzos[60] = "bin/yes.lua"
flzos[61] = "boot/00_base.lua"
flzos[62] = "boot/01_process.lua"
flzos[63] = "boot/02_os.lua"
flzos[64] = "boot/03_io.lua"
flzos[65] = "boot/04_component.lua"
flzos[66] = "boot/10_devfs.lua"
flzos[67] = "boot/89_rc.lua"
flzos[68] = "boot/90_filesystem.lua"
flzos[69] = "boot/91_gpu.lua"
flzos[70] = "boot/92_keyboard.lua"
flzos[71] = "boot/93_term.lua"
flzos[72] = "boot/94_shell.lua"
flzos[73] = "etc/edit.cfg"
flzos[74] = "etc/motd"
flzos[75] = "etc/profile.lua"
flzos[76] = "etc/rc.cfg"
flzos[77] = "etc/rc.d/example.lua"
flzos[78] = "lib/bit32.lua"
flzos[79] = "lib/buffer.lua"
flzos[80] = "lib/colors.lua"
flzos[81] = "lib/devfs.lua"
flzos[82] = "lib/event.lua"
flzos[83] = "lib/filesystem.lua"
flzos[84] = "lib/internet.lua"
flzos[85] = "lib/io.lua"
flzos[86] = "lib/keyboard.lua"
flzos[87] = "lib/note.lua"
flzos[88] = "lib/package.lua"
flzos[89] = "lib/pipe.lua"
flzos[90] = "lib/process.lua"
flzos[91] = "lib/rc.lua"
flzos[92] = "lib/serialization.lua"
flzos[93] = "lib/sh.lua"
flzos[94] = "lib/shell.lua"
flzos[95] = "lib/sides.lua"
flzos[96] = "lib/term.lua"
flzos[97] = "lib/text.lua"
flzos[98] = "lib/thread.lua"
flzos[99] = "lib/transforms.lua"
flzos[100] = "lib/tty.lua"
flzos[101] = "lib/uuid.lua"
flzos[102] = "lib/vt100.lua"
flzos[103] = "lib/core/boot.lua"
flzos[104] = "lib/core/cursor.lua"
flzos[105] = "lib/core/device_labeling.lua"
flzos[106] = "lib/core/full_buffer.lua"
flzos[107] = "lib/core/full_cursor.lua"
flzos[108] = "lib/core/full_event.lua"
flzos[109] = "lib/core/full_filesystem.lua"
flzos[110] = "lib/core/full_keyboard.lua"
flzos[111] = "lib/core/full_ls.lua"
flzos[112] = "lib/core/full_sh.lua"
flzos[113] = "lib/core/full_shell.lua"
flzos[114] = "lib/core/full_text.lua"
flzos[115] = "lib/core/full_transforms.lua"
flzos[116] = "lib/core/full_vt.lua"
flzos[117] = "lib/core/install_basics.lua"
flzos[118] = "lib/core/install_utils.lua"
flzos[119] = "lib/core/lua_shell.lua"
flzos[120] = "lib/core/devfs/01_hw.lua"
flzos[121] = "lib/core/devfs/02_utils.lua"
flzos[122] = "lib/core/devfs/adapters/computer.lua"
flzos[123] = "lib/core/devfs/adapters/eeprom.lua"
flzos[124] = "lib/core/devfs/adapters/filesystem.lua"
flzos[125] = "lib/core/devfs/adapters/gpu.lua"
flzos[126] = "lib/core/devfs/adapters/internet.lua"
flzos[127] = "lib/core/devfs/adapters/modem.lua"
flzos[128] = "lib/core/devfs/adapters/screen.lua"
flzos[129] = "lib/tools/programLocations.lua"
flzos[130] = "lib/tools/transfer.lua"
flzos[131] = "usr/man/address"
flzos[132] = "usr/man/alias"
flzos[133] = "usr/man/cat"
flzos[134] = "usr/man/cd"
flzos[135] = "usr/man/clear"
flzos[136] = "usr/man/cp"
flzos[137] = "usr/man/date"
flzos[138] = "usr/man/df"
flzos[139] = "usr/man/dmesg"
flzos[140] = "usr/man/echo"
flzos[141] = "usr/man/edit"
flzos[142] = "usr/man/grep"
flzos[143] = "usr/man/head"
flzos[144] = "usr/man/hostname"
flzos[145] = "usr/man/install"
flzos[146] = "usr/man/label"
flzos[147] = "usr/man/less"
flzos[148] = "usr/man/ln"
flzos[149] = "usr/man/ls"
flzos[150] = "usr/man/lshw"
flzos[151] = "usr/man/lua"
flzos[152] = "usr/man/man"
flzos[153] = "usr/man/mkdir"
flzos[154] = "usr/man/more"
flzos[155] = "usr/man/mount"
flzos[156] = "usr/man/mv"
flzos[157] = "usr/man/pastebin"
flzos[158] = "usr/man/primary"
flzos[159] = "usr/man/pwd"
flzos[160] = "usr/man/rc"
flzos[161] = "usr/man/reboot"
flzos[162] = "usr/man/redstone"
flzos[163] = "usr/man/resolution"
flzos[164] = "usr/man/rm"
flzos[165] = "usr/man/rmdir"
flzos[166] = "usr/man/set"
flzos[167] = "usr/man/sh"
flzos[168] = "usr/man/shutdown"
flzos[169] = "usr/man/umount"
flzos[170] = "usr/man/unalias"
flzos[171] = "usr/man/unset"
flzos[172] = "usr/man/uptime"
flzos[173] = "usr/man/useradd"
flzos[174] = "usr/man/userdel"
flzos[175] = "usr/man/wget"
flzos[176] = "usr/man/which"
flzos[177] = "usr/man/yes"
flzos[178] = "usr/misc/greetings.txt"

flzos[179] = "bin/flzcode.lua"
flzos[180] = "usr/man/flzcode"
flzos[181] = "boot_code.lua"
flzos[182] = "set_pass.lua"
flzos[183] = "pass_sha256"
flzos[184] = "pass_reset.lua"
flzos[185] = "usr/bin/lock_sys.lua"
flzos[186] = "usr/bin/pong.lua"
flzos[187] = "usr/bin/draw.lua"

local w, h = gpu.getResolution()

function drawLogo(charLen, x, y, color, bgColor)
  gpu.setBackground(bgColor)
  gpu.setForeground(color)
  local finalX = x - charLen / 2 + 1
  for i=0, #logo do
    gpu.set(finalX, y+i, logo[i])
  end
end

function drawProgressBar(x, y, len, percentage, fill_col)
  local len_fill = len*percentage/100
  local percentage_pos = x + (len / 2) - 2
  gpu.setForeground(0x1A1A1A)
  for i=0, len do
    gpu.set(x+i, y, "▀")
  end
  gpu.setForeground(fill_col)
  for i=0, len_fill do
    gpu.set(x+i, y, "▀")
  end
  gpu.setForeground(0x1A1A1A)
  gpu.set(percentage_pos, y-1, tostring(math.floor(percentage*10)/10).."%")
end

function exec(func)
  gpu.fill(1, 1, w, 5, " ")
  if func == 0 then
    local config = ""
    os.execute("wget -f https://github.com/BrightYC/Cyan/blob/master/stuff/cyan.bin?raw=true /tmp/cyan.bin")
    local file = io.open("/tmp/cyan.bin", "r")
    local data = file:read("*a")
    file:close()
    gpu.set(1, 1, "Flashing Cyan BIOS to EEPROM...")
    local success, reason = eeprom.set(config..data)
    if not reason then
      eeprom.setLabel("Cyan BIOS")
      eeprom.setData(computer.getBootAddress())
    end
  end
  if func == 1 then
  end
  if func == 2 then
  end
end

function downloadFile(filename, int_prefix)
  gpu.setForeground(0x00F01A)
  term.setCursor(1, 1)
  gpu.fill(1, 1, w, 5, " ")
  shell.execute("wget", nil, int_prefix..filename, prefix..filename)
end

gpu.setBackground(0x707070)
gpu.fill(1, 1, w, h, " ")
hi_res = false
if w >= 80 and h >= 25 then
  hi_res = true
end
if hi_res then
  drawLogo(54, w/2, h/7, 0x1A1A1A, 0x0070F0)
else
  gpu.setBackground(0x0070F0)
  gpu.setForeground(0x1A1A1A)
  gpu.set(w/2-2, h-h/2, "FLZos")
end
gpu.setBackground(0x707070)

local download_prefix = "https://raw.githubusercontent.com/PFnove/oc-flzos/main/"

local max_len = #flzos
for i=0, max_len do
  if hi_res then
    drawLogo(54, w/2, h/7, 0x1A1A1A, 0x0070F0)
    gpu.setBackground(0x707070)
  end
  local percentage = i*100/max_len
  drawProgressBar(w/4, h-h/5, w/2, percentage, 0x0070F0)
  if tostring(flzos[i]) == flzos[i] then
    downloadFile(flzos[i], download_prefix)
  else
    exec(flzos[i])
  end
  os.sleep(0) -- Graphics fix for OCEmu
end

gpu.fill(1, 1, w, 5, " ")
if hi_res then
  drawLogo(54, w/2, h/7, 0x1A1A1A, 0x0070F0)
end
gpu.setBackground(0x707070)
drawProgressBar(w/4, h-h/5, w/2, 100, 0x00F01A)
gpu.setForeground(0x1A1A1A)
gpu.set(1, 1, "Rebooting...")
os.sleep(0.5)
computer.beep(2000)
gpu.setBackground(0x000000)
gpu.setForeground(0xFFFFFF)
term.clear()
computer.shutdown(true)

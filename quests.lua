os.loadAPI("button")
local dualMonitor = false
local monitors = {}
local m = {}
local playerName = "MrJ"

function connectMonitors()
	monitors = {peripheral.find("monitor")}
	for funcName,_ in pairs(monitors[1]) do
		m[funcName] = function(...)
			for i=1,#monitors-1 do monitors[i][funcName](unpack(arg)) end
			return monitors[#monitors][funcName](unpack(arg))
		end
	end
end

function idPlayer()
	players = {}
	_, users = commands.xp(0, "@p")
	for a,b in pairs(users) do
		local name = ""
		strStart, strEnd = string.find(b,"to ")
		name = string.sub(b,strEnd+1)
		players[playerCount] = name
	end
	chooseAssignment()
end

function chooseAssignment()
	button.clearTable()
	m.setBackgroundColor(colors.black)
	m.clear()
	m.setTextColor(colors.white)
	m.setCursorPos(1,1)
	playerName = players[1]
	button.label(7,1,"Hi" ..playerName)
	button.label(4,1,"Choose assignment to hand in:")
	screenx = 2
	screeny = 1
	button.setTable("Full Iron Armour",mainMenu,"",screenx,screenx+17,screeny+4,screeny+4)
	button.setTable("Bake a Cake",mainMenu,"",screenx+19,screeny+36,screeny+4,screeny+4)
	button.setTable("Iron Pickaxe",mainMenu,"",screenx,screenx+17,screeny+8,screeny+8)
	button.setTable("DIAMONDSSSSSSSSS",mainMenu,"",screenx+19,screeny+36,screeny+8,screeny+8)
	button.setTable("Notch Apple",mainMenu,"",screenx,screenx+17,screeny+12,screeny+12)
	button.setTable("Build a Base",mainMenu,"",screenx+19,screeny+36,screeny+12,screeny+12)
	button.setTable("Diamantes",mainMenu,"",screenx,screenx+17,screeny+16,screeny+16)
	button.setTable("BEASTMODE ACTIVATE",mainMenu,"",screenx+19,screeny+36,screeny+16,screeny+16)
	button.setTable("Explore #1",mainMenu,"",screenx,screenx+17,screeny+20,screeny+20)
	button.setTable("Herobrine?",mainMenu,"",screenx+19,screeny+36,screeny+20,screeny+20)
	button.setTable("Quit",mainMenu,"",18,23,18,18)
	button.screen()	
	x,y,side = getClick()
	while not button.checkxy(x,y) do
		x,y = getClick()
	end
end

function mainMenu()
	mainMenuBool = true
	page = 1
	button.clearTable()
	m.setBackgroundColor(colors.black)
	m.clear()
	m.setTextColor(colors.white)
	m.setCursorPos(1,1)
	button.label(5,2,"Welcome to the Assignment Machine")
	button.setTable("Start",new,"", 10, 30, 9, 11)
	button.screen()
end

function new()
	idPlayer()
	mainMenuBool = false
	button.clearTable()
	m.clear()
	mainMenu()
	button.screen()
end

function getClick()
	local event, side, x, y = os.pullEvent("monitor_touch")
	return x,y,side
end

function waitPlayer()
	local tempColor
	local valid = false
	x,y = getClick()
	if button.checkxy(x,y) then
		return true
	end
	if mainMenuBool then
		return true
	end
end

connectMonitors()
mainMenu()
while true do
	waitPlayer()
end
--[[
Copyright (c) <''2014''> <''Florian Fischer''>
]]--

local astray = require 'astray.init'

function drawdungeon(tiles, width, height)
    for y = 0, height do
        local line = ''
		for x = 0, width do
			line = line .. tiles[x][y]
		end
		print(line)
	end
	print('')
end

local symbols = {Wall='#', Empty=' ', DoorN='-', DoorS='-', DoorE='|', DoorW='|'}

local generator = astray.Astray:new( 25, 25, 30, 70, 80, astray.RoomGenerator:new(8, 3, 6, 3, 6) )
	-- local generator = astray.Astray:new( 5, 5, 1, 15, 5, astray.RoomGenerator:new(1, 1, 2, 1, 2) )
	-- local generator = astray.Astray:new( 20, 10, 15, 70, 80, astray.RoomGenerator:new(4, 2, 6, 2, 6) )
--	local dungeon = generator:Generate()
--	local tiles = generator:CellToTiles(dungeon, symbols )
--	print("Mazesize=", #tiles+1, #tiles[1]+1 )
--	drawdungeon(tiles, #tiles, #tiles[1] )

local dungeon = generator:GenerateDungeon()
generator:GenerateSparsifyMaze(dungeon)
generator:GenerateRemoveDeadEnds(dungeon)
generator:GeneratePlaceRooms(dungeon)
generator:GeneratePlaceDoors(dungeon)
local tiles = generator:CellToTiles(dungeon, symbols)

function love.load()
end

function love.draw()
	local multiplier = 12
	for y = 0, #tiles[1] do
		for x = 0, #tiles do
			if tiles[x][y] == '#' then
				love.graphics.setColor(255,255,255)
				love.graphics.rectangle('fill', x*multiplier, y*multiplier, multiplier, multiplier)
			end
			if tiles[x][y] == '|' or tiles[x][y] == '-' then
				love.graphics.setColor(255,0,0)
				love.graphics.rectangle('fill', x*multiplier, y*multiplier, multiplier, multiplier)
			end
		end
	end
end
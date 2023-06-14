local composer = require( "composer" )
local physics = require "physics"

local scene = composer.newScene()
local group_scene = display.newGroup()
local group_bg = display.newGroup()
local group_interface = display.newGroup()
local group_grid = display.newGroup()
group_grid.anchorY = 0; group_grid.anchorx = 0
local background

local vx
local vy
local projectile
local pos_beganX
local pos_beganY
local pos_endedX
local pos_endedY

local grid_width = CW/16
local grid_height = CH/10

local rock_large2

local tPrevious = system.getTimer()
local tDelta

physics.start()
physics.setDrawMode("hybrid")

group_scene:insert(group_bg)
group_scene:insert(group_interface)
group_scene:insert(group_grid)

local options_red = {
    width = 522/3,
    height = 341/2,
    numFrames = 6
}
local options_pig = {
    width = 388/3,
    height = 374/3,
    numFrames = 6
}

local red_sprite = graphics.newImageSheet(rutaAssets.."sprite_red.png", options_red)
local pig_sprite = graphics.newImageSheet(rutaAssets.."pigs_sprite.png", options_pig)
local sequence = {
    {
        name = "fly",
        frames = {1,2,3,4,5,6},
        sheet = red_sprite,
        time = 2500
    },
    {
        name = "wait",
        frames = {1,2,3},
        sheet = pig_sprite,
        time = 2500
    },
    {
        name = "wait_hurt",
        frames = {4,5,6,4,5},
        sheet = pig_sprite,
        time = 3000
    }
}

local red = display.newSprite(group_scene,red_sprite, sequence)
red.x = CW*0.06; red.y = CH*0.75
red:scale(0.25,0.25)
red:setSequence("fly")
red:play()
physics.addBody(red, "dynamic",{radius = 15, friction = 0})
--red.isFixedRotation = true

local floor = display.newRect(group_bg, CW/2, CH*0.9, CW, 30)
floor:setFillColor(0,1,0,0)
floor.anchorY = 0
physics.addBody(floor, "static", {friction = 0.5})

projectile = display.newImageRect(group_bg,rutaAssets.."projectile.png",348/3,510/3)
projectile.x = CW*0.12; projectile.y = CH*0.68
projectile.anchorY = 0
physics.addBody(floor, "static", {friction = 1})

local support_bird = display.newRect(group_bg, 0, CH*0.8, CW*0.2, 10)
support_bird:setFillColor(0,1,0,0)
physics.addBody(support_bird, "static", {friction = 1})

-- ===== Angles =====

local circle_angles = display.newCircle(projectile.x,projectile.y,100)
circle_angles.alpha = 1
circle_angles.strokeWidth = 1.5
circle_angles:setFillColor(0,1,0,0)

-- ===== Grid ===== ---
local function create_grid()
    for i=1,8 do
        local line = display.newLine(group_grid, CW/2 + grid_width*i, 0,  CW/2 + grid_width*i, CH)
        line.strokeWidth = 2
        line:setStrokeColor(1,1,1,0.5)
    end

    for i=1,10 do
        local line = display.newLine(group_grid, CW/2 + grid_width, grid_height*i, CW, grid_height*i)
        line.strokeWidth = 2
        line:setStrokeColor(1,1,1,0.5)
    end
end

local wood_square = display.newImageRect(group_scene,rutaAssets.."wood_rectangle.png",grid_width,grid_height)
wood_square.x = 11.5*grid_width; wood_square.y = grid_height*8.5
physics.addBody(wood_square, "dynamic", {friction = 0.01})

local ice_rectangle1 = display.newImageRect(group_scene,rutaAssets.."ice_rectangle.png",grid_width/2,grid_height)
ice_rectangle1.x = 13.25*grid_width; ice_rectangle1.y = grid_height*8.5
physics.addBody(ice_rectangle1, "dynamic", {friction = 0.01})

local ice_rectangle2 = display.newImageRect(group_scene,rutaAssets.."ice_rectangle.png",grid_width/2,grid_height)
ice_rectangle2.x = 13.75*grid_width; ice_rectangle2.y = grid_height*8.5
physics.addBody(ice_rectangle2, "dynamic", {friction = 0.01})

local ice_large1 = display.newImageRect(group_scene,rutaAssets.."ice_large.png",grid_width/2,2*grid_height)
ice_large1.x = 11.25*grid_width; ice_large1.y = grid_height*7
physics.addBody(ice_large1, "dynamic", {friction = 0.01})

local ice_large2 = display.newImageRect(group_scene,rutaAssets.."ice_large.png",grid_width/2,2*grid_height)
ice_large2.x = 11.75*grid_width; ice_large2.y = grid_height*7
physics.addBody(ice_large2, "dynamic", {friction = 0.01})

local rock_large1 = display.newImageRect(group_scene,rutaAssets.."rock_large.png",grid_width/2,2*grid_height)
rock_large1.x = 13.25*grid_width; rock_large1.y = grid_height*7
physics.addBody(rock_large1, "dynamic", {friction = 0.01})

rock_large2 = display.newImageRect(group_scene,rutaAssets.."rock_large.png",grid_width/2,2*grid_height)
rock_large2.x = 13.75*grid_width; rock_large2.y = grid_height*7
physics.addBody(rock_large2, "dynamic", {friction = 0.01})

local rock_large_hor = display.newImageRect(group_scene,rutaAssets.."rock_large_horizontal.png",3*grid_width,grid_height/2)
rock_large_hor.x = 12.5*grid_width; rock_large_hor.y = grid_height*5.75
physics.addBody(rock_large_hor, "dynamic", {friction = 0.01})

local rock_triangle_rigth = display.newImageRect(group_scene,rutaAssets.."rock_triangleLeft.png",1*grid_width,grid_height)
rock_triangle_rigth.x = 13.5*grid_width; rock_triangle_rigth.y = grid_height*5
physics.addBody(rock_triangle_rigth, "dynamic", {friction = 0.01})

local rock_triangle_left= display.newImageRect(group_scene,rutaAssets.."ice_triangle_rotate.png",1*grid_width,grid_height)
rock_triangle_left.x = 11.5*grid_width; rock_triangle_left.y = grid_height*5
physics.addBody(rock_triangle_left, "dynamic", {friction = 0.01})

local rock_large_hor2 = display.newImageRect(group_scene,rutaAssets.."rock_large_horizontal.png",3*grid_width,grid_height/2)
rock_large_hor2.x = 12.5*grid_width; rock_large_hor2.y = grid_height*4.25
physics.addBody(rock_large_hor2, "dynamic", {friction = 0.01})

local birds_home = display.newImageRect(group_scene,rutaAssets.."birds_home.png",grid_width,grid_height)
birds_home.x = 12.5*grid_width; birds_home.y = grid_height*3.5
physics.addBody(birds_home, "dynamic", {friction = 0.01})

-- Pigs --

local pig = display.newSprite(group_scene,pig_sprite, sequence)
pig.x = grid_width*12.5; pig.y = grid_height*5.5
pig:scale(0.5,0.5)
pig:setSequence("wait")
pig:play()
physics.addBody(pig, "dynamic",{radius = 15, friction = 0.01})

local pig_hurt = display.newSprite(group_scene,pig_sprite, sequence)
pig_hurt.x = grid_width*11.5; pig_hurt.y = grid_height*3.5
pig_hurt:scale(0.5,0.5)
pig_hurt:setSequence("wait_hurt")
pig_hurt:play()
physics.addBody(pig_hurt, "dynamic",{radius = 15, friction = 0.01})

local pig_military= display.newImageRect(group_scene,rutaAssets.."pig_military.png",1*grid_width,grid_height)
pig_military.x = 12.5*grid_width; pig_military.y = grid_height*8.5
physics.addBody(pig_military, "dynamic", {friction = 0.01})

-- ===== Function of Parabolic Moviment =====
local function parabolic_move(event)
    pos_endedX = event.x
    pos_endedY = event.y
    local delta_X = pos_endedX - pos_beganX
    local delta_Y = pos_endedY - pos_beganY
    local distance = math.sqrt(delta_X^2 + delta_Y^2) -- Calculation of the hypotenuse
    local angle = math.atan2(delta_X, delta_Y) -- Angle in radians
        
    local velocity_max = 10--8.4
    local velocity_began = math.min(distance, velocity_max)

    local forceX = -velocity_began * math.cos(angle)
    local forceY = velocity_began * math.sin(angle)
    red:applyForce(forceX, forceY, red.x, red.y)
end

function onTouch(event)
    -- red:setLinearVelocity(100, -500)
    -- vx, vy = red:getLinearVelocity()
    if event.phase == "began" then
        pos_beganX = event.x
        pos_beganY = event.y
        print(pos_beganX,pos_beganY)
    elseif event.phase == "moved" then
        red.x = event.x
        red.y = event.y
        print(red.x,red.y)
    elseif event.phase == "ended" or event.phase == "cancelled" then
        parabolic_move(event)
    end
end


local function onPostCollision( self, event )
    if event.force >= 0.01 then
        rock_large2.friction = 0
    end
    event.target.x = pos_beganX
    event.target.y = pos_beganY
end

-- CREATE
function scene:create( event )
    local sceneGroup = self.view
    background = display.newImageRect(sceneGroup, rutaAssets.."bg_spring.png", CW, CH)
    background.x, background.y = CW/2, CH/2
    print(background.x,background.y)
    create_grid()
end
 
 
-- SHOW
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
        rock_large2.postCollision = onPostCollision
        rock_large2:addEventListener( "postCollision" )
    end
end
 
 
-- HIDE
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
 
    end
end
 
 
-- DESTROY
function scene:destroy( event )
 
    local sceneGroup = self.view
 
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

Runtime:addEventListener("touch", onTouch)

return scene

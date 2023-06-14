local composer = require( "composer" )
local physics = require "physics"

local scene = composer.newScene()
local group_scene = display.newGroup()
local group_bg = display.newGroup()
local group_interface = display.newGroup()
local background

physics.start()
physics.setDrawMode("hybrid")

group_scene:insert(group_bg)
group_scene:insert(group_interface)

local options_red = {
    width = 522/3,
    height = 341/2,
    numFrames = 6
}

local red_sprite = graphics.newImageSheet(rutaAssets.."sprite_red.png", options_red)

local sequence = {
    {
        name = "fly",
        frames = {1,2,3,4,5,6},
        sheet = red_sprite,
        time = 2500
    }
}

local red = display.newSprite(group_scene,red_sprite, sequence)
red.x = CW*0.09; red.y = CH*0.80
red:scale(0.25,0.25)
red:setSequence("fly")
red:play()

physics.addBody(red, "dynamic",{radius = 15, friction = 0})
print(red.sequence, red.frame)
red.isFixedRotation = true

local floor = display.newRect(group_bg, CW/2, CH*0.9, CW, 30)
floor:setFillColor(0,1,0,0)
floor.anchorY = 0
physics.addBody(floor, "static", {friction = 1})

local projectile = display.newImageRect(group_bg,rutaAssets.."projectile.png",348/3,510/3)
projectile.x = CW*0.12; projectile.y = CH*0.79
physics.addBody(floor, "static", {friction = 1})

-- CREATE
function scene:create( event )
    local sceneGroup = self.view
    background = display.newImageRect(sceneGroup, rutaAssets.."bg_spring.png", CW, CH)
    background.x, background.y = CW/2, CH/2
end
 
 
-- SHOW
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
 
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
 
return scene
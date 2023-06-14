local composer = require( "composer" )
local scene = composer.newScene()
local fondo

function toLevels(event) 
    if event.phase == "ended" then
        composer.gotoScene("levels", {time = 500, effect = "zoomInOut"})
    end
    return true
end

-- CREATE
function scene:create( event )
 
    local sceneGroup = self.view
    fondo = display.newImageRect(sceneGroup, rutaAssets.."Logo_AngryBirds.png",CW, CH )
    fondo.x, fondo.y = CW/2, CH/2
 
end
 
 
-- SHOW
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
        fondo:addEventListener("touch", toLevels)
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
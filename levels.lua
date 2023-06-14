local composer = require( "composer" )
local scene = composer.newScene()
local fondo
local level1_red
local level2_bros
local level3_white

function toPlay(event) 
    if event.phase == "ended" then
        composer.gotoScene("play", {time = 1000, effect = "slideLeft"})
    end
    return true
end

-- CREATE
function scene:create( event )
 
    local sceneGroup = self.view
    fondo = display.newImageRect(sceneGroup, rutaAssets.."fondo_seco.jpg", CW, CH)
    fondo.x, fondo.y = CW/2, CH/2
    fondo.alpha = 0.85

    -- Levels
    level1_red = display.newImageRect(sceneGroup, rutaAssets.."Nivel_Rojo.png", 355/1.5, 433/1.5)
    level1_red.x, level1_red.y = CW*0.25, CH*0.45

    level2_bros = display.newImageRect(sceneGroup, rutaAssets.."Nivel_Azul.png", 355/1.5, 433/1.5)
    level2_bros.x, level2_bros.y = CW*0.5, CH*0.45
    level2_bros.alpha = 0.4

    level3_white = display.newImageRect(sceneGroup, rutaAssets.."Nivel_blanco.png", 355/1.5, 433/1.5)
    level3_white.x, level3_white.y = CW*0.75, CH*0.45
    level3_white.alpha = 0.4
end
 
 
-- SHOW
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
 
    elseif ( phase == "did" ) then
        fondo:addEventListener("touch", toPlay)
 
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
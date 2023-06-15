-----------------------------------------------------------------------------------------
--
-- Proyecto: Angry Birds | LUA
--
-----------------------------------------------------------------------------------------

CW = display.contentWidth
CH = display.contentHeight

rutaAssets = "Assets/" 

local composer = require "composer"

composer.gotoScene("splashScreen", {time = 700, effect = "fade"})
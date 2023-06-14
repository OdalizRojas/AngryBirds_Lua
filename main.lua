-----------------------------------------------------------------------------------------
--
-- Proyecto: Angry Birds | LUA
--
-----------------------------------------------------------------------------------------

CW = display.contentWidth
CH = display.contentHeight

rutaAssets = "Assets/" 

local composer = require "composer"

composer.gotoScene("splashScreen", {time = 1000, effect = "fade"})
-- Filename: main.lua
-- Author: Nyefan
-- Contact: nyfan@aol.com

GLOBAL_SETTINGS = { resolution_x = 320, resolution_y = 180 }

local main_menu


iniFileName = "config.ini"

function love.load()
  readIni(iniFileName)
  implementIni()
  openModule(primary)
end

function readIni(iniFileName)
  --read iniFileName and input the results into GLOBAL_SETTINGS
  
  ---[[ as a placeholder, these default settings are used for testing
  GLOBAL_SETTINGS.resolution_x = 1600
  GLOBAL_SETTINGS.resolution_y = 900
  ---]]
end

function implementIni()
  --implement GLOBAL_SETTINGS
  love.window.setMode( GLOBAL_SETTINGS.resolution_x, 
                       GLOBAL_SETTINGS.resolution_y,
                       {centered=true} -- flags table
                     )
end

function openModule(module)
  love.draw = module.draw or love.draw
  love.errhand = module.errhand or love.errhand
  love.focus = module.focus or love.focus
  love.keypressed = module.keypressed or love.keypressed
  love.keyreleased = module.keyreleased or love.keyreleased
  love.load = module.load or love.load
  love.mousefocus = module.mousefocus or love.mousefocus
  love.mousemoved = module.mousemoved or love.mousemoved
  love.mousepressed = module.mousepressed or love.mousepressed
  love.mousereleased = module.mousereleased or love.mousereleased
  love.quit = module.quit or love.quit
  love.resize = module.resize or love.resize
  love.run = module.run or love.run
  love.textinput = module.textinput or love.textinput
  love.threaderror = module.threaderror or love.threaderror
  love.update = module.update or love.update
  love.visible = module.visible or love.visible
  -- there has to be a more elegant way to do this 
  init = module.init or function() end
  init()
end

main_menu = require "main_menu"
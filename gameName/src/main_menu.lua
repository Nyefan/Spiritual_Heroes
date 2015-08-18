-- Filename: main_menu.lua
-- Author: Nyefan
-- Contact: nyefan@aol.com
-- This module sets up and controls the main menu/game upon launch
-- TODO: abstract button management into another module

local M = {buttons = { main = { campaign =    { newgame =  {},
                                                continue = {},
                                                load =     {},
                                                back =     {} },
                                freeplay =    { newgame =  {},
                                                continue = {},
                                                load =     {},
                                                back =     {} },
                                multiplayer = { lan =      { newgame = {},
                                                             load =    {},
                                                             back =    {} },
                                                hotseat =  { newgame = {},
                                                             load =    {},
                                                             back =    {} },
                                                network =  { newgame = {}, 
                                                             load =    {},
                                                             back =    {} },
                                                back =     {} },
                                options =    {  audio =    { back = {} },
                                                display =  { back = {} },
                                                gameplay = { back = {} },
                                                credits =  { back = {} },
                                                back =     { back = {} } },
                                exitgame =   {} } } }
                                
local engine = require "engine"

             
function M.formButton(menu, buttonName, pos_x, pos_y, size_x, size_y, text, fun)
  menu[buttonName].pos_x = pos_x
  menu[buttonName].pos_y = pos_y
  menu[buttonName].size_x = size_x
  menu[buttonName].size_y = size_y
  menu[buttonName].text = text
  menu[buttonName].fun = fun
end

function M.mouseCollide(x, y, button) --button should be initialized via M.formButton before this is called
  return (x > button.pos_x) and 
         (y > button.pos_y) and 
         (x < button.pos_x+button.size_x) and 
         (y < button.pos_y+button.size_y)
end

function M.init() 
  M.buttons.buttonPressedFlag = false
  M.buttons.buttonPressed = nil

  M.buttons.size_x = GLOBAL_SETTINGS.resolution_x/20 
  M.buttons.size_y = GLOBAL_SETTINGS.resolution_y/20
  M.buttons.hlt_color = {150,   0, 260}
  M.buttons.bkg_color = { 75,   0, 130}
  M.buttons.txt_color = {255, 255, 255}
  M.buttons.txt_outln = {  0,   0,   0}


  --initialize all the buttons in the main menu
  
  M.formButton( M.buttons.main, 
                "campaign",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x, 
                GLOBAL_SETTINGS.resolution_y/7*2-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Campaign",
                function() M.buttons.current = M.buttons.main.campaign end )
  
  M.formButton( M.buttons.main,
                "freeplay",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*3-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Free Play",
                function() M.buttons.current = M.buttons.main.freeplay end )
                
  M.formButton( M.buttons.main,
                "multiplayer",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*4-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Multiplayer",
                function() M.buttons.current = M.buttons.main.multiplayer end )
  
  M.formButton( M.buttons.main,
                "options",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*5-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Options",
                function() M.buttons.current = M.buttons.main.options end )
                
  M.formButton( M.buttons.main,
                "exitgame",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*6-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Exit Game",
                function() love.event.quit() end )
  
  
  --initalize all the buttons in the campaign submenu
  
  M.formButton( M.buttons.main.campaign,
                "newgame",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*2-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "New Game",
                function() end )
                
  M.formButton( M.buttons.main.campaign,
                "continue",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*3-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Continue",
                function() end )
                
  M.formButton( M.buttons.main.campaign,
                "load",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*4-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Load",
                function() end )
                
  M.formButton( M.buttons.main.campaign,
                "back",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*5-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Back",
                function() M.buttons.current = M.buttons.main end )
                
                
  --initalize all the buttons in the freeplay submenu
  
  M.formButton( M.buttons.main.freeplay,
                "newgame",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*2-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "New Game",
                function() 
                  GLOBAL_SETTINGS.game_type = "multiplayer_hotseat"
                  openModule(engine) 
                end )
                
  M.formButton( M.buttons.main.freeplay,
                "continue",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*3-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Continue",
                function() end )
                
  M.formButton( M.buttons.main.freeplay,
                "load",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*4-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Load",
                function() end )
                
  M.formButton( M.buttons.main.freeplay,
                "back",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*5-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Back",
                function() M.buttons.current = M.buttons.main end )
                
                
  --initalize all the buttons in the multiplayer submenu
  
  
  M.formButton( M.buttons.main.multiplayer,
                "lan",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*2-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "LAN",
                function() M.buttons.current = M.buttons.main.multiplayer.lan end )
  
    M.formButton( M.buttons.main.multiplayer.lan,
                  "newgame",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*2-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "New Game",
                  function() end )
                  
    M.formButton( M.buttons.main.multiplayer.lan,
                  "load",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*3-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "Load",
                  function() end )
                  
    M.formButton( M.buttons.main.multiplayer.lan,
                  "back",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*4-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "Back",
                  function() M.buttons.current = M.buttons.main.multiplayer end )
                
  M.formButton( M.buttons.main.multiplayer,
                "hotseat",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*3-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Hotseat",
                function() M.buttons.current = M.buttons.main.multiplayer.hotseat end )
                
    M.formButton( M.buttons.main.multiplayer.hotseat,
                  "newgame",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*2-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "New Game",
                  function() end )
                  
    M.formButton( M.buttons.main.multiplayer.hotseat,
                  "load",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*3-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "Load",
                  function() end )
                  
    M.formButton( M.buttons.main.multiplayer.hotseat,
                  "back",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*4-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "Back",
                  function() M.buttons.current = M.buttons.main.multiplayer end )
                
  M.formButton( M.buttons.main.multiplayer,
                "network",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*4-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Online",
                function() M.buttons.current = M.buttons.main.multiplayer.network end )
                
    M.formButton( M.buttons.main.multiplayer.network,
                  "newgame",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*2-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "New Game",
                  function() end )
                  
    M.formButton( M.buttons.main.multiplayer.network,
                  "load",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*3-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "Load",
                  function() end )
                  
    M.formButton( M.buttons.main.multiplayer.network,
                  "back",
                  GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                  GLOBAL_SETTINGS.resolution_y/5*4-M.buttons.size_y,
                  M.buttons.size_x,
                  M.buttons.size_y,
                  "Back",
                  function() M.buttons.current = M.buttons.main.multiplayer end )
  
  M.formButton( M.buttons.main.multiplayer,
                "back",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/6*5-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Back",
                function() M.buttons.current = M.buttons.main end )
                
                
  --initalize all the buttons in the options submenu
  
  M.formButton( M.buttons.main.options,
                "audio",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*2-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Audio",
                function() end )
                
  M.formButton( M.buttons.main.options,
                "display",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*3-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Display",
                function() end )
  
  M.formButton( M.buttons.main.options,
                "gameplay",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*4-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Gameplay",
                function() end )
  
  M.formButton( M.buttons.main.options,
                "credits",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*5-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "About",
                function() end )
                
  M.formButton( M.buttons.main.options,
                "back",
                GLOBAL_SETTINGS.resolution_x/2-M.buttons.size_x,
                GLOBAL_SETTINGS.resolution_y/7*6-M.buttons.size_y,
                M.buttons.size_x,
                M.buttons.size_y,
                "Back",
                function() M.buttons.current = M.buttons.main M.init() end )
  
  --start the module by loading into the main menu
  M.buttons.current = M.buttons.main
end

function M.draw()
  for k, item in pairs(M.buttons.current) do
    if type(item) == 'table' then
      love.graphics.setColor(M.buttons.bkg_color)
      love.graphics.rectangle("fill", item.pos_x, item.pos_y, M.buttons.size_x, M.buttons.size_y)
      love.graphics.setColor(M.buttons.txt_color)
      love.graphics.print(item.text, item.pos_x+10, item.pos_y+10)
    end
  end
end

function M.update(dt) --dt is the time since update was last called
  love.graphics.setNewFont(12)
  love.graphics.setBackgroundColor(255,255,255)
  if love.mouse.isDown('l') then
    love.graphics.setBackgroundColor(love.mouse.getX(),love.mouse.getY(),math.sqrt(math.pow(love.mouse.getX(), 2) + math.pow(love.mouse.getY(), 2))/2)
  end
end

--function M.mousemoved(x, y, dx, dy) 
--  for k, item in pairs(M.buttons.current) do
--    if type(item) == 'table' and M.mouseCollide(x,y,item) then
--    end
--  end
--end

function M.mousepressed(x, y, button)
  for k, item in pairs(M.buttons.current) do
    if button == 'l' and type(item) == 'table' and M.mouseCollide(x,y,item) then
      M.buttons.buttonPressedFlag = true
      M.buttons.buttonPressed = item
    end
  end
end

function M.mousereleased(x, y, button)
  if button == 'l' and M.buttons.buttonPressedFlag and M.mouseCollide(x,y,M.buttons.buttonPressed) then
    M.buttons.buttonPressed.fun()
  end
  M.buttons.buttonPressedFlag = false
end

local public = { draw = M.draw,
                 errhand = M.errhand,
                 focus = M.focus,
                 init = M.init,
                 keypressed = M.keypressed,
                 keyreleased = M.keyreleased,
                 load = M.load,
                 mousefocus = M.mousefocus,
                 mousemoved = M.mousemoved,
                 mousepressed = M.mousepressed,
                 mousereleased = M.mousereleased,
                 quit = M.quit,
                 resize = M.resize,
                 run = M.run,
                 textinput = M.textinput,
                 threaderror = M.threaderror,
                 update = M.update,
                 visible = M.visible }
return public
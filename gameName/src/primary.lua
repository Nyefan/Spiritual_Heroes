-- This file sets up and controls the main menu/game upon launch

local M = {}

M.draw = function()
           love.graphics.setColor(255,255,255)
           love.graphics.print(M.text, 10, 20)
         end

M.update = function(dt) --dt is the time since update was last called
             
             love.graphics.setNewFont(12)
             love.graphics.setBackgroundColor(255,255,255)
             M.text = "Nothing has been done"
            if love.mouse.isDown('l') then
               love.graphics.setBackgroundColor(love.mouse.getX(),love.mouse.getY(),math.sqrt(math.pow(love.mouse.getX(), 2) + math.pow(love.mouse.getY(), 2))/2)
               M.text = "The color has been changed with the mouse"
             end
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
local camera = {};

camera.load = function ()
    
    love.window.setMode(love.graphics.getWidth(),love.graphics.getWidth()*19/16,{fullscreen = true});
    local gameWidth = 1920;
    screenScale = 1/(love.graphics.getWidth()/gameWidth);
    zoom = 1;
    translate = {x = 0, y = 0};
    local isPan = false;
    
end

camera.screenToWorldcords = function (x,y)
    
    return {x = x/screenScale/zoom - translate.x, y = y/screenScale/zoom - translate.y};

end

camera.worldToScreencords = function (x,y)
    
    return {x = x*screenScale*zoom - translate.x, y = y*screenScale*zoom - translate.y};

end




local function scrl(y)
    local bmouse = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY());

    zoom = zoom + 0.1*y;
 
    local amouse = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY());

    local d = {x = amouse.x - bmouse.x, y = amouse.y - bmouse.y}; 

    translate.x = translate.x + d.x;
    translate.y = translate.y + d.y;
end

local function setPan(button)
    if(button == 3) then isPan = true; end
end

local function resPan(button)
    if(button == 3) then isPan = false; end
end

local function updatePan ()
    local mouse = {x = love.mouse.getX(), y = love.mouse.getY();}; 

    if(isPan) then
        translate.x = translate.x + (mouse.x - prevX)/screenScale/zoom;
        translate.y = translate.y + (mouse.y - prevY)/screenScale/zoom;
    end    

    prevX = mouse.x;
    prevY = mouse.y;
end    

camera.update = function (type,value)
    
    if(type == "scrl") then scrl(value);
    elseif(type == "mPush") then setPan(value);
    elseif(type == "mRel") then resPan(value);
    elseif(type == "pan") then updatePan(); end    

end

return camera;
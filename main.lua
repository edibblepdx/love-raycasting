function love.load()
    love.keyboard.setKeyRepeat(true)
    worldMap = {
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
        {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,1},
        {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,4,0,0,0,0,5,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,4,0,4,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,4,0,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,4,4,4,4,4,4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
        --[[
        {1,1,1,1,1,1,1,1},
        {1,0,0,0,0,0,0,1},
        {1,0,1,0,1,0,0,1},
        {1,0,0,0,0,0,0,1},
        {1,0,1,0,1,0,0,1},
        {1,0,0,0,0,0,0,1},
        {1,0,0,0,0,0,0,1},
        {1,1,1,1,1,1,1,1},
        ]]
        
    }
    -- FOV = 2arctan(||direction|| / ||camera plane||)
    playerX, playerY = 12, 12       -- player position vector
    dirX, dirY = -1, 0          -- player direction vector
    planeX, planeY = 0, 0.66    -- camera plane
    windowWidth = 512
    windowHeight = 512
end

function love.update(dt)
    local rotSpeed = 0.025 -- radians

    -- move
    --[[
    if love.keyboard.isDown('d') then playerX = playerX + 1
    elseif love.keyboard.isDown('a') then playerX = playerX - 1
    elseif love.keyboard.isDown('s') then playerY = playerY + 1
    elseif love.keyboard.isDown('w') then playerY = playerY - 1
    end
    ]]
    local moveSpeed = 0.025
    if love.keyboard.isDown('up') then 
        playerX, playerY = playerX + moveSpeed * dirX, playerY + moveSpeed * dirY
    elseif love.keyboard.isDown('down') then 
        playerX, playerY = playerX - moveSpeed * dirX, playerY - moveSpeed * dirY
    end
    
    -- rotate
    if love.keyboard.isDown('right') then
        local oldDirX = dirX
        dirX = dirX * math.cos(-rotSpeed) - dirY * math.sin(-rotSpeed)
        dirY = oldDirX * math.sin(-rotSpeed) + dirY * math.cos(-rotSpeed)
        local oldPlaneX = planeX
        planeX = planeX * math.cos(-rotSpeed) - planeY * math.sin(-rotSpeed)
        planeY = oldPlaneX * math.sin(-rotSpeed) + planeY * math.cos(-rotSpeed)
    elseif love.keyboard.isDown('left') then
        local oldDirX = dirX
        dirX = dirX * math.cos(rotSpeed) - dirY * math.sin(rotSpeed)
        dirY = oldDirX * math.sin(rotSpeed) + dirY * math.cos(rotSpeed)
        local oldPlaneX = planeX
        planeX = planeX * math.cos(rotSpeed) - planeY * math.sin(rotSpeed)
        planeY = oldPlaneX * math.sin(rotSpeed) + planeY * math.cos(rotSpeed)
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0.1,0.1,0.1)

    --[[
    love.graphics.setColor(1,1,0)
    love.graphics.circle('fill', playerX, playerY, 5)
    love.graphics.line(playerX, playerY, playerX + (20 * dirX), playerY + (20 * dirY))
    ]]

    for x = 1, windowWidth do
        -- calculate ray position and direction
        local cameraX = (2 * (x - 1) / windowWidth) - 1 -- x-coordinate in camera space
        local rayDirX = dirX + planeX * cameraX
        local rayDirY = dirY + planeY * cameraX

        -- what tile of the map the player is in
        local mapX, mapY = math.floor(playerX), math.floor(playerY)
        
        -- length of ray from player position to next closest x or y-side
        local sideDistX, sideDistY

        -- distance from hit to camera plane
        local perpWallDist

        -- length of ray from one x or y-side to next x or y-side
        local deltaDistX = rayDirX == 0 and math.huge or math.abs(1 / rayDirX)
        local deltaDistY = rayDirY == 0 and math.huge or math.abs(1 / rayDirY)
        local perpWallDist

        -- what direction to step in the x or y-direction (+1 or -1)
        local stepX, stepY

        local hit = false   -- was a wall hit?
        local side          -- was it a E/W (0) or N/S wall (1)?

        -- calculate initial step and initial sideDist
        if rayDirX < 0 then
            stepX = -1
            sideDistX = (playerX - mapX) * deltaDistX
        else
            stepX = 1
            sideDistX = (mapX + 1 - playerX) * deltaDistX
        end
        if rayDirY < 0 then
            stepY = -1
            sideDistY = (playerY - mapY) * deltaDistY
        else
            stepY = 1
            sideDistY = (mapY + 1 - playerY) * deltaDistY
        end

        -- DDA algorithm
        while not hit do
            if sideDistX < sideDistY then
                -- jump to next map tile in x-direction
                sideDistX = sideDistX + deltaDistX
                mapX = mapX + stepX
                side = 0
            else
                -- jump to next map tile in y-direction
                sideDistY = sideDistY + deltaDistY
                mapY = mapY + stepY
                side = 1
            end
            -- check if ray has hit a wall
            if (worldMap[mapY][mapX] > 0) then hit = 1 end
        end

        -- calculate distance projected on camera plane (avoid fisheye)
        if side == 0 then perpWallDist = sideDistX - deltaDistX
        else perpWallDist = sideDistY - deltaDistY 
        end

        -- calculate the height of the line to draw on screen
        local lineHeight = math.floor(windowHeight / perpWallDist)

        -- calculate lowest and highest pixel to fill in current stripe
        local drawStart = -lineHeight / 2 + windowHeight / 2
        if drawStart < 0 then drawStart = 0 end
        local drawEnd = lineHeight / 2 + windowHeight / 2
        if drawEnd >= windowHeight then drawEnd = windowHeight - 1 end

        if side == 0 then love.graphics.setColor(1,0,0)
        else love.graphics.setColor(0.5,0,0)
        end
        
        love.graphics.line(x, drawStart, x, drawEnd)
    end
end

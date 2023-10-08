-- snake game demo

-- window config
local winWidth, winHeight, winTitle = 400, 400, "Snake.lua"
local gameState = "Play"

-- snake config
local snake = {x= winWidth /2, y = winHeight /2, height = 10, width = 10, size = 1, dir = true, UPDIR = false, speed = 100}
local defSpeed = snake.speed
-- score
local gameScore = 0

-- create a game state once the spaghetti code is done
function love.load()
    -- window setup
    love.window.setMode(winWidth, winHeight)
    love.window.setTitle(winTitle)

    -- init game
    resetGame()
end

function love.update(dt)
    
    -- game state
    if gameState == 'Play' then
        if snake.dir == true then
            snake.x = snake.x + snake.speed * dt
            snake.UPDIR = true
        else
            snake.y = snake.y - snake.speed * dt -- snake goes up
        end
    
        if love.keyboard.isDown("up") and snake.UPDIR == true then
            snake.dir = false
            snake.UPDIR = false
            snake.speed = defSpeed
        elseif love.keyboard.isDown("down") and snake.UPDIR == true then
            snake.dir = false
            snake.UPDIR = false
            snake.speed = -defSpeed
        end
    
        if love.keyboard.isDown("left") and snake.dir == false then
            snake.dir = true
            snake.speed = -defSpeed
        elseif love.keyboard.isDown("right") and snake.dir == false then
            snake.dir = true
            snake.speed = defSpeed
        end

        -- collision ingame
        if snake.x < 0 or snake.x + snake.width > winWidth or
           snake.y < 0 or snake.y + snake.height > winHeight then
            gameState = "gameover"
        end    
    end
    
    -- reset game
    if gameState == "gameover" and love.keyboard.isDown("r") then
        resetGame()
    end

end -- func ends


function resetGame()
    snake.x = winWidth /2
    snake.y = winHeight /2
    -- Reset game state
    gameState = "Play"
end

function love.draw()
    love.graphics.clear() -- cls

    -- main
    if gameState == "Play" then
        -- drawin snake
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", snake.x, snake.y, snake.width, snake.height)
        -- drawin score
        love.graphics.setColor(1, 1, 1, 0.3)
        love.graphics.setFont(love.graphics.newFont(14))
        love.graphics.print("Score: " .. gameScore, 10, 10)
        
    elseif gameState == "gameover" then
        -- Draw the "Game Over" screen
        love.graphics.setColor(1, 0, 0)  -- Red color
        love.graphics.setFont(love.graphics.newFont(38))
        love.graphics.printf("Game Over", 0, winHeight / 2 - 48, winWidth, "center")
        love.graphics.setFont(love.graphics.newFont(18))
        love.graphics.printf("Press 'r' to restart", 0, winHeight / 2 + 24, winWidth, "center")
    end

end
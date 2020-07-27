--[[
    push es una libreria que nos permite dibujar nuestro juego
    en una resolucion virtual 
    https://github.com/Ulydev/push

    Ejemplo:
    push local =  requiere  " push "

    locales gameWidth, gameHeight =  1080 , 720  - fijado resolución del juego 
    local de WindowWidth, WindowHeight = love.windows. getDesktopDimensions ()
    or variables
    WINDOW_WIDTH = 1280
    WINDOW_HEIGHT = 720


    function love.load()
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, 
    {
        fullscreen = true,
        resizable = true,
        vsync = true
    })
    end

    function love.draw()
        push:start()
  
         draw here

         push:finish()
    end
]]
push = require 'push'
--[[ "Class" library dispara algunas variables y metodos 
Class = require 'class'
]]
Class = require 'class'


require 'Paddle'    -- Nuestra Paddle class

require 'Ball'      -- Nuestra Ball class

WINDOW_WIDTH = 1280     --Variables
WINDOW_HEIGHT = 720         --Variables

VIRTUAL_WIDTH = 432             --Variables
VIRTUAL_HEIGHT = 243                --Variables

PADDLE_SPEED = 200  -- Velocidad que se va a mover la paleta, multiplicada por el 
--                          (dt) in UPDATE

---------------------------------------------------------------------------------------------------------------------
function love.load()        -- Inicializacion en el juego.

    love.graphics.setDefaultFilter('nearest', 'nearest')    --Para acercar los pixeles


    love.window.setTitle('Pong')        --Titulo de la aplicacion de Windows

    --math.randomseed(os.time())          --startup every time

   
    smallFont = love.graphics.newFont('font.ttf', 8)    --Inicializacion de nuestro FONT-TEXT RETRO
    largeFont = love.graphics.newFont('font.ttf', 16)       --Inicializacion de nuestro FONT-TEXT RETRO
    scoreFont = love.graphics.newFont('font.ttf', 32)           --Inicializacion de nuestro FONT-TEXT RETRO
    
    
    love.graphics.setFont(smallFont)        --Seteo  el FONT en los Graphicos

    sounds = {                                                                      --Indexamos la Key, con Source (Ubicacion del archivo. en string +, static)
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),      --  para utilizarlo es como un diccionario en Python, se le envia la Key:PLAY() 
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),                    --sounds['paddle_hit']:play()
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')       ,
        ['miCancion2'] = love.audio.newSource('sounds/miCancion2.mp3','static')
     }


    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {      -- inicializamos la Virtual Reality
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1Score = 0           --Variables Iniciadas
    player2Score = 0                --Variables Iniciadas

  
    servingPlayer = 1           --Inicializacion de quien sirve primero

    
    player1 = Paddle(10, VIRTUAL_HEIGHT/2, 5, 20)                             --Variable  Ubicacion y  tamaño usando el constructor de la clase, le envio los parametros
    player2 = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT /2, 5, 20)--Variable Ubicacion y  tamaño usando el constructor de la clase, le envio los parametros
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)   --Variable Ubicacion y  tamaño usando el constructor de la clase, le envio los parametros 

    gameState = 'start'             --Variable del juego, ESTADO DEL JUEGO AL INICIAR LA PARTIDA
end



function love.resize(w, h)      --Cambiar tamaño de la pantalla virtual del juego
    push:resize(w, h)
end

---------------------------------------------------------------------------------------------------------------------
function love.update(dt)            --Parametro DeltaTime
    if gameState == 'serve' then
       
        ball.dy = math.random(-50, 50)          --Random Iniciacion 

        if servingPlayer == 1 then                  --Si el servidor es 1
            ball.dx = math.random(140, 200)             --Lanzo la pelota a la derecha
        else                                                --RELACIONADO CON function love.keypressed(key) +servingPlayer
            ball.dx = -math.random(140, 200)                --Sino lanzo la pelota a la Izquierdo
        end
    elseif gameState == 'play' then
        sounds['miCancion2']:play()                 --Sonido
        if ball:collides(player1) then              --Detectar la colicion y si la detecta PLAYER 1
            ball.dx = -ball.dx * 1.03                   --La invierte + le aumento la velocidad, multiplicadole * DELTA TIME
            ball.x = player1.x + 5                          --ordenadas al EJE X (ANGULO)

            
            if ball.dy < 0 then                         --Random Ubicacion en el EJE Y
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()                 --Sonido
        end


        if ball:collides(player2) then                 --Detectar la colicion y si la detecta PLAYER 2     
            ball.dx = -ball.dx * 1.03                       --La invierte + le aumento la velocidad, multiplicadole * DELTA TIME
            ball.x = player2.x - 4                               --ordenadas al EJE X (ANGULO)

            
            if ball.dy < 0 then                         --Random Ubicacion en el EJE Y
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()                 --Sonido
        end

        
        if ball.y <= 0 then               -- Detecto si coliciona con el eje X es decir el borde SUPERIOR del Virtual Game
            ball.y = 0
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end

        
        if ball.y >= VIRTUAL_HEIGHT - 4 then    -- Detecto si coliciona con el eje X es decir el borde INFERIOR del Virtual Game
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
            sounds['wall_hit']:play()
        end
        
        
        if ball.x < 0 then              --JUGADOR 2 SI LE ANOTA AL JUGADOR 1
            servingPlayer = 1           --Sumamos el Score y Administramos el score para servir en base a quien anota
            player2Score = player2Score + 1
            sounds['score']:play()              --Sonido

            
            if player2Score == 10 then  -- WINNING
                winningPlayer = 2
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()    --Reseteamos la Bola al medio, pero no la velocidad.
            end
        end

        if ball.x > VIRTUAL_WIDTH then      --JUGADOR 1 SI LE ANOTA AL JUGADOR 2
            servingPlayer = 2               --Sumamos el Score y Administramos el score para servir en base a quien anota
            player1Score = player1Score + 1
            sounds['score']:play()          --Sonido
            
            if player1Score == 10 then      -- WINNING
                winningPlayer = 1
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()                --Reseteamos la Bola al medio, pero no la velocidad.
            end
        end
    end

    --[[                                                      player 1 movimiento
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end
    ]]   
    --[[                                                   player 2 movimiento
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end
    ]]

   Paddle:AI()                                              --AI
    
    if gameState == 'play' then         --Lavelocidad es independiente de el STATE 
        ball:update(dt)
    end

    player1:update(dt)          --Objeto/Instanciacion del tipo Paddle + llamar a la funcion
    player2:update(dt)              --Objeto/Instanciacion del tipo Paddle + llamar a la funcion
end
---------------------------------------------------------------------------------------------------------------------
function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    
    elseif key == 'enter' or key == 'return' then       --Cambios de State
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then     --Reseteamos la bola y el STATE si anota, es decir DONE si llega a 10
          
            gameState = 'serve'                 

            ball:reset()

          
            player1Score = 0        --Resetear Scorel
            player2Score = 0

            
            if winningPlayer == 1 then      --Decidir quien Sirve en base a quien anoto
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end
---------------------------------------------------------------------------------------------------------------------
function love.draw()

    push:apply('start')                         --Usar la Class Push

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)            --Setiar el color
    love.graphics.setFont(smallFont)                                    --Setiar FONT


    if gameState == 'start' then                            --Diferentes mensajes Para el STATE
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
    --                                                                              Sin titulo
    elseif gameState == 'done' then
        
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
    end

    player1:render()            --Con esto creo las paletas de jugadores en la funcion, pasandole por constructor los previos datos
    player2:render()            --Con esto creo las paletas de jugadores en la funcion, pasandole por constructor los previos datos
    ball:render()

    
    displayScore()
    displayFPS()
   

    push:apply('end')
end


function displayFPS()                           --Funcion para ver el fps
    
    love.graphics.setFont(smallFont)            --Aplico la FONT creada en el HEAD
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end


function displayScore()                              --Funcion para ver el SCORE
    
    love.graphics.setFont(scoreFont)            --Aplico la FONT creada en el HEAD
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, 
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)
end

Paddle = Class{}

function Paddle:init(x, y, width, height)           --Constructor
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)
   
    if self.dy < 0 then                          --Para poner el tope superior
        self.y = math.max(0, self.y + self.dy * dt) --Comparo para que el tope Maximo sea 0
    
    else                                                                            --Para poner el tope Inferior
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)          --Comparo para que el tope Minimo sea el alto(teniendo en cuenta el alto del paddle)
    end                                                                                     --segundo parametro es la ubicacion en DT(delta time, tiempo real, del paddle)
end


function Paddle:render()                    --Para crear el los padel
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end


function Paddle:AI()                        --AI
     
            if gameState=='play' then
                if 2 > 1 then
                    player2.y=ball.y
                    
                end
                if 2 > 1 then
                    player1.y=ball.y
                    
                end
            end
      
end
Ball = Class{}

function Ball:init(x, y, width, height)             --Constructor
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = math.random(2) == 1 and -100 or 100                                   --Random  Iniciacion en el EJE X
    self.dx = math.random(2) == 1 and math.random(-80, -100) or math.random(80, 100)    --Randon Iniciacion en el EJE Y
end

function Ball:collides(paddle)

    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then          --Comparo mientras no choque con las coordenas o no se super pongan, por eso es
        return false                                                                        --< or >  sin el = ya que sino se super pondria
    end

    
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then        --Comparo mientras no choque con las coordenas o no se super pongan, por eso es
        return false                                                                        --< or >  sin el = ya que sino se super pondria
    end 
 
    return true     --Si es TRUE , le envio la colicion con lo cual, invirte los datos en el MAIN
end


function Ball:reset()                                --Random Iniciacion
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

-- simplemente le aplicamos velocidad a la posicion, con la escala  deltatime

function Ball:update(dt)                        --segundo parametro es la ubicacion en DT(delta time, tiempo real, del paddle)
    self.x = self.x + self.dx * dt                 
    self.y = self.y + self.dy * dt
end

function Ball:render()                              --Creo el ballon
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
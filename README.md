# Pong
En Pong, habrá dos paletas y una pelota que rebotará entre ellas, y dibujaremos cada componente y el texto. 
Usaremos el lenguaje Lua y el marco LÖVE, y aprenderemos sobre el estado del juego, 
la programación orientada a objetos y la detección de colisiones.

Usaremos un lenguaje de programación llamado Lua, similar a JavaScript, enfocado en "tablas", 
que son como objetos en JavaScript o diccionarios en Python, con pares clave-valor.
LÖVE es un marco de desarrollo de juegos en 2D, escrito en C ++, 
pero nos permite usar Lua para escribir juegos que se ejecutan en el marco, 
con características integradas como gráficos, 
entrada de teclado, matemáticas, audio, física y más.
Necesitaremos instalar LÖVE desde https://love2d.org/ , 
donde también podemos encontrar su documentación y wiki. 
El wiki también tiene instrucciones para instalarlo fácilmente en nuestro sistema operativo. 
Necesitaremos algún tipo de editor de código, como Visual Studio Code, Atom o Sublime Text.
Podemos abrir VS Code y crear una nueva carpeta para nuestro proyecto con un archivo llamado main.lua. 
Este es el archivo principal que ejecutará Lua. 
Agregaremos una pequeña función y luego arrastraremos nuestra carpeta a la parte superior de la aplicación Lua, 
que ejecutará nuestro código por nosotros. En VS Code, también podemos agregar una extensión para hacer esto con solo un atajo de teclado.
En nuestros juegos, confiaremos en el sistema de coordenadas 2D, 
donde nuestra esquina superior izquierda es 0, 0, y x es la distancia horizontal de izquierda a derecha, e y 
es la distancia vertical de arriba a abajo fondo.

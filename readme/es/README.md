![uW33D Anticheat.](https://cdn.discordapp.com/attachments/1110700176361918545/1137505212903456808/AC.png "Anticheat")

# **Anticheat para MTA (Multi Theft Auto)**

Bienvenido al proyecto Anticheat para Multi Theft Auto (MTA). Este repositorio tiene como objetivo alojar el desarrollo de un sistema anticheat para mejorar la integridad y equidad del juego en el entorno multijugador de MTA.

[Video sobre cómo configurarlo + AntiVPN](https://youtu.be/XuNNihYl7KE)

[Todas las versiones de Anticheat](https://github.com/ruip005/mta_anticheat/releases)

## Elija su idioma
Tenga en cuenta que solo el portugués es estable y completo; otros idiomas pueden tener errores graves debido a que no están terminados. Espere una versión estable o úselo SOLO en portugués.
  
 * [Português](https://github.com/ruip005/mta_anticheat/blob/main/readme/pt/README.md)   
 * [Español](https://github.com/ruip005/mta_anticheat/blob/main/readme/es/README.md)  
 * [Inglés](https://github.com/ruip005/mta_anticheat/blob/main/readme/en/README.md)
 * [Türkçe](https://github.com/ruip005/mta_anticheat/blob/main/readme/tr/README.md)  
 * [Alemán](https://github.com/ruip005/mta_anticheat/blob/main/readme/de/README.md) 

## Autenticación

### Autenticación para iniciar el anticheat.

| Variable   | Tipo       | Descripción                           |
| :---------- | :--------- | :---------------------------------- |
| `user` | `string` | **Obligatorio**. Nombre de usuario |
| `key` | `string` | **Obligatorio**. Clave de activación del usuario |


### Algunas Autenticaciones Gratuitas.

1.
**user**: `trial01`

**key**: `f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85`

2.
**user**: `trial02`

**key**: `a0b27debfdda2cb2e99f4faf47b8f6b7b758b0c1c36f53d42078d9df9212c252`

3.
**user**: `trial03`

**key**: `656f0a57cb751e8f55779b991ba4ea016e870b68f2d86271dfe0701bfe70f300`

*Si su clave es privada, no la comparta con nadie; ¡úsela solo en su servidor! Nuestro sistema detecta la IP original y el puerto del servidor que inicia el anticheat.*  

 
## Resumen

El objetivo de este proyecto es crear un anticheat eficiente y sólido para Multi Theft Auto. El anticheat tiene como objetivo detectar y prevenir trampas, hacks y otras actividades fraudulentas que puedan afectar negativamente la experiencia de juego de los jugadores.

## Funciones

- **Captura de Pantalla**: Captura una imagen de la pantalla del jugador sospechoso y la muestra en la pantalla del personal, además de guardarla en una carpeta dentro del mod anticheat.

- **Discord Webhook**: Este anticheat también tiene registros que se envían a canales de Discord a través de webhooks.

- **No AntiScreenShot**: Esta función, cuando está habilitada, solo permite que los jugadores se unan al servidor si la opción "Permitir capturas de pantalla" está activada.

- **Binds**: Esta función alerta al personal cuando se presionan teclas que normalmente se usan para activar trampas.

- **Anti "Backdoor"**: Esta función ayuda a descubrir comandos ocultos en mods compilados.

- **Path**: Esta función ayuda a descubrir la ubicación de un mod específico en el servidor.

- **Lista Negra de Armas**: Esta función detecta jugadores con armas no autorizadas en el servidor y los prohíbe (excepto el personal).

- **Lista Negra de Vehículos**: Esta función detecta jugadores con vehículos no autorizados en el servidor y los prohíbe (excepto el personal).

- **Velocidad de Juego**: Esta función detecta si la velocidad de juego de un jugador está por encima de lo normal.

- **Anti Jetpack**: Esta función detecta si un jugador no es parte del personal y está usando un jetpack; serán prohibidos.

- **Anti Fly [BETA]**: Esta función aún no está completamente funcional, pero su objetivo es detectar si un jugador está volando sin ser parte del personal del servidor.

- **Disparo RPG**: Si la función de lista negra de armas no detecta a un tramposo, se activará esta función. Cuando un jugador que utiliza un RPG dispara, se activa un disparador, lo que resulta en una prohibición.

- **Disparo desde Tanque**: Es similar a la función anterior, pero se activa si un tramposo dispara desde un tanque.

- **Spawn VBR**: Esta función es para aquellos que usan VBR e incluye la opción de invocar un tanque y una hydra. Esta función analiza si un tramposo tiene un tanque en el lado del cliente y otro vehículo en el lado del servidor, lo que resulta en una prohibición.

- **Anti Detención de Recursos**: Esta función evita que los mods del servidor se desactiven. Si un cliente desactiva mods importantes, se les prohibirá en el servidor.

- **Anti Aimbot [BETA]**: Esta función aún no está completamente funcional, pero su objetivo es detectar si un jugador mueve su objetivo demasiado rápido, como si estuviera usando un aimbot.

- **Seriales de Personal**: Cuando está activada, esta función solo permite que los "staffers" registrados entren.

- **Wallhack de Personal**: Esta función está disponible solo para el personal del servidor y les ayuda a conocer la ubicación de los jugadores cercanos.

- **Registros de Prohibiciones y Desbloqueos**: Esta función envía un registro a Discord con información sobre qué miembro del personal prohibió o desbloqueó a un jugador.

- **Prohibición Global**: Esta función es exclusiva del anticheat y, cuando está activada, los jugadores que hayan utilizado trampas recientemente serán prohibidos por el sistema al ingresar al servidor.

- **Anti Prohibición**: Esta función evita que los jugadores con seriales registrados sean prohibidos.

- **Actualización**: El anticheat tiene un sistema

 de actualización.

- **Arma Invisible [BETA]**: Esta función aún no está completamente probada, pero su objetivo es detectar si un jugador tiene un arma invisible.

- **Anti Reparación [BETA]**: Esta función aún no está completamente probada, pero su objetivo es detectar si un jugador ha ejecutado alguna función de reparación de vehículos y cancelarla.

- **Anti Ritmo de Disparo**: Esta función aún no está completamente probada, pero su objetivo es detectar si un jugador ha disparado múltiples tiros en segundos, lo que resulta en una prohibición.

- **Anti VPN**: Esta función detecta si un jugador está utilizando una VPN, lo que resulta en una expulsión.

- **Vehículos Falsos**: Esta función detecta si un jugador ha invocado un vehículo a través de un menú de mods.

- **Teletransportar Vehículo hacia mí**: Esta función detecta si un jugador ha teletransportado un vehículo existente lejos de su ubicación.

- **API de Capturas de Pantalla**: Todas las capturas de pantalla ahora se almacenan en un servidor web a través de una API, lo que permite enviar un registro de Discord con archivos multimedia.

- **Anti Velocidad Máxima**: Esta función detecta si un jugador se mueve a una velocidad extremadamente alta.

- **Compartir Pantalla**: Esta función muestra la pantalla de un jugador al personal. (Créditos a *zJoaoFtw_*, ya que lo creó.)

- **Datos de Elemento**: Esta función detecta modificaciones no autorizadas en los datos de elemento del jugador.

- **Ejecutor Lua**: Esta función detecta cualquier inyección de código LUA en el lado del cliente.

- **Lista Negra/Bloqueo de Comandos**: Esta función castiga a los jugadores que ejecutan un comando en la lista negra.
  
## Aviso Legal

Este proyecto se desarrolla de forma independiente y no tiene afiliación oficial con los desarrolladores de Multi Theft Auto o la serie Grand Theft Auto. El uso de este anticheat es opcional y se basa en la elección de los administradores del servidor MTA.

## Contacto

Si tiene preguntas, sugerencias o informes de problemas, no dude en crear un problema en este repositorio o ponerse en contacto a través de Discord en uw33d (ID de usuario: 297122391580999692).

## Compartir

Si distribuye este recurso, por favor, dé crédito, ya que este proyecto fue bastante agotador y llevó mucho tiempo crearlo.

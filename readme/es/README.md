# **Anticheat para MTA (Multi Theft Auto)**

Bienvenido al proyecto de Anticheat para Multi Theft Auto (MTA). Este repositorio está diseñado para albergar el desarrollo de un sistema anticheat destinado a mejorar la integridad y equidad del juego en el entorno multijugador de MTA.

[Video sobre cómo configurar + AntiVPN](https://youtu.be/XuNNihYl7KE)

## Autenticación

### Autenticación para iniciar el anticheat.

| Variable | Tipo     | Descripción                                 |
| :------- | :------- | :------------------------------------------ |
| `user`   | `string` | **Obligatorio**. Nombre de usuario          |
| `key`    | `string` | **Obligatorio**. Clave de activación del usuario |

### Algunas autenticaciones gratuitas.

1.
**user**: `trial01`

**key**: `f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85`

2.
**user**: `trial02`

**key**: `a0b27debfdda2cb2e99f4faf47b8f6b7b758b0c1c36f53d42078d9df9212c252`

3.
**user**: `trial03`

**key**: `656f0a57cb751e8f55779b991ba4ea016e870b68f2d86271dfe0701bfe70f300`

## Visión General

El objetivo de este proyecto es crear un anticheat eficiente y sólido para Multi Theft Auto. El anticheat tiene como objetivo detectar y prevenir trampas, hacks y otras actividades fraudulentas que puedan afectar negativamente la experiencia de juego de los jugadores.

## Funcionalidades

- **Captura de Pantalla**: Tomar una captura de pantalla de un jugador sospechoso y mostrarla en la pantalla del personal y guardarla en una carpeta dentro del mod del anticheat.

- **Discord Webhook**: Este anticheat también cuenta con registros que se enviarán a salas de Discord a través de webhooks.

- **Sin AntiScreenShot**: Esta característica, cuando está activada, permite que los jugadores jueguen en el servidor solo si tienen habilitada la opción "Permitir el envío de capturas de pantalla".

- **Binds**: Esta función alerta al personal cuando se presionan teclas que normalmente se utilizan para abrir trampas.

- **Anti "Backdoor"**: Esta función ayuda a descubrir comandos ocultos en los mods compilados.

- **Ruta**: Esta función ayuda a descubrir la ubicación de un mod específico en el servidor.

- **Lista Negra de Armas**: Esta función detecta a los jugadores que tienen armas no permitidas en el servidor y los banea (excepto el personal).

- **Lista Negra de Vehículos**: Esta función detecta a los jugadores que tienen vehículos no permitidos en el servidor y los banea (excepto el personal).

- **Velocidad del Juego**: Esta función detecta si un jugador tiene la velocidad del juego por encima de lo normal.

- **Anti Jetpack**: Esta función detecta si un jugador no es parte del personal y está usando un Jetpack, y lo banea.

- **Anti Fly [BETA]**: Esta función aún no está al 100%, pero su función es detectar si un jugador está volando sin ser parte del personal del servidor.

- **RPG Fire**: En caso de que la función de la lista negra de armas no detecte nada, se activará esta función de RPG Fire, que consiste en que si un jugador que está usando un RPG dispara, se activará un *trigger* que luego baneará al tramposo.

- **Tank Fire**: Es casi lo mismo que la función anterior, pero si el tramposo dispara desde un tanque.

- **Spawn de VBR**: Esta función es para quienes usan VBR y contiene la opción de hacer aparecer un tanque y un hydra; esta función analiza si el tramposo tiene un tanque en el lado del cliente y otro vehículo en el lado del servidor, lo que resultará en un baneo.

- **Anti Detención de Recursos**: Esta función evita que los mods del servidor se apaguen si el cliente desactiva mods importantes; en ese caso, se banea al jugador.

- **Anti Aimbot [BETA]**: Esta función aún no está al 100%, pero su función es detectar si un jugador está moviendo su mira demasiado rápido, como si fuera un aimbot real.

- **Serials de Personal**: Cuando esta función está activada, solo permite la entrada de personal con serials registrados.

- **Wallhack de Personal**: Esta función está presente solo para el personal del servidor y ayuda a saber dónde se encuentran los jugadores cercanos.

- **Registros de Baneo y Desbaneo**: Esta función enviará un registro a Discord con información sobre qué miembro del personal baneó o desbaneó a un jugador.

- **Baneo Global**: Esta función es exclusiva del anticheat y, cuando está activada, los jugadores que hayan utilizado trampas recientemente al ingresar al servidor serán baneados por el sistema.

- **Anti Baneo**: Esta función evita que los jugadores con serials registrados sean baneados.

- **Actualización**: El anticheat cuenta con un sistema de actualización.

- **Arma Invisible [BETA]**: Esta función aún no está al 100% TESTADA, pero su función es detectar si un jugador tiene un arma invisible.

- **Anti Fix [BETA]**: Esta función aún no está al 100% TESTADA, pero su función es detectar si un jugador ejecutó alguna función para reparar un automóvil y cancelar esa función.

- **Anti Fire-Rate**: Esta función aún no está al 100% TESTADA, pero su función es detectar si un jugador disparó varias veces en segundos, lo que resultará en un baneo.

- **Anti VPN**: Esta función detecta si un jugador está utilizando una VPN, lo que resultará en un Kick.

- **Vehículos Falsos**: Esta función detecta si un jugador ha invocado un vehículo a través de algún menú de mods.

- **Teletransportar Vehículo a mí**: Esta función detecta si un jugador ha teletransportado un vehículo existente lejos de él.

- **API de Captura de Pantalla**: Todas las capturas de pantalla se almacenan ahora en un servidor web a través de una API, lo que permite enviar un registro de Discord con archivos multimedia.

- **Anti Velocidad Máxima**: Esta función detecta si un jugador se mueve a una velocidad absurda.

- **Compartir Pantalla

**: Esta función permite que un jugador comparta su pantalla. (Créditos a *zJoaoFtw_*, ya que él lo hizo).

- **Datos de Elementos**: Esta función detecta modificaciones que no deberían ocurrir en los datos de elementos de los jugadores.

- **Ejecutor de Lua**: Esta función detecta cualquier inyección de código LUA en el lado del cliente.

- **Lista Negra/Bloqueo de Comandos**: Esta función castiga al jugador que ejecuta un comando en la lista negra.

## Aviso Legal

Este proyecto se desarrolla de forma independiente y no tiene afiliación oficial con los desarrolladores de Multi Theft Auto ni de la serie Grand Theft Auto. El uso de este anticheat es opcional y depende de la elección de los administradores del servidor MTA.

## Contacto

Si tienes preguntas, sugerencias o informes de problemas, no dudes en crear un problema (issue) en este repositorio o ponerte en contacto por correo electrónico en [ruirr31@gmail.com](mailto:ruirr31@gmail.com).

## Compartir

Si decides utilizar este recurso, por favor, otorga los créditos correspondientes, ya que este proyecto fue bastante agotador y llevó mucho tiempo realizarlo.
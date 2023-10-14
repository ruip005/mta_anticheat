# **Anticheat für MTA (Multi Theft Auto)**

Willkommen beim Anticheat-Projekt für Multi Theft Auto (MTA). Dieses Repository dient der Entwicklung eines Anticheat-Systems, das darauf abzielt, die Integrität und Fairness des Spiels in der Mehrspielerumgebung von MTA zu verbessern.

[Video zur Einrichtung + AntiVPN](https://youtu.be/XuNNihYl7KE)

## Authentifizierung

### Authentifizierung, um das Anticheat zu starten.

| Variable | Typ      | Beschreibung                           |
| :------- | :------- | :------------------------------------ |
| `user`   | `string` | **Erforderlich**. Benutzername        |
| `key`    | `string` | **Erforderlich**. Benutzeraktivierungsschlüssel |

### Einige kostenlose Authentifizierungen.

1.
**Benutzer**: `trial01`

**Schlüssel**: `f8e2a1388546f9313ad7ac965a4e5990061b2d2dfd4a0e5f9b635799986fdd85`

2.
**Benutzer**: `trial02`

**Schlüssel**: `a0b27debfdda2cb2e99f4faf47b8f6b7b758b0c1c36f53d42078d9df9212c252`

3.
**Benutzer**: `trial03`

**Schlüssel**: `656f0a57cb751e8f55779b991ba4ea016e870b68f2d86271dfe0701bfe70f300`

## Überblick

Das Ziel dieses Projekts ist es, ein effizientes und robustes Anticheat für Multi Theft Auto zu erstellen. Das Anticheat soll Cheats, Hacks und andere betrügerische Aktivitäten erkennen und verhindern, die die Spielererfahrung negativ beeinflussen könnten.

## Funktionen

- **Screenshot**: Nehmen Sie einen Screenshot des Bildschirms des verdächtigen Spielers auf und zeigen Sie ihn auf dem Bildschirm des Personals an. Speichern Sie ihn in einem Ordner im Anticheat-Mod.

- **Discord-Webhook**: Dieses Anticheat enthält auch Logs, die über Webhooks an Discord-Kanäle gesendet werden.

- **Kein Anti-Screenshot**: Wenn aktiviert, erlaubt diese Funktion nur das Betreten des Servers, wenn die Option "Bildschirmaufnahmen erlauben" aktiviert ist.

- **Binds**: Diese Funktion benachrichtigt das Personal, wenn Tasten gedrückt werden, die normalerweise zum Öffnen von Cheats verwendet werden.

- **Anti "Backdoor"**: Diese Funktion hilft dabei, versteckte Befehle in kompilierten Mods zu entdecken.

- **Pfad**: Diese Funktion hilft dabei, den Speicherort eines bestimmten Mods auf dem Server zu finden.

- **Waffen-Schwarze Liste**: Diese Funktion erkennt Spieler mit nicht genehmigten Waffen auf dem Server und sperrt sie dann (außer das Personal).

- **Fahrzeug-Schwarze Liste**: Diese Funktion erkennt Spieler mit nicht genehmigten Fahrzeugen auf dem Server und sperrt sie dann (außer das Personal).

- **Spielgeschwindigkeit**: Diese Funktion erkennt, ob die Spielgeschwindigkeit eines Spielers über dem Normalwert liegt.

- **Anti-Jetpack**: Diese Funktion erkennt, ob ein Spieler kein Personalmitglied ist und einen Jetpack verwendet, und sperrt ihn dann.

- **Anti-Flug [BETA]**: Diese Funktion ist noch nicht zu 100% abgeschlossen, hat aber den Zweck, zu erkennen, ob ein Spieler ohne Teil des Serverpersonals zu sein fliegt.

- **RPG-Feuer**: Wenn die Funktion für die Waffenschwarze Liste nichts erkennt, wird diese RPG-Feuer-Funktion aktiviert. Sie löst ein Verbot aus, wenn ein Spieler mit einem RPG schießt.

- **Panzer-Feuer**: Ähnlich wie die obige Funktion, aber für den Fall, dass ein Cheater aus einem Panzer schießt.

- **VBR-Spawn**: Diese Funktion ist für diejenigen gedacht, die VBR verwenden und die Möglichkeit bieten, einen Panzer und einen Hydra zu spawnen. Sie überprüft, ob der Cheater auf der Client-Seite einen Panzer und auf der Server-Seite ein anderes Fahrzeug hat, was zu einem Verbot führt.

- **Anti-Ressourcenstopp**: Diese Funktion verhindert, dass wichtige Servermods ausgeschaltet werden, wenn der Client sie deaktiviert; in solchen Fällen wird der Spieler gesperrt.

- **Anti-Aimbot [BETA]**: Diese Funktion ist noch nicht zu 100% abgeschlossen, hat aber den Zweck, zu erkennen, ob ein Spieler sein Fadenkreuz zu schnell bewegt, als ob er wirklich einen Aimbot verwendet.

- **Personal-Serien**: Wenn diese Funktion aktiviert ist, dürfen nur Mitarbeiter mit registrierten Seriennummern eintreten.

- **Personal-Wallhack**: Diese Funktion steht nur Serverpersonal zur Verfügung und hilft dabei, sich in der Nähe befindliche Spieler zu lokalisieren.

- **Sperrungs- und Entsper

rungs-Logs**: Diese Funktion sendet ein Log an Discord mit Informationen darüber, welches Mitarbeitermitglied einen Spieler gesperrt oder entsperrt hat.

- **Globaler Bann**: Diese Funktion ist exklusiv für das Anticheat und sperrt Spieler, die kürzlich beim Betreten des Servers Cheats verwendet haben, automatisch.

- **Anti-Bann**: Diese Funktion verhindert, dass Spieler mit registrierten Seriennummern gesperrt werden.

- **Update**: Das Anticheat enthält ein Update-System.

- **Unsichtbare Waffe [BETA]**: Diese Funktion ist noch nicht zu 100% GETESTET, hat aber den Zweck, zu erkennen, ob ein Spieler eine unsichtbare Waffe hat.

- **Anti-Fix [BETA]**: Diese Funktion ist noch nicht zu 100% GETESTET, hat aber den Zweck, zu erkennen, ob ein Spieler eine Reparaturfunktion für ein Fahrzeug ausgeführt hat und diese abzubrechen.

- **Anti-Schussrate**: Diese Funktion ist noch nicht zu 100% GETESTET, hat aber den Zweck, zu erkennen, ob ein Spieler in Sekundenbruchteilen mehrere Schüsse abgefeuert hat und dann sperrt.

- **Anti-VPN**: Diese Funktion erkennt, ob ein Spieler ein VPN verwendet, und führt dann einen Kick durch.

- **Falsche Fahrzeuge**: Diese Funktion erkennt,

 ob ein Spieler ein Fahrzeug über ein Mod-Menü beschworen hat.

- **Fahrzeug zu mir teleportieren**: Diese Funktion erkennt, ob ein Spieler ein vorhandenes Fahrzeug von sich weg teleportiert hat.

- **Screenshot-API**: Alle Screenshots werden jetzt über eine API auf einem Webserver gespeichert, sodass sie zusammen mit einer Discord-Log-Datei gesendet werden können.

- **Anti-Maximalgeschwindigkeit**: Diese Funktion erkennt, ob ein Spieler mit einer absurden Geschwindigkeit läuft.

- **Bildschirmübertragung**: Diese Funktion zwingt einen Spieler, seinen Bildschirm zu übertragen. (Dank geht an *zJoaoFtw_*, der das gemacht hat.)

- **Elementdaten**: Diese Funktion erkennt Änderungen, die nicht in den Elementdaten der Spieler auftreten sollten.

- **Lua-Executor**: Diese Funktion erkennt jede LUA-Code-Injektion auf der Client-Seite.

- **CMD-Blacklist/Block**: Diese Funktion bestraft Spieler, die einen Befehl aus der Blacklist ausführen.

## Rechtlicher Hinweis

Dieses Projekt wird unabhängig entwickelt und hat keine offizielle Verbindung zu den Entwicklern von Multi Theft Auto oder der Grand Theft Auto-Reihe. Die Verwendung dieses Anticheats ist optional und basiert auf der Entscheidung der Serveradministratoren von MTA.

## Kontakt

Wenn Sie Fragen, Anregungen oder Problemberichte haben, zögern Sie nicht, ein Problem (Issue) in diesem Repository zu erstellen oder per E-Mail unter [ruirr31@gmail.com](mailto:ruirr31@gmail.com) Kontakt aufzunehmen.

## Teilen

Wenn Sie dieses Ressourcenpaket verwenden, geben Sie bitte angemessenes Guthaben, da dieses Projekt sehr aufwendig und zeitaufwendig war.
![uW33D Anticheat.](https://cdn.discordapp.com/attachments/1110700176361918545/1137505212903456808/AC.png "Anticheat")

# **Anticheat für MTA (Multi Theft Auto)**

Willkommen beim Anticheat-Projekt für Multi Theft Auto (MTA). Dieses Repository dient der Entwicklung eines Anticheat-Systems zur Verbesserung der Integrität und Fairness des Spiels in der Mehrspielerumgebung von MTA.

[Video zur Konfiguration + AntiVPN](https://youtu.be/XuNNihYl7KE)

[Alle Anticheat-Versionen](https://github.com/ruip005/mta_anticheat/releases)

## Wählen Sie Ihre Sprache
Bitte beachten Sie, dass nur Portugiesisch stabil und vollständig ist. Andere Sprachen können schwerwiegende Fehler aufweisen, da sie nicht abgeschlossen sind. Bitte warten Sie auf eine stabile Version oder verwenden Sie nur die portugiesische Version.

 * [Portugiesisch](https://github.com/ruip005/mta_anticheat/blob/main/readme/pt/README.md)   
 * [Spanisch](https://github.com/ruip005/mta_anticheat/blob/main/readme/es/README.md)  
 * [Englisch](https://github.com/ruip005/mta_anticheat/blob/main/readme/en/README.md)
 * [Türkisch](https://github.com/ruip005/mta_anticheat/blob/main/readme/tr/README.md)  
 * [Deutsch](https://github.com/ruip005/mta_anticheat/blob/main/readme/de/README.md) 

## Authentifizierung

### Authentifizierung, um das Anticheat zu starten.

| Variable   | Typ       | Beschreibung                           |
| :---------- | :--------- | :---------------------------------- |
| `user` | `string` | **Erforderlich**. Benutzername |
| `key` | `string` | **Erforderlich**. Benutzeraktivierungsschlüssel |


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

*Wenn Ihr Schlüssel privat ist, geben Sie ihn niemandem preis und verwenden Sie ihn nur auf Ihrem Server! Unser System erkennt die Original-IP und den Port des Servers, auf dem das Anticheat gestartet wird!*  

 
## Überblick

Ziel dieses Projekts ist es, ein effizientes und robustes Anticheat für Multi Theft Auto zu erstellen. Das Anticheat soll Cheats, Hacks und andere betrügerische Aktivitäten erkennen und verhindern, die die Spielerfahrung negativ beeinflussen könnten.

## Funktionen

- **Screenshot**: Aufnahme eines Screenshots des Bildschirms des verdächtigen Spielers und Anzeige auf dem Bildschirm des Personals sowie Speicherung in einem Ordner im Anticheat-Mod.

- **Discord Webhook**: Dieses Anticheat verfügt auch über Protokolle, die über Webhooks an Discord-Räume gesendet werden.

- **Kein AntiScreenShot**: Diese Funktion ermöglicht es dem Spieler nur auf dem Server zu spielen, wenn die Option "Screenshot senden erlauben" aktiviert ist.

- **Binds**: Diese Funktion benachrichtigt das Personal, wenn Tasten, die normalerweise für das Öffnen von Cheats verwendet werden, gedrückt werden.

- **Anti "Backdoor"**: Diese Funktion hilft dabei, versteckte Befehle in kompilierten Mods zu entdecken.

- **Pfad**: Diese Funktion hilft dabei, den Speicherort eines bestimmten Mods auf dem Server zu finden.

- **Waffen-Sperrliste**: Diese Funktion erkennt Spieler, die nicht erlaubte Waffen auf dem Server verwenden, und sperrt sie dann (außer dem Personal).

- **Fahrzeug-Sperrliste**: Diese Funktion erkennt Spieler, die nicht erlaubte Fahrzeuge auf dem Server verwenden, und sperrt sie dann (außer dem Personal).

- **Spielgeschwindigkeit**: Diese Funktion erkennt, ob die Spieler die Spielgeschwindigkeit über dem Normalwert haben.

- **Anti Jetpack**: Diese Funktion erkennt, ob der Spieler nicht zum Personal gehört und einen Jetpack verwendet, und sperrt ihn dann.

- **Anti Fliegen [BETA]**: Diese Funktion ist noch nicht zu 100 % abgeschlossen, hat aber die Aufgabe, zu erkennen, ob ein Spieler fliegt, ohne zum Serverpersonal zu gehören.

- **RPG-Schuss**: Wenn die Funktion Waffen-Sperrliste nicht funktioniert, wird die RPG-Schussfunktion aktiviert, die den Cheater sperrt, wenn er schießt.

- **Tank-Schuss**: Ähnlich wie die obige Funktion, jedoch sperrt sie den Cheater, wenn er aus einem Panzer schießt.

- **Spawn VBR**: Diese Funktion ist für diejenigen gedacht, die VBR (Vanilla Battle Royale) verwenden und die Option zum Spawnen von Panzern und Hydras haben. Diese Funktion erkennt, ob der Cheater ein Fahrzeug auf Clientseite und ein anderes auf Serverseite hat, und sperrt ihn dann.

- **Anti Ressourcenstopp**: Diese Funktion verhindert das Deaktivieren von wichtigen Mods auf dem Server, wenn der Client wichtige Mods deaktiviert, und sperrt dann den Spieler.

- **Anti Aimbot [BETA]**: Diese Funktion ist noch nicht zu 100 % abgeschlossen, hat aber die Aufgabe, zu erkennen, ob ein Spieler sein Zielen zu schnell bewegt, als ob er wirklich einen Aimbot hätte.

- **Personalseriennummern**: Diese Funktion erlaubt nur registrierten "Mitarbeitern" den Zugang, wenn die Seriennummer registriert ist.

- **Wallhack für Personal**: Diese Funktion steht nur dem Serverpersonal zur Verfügung und hilft dabei, zu sehen, wo sich die Spieler in der Nähe befinden.

- **Protokolle für Verbote und Aufhebungen**: Diese

 Funktion sendet ein Protokoll an Discord mit Informationen darüber, welches Personal einem Spieler ein Verbot oder eine Aufhebung erteilt hat.

- **Globaler Bann**: Diese Funktion ist exklusiv für das Anticheat und sperrt Spieler, die kürzlich betrogen haben, automatisch, wenn sie den Server betreten.

- **Anti-Bann**: Diese Funktion verhindert, dass Spieler mit registrierten Seriennummern gesperrt werden.

- **Update**: Das Anticheat verfügt über ein Update-System.

- **Unsichtbare Waffe [BETA]**: Diese Funktion ist noch nicht zu 100 % GETESTET, hat aber die Aufgabe, zu erkennen, ob ein Spieler eine unsichtbare Waffe hat.

- **Anti-Fix [BETA]**: Diese Funktion ist noch nicht zu 100 % GETESTET, hat aber die Aufgabe, zu erkennen, ob ein Spieler versucht hat, ein Fahrzeug zu reparieren, und die Reparatur abzubrechen.

- **Anti-Schussrate**: Diese Funktion ist noch nicht zu 100 % GETESTET, hat aber die Aufgabe, zu erkennen, ob ein Spieler in Sekundenbruchteilen mehrere Schüsse abgegeben hat und sie dann sperrt.

- **Anti VPN**: Diese Funktion erkennt, ob ein Spieler eine VPN verwendet, und wirft ihn dann aus dem Spiel.

- **Gefälschte Fahrzeuge**: Diese Funktion erkennt, ob ein Spieler ein Fahrzeug über ein Mod-Menü beschafft hat.

- **Fahrzeug zu mir warpen**: Diese Funktion erkennt, ob ein Spieler ein existierendes Fahrzeug von sich weg geworfen hat.

- **Screenshot-API**: Alle Screenshots werden jetzt auf einem Webserver über eine API gespeichert, sodass sie ein Discord-Protokoll mit Mediendatei senden können.

- **Anti Maximalgeschwindigkeit**: Diese Funktion erkennt, ob ein Spieler mit absurd hoher Geschwindigkeit unterwegs ist.

- **Screenshare**: Diese Funktion zieht einen Spieler, um seinen Bildschirm zu teilen. (Credits gehen an *zJoaoFtw_*, da er dies gemacht hat.)

- **Elementdaten**: Diese Funktion erkennt Änderungen in den Elementdaten der Spieler, die nicht auftreten sollten.

- **Lua-Executor**: Diese Funktion erkennt jede LUA-Code-Injektion auf der Clientseite.

- **CMD-Sperrliste/Block**: Diese Funktion bestraft einen Spieler, der einen gesperrten Befehl ausführt.
  
## Haftungsausschluss

Dieses Projekt wird unabhängig entwickelt und hat keine offizielle Verbindung zu den Entwicklern von Multi Theft Auto oder der Grand Theft Auto-Serie. Die Verwendung dieses Anticheats ist optional und basiert auf der Entscheidung der Serveradministratoren von MTA.

## Kontakt

Wenn Sie Fragen, Vorschläge oder Problemmeldungen haben, zögern Sie nicht, ein Problem (Issue) in diesem Repository zu erstellen oder über Discord uw33d (Benutzer-ID: 297122391580999692) Kontakt aufzunehmen.

## Weitergabe

Wenn Sie dieses Ressourcenpaket verwenden, geben Sie bitte die Credits an, da dieses Projekt sehr aufwendig und zeitaufwändig war.

# 2d-Jump-n-Run
Das Spiel wird mit Hilfe der [Godot-Engine](https://godotengine.org/) entwickelt.

Der Code wird vollständig in englischer Sprache gehalten.

## Einrichtung
Das Projekt lokal einbinden:

Godot Engine starten<br>
Import -> in das Projekt-Verzeichnis wechseln -> "project.godot" auswählen
## Development
Bevor man die Abarbeitung eines Issues beginnt, unbedingt sich selbst zu diesem assignen. <br/>
Die eigentliche Entwicklung erfolgt immer auf einem eigenen Branch:
* **git checkout -b \[branch-name\]** Erstellt einen neuen Branch
* **git branch \[branch-name\]** Wechseln zwischen Branch
* **git push origin \[branch-name\]** Pusht den neuen Branch auf Github, erstellt dort einen neue Branch falls nicht vorhanden
* Branch-Name sollte der Entwicklung auf diesem Branch entsprechen<br/>

Nach Fertigstellung eines Features Pull-Request auf Master-Branch:
* Unter **Pull Request** neuen Pull-Request erstellen
* Entsprechenden Branch auswählen und ggf. Pull-Request kommentieren
* Code-Review und Merge in master erfolgt durch [Max](https://github.com/rxt30) und [Moritz](https://github.com/Firomaeor)<br/>

Falls ein Problem gefunden wird, Issue erstellen
* Ausschlaggebende Beschreibung verwenden
* Mit Labeln versehen für eine bessere Sortierung<br/>

Bevorzugte Sprachen GDScript und c++, kann sich aber ggf. noch ändern.<br/>
Standard-Einrückung: 4 Spaces<br/>
Sprache des Codes unbedingt auf Englisch halten.<br/>
Selbsterklärende Namen verwenden.<br/>
Falls die Funktion sich nicht aufgrund ihrer Einfachkeit und des Namen selbst beschreibt, Beschreibung ähnlich Java-Docs als Kommentar hinzufügen.</br>
Eine Liste mit wichtigen Klassen und Funktionen folgt noch.<br/>

## Ordner-Struktur
Als Hauptordner für den Code dient der Ordner 2d-Jump-n-Run-SE, dabei gibt es folgende Unterordner
* **Scenes/** wird für die Erstellung und Speicherung von Szenen verwendet
  * Bitte Unterordner mit First_Level, Second_Level usw. erstellen, ggf. shared-Ordner mit geteilten Szenen
* **Scripts/** wird für die Erstellung von Skripten verwendet
  * Bitte Unterordner für die zugehörigen Modell-Objeke erstellen, z.B. Player, Boss_1 usw.
* **imagesFiles** enthält alle Bilddateien
  * Hier ebenfalls Unterordner zum zugehörigen Modell/Level erstellen

## Exportieren des Projekts
Unter dem Reiter Projekt gibt es den Punkt exportieren. Wenn dieser angeclickt wird muss zuerst eine Vorlage gewählt werden, wofür man das Projekt exportieren möchte.
Wenn man das zum ersten mal macht wird man ein Template herunterladen müssen. Dieses Template wird von Godot direkt angezeigt und kann direkt in der Anwendung heruntergeladen werden, wenn das nicht funktioniert findet man die Templates auch auf der Godot Website. Im Anschluss kann man das Projekt exportieren. Hierbei sollten eine exe und eine pck Datei entstehen. Damit hat man nun ein funktionierendes Export.

Hier ein kleines Video tutorial zum Export in Godot:
https://youtu.be/cXahUh9Zfho?t=40

## Google-Drive Link zu allen relevanten Dokumenten
https://drive.google.com/drive/folders/1fcZYi8vxpXD6oUy3UmAal-U4MVxDlJ2M?usp=sharing

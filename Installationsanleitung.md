# Installationsanleitung

Die Foodcoop App kann über zwei Wege auf einem Android Gerät installiert werden

## Installation mit APK (empfohlen)

1. APK-Datei herunterladen
2. Die APK-Datei auf das Geräte kopieren
3. Die APk-Datei auf dem Gerät ausführen


## Installation mit Android Studio und Flutter (aufwendig)

Hierfür ist die Installation von Android Studio, Flutter und den benötigten Plugins für Android Studio notwendig
1. Wechsel in das Verzeichnis des Codes (clone des Codes notwendig)
2. APK erstellen: flutter build apk --no-tree-shake-icons
3. Auf Endgerät installieren: flutter install

Hinweis: Die APK Datei des builds aus Schritt 2. ist in dem lokalen Ordner (nicht in GIT)
> build\app\outputs\apk\release

zu finden.
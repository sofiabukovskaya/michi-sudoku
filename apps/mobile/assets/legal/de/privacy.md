# Datenschutzerklärung

**Entwurf zur Prüfung.** Verantwortlich für MICHI ist {{CONTROLLER}} mit Sitz in {{COUNTRY}}. Datenschutzanfragen: [{{EMAIL}}](mailto:{{EMAIL}}).

## Was auf deinem Gerät bleibt

- Die lokale Datenbank enthält laufende und abgeschlossene Spiele, Technikfortschritte, abgeschlossene Tagesrätsel und importierte Sudoku-Gitter.
- Lokal gespeichert werden Einstiegsstufe und Abschluss der Einführung, Sprache, Serienerinnerung, persönliche Bestwerte, gelöste Spot-it-Tage, gesehene Notizbuchstempel und deine Einstellung zu Absturzberichten.
- Mit deiner Erlaubnis liest der Scanner ein Kamerafoto oder ein ausgewähltes Bibliotheksfoto. Ein integriertes TensorFlow-Lite-Modell verarbeitet es auf deinem Gerät. MICHI lädt keine Fotos hoch und versucht, temporäre Kameraaufnahmen nach dem Einlesen zu löschen. Das Original bleibt in deiner Fotomediathek. Interne Diagnoseversionen können Scandateien lokal behalten.
- Die Serienerinnerung wird nach dem Einschalten anhand lokaler Abschlusszeiten auf dem Gerät geplant. Du kannst sie in den Einstellungen ausschalten oder die Berechtigung entziehen.

## Konto und Synchronisierung

Beim Spielen als Gast bleibt dein Fortschritt lokal. Bei der E-Mail-Registrierung verarbeitet Firebase Authentication Name, E-Mail-Adresse, Passwort und Konto-ID. Wenn dein Build Google- oder Apple-Anmeldung anbietet und du sie nutzt, übernimmt der Anbieter die Anmeldung. Firebase erhält Anmeldeinformationen und verfügbare Profildaten wie Name und E-Mail-Adresse.

Nach der Anmeldung synchronisiert Cloud Firestore abgeschlossene Spiele, Tagesrätsel und Technikfortschritte einschließlich der Beiträge einzelner Installationen. Bei abgeschlossenen importierten Spielen können die Start- und Lösungsgitter als Zahlen, Zeiten, Fehler und Hilfen übertragen werden. Laufende Spiele werden nicht synchronisiert. Altdaten der früheren 8-Uhr-Push-Erinnerung können Installations-ID, Plattform, Sprache, Zeitzone, Push-Token und Zeitplaneinstellungen enthalten.

## Dienste für alle

- Firebase Remote Config liefert Vorgaben für Funktionen und Inhalte. Firestore liefert veröffentlichte Rätsel und Tagesaufgaben. Dabei fallen übliche technische Anfragedaten wie IP-Adresse und gegebenenfalls SDK- oder Installationsdaten an.
- Das Firebase Messaging SDK ist weiterhin enthalten. Es kann Installations- und Push-Registrierungskennungen erzeugen, auch wenn du nur die lokale Erinnerung nutzt.
- Firebase App Check verwendet Play Integrity oder App Attest mit DeviceCheck als Ausweichlösung, um App und Gerät zu prüfen und Missbrauch vorzubeugen.
- Firebase Crashlytics hilft bei der Fehlerdiagnose. Berichte können Stacktraces, Gerätemodell, Betriebssystem, App-Version und Installationsinformationen enthalten. In Release-Builds ist **Absturzberichte teilen** standardmäßig aktiv. Die Einstellung findest du unter Einstellungen → Über MICHI. Nach dem Ausschalten sendet Dart keine neuen Absturzberichte. Das native SDK kann die Änderung beim nächsten Start übernehmen und bei deaktivierter Übermittlung Absturzdaten lokal zwischenspeichern. Bereits gesendete Berichte bleiben davon unberührt.

Die Datenerfassung von Firebase Analytics ist deaktiviert. MICHI zeigt keine Werbung, verfolgt dich nicht über Apps hinweg und verkauft keine Daten. Derzeit erhebt MICHI keine Zahlungsdaten. Falls MICHI Plus angeboten wird, verarbeitet Apple oder Google Käufe nach den eigenen Bedingungen.

## Anbieter, Aufbewahrung und deine Rechte

Google stellt [Firebase-Dienste](https://firebase.google.com/support/privacy) bereit. Apple kann Gerätedaten zur Prüfung und optionale Anmeldedaten verarbeiten. Firebase kann Daten außerhalb deines Landes verarbeiten. Die Funktion zur Kontobereinigung läuft in europe-west1. Firebase Authentication verarbeitet Kontodaten in den Vereinigten Staaten. Das legt nicht den Standort aller Dienste fest. Wenn du uns schreibst, verwenden wir Adresse und Nachricht zur Beantwortung.

Lokale Daten bleiben bis zur Löschung in der App, dem Leeren des App-Speichers oder der Deinstallation erhalten. Betriebssystem-Backups können Kopien behalten. Synchronisierte Daten bleiben bis zur Kontolöschung gespeichert. Die Aufbewahrung bei Firebase hängt vom Dienst ab. {{RETENTION}} {{LEGAL_BASIS_TRANSFERS}}

Je nach anwendbarem Recht kannst du Auskunft, Berichtigung, Löschung, Einschränkung oder Übertragung verlangen, Widerspruch einlegen oder dich bei einer Aufsichtsbehörde beschweren. Schreib an [{{EMAIL}}](mailto:{{EMAIL}}). Kamera-, Foto- und Mitteilungsrechte änderst du in den Geräteeinstellungen.

## Dein Konto löschen

Melde dich an und öffne **Profil → Einstellungen → Konto → Konto löschen**. Firebase löscht das Konto und stößt die Entfernung der zugehörigen Cloud-Daten zu Spielen, Fortschritten und Erinnerungen an. MICHI entfernt das lokale Kontoprofil auf diesem Gerät. Getrennte Gastdaten und Kopien auf anderen Geräten können erhalten bleiben. Wenn du die App nicht nutzen kannst, bitte per E-Mail von deiner Konto-Adresse an [{{EMAIL}}](mailto:{{EMAIL}}) um Löschung deines MICHI-Kontos und der zugehörigen Daten. Sende kein Passwort. Wir können deine Berechtigung prüfen.

# Übungen für Vorlesung Netzwerke an der HFT Stuttgart

Kontakt: sebastian.speiser@hft-stuttgart.de

## Einrichten des Netzwerk-Simulators

Wir benutzen [Kathará](https://www.kathara.org/) als Netzwerk-Simulator.
Nutzen Sie eine der folgenden Möglichkeiten:
- Installation auf Ihrem PC (Voraussetzung: Docker) gemäss den Anleitungen für [Windows](https://github.com/KatharaFramework/Kathara/wiki/Windows), [macOS](https://github.com/KatharaFramework/Kathara/wiki/Macos), [Linux](https://github.com/KatharaFramework/Kathara/wiki/Linux)
- Booten des Live-Images (verfügbar in Moodle) in einer virtuellen Maschine oder per USB-Stick ([Rufus](https://rufus.ie)) auf einem PC/Laptop 

## Erstes Lab

Checken Sie das Git-Repository aus, aktualisieren Sie es ggfs. und starten Sie das erste Szenario (der Schritt mit git clone kann im Live-Image übersprungen werden):
```
$ git clone https://github.com/sspeiser/netzwerke-uebungen.git
$ cd netzwerke-uebungen
$ git pull
$ kathara lstart -d 01_two_computers
```
Das kann beim ersten Start eine Weile dauern und sollte dann 2 Terminal-Fenster öffnen - eines für jeden der beiden erzeugten virtuellen Computer im Netzwerk.

Gehen Sie ins Terminal von "pc1" und probieren Sie "pc2" anzupingen (Abbruch mit CTRL-C):
```
root@pc1:/# ping 192.168.0.102
PING 192.168.0.102 (192.168.0.102) 56(84) bytes of data.
64 bytes from 192.168.0.102: icmp_seq=1 ttl=64 time=0.099 ms
64 bytes from 192.168.0.102: icmp_seq=2 ttl=64 time=0.068 ms
64 bytes from 192.168.0.102: icmp_seq=3 ttl=64 time=0.100 ms
64 bytes from 192.168.0.102: icmp_seq=4 ttl=64 time=0.074 ms
64 bytes from 192.168.0.102: icmp_seq=5 ttl=64 time=0.042 ms
^C
--- 192.168.0.102 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4129ms
rtt min/avg/max/mdev = 0.042/0.076/0.100/0.023 ms
root@pc1:/# 
```

Wenn Sie mit einem Lab fertig sind können Sie die Terminals schliessen und in der Konsolte Ihres Computers das Lab beenden/loeschen mit:
```
$ kathara wipe
```

## Grundlegendes zu Labs

Ein Kathará Lab ist in einem Verzeichnis gespeichert mit folgenden Inhalten:
- lab.conf: Beschreibt die Geräte (Hosts und Router), ihre Netzwerkinterfaces und ihre "Verkabelung". Format ist z.B. pc[0]=A, d.h. es wird ein Gerät "pc" angelegt, dessen Netzwerkinterface "eth0" mit der Kollisionsdomäne "A" verbunden ist. Netzwerkinterfaces in der gleichen Kollisionsdomäne können miteinander kommunizieren. Mehr Details in der [Kathará-Dokumentation](https://www.kathara.org/man-pages/kathara-lab.conf.5.html)
- Optional für jedes Gerät "device" eine Datei "device.startup": Shell Skript, das das Gerät konfiguriert, z.B. IP-Adresse setzen
- Weitere Möglichkeiten, wie z.B. Verzeichnisse, die auf die einzelnen Geräte gemappt werden in der [Kathará-Dokumentation](https://www.kathara.org/man-pages/kathara-lab-dirs.7.html)

Ein Lab im Verzeichnis ExampleLab können Sie mit dem Befehl: 
```
$ kathara lstart -d ExampleLab
```
starten. Das beenden erfolgt mit kathara lclean -d ... oder mit kathara wipe (hier werden alle Labs und sonstigen Geräte gelöscht/gestoppt).

## Aufgabe 1: Setzen von IP-Adressen

Unter Linux können Sie mit dem [ifconfig](https://linux.die.net/man/8/ifconfig) Befehl IP-Adressen setzen, z.B.:
```
$ ifconfig eth0 192.168.0.1 netmask 255.255.255.0 up
```
Starten Sie das Lab 01_two_computers und ändern Sie in den Kommandozeilen der Rechner "pc1" und "pc2" die IP-Adressen auf 10.0.0.1 und 10.10.10.10 mit Netz 10.0.0.0/8. 
Testen Sie die Konfiguration durch gegenseitges anpingen.

## Aufgabe 2a: Routing

Im Lab 02_network ist ein sehr einfaches Netzwerk(fragment). Server 1, Server 2 und Server 3 sind mit IP-Adressen konfiguriert. Die Routing-Tabellen und die Router müssen initialisiert werden.
Mit dem [route](https://linux.die.net/man/8/route) Befehl können Routen angezeigt und angelegt werden.
- Visualisieren oder Beschreiben Sie das Netzwerk
- Vergeben Sie IP-Adressen an die Netzwerkinterfaces der Router, verwenden Sie für neu benötigte Netzwerke die Teile des Netzwerks 203.0.113.0/24
- Richten Sie die Routen ein
Testen Sie, dass alle Server miteinander "sprechen" können mit Hilfe von ping.

Verwenden Sie den Befehl [traceroute](https://linux.die.net/man/8/traceroute), um die Routing-Stationen zwischen Server 1 und Server 2 sowie zwischen Server 2 und Server 3 nachzuvollziehen.

## Aufgabe 2b: Analyse mit tcpdump

Verwenden Sie das konfigurierte Netzwerk aus Aufgabe 2a und analysieren Sie es mit [tcpdump](https://linux.die.net/man/8/tcpdump).
Der Befehl tcpdump gibt die Netzwerkpakete auf einem Interface in strukturierter Form auf der Konsole aus. Dumpen Sie bei Router 1 und Router 2 jeweils das Interface eth0:
```
$ tcpdump -tennvv -i eth0
```
Beobachten Sie die Pakete, wenn Sie Server 3 von Server 1 aus anpingen.
Was ist bei den Paketen gleich, worin unterscheiden Sie sich?

Was beobachten Sie, wenn Sie von Server 1 ein traceroute zu Server 3 machen?

## Aufgabe 3: Firewall

ACHTUNG: Probieren Sie das nur im Netzwerk-Simulator! Keine Attacken im Internet, Hochschulnetz, Firmennetzen und geteilten Heimnetzen.




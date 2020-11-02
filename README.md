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




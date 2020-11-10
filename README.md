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

## Aufgabe 3a: Firewall

ACHTUNG: Probieren Sie das nur im Netzwerk-Simulator! Keine Attacken im Internet, Hochschulnetz, Firmennetzen und geteilten Heimnetzen. Keine unsicheren Logins mit einstelligen Passwörtern. Die Firewall-Konfiguration geht nur auf spezifische Beispiele ein und ist keine Konfiguration für ein System, das mit dem Internet verbunden ist.

Machen Sie sich mit der Netzwerkstruktur vertraut. Wir verwenden iptables für die Firewall ([man Page](https://linux.die.net/man/8/iptables), [Intro Artikel](https://www.pro-linux.de/artikel/2/761/2,grundsätzliche-funktionsweise.html)). 

Lassen Sie sich als erstes die Konfiguration der Firewall-Regeln anzeigen:
```
$ iptables -L -v
```
Wofür sind die 3 angezeigten Chains? Was bewirken diese im Moment?

Pingen Sie vom Attacker den Server und die Firewall an:
```
root@attacker:~# ping -c 1 198.51.100.9
...
root@attacker:~# ping -c 1 203.0.113.13
...
```

Verändern Sie das Verhalten für die INPUT Chain von ACCEPT zu DROP:
```
root@firewall:/# iptables --policy INPUT DROP
```

Pingen Sie erneut vom Attacker den Server und die Firewall an. Was ist anders? Was passiert, wenn Sie von der Firewall den Attacker anpingen?
Lassen Sie sich danach mit iptables -L -v wieder die Firewallregeln anzeigen.

Bisher haben wir nur die Default-Policies für die Chains gesetzt. Mit "iptables -A KETTE -j REGEL BEDINGUNGEN"  wird eine Kette (Chain) am Ende erweiert. Eine Chain wird ausgewertet bis die erste Bedingung erfüllt wurde oder sonst eben der Default.
Fügen Sie nun eine Regel für die INPUT Chain ein, die Pakete REJECTed:
```
root@firewall:/# iptables -A INPUT -j REJECT
```
Wenn Sie jetzt die Firewall anpingen, was ist anders? Diskutieren Sie Vor- und Nachteile.

## Aufgabe 3b: SSH Brute Force Attack blokieren

ACHTUNG: Probieren Sie das nur im Netzwerk-Simulator! Keine Attacken im Internet, Hochschulnetz, Firmennetzen und geteilten Heimnetzen. Keine unsicheren Logins mit einstelligen Passwörtern. Die Firewall-Konfiguration geht nur auf spezifische Beispiele ein und ist keine Konfiguration für ein System, das mit dem Internet verbunden ist.

Wir verwenden weiter das Lab 03_firewall. Auf dem Server wird beim Start ein Nutzer "test" mit einem zufälligen Passwort bestehend aus einem(!) Kleinbuchstaben. Auf dem Attacker ist ein Skript, das alle Kleinbuchstaben als Passwort durchprobiert, um sich auf den Server einzuloggen und bei Erfolgt dort eine Datei "HACKED" im Verzeichnis "/home/test" zu hinterlassen.
Starten Sie das Skript und prüfen danach, ob es erfolgreich war. 
Attacker:
```
root@attacker:~# bash brute_force_ssh.sh 
...
```
Danach auf dem Server:
```
root@server1:~# ls /home/test/
HACKED_12_25_57_PASSWORD_w
```
Das heisst, dass um 12:25:57 Uhr die Brute-Force-Attacke erfolgreich war mit dem Passwort "w".
Richten Sie nun die Firewall so ein, dass eine Brute-Force-Attacke verhindert wird, indem nur 3 Verbindungen pro 5 Minuten auf den SSH-Port (22) weitergeleitet werden. Orientieren Sie sich dabei z.B. an [Tutorial](https://www.rackaid.com/blog/how-to-block-ssh-brute-force-attacks/). Beachten Sie u.a. die folgenden Abweichungen:
- Logging für IP-Tables funktioniert im Netzwerksimulator nicht (wegen Docker)
- Firewall und Server sind bei uns auf verschiedenen Rechnern. Dies erfordert Anpassungen bzgl. der Chains und Netzwerkinterfaces

Testen Sie erneut die Attacke. Beobachten Sie das verhalten des Skripts und prüfen Sie, ob nach Durchlaufen des Skripts der Hack erfolgreich war.

Was sind die Vorteile diese Blockade (und weitere Regeln) auf einer dezidierten Firewall statt direkt auf dem Server durchzuführen?

Was wären weitere Möglichkeiten, um den SSH-Zugang zu schützen?

## Aufgabe 4: Network Addresse Translation (NAT)

Mit NAT können mehrere Computer mit privaten IP-Adressen sich eine öffentliche IP-Adresse teilen, um auf das Internet zuzugreifen.

Starten Sie das Lab 04_nat. Hier ist ein PC über einen NAT-Router mit einem Server verbunden. Sowohl auf PC als auch Server laufen HTTP-Server. Unser Ziel ist es, dass diese Gegenseitig auf die Server zugreifen können. Richten Sie dazu das Routing auf PC und Router ein, sowie NAT auf dem Router. Beachten Sie, dass der PC eine private IP-Adresse hat und daher kein Traffic vom Internet an diese Adressen geroutet werden können (und aus Sicherheitsgründen auch im Allgemeinen nicht gewünscht ist.)

Nutzen Sie den Kommandozeilenbrowser links, z.B. auf dem PC:
```
root@pc:/# links 127.0.0.1
```
Mit "q" können Sie den Browser wieder verlassen.

Starten Sie als nächstes tcpdump auf dem Router und probieren Sie dann vom PC auf den Server zuzugreifen:
```
root@router:/# tcpdump -tennvvi eth1
...
# WECHSEL KONSOLE
root@pc:/# links 203.0.113.51
[q]
```
Was passiert?

Konfigurieren Sie als nächstes den Router für NAT.
```
iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE
```

Beobachten Sie auf Router erneut mit tcpdump und probieren vom PC auf den Server zuzugreifen. Mit welcher IP-Adressen denkt der Server zu kommunizieren?

Richten Sie auf dem Router eine Port-Weiterleitung auf den HTTP-Server des PCs ein. Verwenden Sie dazu iptables indem Sie die richtigen Werte für \[PLATZHALTER\] einfügen:
```
root@router:/# iptables -t nat -A PREROUTING -i [INTERFACE] -p [PROTOKOLL] --dport [PORT] -j DNAT --to-destination [ZIELIP]:[ZIELPORT]
```

Greifen Sie danach vom Server auf den HTTP-Server des Clients zu. Welche IP-Adresse muss ausgewählt werden?
Beobachten Sie den Traffic auf dem Router mit tcpdump. Welche HTTP-Methoden werden verwendet? Welche Header sind gesetzt? Was steht im Host-Header?
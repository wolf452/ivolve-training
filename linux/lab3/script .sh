#!/bin/bash

EMAIL="ahmed.software200@gmail.com"

for i in {0..255}
do
    ping -c 1 -w 1 172.16.17.$i &> /dev/null

    if [ $? -eq 0 ]; then
        echo "Server 172.16.17.$i is up and running."

        echo -e "To: $EMAIL\nSubject: Server 172.16.17.$i is up\n\nServer 172.16.17.$i is up and running." | msmtp --debug --from=default -t
    else
        echo "Server 172.16.17.$i is unreachable."

        echo -e "To: $EMAIL\nSubject: Server 172.16.17.$i is unreachable\n\nServer 172.16.17.$i is unreachable." | msmtp --debug --from=default -t
    fi
done


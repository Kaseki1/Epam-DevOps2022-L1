#!/bin/bash

logfile='example_log.log'

echo -en '\nIP from which were the most requests:'
cat $logfile | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -1
echo -en '\nThe most requested page:'
cat $logfile | cut -d' ' -f7 | sort | uniq -c | sort -nr | head -1
echo -e '\nNumber of requests from each IP:'
cat $logfile | cut -d' ' -f1 | sort | uniq -c | sort -n
echo -e '\nNon-existent pages were clients referred to:'
while IFS= read -r line
do
    if [[ $(cut -d' ' -f9 <<< "$line") = "404" ]]
    then
        echo $(cut -d' ' -f7 <<< "$line")
    fi
done < $logfile
echo -en '\nSite got most requests on '
cat $logfile | cut -d' ' -f4 | cut -d'/' -f3 | sort | uniq -c | sort -nr | head -1 | cut -d':' -f2,3,4
echo -e '\nSearch bots accessed the site:'
while IFS= read -r line;
do
    echo $(cut -d' ' -f12 <<< "$line") $(cut -d' ' -f1 <<< "$line")
done < $logfile

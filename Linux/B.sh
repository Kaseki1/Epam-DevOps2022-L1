#!/bin/bash

echo -n 'IP from which were the most requests:'
cat apache_logs.txt | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -1
echo -n 'The most requested page:'
cat apache_logs.txt | cut -d' ' -f7 | sort | uniq -c | sort -nr | head -1
echo 'Number of requests from each IP:'
cat apache_logs.txt | cut -d' ' -f1 | sort | uniq -c | sort -n
echo 'Non-existent pages were clients referred to:'
buf=$(cat apache_logs.txt)
while IFS= read -r line
do
    if [[ $(cut -d' ' -f9 <<< "$line") == "404" ]]
    then
        echo $(cut -d' ' -f8 <<< "$line")
    fi
done < apache_logs.txt
echo -n 'Site got most requests on '
cat apache_logs.txt | cut -d' ' -f4 | cut -d'/' -f3 | sort | uniq -c | sort -nr | head -1 | cut -d':' -f2,3,4
echo 'Search bots accessed the site:'
while IFS= read -r line;
do
    echo $(cut -d' ' -f12 <<< "$line") $(cut -d' ' -f1 <<< "$line")
done < apache_logs.txt

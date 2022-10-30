#!/bin/bash

echo -n 'IP from which were the most requests:'
cat apache_logs.txt | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -1
echo -n 'The most requested page:'
cat apache_logs.txt | cut -d' ' -f7 | sort | uniq -c | sort -nr | head -1
echo 'Number of requests from each IP:'
cat apache_logs.txt | cut -d' ' -f1 | sort | uniq -c | sort -n

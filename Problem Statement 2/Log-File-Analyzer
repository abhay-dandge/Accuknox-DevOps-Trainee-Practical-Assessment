#!/bin/bash

read -p "Enter log file path: " logfile

echo "====== Web Log Analysis Report ======"
echo "Total 404 Errors:"
grep ' 404 ' $logfile | wc -l
echo "Top 5 Most Requested Pages:"
awk '{print $7}' $logfile | sort | uniq -c | sort -nr | head -5
echo ""
echo "Top 5 IP Addresses:"
awk '{print $1}' $logfile | sort | uniq -c | sort -nr | head -5
echo ""

echo "====== End of Report ======"

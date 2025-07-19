#!/bin/bash

LOG_DIR="/home/mass111/logs"
ERROR_PATTERNS=("ERROR" "FATAL" "CRITICAL")
REPORT_FILE="/home/mass111/logs/log_report.txt"

echo "Analyzing Log Files" > "$REPORT_FILE"
echo "-------------------" >> "$REPORT_FILE"


echo -e "\nList of log files updated in last 24 hrs" >> "$REPORT_FILE"
LOG_FILES=$(find "$LOG_DIR" -name "*.log" -mtime -1)
echo "$LOG_FILES" >> "$REPORT_FILE"

for LOG_FILE in $LOG_FILES; do

    echo -e "\n" >> "$REPORT_FILE"
    echo "-----------------------------------------------------------" >> "$REPORT_FILE"
    echo "------------$LOG_FILE-------------" >> "$REPORT_FILE"
    echo "-----------------------------------------------------------" >> "$REPORT_FILE"

    for PATTERN in ${ERROR_PATTERNS[@]}; do

        echo -e "\nsearching $PATTERN logs in $LOG_FILE file" >> "$REPORT_FILE"
        grep "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"

        echo -e "\nNumber of $PATTERN logs found in $LOG_FILE" >> "$REPORT_FILE"
        grep -c "$PATTERN" "$LOG_FILE" >> "$REPORT_FILE"

    done
done

echo -e "\nLog Analysis Completed and Report Has Been Saved in: $REPORT_FILE"

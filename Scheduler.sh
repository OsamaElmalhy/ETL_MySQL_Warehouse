#!/bin/bash

# Path to Python
pythonPath="/usr/bin/python3"

# Path to ETL script
scriptPath="/home/elmal/Downloads/project/Task 1/ETL.py"

# Path to log file
logFile="/home/elmal/Downloads/project/Task 1/logfile.txt"

# Check if the ETL script exists
if [ -f "$scriptPath" ]; then
    # Run the Python script
    "$pythonPath" "$scriptPath"
    
    if [ $? -eq 0 ]; then
        echo "Script Executed Successfully"
        # Log successful execution
        echo "$(date): Script Executed Successfully" >> "$logFile"
    else
        echo "Error occurred while executing the script"
        # Log failure of script execution
        echo "$(date): Error - Script execution failed" >> "$logFile"
    fi
else
    echo "Script didn't get executed, file not found"
    # Log error if the script doesn't exist
    echo "$(date): Error - Python script not found at $scriptPath" >> "$logFile"
fi

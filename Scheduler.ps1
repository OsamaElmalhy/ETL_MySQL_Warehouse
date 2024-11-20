# Path to Python 
$pythonPath = "C:\Python312\python.exe"

# Path to ETL script
$scriptPath = "C:\Users\elmal\Downloads\project\Task 1\ETL.PY"

# adding log file to log the excutions of the script
$logFile = "C:\Users\elmal\Downloads\project\Task 1\logfile.txt"

# Check if the ETL script exists
if (Test-Path $scriptPath) {
    # Run the Python script
    Start-Process -FilePath $pythonPath -ArgumentList $scriptPath -NoNewWindow -Wait
    Write-Host "Script Executed Successfully"

    # Log successful execution
    Add-Content -Path $logFile -Value "$(Get-Date): Script Executed Successfully"
} else {
    Write-Host "Script didn`t get Executed"
    # Log error if the script doesn't exist
    Add-Content -Path $logFile -Value "$(Get-Date): Error - Python script not found at $scriptPath"
}

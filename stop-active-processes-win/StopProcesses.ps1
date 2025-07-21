Get-Process | Where-Object { 
    $_.MainWindowTitle -ne '' -and 
    $_.Id -ne $PID -and 
    $_.ProcessName -ne 'explorer' 
} | Stop-Process -Force
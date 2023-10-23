Write-Host "Provisioning laptop. Please wait..."

Write-Host "Running Windows Update..."
# Install module to run Windows Update through script
Install-Module PSWindowsUpdate -Force
# Check and install updates
Get-WindowsUpdate
Install-WindowsUpdate -AcceptAll -Install

Write-Host "Adjusting Power Options"

# Change Power options to prevent timeout and disable fast startup
    # Screen Timeout
        # Plugged in
        powercfg -change -monitor-timeout-ac 0
        # Battery
        powercfg -change -monitor-timeout-dc 0
    # Standby Timeout
        # Plugged in
        powercfg -change -standby-timeout-ac 0
        # Battery
        powercfg -change -standby-timeout-dc 0
    
    # Disable Hibernate (Disabled Fast Startup)
    powercfg -h off
    # Disable Fast Startup in Registry
    Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value "0"

# Change power button action to do nothing
    # Plugged in
    powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 0
    # Battery
    powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 7648efa3-dd9c-4e3e-b566-50f929386280 0

# Change lid closing action to do nothing
    # Plugged in
    powercfg -setdcvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
    # Battery
    powercfg -setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0

    # Activate these changes
    powercfg -SetActive SCHEME_CURRENT

Write-Host "Now you just need to reboot, run HP Support Assistant, and install your software."
Write-Host "You may want to check for updates again after rebooting."
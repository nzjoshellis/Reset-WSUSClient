################################################################
# SCRIPT: Reset-WSUSClient.ps1
# AUTHOR: Josh Ellis - Josh@JoshEllis.NZ
# Website: JoshEllis.NZ
# VERSION: 1.0
# DATE: 08/02/2016
# DESCRIPTION: Resets the WSUS Client ID and clears our C:\Windows\SoftwareDistribution.
################################################################

$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate"

#Stop Service
Stop-Service "Windows Update"

#Remove Reg Keys
Get-ItemProperty -Path $Path | Remove-ItemProperty -Name 'PingID' -Force | Out-Null
Get-ItemProperty -Path $Path | Remove-ItemProperty -Name 'AccountDomainSid' -Force | Out-Null
Get-ItemProperty -Path $Path | Remove-ItemProperty -Name 'SusClientID' -Force | Out-Null
Get-ItemProperty -Path $Path | Remove-ItemProperty -Name 'SusClientIdValidation' -Force | Out-Null

#Remove SoftWare Distribution Folder
Remove-Item "C:\Windows\SoftwareDistribution" -Recurse -Force

#Start Service
Start-Service "Windows Update"

#Check into WSUS
wuauclt.exe /resetauthorization /detectnow 

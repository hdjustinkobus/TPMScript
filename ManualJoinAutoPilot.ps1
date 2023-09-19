$hwid = ((Get-WmiObject -Namespace root/cimv2/mdm/dmmap -Class MDM_DevDetail_Ext01 -Filter "InstanceID='Ext' AND ParentID='./DevDetail'").DeviceHardwareData)



$ser = (Get-WmiObject win32_bios).SerialNumber
if([string]::IsNullOrWhiteSpace($ser)) { $ser = $env:COMPUTERNAME}



################# Get PowerShell modules ###################



Install-PackageProvider -Name NuGet -Confirm:$false -Force
Install-Module -Name Microsoft.Graph.Intune -Confirm:$false -Force
Install-Module -Name WindowsAutoPilotIntune -Confirm:$false -Force



Import-Module Microsoft.Graph.Intune
Import-Module WindowsAutoPilotIntune



################## Connect Graph ################




################# ENTER YOUR GROUP TAG BELOW ##############



$tag = Read-Host "Enter group tag"



###########################################################




Write-Host "Connecting to Intune..." -ForegroundColor Cyan
Try{
Connect-MSGraph -ForceInteractive
write-host "Success" -ForegroundColor green
}
Catch{
Write-Host "Error- try logging in again" -ForegroundColor red
}



Add-AutoPilotImportedDevice -serialNumber $ser -hardwareIdentifier $hwid -groupTag $tag
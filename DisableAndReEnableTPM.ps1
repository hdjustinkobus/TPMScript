#To disable TPM
Suspend-BitLocker -MountPoint "C:" -RebootCount 1 -ErrorAction Continue
(Get-WmiObject -Class Lenovo_SetBiosSetting -Namespace root\wmi).SetBiosSetting("SecurityChip,Disable")
(Get-WmiObject -Class Lenovo_SaveBiosSettings -Namespace root\wmi).SaveBiosSettings()


#Then Reboot

#To turn TPM back on
(Get-WmiObject -Class Lenovo_SetBiosSetting -Namespace root\wmi).SetBiosSetting("SecurityChip,Enable$Password1")
(Get-WmiObject -Class Lenovo_SaveBiosSettings -Namespace root\wmi).SaveBiosSettings($Password2)

#Reboot again and verify that when running tpm.msc as an admin TPM shows visable.

#Get BIOS Information in case it's needed
gwmi -class Lenovo_BiosSetting -namespace root\wmi | ForEach-Object {if ($_.CurrentSetting -ne "") {Write-Host $_.CurrentSetting.replace(","," = ")}}
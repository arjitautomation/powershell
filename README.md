
param (
   $ou,$name,$Display_Name
)
$ou="whatever ou name"
#$name="automation_test2"
Add-PSSnapin microsoft.exchange.management.powershell.e2010
Import-module Activedirectory
$ErrorActionPreference='silentlycontinue'
$error.Clear()

$upn=$name+"@xyz.com"
$pass = (ConvertTo-SecureString -String 'Welcome@123' -AsPlainText -Force)
try
{
New-RemoteMailbox -Name $name -OnPremisesOrganizationalUnit $ou -DisplayName $Display_Name -UserPrincipalName $upn -Password $pass -ResetPasswordOnNextLogon $false -ErrorAction $ErrorActionPreference -WarningAction Ignore
}
catch
{

Write-Host "was not successfull"
}
$b=$error[0].exception.Message 
Write-Host $b
if ($b -ne $Null)
{
Write-Host "Failed to create the mailbox as we got the above error" 
}
Else {
Write-host "Mailbox has been created Successfully"
Set-RemoteMailbox -Identity $name -CustomAttribute2 "arjit"
}







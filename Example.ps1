#
# Deployment init
#

#Import-Module psDeploy
Import-Module -Name "C:\Romain\psDeploy\psDeploy\psDeploy.psm1" -Force 
Assert-PsDeploySupported
Initialize-PsDeploy -FailFast -LogPath "C:\DeploymentLogs"

#
# Deployment steps
#

New-User -Name 'Bob' -Password 'Password1'
Add-UserToGroup -Username 'Bob' -Group 'IIS_WPG'
Remove-UserFromGroup -Username 'Bob' -Group 'IIS_WPG'

New-VirtualDirectory -Website 'MyWeb' -Name 'Content' -Path 'C:\Inetpub\Content'
Remove-VirtualDirectory -Website 'MyWeb' -Name 'Content'

New-AppPool -Name 'MyWeb'
Remove-AppPool -Name 'MyWeb'


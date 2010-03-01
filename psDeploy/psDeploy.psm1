<#
    psDeploy - A Powershell deployment automation library
    Find the latest version and documentation at http://github.com/rprieto/psDeploy
#>


$currentDir = Split-Path $MyInvocation.MyCommand.Path

Import-Module -Name "$currentDir\Windows\Groups.psm1" -Force
Import-Module -Name "$currentDir\Windows\ScheduledTasks.psm1" -Force
Import-Module -Name "$currentDir\Windows\Users.psm1" -Force
Import-Module -Name "$currentDir\Windows\Shares.psm1" -Force
Import-Module -Name "$currentDir\Windows\Permissions.psm1" -Force
Import-Module -Name "$currentDir\IIS6\AppPools.psm1" -Force
Import-Module -Name "$currentDir\IIS6\Websites.psm1" -Force
Import-Module -Name "$currentDir\IIS6\VirtualDirectories.psm1" -Force



<#
.Synopsis
Checks that all the dependencies are available.
Please call this before calling any other cmdlets in psDeploy
#>
function Assert-PsDeploySupported
{
	[wmiclass] 'root/MicrosoftIISv2:IIsWebServer' > $null
	if (!$?)
	{
		throw "The IIS WMI Provider does not appear to be installed"
	}
}



<#
.Synopsis
Initialises standard deployment settings
#>
function Initialize-PsDeploy
{
    param
    (
        [switch] $FailFast,
        [string] $LogPath = $null
    ) 

    if ($FailFast)
    {
	   $ErrorActionPreference = 'Stop'
    }
    
    if ($LogPath -ne $null)
    {
        Try
        {
            $date = Get-Date -Format "yyyy-MM-dd-hh\hmm\mss\s"
            Start-Transcript -Path "$LogPath\$date.log"
        }
        Catch [System.Management.Automation.PSNotSupportedException]
        {
            Write-Output "Log transcripts are not available when running from the IDE"
        }
    }
}

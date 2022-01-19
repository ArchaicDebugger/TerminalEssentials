Import-Module Find-String
Import-Module Pscx
Import-Module Get-ChildItemColor
Import-Module posh-git
Import-Module oh-my-posh

$GitPromptSettings.WindowTitle = {
	param($GitStatus, [bool]$IsAdmin)
	"$(if ($IsAdmin) {'Admin: '})$(if ($GitStatus) {"$($GitStatus.RepoName) [$($GitStatus.Branch)]"} else {Get-PromptPath})"
}


Function CD2Source { Set-LocationEx -Path C:\source }
Function CD2Repos { Set-LocationEx -Path C:\source\repos }
Function cuserprofile { Set-LocationEx -Path $env:UserProfile }
Function U
{
    param
    (
        [int] $Code
    )
 
    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }
 
    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }
 
    throw "Invalid character code $Code"
}
Function RunEfs { dotnet run --launch-profile Local }

Set-Alias -Name ~ -Value cuserprofile -Option AllScope
Set-Alias -Name ll -Value Get-ChildItemColor -Option AllScope
Set-Alias -Name npp -Value C:\Apps\Notepad++\notepad++.exe
Set-Alias -Name cds -Value CD2Source
Set-Alias -Name cdr -Value CD2Repos
Set-Alias -Name docker-containers -Value DockerContainersContinuous
Set-Alias -Name run-efs -Value RunEfs

Function OpenContextEnv { cds; pwsh -Command ".\opencontextenv" -NoExit; }
Function DockerContainersContinuous { Do { docker ps -a; sleep 5; cls } while ($true) }

$DefaultUser = "User"

#Set-LocationEx C:\Users\CRS\source\repos

Set-PoshPrompt -Theme vinposh
#Set-PoshPrompt -Theme blueish

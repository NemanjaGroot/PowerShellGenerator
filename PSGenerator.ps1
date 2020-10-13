#ProjectName and SolutionName varibales
$pName = Read-Host -Prompt 'Please enter Project Name'
$sName = Read-Host -Prompt 'Please enter Solution Name'

if($pName -and $sName) {
    Write-Host "Project Name and Solution Name are successfuly added! :)"
} else {
    Write-Warning -Message "No names added."
}

#This part of script does Creating path, Planting application.cpp in root folder, Changing #ProjectName and #SolutionName in main file
# 

#=========================================================================================================================================

#Use the path from your default project locaton by Visual Studio
New-Item -ItemType "directory" -Path "C:\PowerShellSleepsHere\source\$pname\application"

#=========================================================================================================================================

#Files will be copied to this directory
Copy-Item C:\RastkoTasks\cpp-template-main\templates\cpp.template -Destination C:\PowerShellSleepsHere\source\$pname\application -Recurse


#=========================================================================================================================================

#This will rename cpp.template file
Rename-Item -Path "C:\PowerShellSleepsHere\source\$pname\application\cpp.template" -NewName "application.cpp"


#=========================================================================================================================================

#This will change strings in tools\Sharpmake\Sharpmake.Build\main.sharpmake.cs
(Get-Content "C:\RastkoTasks\cpp-template-main\tools\Sharpmake\Sharpmake.Build\main.sharpmake.cs") | ForEach-Object{ $_ -replace "#SolutionName", "$sname" } | Set-Content "C:\RastkoTasks\cpp-template-main\tools\Sharpmake\Sharpmake.Build\main.sharpmake.cs" -Force

(Get-Content "C:\RastkoTasks\cpp-template-main\tools\Sharpmake\Sharpmake.Build\main.sharpmake.cs") | ForEach-Object { $_ -replace "#ProjectName", "$pname" } | Set-Content "C:\RastkoTasks\cpp-template-main\tools\Sharpmake\Sharpmake.Build\main.sharpmake.cs" -Force


#=========================================================================================================================================

#This will remove files like .git .gitignore and \templates directory
Get-ChildItem -Path "C:\RastkoTasks\cpp-template-main" * -Include *.git, *.gitignore -Recurse | Remove-Item
Remove-Item 'C:\RastkoTasks\cpp-template-main\templates' -Recurse


#=========================================================================================================================================

#DEVELOPER NOTES FOR LATER:

#Get-Content ispitati regex pristup? UPDATE: Throws in some sort of pipeline mode...SOLUTION?
#ForEach-Object {  $_ -replace "#ProjectName", "$pname"}


#Kako push na Git i o Git-u :D
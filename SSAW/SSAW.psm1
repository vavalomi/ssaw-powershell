$Public = @( Get-ChildItem -Path "$PSScriptRoot\Public" -Include *.ps1 -Recurse)
$Private = @( Get-ChildItem -Path "$PSScriptRoot\Private" -Include *.ps1 -Recurse)

@($Public + $Private) | ForEach-Object {
    Try {
        . $_.FullName
    } Catch {
        Write-Error -Message "Failed to import function $($_.FullName): $_"
    }
}
Export-ModuleMember -Function $Public.BaseName

function Format-Payload {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [PSCustomObject]$Payload
    )
    Add-Type -AssemblyName System.Web
    $keys = @()
    $Payload.GetEnumerator() | ForEach-Object {
        $keys += (
            $($_.Key) + "=" + [System.Web.HttpUtility]::UrlEncode($($_.Value))
        )
    }
    return ("?" + ($keys -join ","))
}

Format-Payload @{a = 'dd'; b = 'ee'}
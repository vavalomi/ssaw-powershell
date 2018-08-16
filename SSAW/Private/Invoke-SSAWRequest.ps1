function Invoke-SSAWRequest {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [String]$Resource,
        [String]$baseUrl,
        [PSCredential]$Cred,
        [String]$Method = "GET",
        [PSCustomObject]$Payload
    )

    if (-not $baseUrl) {
        $baseUrl = $Script:scriptbaseUrl
    }
    if (-not $Cred) {
        $Cred = $Script:scriptCred
    }

    if (@("PATCH", "POST", "PUT").Contains($Method)) {
        $query = Format-Payload $Payload
    }
    $headers = @{
        "Content-Type" = 'application/json';
        "Accept" = 'application/json';
    }

    $uri = $baseUrl + $Resource + $query
    Invoke-RestMethod -Method $Method -Uri $uri -Headers $headers -Credential $Cred
}
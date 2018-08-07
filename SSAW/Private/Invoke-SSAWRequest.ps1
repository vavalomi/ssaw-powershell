function Invoke-SSAWRequest {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [String]$Resource,
        [String]$baseUrl,
        [PSCredential]$Cred,
        [String]$Method = "GET"
    )

    if (-not $baseUrl) {
        $baseUrl = $Script:scriptbaseUrl
    }
    if (-not $Cred) {
        $Cred = $Script:scriptCred
    }

    $headers = @{
        "Content-Type" = 'application/json';
        "Accept" = 'application/json';
    }

    $uri = $baseUrl + $Resource
    Invoke-RestMethod -Method $Method -Uri $uri -Headers $headers -Credential $Cred
}
function Invoke-SSAWRequest {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [parameter(Mandatory = $true)]
        [String]$Resource,
        [String]$baseUrl,
        [PSCredential]$Cred,
        [String]$Method = "GET",
        [PSCustomObject]$Payload,
        [Switch]$Force
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
    if ($Force -or $PSCmdlet.ShouldProcess("Interview status will be changed to $resultstatus", "Are you sure?", "Confirm status change")) {
        Invoke-RestMethod -Method $Method -Uri $uri -Headers $headers -Credential $Cred
    }
}
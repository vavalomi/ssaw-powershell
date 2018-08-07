function Get-SSAWInterviewHistory {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [String]$id,
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $resource = "interviews/" + ($id -replace "-", "") + "/history"

    $response = Invoke-SSAWRequest -Method GET -Resource $resource -Cred $Cred -baseUrl $baseUrl

    if ($response.Records) {
        return $response.Records
    }
}
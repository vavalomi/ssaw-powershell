function Get-SSAWInterviewStats {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseSingularNouns")]
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [String]$id,
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $resource = "interviews/" + ($id -replace "-", "") + "/stats"

    $response = Invoke-SSAWRequest -Method GET -Resource $resource -Cred $Cred -baseUrl $baseUrl

    return $response
}
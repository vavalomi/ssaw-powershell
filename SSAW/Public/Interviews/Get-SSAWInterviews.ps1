function Get-SSAWInterviews {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [String]$questionnaireId,
        [parameter(Mandatory = $true)]
        [Int]$questionnaireVersion,
        [String]$status,
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $resource = "interviews"

    $response = Invoke-SSAWRequest -Method GET -Resource $resource -Cred $Cred -baseUrl $baseUrl

    if ($response.Interviews) {
        return $response.Interviews
    }
}
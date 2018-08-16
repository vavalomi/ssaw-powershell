function Get-SSAWInterview {
    [cmdletbinding()]
    param(
        [String]$questionnaireId,
        [Int]$questionnaireVersion,
        [String]$status,
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $resource = "interviews"
    $q = @()
    if ($questionnaireId) {
        $q += "questionnaireId=$questionnaireId"
    }
    if ($questionnaireVersion) {
        $q += "questionnaireVersion=$questionnaireVersion"
    }
    if ($status) {
        $q += "status=$status"
    }
    if ($q.count) {
        $resource = $resource + "?" + ($q -join "&")
    }
    $response = Invoke-SSAWRequest -Method GET -Resource $resource -Cred $Cred -baseUrl $baseUrl

    if ($response.Interviews) {
        return $response.Interviews
    }
}
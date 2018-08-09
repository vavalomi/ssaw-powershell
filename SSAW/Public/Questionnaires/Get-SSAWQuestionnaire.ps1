function Get-SSAWQuestionnaire {
    [cmdletbinding()]
    param(
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $resource = "questionnaires"

    $response = Invoke-SSAWRequest -Method GET -Resource $resource -Cred $Cred -baseUrl $baseUrl

    if ($response.Questionnaires) {
        return $response.Questionnaires
    }
}
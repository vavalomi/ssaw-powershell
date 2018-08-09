function Start-SSAWExport {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [String]$questionnaireId,
        [parameter(Mandatory = $true)]
        [Int]$questionnaireVersion,
        [String]$exportType = "Tabular",
        [String]$status,
        [Datetime]$from,
        [Datetime]$to,
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $qid = ($questionnaireId -replace "-", "") + "$" + $questionnaireVersion
    $resource = "export/" + $exportType + "/" + $qid + "/start"

     $response = Invoke-SSAWRequest -Method POST -Resource $resource -Cred $Cred -baseUrl $baseUrl

    return $response
}
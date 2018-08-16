function Start-SSAWExport {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
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
        [PSCredential]$Cred,
        [Switch]$Force
    )

    $qid = ($questionnaireId -replace "-", "") + "$" + $questionnaireVersion
    $resource = "export/" + $exportType + "/" + $qid + "/start"

    if ($Force -or $PSCmdlet.ShouldContinue("New export process will be triggered", "Are you sure?")) {
        $response = Invoke-SSAWRequest -Method POST -Resource $resource -Cred $Cred -baseUrl $baseUrl -Force:$Force -Confirm:$False
    }

    return $response
}
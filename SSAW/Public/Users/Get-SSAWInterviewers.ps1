function Get-SSAWInterviewers {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        $supervisorId,
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $resource = "supervisors/" + ($supervisorId -replace "-", "") + "/interviewers"

    $response = Invoke-SSAWRequest -Method GET -Resource $resource -Cred $Cred -baseUrl $baseUrl

    if ($response.Users) {
        return $response.Users
    }
}
function Get-SSAWSupervisors {
    [cmdletbinding()]
    param(
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $resource = "supervisors"

    $response = Invoke-SSAWRequest -Method GET -Resource $resource -Cred $Cred -baseUrl $baseUrl

    if($response.Users){
        return $response.Users
    }
}
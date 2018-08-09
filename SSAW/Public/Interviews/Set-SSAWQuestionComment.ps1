function Set-SSAWQuestionComment {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [String]$id,
        [parameter(Mandatory = $true)]
        [String]$variable,
        [parameter(Mandatory = $true)]
        [String]$Comment,
        [Array]$rosterVector,
        [String]$baseUrl,
        [PSCredential]$Cred
    )

    $Payload = @{
        comment = $Comment
    }
    $resource = "interviews/" + ($id -replace "-", "") + "/comment-by-variable/" + $variable

    $response = Invoke-SSAWRequest -Method POST -Resource $resource -Cred $Cred -baseUrl $baseUrl -Payload $Payload

    return $response
}
function Set-SSAWQuestionComment {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [parameter(Mandatory = $true)]
        [String]$id,
        [parameter(Mandatory = $true)]
        [String]$variable,
        [parameter(Mandatory = $true)]
        [String]$Comment,
        [Array]$rosterVector,
        [String]$baseUrl,
        [PSCredential]$Cred,
        [Switch]$Force
    )

    $Payload = @{
        comment = $Comment
    }
    $resource = "interviews/" + ($id -replace "-", "") + "/comment-by-variable/" + $variable

    if ($Force -or $PSCmdlet.ShouldProcess("New comment will be added", "Are you sure?", "Confirm the change")) {
        $response = Invoke-SSAWRequest -Method POST -Resource $resource -Cred $Cred -baseUrl $baseUrl -Payload $Payload -Force:$Force -Confirm:$False
        return $response
    }
}
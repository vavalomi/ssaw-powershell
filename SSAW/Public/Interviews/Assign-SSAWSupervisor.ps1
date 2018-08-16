function Assign-SSAWSupervisor {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [String]$id,

        [String]$Comment,
        [String]$BaseUrl,
        [PSCredential]$Cred,
        [Switch]$Force
    )

    $Payload = @{
        comment = $comment
    }

    $resource = "interviews/" + ($id -replace "-", "") + "/" + $action

    if ($Force -or $PSCmdlet.ShouldProcess("Assignment responsible will be changed", "Are you sure?", "Confirm responsible change")) {
        $response = Invoke-SSAWRequest -Method PATCH -Resource $resource -Cred $Cred -baseUrl $BaseUrl -Payload $Payload -Force:$Force -Confirm:$False
    }

    return $response
}
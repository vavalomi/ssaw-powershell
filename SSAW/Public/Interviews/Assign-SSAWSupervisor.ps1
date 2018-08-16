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

    if ($Force -and $PSCmdlet.ShouldProcess("Interview status will be changed to $resultstatus", "Are you sure?", "Confirm status change")) {
        $response = Invoke-SSAWRequest -Method PATCH -Resource $resource -Cred $Cred -baseUrl $BaseUrl -Payload $Payload
    }

    return $response
}
function Set-InterviewStatus {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [String]$id,
        [Parameter(Mandatory = $true)]
        [ValidateSet("approve", "reject", "hqapprove", "hqreject", "hqunapprove")]
        [String]$Action,
        [String]$Comment,
        [String]$BaseUrl,
        [PSCredential]$Cred,
        [Switch]$Force
    )

    $Payload = @{
        comment = $comment
    }

    $resource = "interviews/" + ($id -replace "-", "") + "/" + $action

    Switch ($action) {
        "approve" { $resultstatus = "ApprovedBySupervisor" }
        "reject" { $resultstatus = "RejectedBySupervisor" }
        "hqapprove" { $resultstatus = "ApprovedByHeadquarters" }
        "hqreject" { $resultstatus = "RejectedByHeadquarters" }
        "hqunapprove" { $resultstatus = "ApprovedBySupervisor" }
    }

    if ($Force -or $PSCmdlet.ShouldProcess("Interview status will be changed to $resultstatus", "Are you sure?", "Confirm status change")) {
        $response = Invoke-SSAWRequest -Method PATCH -Resource $resource -Cred $Cred -baseUrl $BaseUrl -Payload $Payload
    }

    return $response
}
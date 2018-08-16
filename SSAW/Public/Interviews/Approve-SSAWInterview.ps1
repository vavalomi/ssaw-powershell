function Approve-SSAWInterview {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [String]$id,
        [String]$comment,
        [String]$baseUrl,
        [PSCredential]$Cred,
        [Alias("ASHQ")]
        [Switch]$ASHeadquarters,
        [Switch]$Force
    )

    if ($ASHeadquarters) {
        $action = "hqapprove"
    }
    else {
        $action = "approve"
    }
    if ($Force -or $PSCmdlet.ShouldProcess("The interview will be approved", "Are you sure?", "Confirm status change")) {
        Set-InterviewStatus -Action $action -id $id -Comment $comment -BaseUrl $baseUrl -Cred $cred
    }
}
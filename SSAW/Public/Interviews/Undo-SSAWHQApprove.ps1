function Undo-SSAWHQApprove {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true)]
        [String]$id,
        [String]$comment,
        [String]$baseUrl,
        [PSCredential]$Cred,
        [Switch]$Force
    )
    $action = "hqunapprove"

    if ($Force -or $PSCmdlet.ShouldProcess("The interview will be unapproved", "Are you sure?", "Confirm status change")) {
        Set-InterviewStatus -Action $action -id $id -Comment $comment -BaseUrl $baseUrl -Cred $cred
    }
}
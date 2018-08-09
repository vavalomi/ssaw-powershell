function Approve-SSAWInterview {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory = $true)]
        [String]$id,
        [String]$comment,
        [String]$baseUrl,
        [PSCredential]$Cred,
        [Alias("ASHQ")]
        [Switch]$ASHeadquarters
    )

    if ($ASHeadquarters) {
        $action = "hqapprove"
    }
    else {
        $action = "approve"
    }
    Set-InterviewStatus -Action $action -id $id -Comment $comment -BaseUrl $baseUrl -Cred $cred
}
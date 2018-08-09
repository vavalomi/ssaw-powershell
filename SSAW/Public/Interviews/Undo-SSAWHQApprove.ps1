function Undo-SSAWHQApprove {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory = $true)]
        [String]$id,
        [String]$comment,
        [String]$baseUrl,
        [PSCredential]$Cred
    )
    $action = "hqunapprove"

    Set-InterviewStatus -Action $action -id $id -Comment $comment -BaseUrl $baseUrl -Cred $cred
}
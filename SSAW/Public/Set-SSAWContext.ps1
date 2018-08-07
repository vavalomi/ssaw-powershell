function Set-SSAWContext() {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$Url,
        [Parameter(
            Mandatory = $true
        )]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential
    )

    $Script:scriptbaseUrl = $Url + "/api/v1/"
    $Script:scriptCred = $Credential
}

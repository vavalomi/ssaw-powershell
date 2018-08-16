function Set-SSAWContext() {
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
        [PSCredential]$Credential,
        [Switch]$Force
    )

    $Script:scriptbaseUrl = $Url + "/api/v1/"
    $Script:scriptCred = $Credential
}

function Set-SSAWContext() {
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact = 'Low')]
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

    if ($Force -or $PSCmdlet.ShouldContinue("The settings will be saved and used by following commandlets", "Are you sure?")) {
        $Script:scriptbaseUrl = $Url + "/api/v1/"
        $Script:scriptCred = $Credential
    }
}

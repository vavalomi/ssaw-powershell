$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf

Remove-Module $moduleName -Force -ErrorAction SilentlyContinue
Import-Module -name (Join-Path $moduleRoot "$moduleName.psm1") -Force

InModuleScope $moduleName {
    Describe 'Set-SSAWContext' {
        BeforeAll {
            $secstr = New-Object -TypeName System.Security.SecureString
            $cred = new-object -typename System.Management.Automation.PSCredential -argumentlist 'username', $secstr
            $url = "https://test.example.com"
        }
   
        It 'Should define globals' {
            Set-SSAWContext -Url $url -Credential $cred
            $script:scriptbaseUrl | Should be ($url + "/api/v1/")
            $script:scriptCred | Should be $cred
        }
    }
}
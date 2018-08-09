Remove-Module $ENV:BHProjectName -Force -ErrorAction SilentlyContinue
Import-Module $ENV:BHPSModulePath -Force

InModuleScope $ENV:BHProjectName {
    Describe Set-SSAWContext {
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
$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf

Remove-Module $moduleName -Force -ErrorAction SilentlyContinue
Import-Module (Join-Path $moduleRoot "$moduleName.psm1")


InModuleScope $moduleName {
    . $PSScriptRoot\Set-TestingContext

    Describe "Users" -Tags Build, Unit {
        $recordweb = $false
        . $PSScriptRoot\New-Mock

        Context "Get-SSAWSupervisor" {
            $testname = "Users_Supervisor_Get"
            It "Gets right number of objects" {
                $res = Get-SSAWSupervisor
                $res.count | Should be 10
                Assert-MockCalled -CommandName 'Invoke-RestMethod' -Scope It
            }
        }

        Context "Get-SSInterviewer" {
            $testname = "Users_Interviewer_Get"
            It "Gets right number of objects" {
                [Array]$res = Get-SSAWInterviewer -SupervisorId "2225421b-9f74-4b1c-8923-9fac6c807225"
                $res.count | Should be 1
                Assert-MockCalled -CommandName 'Invoke-RestMethod' -Scope It
            }
            $testname = "Users_Interviewer_Get_empty"
            It "Nonexistant supervisor" {
                [Array]$res = Get-SSAWInterviewer -SupervisorId "00000000-9f74-4b1c-8923-9fac6c807225"
                $res.count | Should be 0
                Assert-MockCalled -CommandName 'Invoke-RestMethod' -Scope It
            }
        }
    }
}
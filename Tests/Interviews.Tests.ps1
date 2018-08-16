$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\*\*.psd1")
$moduleName = Split-Path $moduleRoot -Leaf

Remove-Module $moduleName -Force -ErrorAction SilentlyContinue
Import-Module (Join-Path $moduleRoot "$moduleName.psm1")


InModuleScope $moduleName {
    . $PSScriptRoot\Set-TestingContext

    Describe "Interviews" -Tags Build, Unit {
        $recordweb = $false
        . $PSScriptRoot\New-Mock

        Context "Get-SSSAWInterview" {
            $testname = "Interviews_Get_all"
            It "Gets right number of objects" {
                $res = Get-SSAWInterview
                $res.count | Should be 10
                Assert-MockCalled -CommandName 'Invoke-RestMethod' -Scope It
            }
            $testname = "Interviews_Get_quest"
            It "Interviews for specific questionnaire" {
                $res = Get-SSAWInterview -questionnaireId "1747a2a5-3045-477b-b3b4-42170948d99e" -questionnaireVersion 2
                $res.count | Should be 10
                Assert-MockCalled -CommandName 'Invoke-RestMethod' -Scope It
            }
            $testname = "Interviews_Get_quest_empty"
            It "Nonexistant questionnaire" {
                $res = Get-SSAWInterview -questionnaireId "00000000-3045-477b-b3b4-42170948d99e" -questionnaireVersion 1
                $res.count | Should be 0
                Assert-MockCalled -CommandName 'Invoke-RestMethod' -Scope It
            }
        }

    }
}
# Adopted from https://github.com/RamblingCookieMonster/PSDeploy


Properties {
    # Find the build folder based on build system
    $ProjectRoot = $ENV:BHProjectPath
    if (-not $ProjectRoot) {
        $ProjectRoot = $PSScriptRoot
    }

    $Timestamp = Get-date -uformat "%Y%m%d-%H%M%S"
    $PSVersion = $PSVersionTable.PSVersion.Major
    $TestFile = "TestResults_PS$PSVersion`_$TimeStamp.xml"
    $lines = '----------------------------------------------------------------------'

    $Verbose = @{}
    if ($ENV:BHCommitMessage -match "!verbose") {
        $Verbose = @{Verbose = $True}
    }
}

Task Default -Depends Deploy

Task Init {
    Remove-item $ProjectRoot\TestResults* -Force
    $lines
    Set-Location $ProjectRoot
    "Build System Details:"
    Get-Item ENV:BH*
    "`n"
}

Task Test -Depends Init {
    $lines
    "`n`tSTATUS: Testing with PowerShell $PSVersion"

    Invoke-ScriptAnalyzer -Path $ENV:BHPSModulePath -Settings PSGallery -Recurse
    $lines

    $sourcefiles = (Get-ChildItem -Path $ENV:BHPSModulePath\*.ps1  -Recurse).FullName
    $TestResults = Invoke-Pester -Path $ProjectRoot\Tests -PassThru -OutputFormat NUnitXml -CodeCoverage $sourcefiles -OutputFile "$ProjectRoot\$TestFile"

    If ($ENV:BHBuildSystem -eq 'Teamcity') {
        Write-Host "##teamcity[importData type='nunit' path='$ProjectRoot\$TestFile']"
        Write-Output "##teamcity[buildStatisticValue key='CodeCoverageAbsLTotal' value='$($testResults.CodeCoverage.NumberOfCommandsAnalyzed)']"
        Write-Output "##teamcity[buildStatisticValue key='CodeCoverageAbsLCovered' value='$($testResults.CodeCoverage.NumberOfCommandsExecuted)']"
    }

    if ($TestResults.FailedCount -gt 0) {
        Write-Error "Failed '$($TestResults.FailedCount)' tests, build failed"
    }
    "`n"
}

Task Build -Depends Test {
    $lines
    
    # Load the module, read the exported functions, update the psd1 FunctionsToExport
    Set-ModuleFunctions

    # Bump the module version
    Update-Metadata -Path $env:BHPSModuleManifest
}

Task Deploy -Depends Build {
    $lines

    $Params = @{
        Path = $ProjectRoot
        Force = $true
        Recurse = $false
    }
    Invoke-PSDeploy @Verbose @Params
}
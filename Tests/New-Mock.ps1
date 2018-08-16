$recordpath = Join-Path $PSScriptRoot "Records"
if ($recordweb) {
    Mock 'Invoke-RestMethod' {
        Write-Host "executing record"
        $ret = Invoke-WebRequest -uri $uri -headers $headers -method $method -credential $credential
        $ret | Export-Clixml "$recordpath\$($testname).xml"
        return ($ret.Content | ConvertFrom-Json)
    } -Verifiable
}
else {
    Mock 'Invoke-RestMethod' {
        Write-Host "executing mock"
        $ret = Import-Clixml "$recordpath\$($testname).xml"
        return ($ret.Content | ConvertFrom-Json)
    } -Verifiable
}

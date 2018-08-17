# define url and credentials for recording

$username = "api_user"
$password = "api_user_password"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
Set-SSAWContext -url "https://yourserver.com" -cred $cred
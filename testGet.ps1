

$params = @{
    Uri = "https://shinseisha.sdt-autolabo.com/api/items/67169/get"
    Method = "POST"
    Body = @{
        ApiVersion = "1.1"
        ApiKey = "503b75c454115189579d41958da552068703cc4692cc0dbca3ecbe1a94a57bcaae26c7a6cd9af2a1fe946649b17da6d57a2c2aba09068294c39e627187b46adf"
    } | ConvertTo-Json
    ContentType = 'application/json'
}

$post = Invoke-RestMethod @params
$post.Response.Data | % {$_.CheckHash.CheckA}

Stop-Process
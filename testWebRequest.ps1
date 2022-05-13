
$word = '”L‚ð'
$params = @{
    Uri = "https://2mtmex.com/search?%2Fsearch=&comment_count=100&q=" + $word + "&sort_by=ikioi&state=1"
    Method = "GET"
    #Body = @{
    #    ApiVersion = "1.1"
    #    ApiKey = "02003838fe851d02b03bdf6f1b5de0a9d624352440db74d8531d98526a12c709bb997e11ae365dd2b5bb8153e9b30443ef16bf0de64ba09004630c0744e33d34"
    #} | ConvertTo-Json
    ContentType = "application/json"
}

$post = Invoke-WebRequest @params
$post = [System.Text.Encoding]::Utf8.GetString($post.RawContentStream.GetBuffer())
$post

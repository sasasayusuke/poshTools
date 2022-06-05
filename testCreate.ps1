
$params = @{
    Uri = "https://ssj-pleasanter-01.sdt-test.work/api/items/110595/create"
    Method = "POST"
    Body = @{
        ApiVersion = "1.1"
        ApiKey = "3b80682c7c46eb8defd61b956100e49792b9c0f273d4345515d0ac9bfcd251a69cd3eeff5610ce0d669b1072a79ecbbce4f37209f2927e3e54c5d1859feb305f"
        DateHash = @{
            DateA = "2019/01/01"
        }
        ClassHash = @{
            ClassB = "Administrator"
        }
        CheckHash = @{
            CheckA = $True
        }
    } | ConvertTo-Json
    ContentType = 'application/json'
}
Invoke-RestMethod @params

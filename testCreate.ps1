
$params = @{
    Uri = "https://ssj-pleasanter-01.sdt-test.work/api/items/110595/create"
    Method = "POST"
    Body = @{
        ApiVersion = "1.1"
        ApiKey = "3b80682c7c46eb8defd61b956100e49792b9c0f273d4345515d0ac9bfcd251a69cd3eeff5610ce0d669b1072a79ecbbce4f37209f2927e3e54c5d1859feb305f"
        Title = "aa"
        Body = "ab"
        CompletionTime = "2018/3/31"
        ClassHash = @{
            ClassA = "fdf"
            ClassB = "gr"
            ClassC = "sdfa"
        }
        NumHash = @{
            NumA = 100
            NumB = 200
        }
        DateHash = @{
            DateA = "2019/01/01"
            DateB = "2020/01/01"
        }
        DescriptionHash = @{
            DescriptionA = "trt"
            DescriptionB = "yt"
            DescriptionC = "u"
        }
        CheckHash = @{
            CheckA = $true
            CheckB = $false
        }
    } | ConvertTo-Json
    ContentType = 'application/json'
}

Invoke-RestMethod @params

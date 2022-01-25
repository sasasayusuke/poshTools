
function global:convert {

    #JSONからCSVに変換
    $a = Get-Content "C:\Users\jntPCadmin\Desktop\work\powershell\json\my.json" -Encoding UTF8 | ConvertFrom-Json
    $a | ConvertTo-Csv > "C:\Users\jntPCadmin\Desktop\work\powershell\json\my.csv"
    #CSVからJSONに変換
    #Import-Csv "C:\Users\jntPCadmin\Desktop\work\powershell\json\my.csv" -Encoding UTF8| ConvertTo-Json > "C:\Users\jntPCadmin\Desktop\work\powershell\json\my.json"

}

function global:araidashi {


    $target = getContent -File "\\172.22.136.159\共有\00_共通\06_個人フォルダ\笹木\外部印刷リスト.txt" -Unique
    $target | %{
        Write-Output $_
        ff $_ -PathCode MyBatis
        ff $_ -PathCode Migration -Include sql
        Write-Output ===========
    }

}

function global:openExt {
    $text = getContent -Unique | extractExt
    Write-Output $text
    $splatting = @{
        Message = "以上の" + $text.Length + "ファイルを開きますか？"
        Title = $text
    }
    $response = confirmYesNoHost @splatting
    if ($response.toUpper() -eq "Y") {
        Invoke-Item $text
    }
}

function global:execOneCockpit {
    Param(
        [switch] $Serve = $false,
        [switch] $Build = $false
    )

    getDirCode Front -Change
    if ($Build) {
        npm run build
    }
    if ($Serve) {
        npm run serve
    } else {
        getDirCode Back -Change
        .\main.py
        getBatCode -BatCode VPNConnect -Execute
        Start-Process http://127.0.0.1:5000/
    }
}


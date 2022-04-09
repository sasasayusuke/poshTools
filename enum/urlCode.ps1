enum UrlCode {
    BitFlyer
    Box
    Empty
    Garoon
    Github
    KingOfTime
    Kompira
    Mirai
    Pleasanter
    Redmine
    SBI
    Trello
    Weblio
    Wikipedia
}

function global:getAllUrlCode {
    return [enum]::GetNames([UrlCode])
}

function global:getUrlCode {
    Param (
        [ArgumentCompleter({getAllUrlCode})][ValidateScript({$_ -in $(getAllUrlCode)})] $UrlCode = "Garoon",
        [switch] $Copy = $false,
        [switch] $Open = $false,
        [String] $Search
    )
    switch ($urlCode) {
        Garoon {
            $url = "https://www2.sdt-itnet.jp/scripts/cbgrn/grn.exe"
        }
        KingOfTime {
            $url = "https://s2.kingtime.jp/independent/recorder/personal/"
        }
        Pleasanter {
            if ([string]::IsNullOrEmpty($Search)) {
                getBatCode -BatCode VPNConnect -Execute
                $url = "https://ssj-pleasanter-01.sdt-test.work/items/5419/index"
            } else {
                $url = "https://pleasanter.org/manual?search=" + $Search
            }
        }
        Redmine {
            getBatCode -BatCode VPNConnect -Execute
            $url = "https://ss-learning.sdt-test.work/redmine/"
        }
        Kompira {
            getBatCode -BatCode VPNConnect -Execute
            $url = "https://autolabo01.sdt-test.work/"
        }
        Github {
            $url = "https://github.com/sasasayusuke/"
        }
        Trello {
            $url = "https://trello.com/b/i4wFrPb9/todo"
        }
        Mirai {
            $url = "https://miraitranslate.com/trial"
            if (![string]::IsNullOrEmpty($Search)) {
                $url += "/#ja/en/" + $Search
            }
        }
        Box {
            $url = "https://app.box.com/folder/0"
        }
        SBI {
            $url = "https://www.sbisec.co.jp/ETGate"
        }
        BitFlyer {
            $url = "https://bitflyer.com/ja-jp/ex/Home"
        }
        Weblio {
            $url = "https://thesaurus.weblio.jp/content/"
            if (![string]::IsNullOrEmpty($Search)) {
                $url += $Search
            }
        }
        Wikipedia {
            $url = "https://ja.wikipedia.org/wiki/"
            if (![string]::IsNullOrEmpty($Search)) {
                $url += $Search
            }
        }
        Empty {
            $url = $SYMBOL_EMPTY
        }
        default {
            writeMessage "invalid argument" -Break
        }
    }
    if ($Copy) {
        Set-Clipboard $url
    }
    if ($Open) {
        Start-Process $url
    }
    return $url
}

Set-Alias gtu getUrlCode

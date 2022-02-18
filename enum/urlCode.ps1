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
        [String] $Word
    )
    switch ($urlCode) {
        Garoon {
            $url = "https://www2.sdt-itnet.jp/scripts/cbgrn/grn.exe"
        }
        KingOfTime {
            $url = "https://s2.kingtime.jp/independent/recorder/personal/"
        }
        Pleasanter {
            getBatCode -BatCode VPNConnect -Execute
            $url = "https://ssj-pleasanter-01.sdt-test.work/items/5419/index"
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
        Wikipedia {
            $url = "https://ja.wikipedia.org/wiki/"
            if (![string]::IsNullOrEmpty($Word)) {
                $url += $Word
            }
        }
        Empty {
            $url = $SYMBOL_EMPTY
        }
        default {
            writeMessageHost "invalid argument" -Break
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

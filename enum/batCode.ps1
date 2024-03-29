enum BatCode {
    IPSwitch
    VPNConnect
    AviUtil
    YMM4
}
function global:getAllBatCode {
    return [enum]::GetNames([BatCode])
}
function global:getBatCode {
    Param (
        [ArgumentCompleter({getAllBatCode})][ValidateScript({$_ -in $(getAllBatCode)})][String] $BatCode = "VPNConnect",
        [switch] $Copy = $false,
        [switch] $Execute = $false
    )
    switch ($BatCode) {
        IPSwitch {
            if ($MAIN_USER -eq "Vaio") {
                $bat = (getDirCode -DirCode Tool) + "\IPSwitch.exe"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
            }
        }
        VPNConnect {
            if ($MAIN_USER -eq "Vaio") {
                $bat = (getDirCode -DirCode Tool) + "\VPNConnect.exe"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
            }
        }
        AviUtil {
            if ($MAIN_USER -eq "Vaio") {
                $bat = (getDirCode -DirCode Tool) + "\aviutil.exe.lnk"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
            }
        }
        YMM4 {
            if ($MAIN_USER -eq "Vaio") {
                $bat = (getDirCode -DirCode Tool) + "\ymm.exe.lnk"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
            }
        }
    }
    if ($Copy) {
        Set-Clipboard $bat
    }
    if ($Execute) {
        Start-Process $bat
    }
    return $bat
}
Set-Alias gtb getBatCode
enum DirCode {
    Book
    Current
    Download
    Empty
    Git
    ImageInternal
    ImageExternal
    PowerShell
    Test
    Tool
}
function global:getAllDirCode {
    return [enum]::GetNames([DirCode])
}
function global:getDirCode {
    Param (
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DirCode = "PowerShell",
        [switch] $Change = $false,
        [switch] $Copy = $false,
        [switch] $Open = $false
    )
    switch ($DirCode) {
        Git {
            if ($MAIN_USER -eq "Vaio") {
                $dir = "C:\Users\Y-Sasaki\Desktop\sasaki\product\github"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = "C:\Users\sasakiy\Desktop\sasaki\git"
            }
        }
        PowerShell {
            if ($MAIN_USER -eq "Vaio") {
                $dir = (getDirCode -DirCode Git) + "\poshTools"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = "C:\Users\pc\Desktop\posh-master"
            }
        }
        Book {
            $dir = "C:\Users\Y-Sasaki\Desktop\sasaki\book"
        }
        Tool {
            $dir = "C:\Users\Y-Sasaki\Desktop\sasaki\tool"
        }
        ImageInternal {
            if ($MAIN_USER -eq "Vaio") {
                $dir = "C:\Users\Y-Sasaki\Desktop\sasaki\image"
            }

        }
        ImageExternal {
            if ($MAIN_USER -eq "Vaio") {
                $dir = "D:\images\t_ver1"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = "E:\images\t_ver1"
            }
        }
        Test {
            if ($MAIN_USER -eq "Vaio") {
                $dir = "C:\Users\Y-Sasaki\Desktop\test"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = "C:\Users\pc\Desktop\test"
            }
        }
        Download {
            if ($MAIN_USER -eq "Vaio") {
                $dir = "C:\Users\Y-sasaki\Downloads"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = "C:\Users\pc\Downloads"
            }
        }
        Current {
            $dir = Convert-Path .
        }
        Empty {
            $dir = $SYMBOL_EMPTY
        }
        default {
            writeMessage "invalid argument" -Break
        }
    }
    if ($Change) {
        Set-Location $dir
    }
    if ($Copy) {
        Set-Clipboard $dir
    }
    if ($Open) {
        Invoke-Item $dir
    }
    return $dir
}
Set-Alias gtd getDirCode
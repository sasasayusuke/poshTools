enum DirCode {
    Back
    Book
    Current
    Download
    Empty
    Front
    Git
    ImageInternal
    ImageExternal
    Personal
    PowerShell
    Svn
    Temporary
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
                $dir = "C:\Users\Y-Sasaki\Desktop\sasaki\git"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = "C:\Users\sasakiy\Desktop\sasaki\git"
            }
        }
        Svn {
            $dir = "C:\Users\Y-Sasaki\Desktop\sasaki\svn"
        }
        PowerShell {
            if ($MAIN_USER -eq "Vaio") {
                $dir = (getDirCode -DirCode Git) + "\posh"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = "C:\Users\pc\Desktop\posh-master"
            }
        }
        Book {
            $dir = "C:\Users\Y-Sasaki\Desktop\sasaki\book"
        }
        Front {
            $dir = (getDirCode -DirCode Svn) + "\onecockpit\フロント\frontend\src"
        }
        Back {
            $dir = (getDirCode -DirCode Svn) + "\onecockpit\フロント\backend"
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
        Temporary {
            if ($MAIN_USER -eq "Vaio") {
                $dir = "C:\Users\Y-Sasaki\Desktop\temp"
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
        Personal {
            if ($MAIN_USER -eq "Vaio") {
                getBatCode -BatCode VPNConnect -Execute
                $dir = "\\192.168.10.37\share\99.個人\笹木勇介\公開\"
            }
            elseif ($MAIN_USER -eq "Dynabook") {
                $dir = ""
            }
        }
        Current {
            $dir = Convert-Path .
        }
        Empty {
            $dir = $SYMBOL_EMPTY
        }
        default {
            writeMessageHost "invalid argument" -Break
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
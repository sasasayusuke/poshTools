
# read-hostを表示する
#
# @param    Title               タイトル
# @param    ConfirmMessage      確認メッセージ
# @param    Tip                 追記事項
# @param    errorMessage        エラー時メッセージ
#
# @return   結果（Y=true | N=false）
function global:confirmHost {
    Param(
        [string] $Title = "*** 実行確認 ***",
        [string] $ConfirmMessage = "実行してよろしいですか？",
        [string] $Tip = " はい=Y いいえ=N"
    )

    return  Read-Host $Title `r`n $ConfirmMessage `r`n $Tip
}

# Hostに数値入力メッセージを表示する
#
# @param    Title               タイトル
# @param    ConfirmMessage      確認メッセージ
# @param    Tip                 追記事項
# @param    errorMessage        エラー時メッセージ
#
# @return   結果（Y=true | N=false）
function global:confirmNumHost {
    Param(
        [string] $Title = "*** 実行確認 ***",
        [string] $ConfirmMessage = "数値を入力してください",
        [string] $Tip = "数値",
        [string] $ErrorMessage = $Tip +"ではありません"
    )

    $splatting = @{
        Title           = $Title
        ConfirmMessage  = $ConfirmMessage
        Tip             = $Tip
    }

    try {
        [Int]$responce = confirmHost @splatting
    } catch {
        writeMessage $ErrorMessage -Break
    }

    return $responce
}

# Hostに確認メッセージを表示する(Yes or No)
#
# @param    Title               タイトル
# @param    ConfirmMessage      確認メッセージ
# @param    Tip                 追記事項
# @param    errorMessage        エラー時メッセージ
#
# @return   結果（Y=true | N=false）
function global:confirmYesNoHost {
    Param(
        [string] $Title = "*** 実行確認 ***",
        [string] $ConfirmMessage = "実行してよろしいですか？",
        [string] $Tip = " はい=Y いいえ=N",
        [string] $ErrorMessage = $Tip +" から選ばれませんでした。"
    )

    $splatting = @{
        Title           = $Title
        ConfirmMessage  = $ConfirmMessage
        Tip             = $Tip
    }

    try {
        [ValidateSet("y","Y","n","N")]$responce = confirmHost @splatting
    } catch {
        writeMessage $ErrorMessage -Break
    }

    return convertYesNo($responce)
}

# YesNo値に変換
#
# @param    YesNo   Y or N
#
# @return   結果（Y=true | N=false）
function global:convertYesNo ($YesNo) {
    switch ($YesNo.ToUpper()) {
        $CAP_YES {
            return $true
        }
        $CAP_NO {
            return $false
        }
        default {
            writeMessage "Y または N ではありません" -Break
        }
    }
}

#ファイルコンテンツ取得
#
# @param    FILE
# @param    文字コード
# @param    一意抽出フラグ
#
# @return   ファイルコンテンツ
function global:getContent {
    Param (
        [String] $File,
        [ValidateSet("Default", "UTF8")][String] $Encode = "Default",
        [switch] $Unique = $false
    )

    # $File が設定されていない
    if ([string]::IsNullOrEmpty($File)) {
        $File = openExplore
    }

    $result = $SYMBOL_EMPTY
    if (Test-Path $File) {
        $result = Get-Content -Path $File -Encoding $Encode
    } else {
        writeMessage "指定ファイルは存在しません" -Break
    }

    if ($Unique) {
        #整列,重複削除
        $result = $result | Sort-Object | Get-Unique
    }

    return $result
}

# 指定したファイルの拡張子を取得
#
# @param    File    ファイル
#
# @return   拡張子
function global:getExtention {
    Param (
        [string] $File
    )
    # $File が設定されていない場合
    if ([string]::IsNullOrEmpty($File)) {
        $File = openExplore
    }
    return [System.IO.Path]::GetExtension($File)
}

# Pathの取得
#  すべてが 空 の場合 空 を返却
#
# @param    DirCode     登録Directory
# @param    Absolute    絶対パス
# @param    Relative    相対パス
#
# @return   Path
function global:getPath {
    Param(
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DirCode = $STR_CURR,
        [String] $Absolute,
        [String] $Relative
    )
    $dir = getDirCode -DirCode $DirCode
    if ([string]::IsNullOrEmpty($dir) -and [string]::IsNullOrEmpty($Absolute) -and [string]::IsNullOrEmpty($Relative)) {
        return $SYMBOL_EMPTY
    } elseif ([string]::IsNullOrEmpty($Absolute)) {
		$path = Join-Path $dir $Relative
	} else {
		$path = Join-Path $Absolute $Relative
    }
    if (!(Test-Path $path)) {
        writeMessage "Path が不正です" -Break
    }

    return $path
}

# エクスプローラーを開きファイルを選択させる
#
# @param    DirCode             登録Directory
# @param    Multi               複数選択フラグ
#
# @return   選択FILE
function global:openExplore {
    Param(
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DirCode = "PowerShell",
        [switch] $Multi = $false
    )
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = $SYMBOL_EMPTY
    $dialog.InitialDirectory = (getDirCode -DirCode $DirCode)
    $dialog.Title = "ファイルを選択してください"
    # 複数選択を許可したい時は Multiselect を設定する
    $dialog.Multiselect = $Multi

    # ダイアログを表示
    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK){
        # 複数選択を許可している時は $dialog.FileNames を利用する
        return $dialog.FileNames
    }
}

# ファイル出力
#
# @param    Title       出力ファイルタイトル
# @param    Body        出力ファイル内容
# @param    Header      出力ファイル見出し
# @param    Path        出力先
# @param    ExtCode     出力ファイル拡張子
function global:outputText {
    Param (
        [parameter(mandatory = $true)][String] $Title,
        [parameter(mandatory = $true)][String[]] $Body,
        [String] $Header,
        [String] $Path,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $ExtCode = $STR_TXT
    )

    # Title設定
    $Title = (Get-PSCallStack)[1].Command + $SYMBOL_UNDERSCORE + $Title + (getExtCode -ExtCode $ExtCode)
	# Path設定
    if ([string]::IsNullOrEmpty($Path)) {
        $outputPath = Join-Path (Split-Path (Get-PSCallStack)[1].ScriptName -Parent) $STR_OUTP
        if (!(Test-Path $outputPath)) {
            New-Item -ItemType Directory -Path $outputPath
        }
    }

    $contents = @()
    if (![string]::IsNullOrEmpty($Header)) {
        $contents += @(
            "=====================================HEAD=========================================="
            , $Header
            , "=====================================BODY=========================================="
        )
    }
    $contents += $Body

    $output = Join-Path $outputPath $Title
    $contents > $output
    writeMessage ($output + " を出力しました。")
}

# 汎用メッセージ出力
#
# @param    Message             メッセージ
# @param    Break               エラーフラグ
# @param    Warn                警告フラグ
function global:writeMessage {
    Param(
        [parameter(mandatory = $true)] $Message,
        [switch] $Break = $false,
        [switch] $Warn = $false
    )

    if ($Break) {
        Write-Output (Get-PSCallStack)[1].Location $SYMBOL_SEMICOLON $Message -BackgroundColor Red -ForegroundColor white
        break
    } elseif ($Warn) {
        Write-Output (Get-PSCallStack)[1].Location $SYMBOL_SEMICOLON $Message -BackgroundColor Yellow -ForegroundColor Black
    } else {
        Write-Output (Get-PSCallStack)[1].Location $SYMBOL_SEMICOLON $Message
    }
}


# ファイル移動
#
# @param    Path            移動対象ファイルまたはディレクトリ
# @param    Destination     目的パス
# @param    Force           強制フラグ
#
function global:moveItem {
    Param (
        [string] $Path,
        [string] $Destination,
        [switch] $Force = $false
    )

    $splatting = @{
        Path            = $Path
        Destination     = $Destination
        Force           = $Force
    }

    if (Test-Path $Destination) {
        if (Test-Path -PathType Container $Path) {
            # 再帰的に moveItem 呼び出し
            Get-ChildItem $Path -File | ForEach-Object {
                $splatting.Path = $_.FullName
                moveItem @splatting
            }
        } elseif (Test-Path $Path) {
            Move-Item @splatting
        } else {
            $warnMessage = $Path + "は存在しません"
            writeMessage $warnMessage -Warn
        }
    } else {
        $confirmMessage = "目的パスが存在しません " + $Destination + " を作成して " + $Path + " を移動しますか"
        $response = (confirmYesNoHost -ConfirmMessage $confirmMessage)
        if ($response) {
            # 再帰的に moveItem 呼び出し
            New-Item $Destination -ItemType Directory
            moveItem @splatting
        } else {
            $errorMessage = "終了しました"
            writeMessage $errorMessage -Break
        }
    }
}

# クリップボードの画像のpngファイル作成
#
# @param    Path            移動対象ファイルまたはディレクトリ
# @param    Destination     目的パス
# @param    Force           強制フラグ
#
function global:saveImage {
    Add-Type -AssemblyName System.Windows.Forms

    If ([Windows.Forms.Clipboard]::ContainsImage() -eq $True) {
        $Image = [Windows.Forms.Clipboard]::GetImage()
        $FilePath = getDirCode -DirCode ImageInternal
        $FileName = (Get-Date -Format "yyyyMMddHHmmss") + ".png"
        $ImagePath = Join-Path $FilePath $FileName
        $Image.Save($ImagePath, [System.Drawing.Imaging.ImageFormat]::Png)
    }
}

# 10進→N進変換
#
# @param    Number             数値（１０進数表記）
# @param    Base               基数
#
# @return   数値（N進数表記）
function global:toBaseN {
    Param (
        [parameter(mandatory = $true)][Int]$Number,
        [ValidateSet(2, 8, 10, 16)][Int]$Base = 16
    )
    return [Convert]::ToString($number, $base)
}

# N進→10進変換
#
# @param    Number             数値（N進数表記）
# @param    Base               基数
#
# @return   数値（１０進数表記）
function global:toBase10 {
    Param (
        [parameter(mandatory = $true)]$Number,
        [ValidateSet(2, 8, 10, 16)][Int]$Base = 16
    )
    return [Convert]::ToInt32($number, $base)
}

# パディングを行う
#
# @param    Char               パディング文字
# @param    ByteSize           桁数
#
# @return   文字列
function global:pad {
    Param (
        [parameter(mandatory = $true)]$String,
        [ValidateLength(0, 1)][String]$Char = "0",
        [int]$ByteSize = 10
    )
    $padding = $Char * $ByteSize + $String
    return $padding.Substring($padding.Length - $ByteSize, $ByteSize)
}

# ランダム文字列生成
#
# @param    Type               アルファベット、数字(記号除く)、混合を選択
# @param    Base               基数
# @param    ByteSize           文字数
#
# @return   ランダム文字列
function global:createRandomStr {
    Param (
        [ValidateSet("ALL", "INT", "CHAR")][String]$Type = $STR_INT,
        [ValidateSet(2, 8, 10, 16)][Int]$Base = 10,
        [int]$ByteSize = 10
    )
    # アセンブリロード
    Add-type -AssemblyName System.Web

    # 文字タイプを設定
    $baseMode = 0
    switch ($Type) {
        $STR_ALL {
            $reg1 = "[^a-z0-9]"
            $reg2 = ""
        }
        $STR_INT {
            $baseMode = $Base
            $reg1 = "[^0-9]"
            $reg2 = "^0+"
        }
        $STR_CHR {
            $reg1 = "[^a-z]"
            $reg2 = ""
        } default {
            writeMessage "Not matched. CreateRandomStr" -Break
        }
    }
    $ret = ""

    # 必要文字数になるまでランダム文字生成
    do {
        # 32文字のランダムな文字列を生成
        $randomString = [System.Web.Security.Membership]::GeneratePassword(32, 0)
        # 不要文字を置換
        $add = $randomString | ForEach-Object {$_ -replace $reg1, ""} | ForEach-Object {$_ -replace $reg2, ""}
        # 進数変換
        if ($baseMode -gt 0) {
            $add = toBaseN -Number $add -Base $Base
        }
        $ret = $ret + [string]$add
    } while ($ret.Length -le $byteSize)

    # 指定文字数にする
    return $ret.Substring(0, $byteSize)
}

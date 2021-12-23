
# 対象Directory内ファイルを抽出して、目的Directoryに移動
#
# @param    DirCode                         対象Directory
# @param    Absolute                        対象絶対パス
# @param    Relative                        対象相対パス
# @param    DestinationDirCode              目的Directory
# @param    DestinationAbsolute             目的絶対パス
# @param    DestinationRelative             目的相対パス

function global:loadFile {
    Param(
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DirCode = "Temporary",
        [String] $Absolute,
        [String] $Relative,
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DestinationDirCode = "Test",
        [String] $DestinationAbsolute,
        [String] $DestinationRelative,
        [switch] $Log = $false

    )

    # Path設定
    $splatting = @{
        DirCode     = $DirCode
        Absolute    = $Absolute
        Relative    = $Relative
    }
    $path = getPath @splatting

    # 目的Path設定
    $destinationSplatting = @{
        DirCode     = $DestinationDirCode
        Absolute    = $DestinationAbsolute
        Relative    = $DestinationRelative
    }
    $destinationPath = getPath @destinationSplatting

    Set-Location $path
    $file = Get-ChildItem -File | extractExt -Ext1 TXT -Ext2 JPG -Ext3 JPEG -Ext4 GIF -Ext5 PNG -Ext6 XLSX -Ext7 XLS -Ext8 MP4
    for ($i=0; $i -lt $file.count; $i++) {
        moveItem $file[$i].Name $destinationPath -Force
    }
    if ($Log) {
        writeMessageHost ($path + " => " + $destinationPath) -Warn
        $file | Select-Object fullname, Length, LastWriteTime
    }
}
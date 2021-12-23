
# �Ώ�Directory���t�@�C���𒊏o���āA�ړIDirectory�Ɉړ�
#
# @param    DirCode                         �Ώ�Directory
# @param    Absolute                        �Ώې�΃p�X
# @param    Relative                        �Ώۑ��΃p�X
# @param    DestinationDirCode              �ړIDirectory
# @param    DestinationAbsolute             �ړI��΃p�X
# @param    DestinationRelative             �ړI���΃p�X

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

    # Path�ݒ�
    $splatting = @{
        DirCode     = $DirCode
        Absolute    = $Absolute
        Relative    = $Relative
    }
    $path = getPath @splatting

    # �ړIPath�ݒ�
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
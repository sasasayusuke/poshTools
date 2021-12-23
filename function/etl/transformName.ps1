
# �t�H���_���t�@�C�����̔�
#
# @param    PaddingByteSize                     �̔Ԍ���
# @param    TransformDirCode                    �t�@�C�����ϊ��Ώ�Directory
# @param    TransformAbsolute                   �t�@�C�����ϊ��Ώې�΃p�X
# @param    TransformRelative                   �t�@�C�����ϊ��Ώۑ��΃p�X
# @param    Log                                 ���O�o��

function global:transformName {
    Param(
        [ValidateRange(3, 10)][int] $PaddingByteSize = 10,
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $TransformDirCode = "Test",
        [String] $TransformAbsolute,
        [String] $TransformRelative,
        [switch] $Log = $false
    )

    # Path�ݒ�
    $splatting = @{
        DirCode     = $TransformDirCode
        Absolute    = $TransformAbsolute
        Relative    = $TransformRelative
    }
    $path = getPath @splatting

    Set-Location $path
    $arrowExt = @("TXT", "JPG", "JPEG", "GIF", "PNG", "XLSX", "XLS", "MP4")
    $arrowExt | ForEach-Object {
        $file = Get-ChildItem -File | extractExt -Ext1 $_ | Sort-Object -Descending Length
        for ($i=0; $i -lt $file.count; $i++){
            $newName = $_ + (pad ($i + 1) -ByteSize $PaddingByteSize) + (getExtCode -ExtCode $_)
            Rename-Item $file[$i].Name $newName
        }
        if ($Log) {
            Write-Output $_
            $file | Select-Object Length, fullname, LastWriteTime
            Write-Output ========================================
        }
    }
}
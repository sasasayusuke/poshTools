
# �t�H���_���g���q�ϊ�
#
# @param    TransformedExtCode                  �ϊ��Ώۊg���q
# @param    TransformExtCode                    �ϊ���g���q
# @param    TransformDirCode                    �g���q�ϊ��Ώ�Directory
# @param    TransformAbsolute                   �g���q�ϊ��Ώې�΃p�X
# @param    TransformRelative                   �g���q�ϊ��Ώۑ��΃p�X
# @param    Log                                 ���O�o��

function global:transformExtention {
    Param(
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $TransformedExtCode = "JPEG",
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $TransformExtCode = "JPG",
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
    $file = Get-ChildItem -File | extractExt -Ext1 $TransformedExtCode
    for ($i=0; $i -lt $file.count; $i++){
        $newName = $file[$i].Basename + (getExtCode -ExtCode $TransformExtCode)
        Rename-Item $file[$i].Name $newName
    }
    if ($Log) {
        Write-Output $_
        $file | Select-Object Length, fullname, LastWriteTime
        Write-Output ========================================
    }
}
# �I���g���q���o����
#
# @param    ExtCode    �g���q(�X�܂őI���\)
# @param    Exclude    �r���t���O
#
# @return   �t�@�C��
filter global:extractExt {
	Param (
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext1,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext2,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext3,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext4,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext5,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext6,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext7,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext8,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $Ext9,
        [switch] $Exclude = $false
	)
    $extArr = @()
    if (![string]::IsNullOrEmpty($Ext1)) {
        $extArr += (getExtCode -ExtCode $Ext1)
    }
    if (![string]::IsNullOrEmpty($Ext2)) {
        $extArr += (getExtCode -ExtCode $Ext2)
    }
    if (![string]::IsNullOrEmpty($Ext3)) {
        $extArr += (getExtCode -ExtCode $Ext3)
    }
    if (![string]::IsNullOrEmpty($Ext4)) {
        $extArr += (getExtCode -ExtCode $Ext4)
    }
    if (![string]::IsNullOrEmpty($Ext5)) {
        $extArr += (getExtCode -ExtCode $Ext5)
    }
    if (![string]::IsNullOrEmpty($Ext6)) {
        $extArr += (getExtCode -ExtCode $Ext6)
    }
    if (![string]::IsNullOrEmpty($Ext7)) {
        $extArr += (getExtCode -ExtCode $Ext7)
    }
    if (![string]::IsNullOrEmpty($Ext8)) {
        $extArr += (getExtCode -ExtCode $Ext8)
    }
    if (![string]::IsNullOrEmpty($Ext9)) {
        $extArr += (getExtCode -ExtCode $Ext9)
    }

    $ext = (getExtention -File $_)
    if ($extArr.Contains($ext) -xor $Exclude) {
        return $_
    }
}

# �L���p�X���o����
#
# @param   Path   �p�X
#
# @return�@�L���p�X
filter global:extractValidPath {
    if (![string]::IsNullOrEmpty($_)) {
        if (Test-Path $_) {
            return $_
        }
    }
}

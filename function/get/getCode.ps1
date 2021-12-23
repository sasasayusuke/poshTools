
#�e��R�[�h�擾
#
# @param    �񋓃f�B���N�g��
# @param    �񋓊g���q
# @param    ��URL
# @param    �񋓎g�p�[��
# @param    �`�F���W�f�B���N�g���@�t���O
# @param    �N���b�v�{�[�h�R�s�[�@�t���O
# @param    �I�[�v���A�v���@�t���O
# @param    �Z�b�e�B���O�@�t���O
#
# @return   �e��R�[�h
function global:getCode {
    Param (
        [switch] $Change = $false,
        [switch] $Copy = $false,
        [switch] $Execute = $false,
        [switch] $Open = $false,
        [switch] $Set = $false,
        [ArgumentCompleter({getAllBatCode})][ValidateScript({$_ -in $(getAllBatCode)})][String] $BatCode = $SYMBOL_EMPTY,
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DirCode = $SYMBOL_EMPTY,
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $ExtCode = $SYMBOL_EMPTY,
        [ArgumentCompleter({getAllUrlCode})][ValidateScript({$_ -in $(getAllUrlCode)})][String] $UrlCode = $SYMBOL_EMPTY,
        [ArgumentCompleter({getAllUserCode})][ValidateScript({$_ -in $(getAllUserCode)})][String] $UserCode = $SYMBOL_EMPTY
    )
    $optionSplatting = @{
        Change  = $Change
        Copy    = $Copy
        Execute = $Execute
        Open    = $Open
        Set     = $Set
    }

    if (![string]::IsNullOrEmpty($BatCode)) {
        getBatCode -BatCode $BatCode @optionSplatting
    }
    if (![string]::IsNullOrEmpty($DirCode)) {
        getDirCode -DirCode $DirCode @optionSplatting
    }
    if (![string]::IsNullOrEmpty($ExtCode)) {
        getExtCode -ExtCode $ExtCode @optionSplatting
    }
    if (![string]::IsNullOrEmpty($UrlCode)) {
        getUrlCode -UrlCode $UrlCode @optionSplatting
    }
    if (![string]::IsNullOrEmpty($UserCode)) {
        getUserCode -UserCode $UserCode @optionSplatting
    }
}


Set-Alias gt getCode

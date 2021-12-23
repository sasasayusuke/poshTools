
#各種コード取得
#
# @param    列挙ディレクトリ
# @param    列挙拡張子
# @param    列挙URL
# @param    列挙使用端末
# @param    チェンジディレクトリ　フラグ
# @param    クリップボードコピー　フラグ
# @param    オープンアプリ　フラグ
# @param    セッティング　フラグ
#
# @return   各種コード
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

enum UserCode {
    Dynabook
    Vaio
}

function global:getAllUserCode {
    return [enum]::GetNames([UserCode])
}

function global:getUserCode {
    Param (
        [ArgumentCompleter({getAllUserCode})][ValidateScript({$_ -in $(getAllUserCode)})] $UserCode = "Vaio",
        [switch] $Copy = $false,
        [switch] $Set = $false
    )
    if ($Copy) {
        Set-Clipboard $UserCode
    }
    if ($Set) {
        Set-Variable -Scope global -Name MAIN_USER       -Value $UserCode
    }
    return $UserCode
}


enum ExtCode {
    CSS
    DOCX
    EXE
    GIF
    HTML
    JAVA
    JPG
    JPEG
    JS
    JSON
    JSX
    MP3
    MP4
    PDF
    PHP
    PNG
    PPTX
    PS1
    PY
    SCSS
    SQL
    TS
    TSX
    TXT
    VUE
    XD
    XLS
    XLSM
    XLSX
    XML
}

function global:getAllExtCode {
    return [enum]::GetNames([ExtCode])
}

function global:getExtCode {
    Param (
        [ArgumentCompleter({getAllExtCode})][ValidateScript({$_ -in $(getAllExtCode)})][String] $ExtCode = $STR_TXT,
        [switch] $Copy = $false
    )
    if ($Copy) {
        Set-Clipboard $ExtCode
    }

    return $SYMBOL_DOT + $ExtCode.ToLower()
}

Set-Alias gte getExtCode

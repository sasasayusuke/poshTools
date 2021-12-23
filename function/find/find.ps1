
# �ėp�t�@�C������
#
# @param    Title                           �����^�C�g��
# @param    DirCode                         �����Ώ� Directory
# @param    Absolute                        �����Ώ� ���Path
# @param    Relative                        �����Ώ� ����Path
# @param    Include                         File���Ɋ܂ޕ�����
# @param    Exclude                         File���Ɋ܂܂Ȃ�������
# @param    Type                            File or Directory
# @param    BeforeLike                      �O��Like�����t���O
# @param    AfterLike                       ���Like�����t���O
# @param    Recurse                         �ċA�����t���O
# @param    OutPut                          �e�L�X�g�o�̓t���O
# @param    OutputTitle                     �o�̓e�L�X�g�^�C�g��
# @param    OutputHeader                    �o�̓e�L�X�g�w�b�_�[
# @param    OutputDirCode                   �o�̓e�L�X�gDirectory
# @param    OutputAbsolute                  �o�̓e�L�X�g��΃p�X
# @param    OutputRelative                  �o�̓e�L�X�g���΃p�X
#
# @return   ��������
function global:find {
    Param (
        [String] $Title,
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DirCode = $STR_CURR,
        [String] $Absolute,
        [String] $Relative,
        [String] $Include,
        [String] $Exclude,
        [ValidateSet("File", "Directory")][String] $Type = $STR_FILE,
        [switch] $BeforeLike = $false,
        [switch] $AfterLike = $false,
        [switch] $Recurse = $false,
        [switch] $OutPut = $false,
        [String] $OutputTitle,
        [String] $OutputHeader,
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $OutputDirCode = $STR_EMP,
        [String] $OutputAbsolute,
        [String] $OutputRelative
    )

	# Path�ݒ�
    $splatting = @{
        DirCode     = $DirCode
        Absolute    = $Absolute
        Relative    = $Relative
    }
    $path = getPath @splatting

    $search = ""
    if (![string]::IsNullOrEmpty($Title)) {
        $search = $Title
        if ($BeforeLike) {
            $search = $SYMBOL_ASTALISK + $search
        }
        if ($AfterLike) {
            $search = $search + $SYMBOL_ASTALISK
        }
    }
    if (![string]::IsNullOrEmpty($Include)) {
        $Include = $SYMBOL_ASTALISK + $Include + $SYMBOL_ASTALISK
    }
    if (![string]::IsNullOrEmpty($Exclude)) {
        $Exclude = $SYMBOL_ASTALISK + $Exclude + $SYMBOL_ASTALISK
    }

    $findSplatting = @{
        Filter      = $search
        Path        = $path
        Recurse     = $Recurse
        File        = ($Type -eq $STR_FILE)
        Directory   = ($Type -eq $STR_DIR)
        Include     = $Include
        Exclude     = $Exclude
    }

    $result = (Get-ChildItem @findSplatting).FullName
    if ([string]::IsNullOrEmpty($result)) {
        writeMessageHost "No Result" -Warn
        return
    }

    # �e�L�X�g�o��
    if ($OutPut -and ![string]::IsNullOrEmpty($result)) {
        # Path�ݒ�
        $splatting = @{
            DirCode     = $OutputDirCode
            Absolute    = $OutputAbsolute
            Relative    = $OutputRelative
        }
        $outputPath = getPath @splatting

        # Title�ݒ�
        if ([string]::IsNullOrEmpty($OutputTitle)) {
            $OutputTitle = $Title
        }
        $outputSplatting = @{
            Title       = $OutputTitle
            Body        = $result
            Header      = $OutputHeader
            Path        = $outputPath
            ExtCode     = $STR_TXT
        }
        outputText @outputSplatting
    } else {
        Write-Output $result
    }
}

Set-Alias fd find

# �Ώ�Directory����File�܂���Directory���^�C�g���Ō�������
#
# @param    Title                           �����^�C�g��
# @param    DirCode                         �����Ώ� Directory
# @param    Absolute                        �����Ώ� ���Path
# @param    Relative                        �����Ώ� ����Path
# @param    Include                         File���Ɋ܂ޕ�����
# @param    Exclude                         File���Ɋ܂܂Ȃ�������
# @param    Type                            File or Directory
# @param    Unrecurse                       ��ċA�����t���O
# @param    OutPut                          �e�L�X�g�o�̓t���O
# @param    OutputTitle                     �o�̓e�L�X�g�^�C�g��
# @param    OutputHeader                    �o�̓e�L�X�g�w�b�_�[
# @param    OutputDirCode                   �o�̓e�L�X�gDirectory
# @param    OutputAbsolute                  �o�̓e�L�X�g��΃p�X
# @param    OutputRelative                  �o�̓e�L�X�g���΃p�X
#
# @return   ��������
function global:findFile {
    Param (
        [String] $Title,
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $DirCode = $STR_CURR,
        [String] $Absolute,
        [String] $Relative,
        [String] $Include,
        [String] $Exclude,
        [ValidateSet("File", "Directory")][String] $Type = $STR_FILE,
        [switch] $Unrecurse = $false,
        [switch] $OutPut = $false,
        [String] $OutputTitle,
        [String] $OutputHeader,
        [ArgumentCompleter({getAllDirCode})][ValidateScript({$_ -in $(getAllDirCode)})][String] $OutputDirCode = $STR_EMP,
        [String] $OutputAbsolute,
        [String] $OutputRelative
    )
    $splatting = @{
        Title                       = $Title
        DirCode                     = $DirCode
        Absolute                    = $Absolute
        Relative                    = $Relative
        Include                     = $Include
        Exclude                     = $Exclude
        Type                        = $Type
        BeforeLike                  = $true
        AfterLike                   = $true
        Recurse                     = !$Unrecurse
    }

    $result = find @splatting

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
            if ([string]::IsNullOrEmpty($Title)) {
                $OutputTitle = createRandomStr -Type $STR_CHR -ByteSize 10
            } else {
                $OutputTitle = $Title
            }
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

Set-Alias fdf findFile


function global:getCalculatePattern2x2 {
    Param (
        [int] $a = 0,
        [int] $b = 0
    )

	if (($a -lt 10) -or ($a -ge 100)) {
		writeMessage -Break "‘æˆêˆø”‚ª2Œ…‚Å‚Í‚ ‚è‚Ü‚¹‚ñ"
	}
	if (($b -lt 10) -or ($b -ge 100)) {
		writeMessage -Break "‘æ“ñˆø”‚ª2Œ…‚Å‚Í‚ ‚è‚Ü‚¹‚ñ"
	}

	$a1st = $a % 10
	$a10th = [Math]::Floor($a / 10)
	$b1st = $b % 10
	$b10th = [Math]::Floor($b / 10)

	if (($a1st -eq 0) -or ($b1st -eq 0)) {
		return "level1:	argument10"
	} elseif ($a * $b % 10 -eq 0) {
		return "level2:	multiple2and5"
	} elseif (($a -eq 11) -or ($b -eq 11)) {
		return "level3:	argument11"
	} elseif ($a * $b % 11 -eq 0) {
		return "level4:	multiple2and5"
	} elseif ($a -eq $b) {
		return "level5:	square"
	} elseif (($a10th -eq $b10th) -and (($a1st + $b1st) -eq 10)) {
		return "level6:	same10th"
	} elseif (($a1st -eq $b1st) -and (($a10th + $b10th) -eq 10)) {
		return "level7:	same1st"
	}
	return "level8: else"
}

function global:testCalculate2x2 {
    Param (
        [int] $a = (createRandomStr -Type INT -ByteSize 2),
        [int] $b = (createRandomStr -Type INT -ByteSize 2),
		[switch] $useTitle = $false

    )
	$title = ""
	if ($useTitle) {
		$title = getCalculatePattern2x2 $a $b
	}
	$splatting = @{
        Title           = $title
        ConfirmMessage  = [String]$a + " x " + [String]$b
        Tip             =  "= "
    }
	$ans = $a * $b
	$res = confirmNumHost @splatting
	if ($res -eq $ans) {
		return "OK"
	} else {
		return "NG : " + [String]$ans
	}
}

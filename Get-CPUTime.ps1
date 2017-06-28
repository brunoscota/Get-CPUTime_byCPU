param(
    [int]$warn,
    [int]$crit
)

$countline = ""
$perfline = ""
$outline = ""
#$warn = 4
#$crit = 50
$warnsignal = 0
$critsignal = 0
$counter = (Get-Counter "\Processor(*)\% Processor time").CounterSamples | Select-Object InstanceName,CookedValue


foreach ($i in $counter){
    $floated = ([math]::round($i.CookedValue,2))

    if(($floated -ge $warn) -and ($floated -lt $crit)){
        $warnsignal++
        #$i.InstanceName+" "+$floated+"WARNING"
    }
        elseif(($floated -gt $warn) -and ($floated -gt $crit)){
            $critsignal++
            #$i.InstanceName+" "+$floated+"CRITICAL"
        }

    $countline += ("CPU "+[string]$i.InstanceName+": "+$floated+"% ")
    $perfline += ("CPU"+[string]$i.InstanceName+"="+$floated+"%;"+$warn+"%;"+$crit+"%; ")
}

$outline = $countline+"| "+$perfline

if ($critsignal -gt 0){
    Write-Host "$critsignal CPU(s) in CRITICAL state - $outline"
	exit(2)
}
    elseif ($warnsignal -gt 0){
        Write-Host "$warnsignal CPU(s) in WARNING state - $outline"
		exit(1)
        }
        else{
            Write-Host "CPU(s) OK - $outline"
			exit(0)
            }

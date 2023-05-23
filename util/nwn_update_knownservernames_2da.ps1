
Write-Host

$path_server = "\\wsl$\Ubuntu\home\athaea-x370\.local\share\Neverwinter Nights"
if (Test-Path $path_server) {} else {Write-Host "Test-Path failed for ... $path_server"; Continue}

$2da = $null
$2da = Get-Content "$path_server\override\knownservernames.2da"
if ($2da -eq $null) {Write-Host "Something broke for ... Get-Content `"$path_server\override\knownservernames.2da`""; Continue}

$log = $null
$log = Get-Content "$path_server\logs.0\nwserverLog1.txt"
if ($log -eq $null) {Write-Host "Something broke for ... Get-Content `"$path_server\logs.0\nwserverLog1.txt`""; Continue}

$player_name = $null
## $player_name = "i am ivar son of ivar"
$player_name = Read-Host "What's the player name? Please paste here"

## Parse $log for most-recent connection attempt by $player_name, error out if no results
$player_name_and_key = $null
$player_name_and_key = ($log | Select-String -Pattern "Connection attempt made by $player_name")[-1] ## [-1] to take only the bottom-most result found by Select-String
if ($player_name_and_key -eq $null) {Write-Host "No log entries found for: `"Connection attempt made by $player_name`""; Continue}

## Parse the result to leave only the key, validate that we end with an 8-character string
$player_key = ($player_name_and_key -split $player_name)[1] -replace " ","" -replace "\(","" -replace "\)",""
if ($player_key.Length -ne 8) {Write-Host "Something broke when parsing `$player_key from log file ... length after parsing is not 8 ... $player_key ... Halting"; Continue}

## Error out if $player_name isn't found in the 2da ... this would indicate something different being the issue
if (($2da | Select-String -Pattern $player_name).Count -eq 0) {Write-Host "No existing 2da entries found for `$player_name ... $player_name"; Continue}

## Error out if $player_key is already found in the 2da ... this would indicate something different being the issue
if (($2da | Select-String -Pattern $player_name | Select-String -Pattern $player_key).Count -gt 0) {Write-Host "Existing 2da entry already found for `$player_name ... `"$player_name`" ... and the `$player_key from their most-recent connection attempt in `$log ... $player_key"; Continue}

$2da_count = $2da.Count ## There are 3 "header" rows in .2da ... but the entries start counting at 00000
$2da_entry_count = ($2da[-1] -replace " ","" -split "`"")[0]

## The number of spaces in the formatting appears to be static ... so I've typed out the same number of spaces. {0:D5} is integer conversion for adding leading 0s up to 5 digits
$2da_entry_new = "$("{0:D5}" -f $($2da_count - 3))   `"$player_key`"  016          `"$player_name`""
$2da += $2da_entry_new

Write-Host "Appended the following new `$2da entry:"
Write-Host
$2da_entry_new

$2da | Out-File -FilePath "$path_server\override\knownservernames.2da"

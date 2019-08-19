# =============================================================================
# File Name: File Hash Tool.ps1
# =============================================================================
# Name: File Hash Tool
# Author: Zak Clifford 
# Contact:  z.clifford[at]computeam.co.uk
# Version 1.0
# Created: 9 Jul 2019
# Updated: N/A
# Description: Creates a file hash and compares it to an expected Hash
# =============================================================================
# Function Change Log
# v1.0 - Creation of script
# =============================================================================
$ver = "1.0"

# =============================================================================
# START OF CODE
# =============================================================================

Write-Host "=============================================================================="
Write-Host "Name: File Hash Tool"
Write-Host "Version:     " $ver
Write-Host "`n"
Write-Host "Before proceeding, ensure that you have the Hash value easily accessible!" -ForegroundColor Cyan
Write-Host "=============================================================================="
Read-Host "Press [ENTER] to continue..."
Write-Host "`n"

# =============================================================================
# Starting the script, enter the expected hash to compare against the file
# =============================================================================

do {
	$HASH = Read-Host "Enter the expected HASH"
	Write-Host "`n"
	Write-Host "You've entered $HASH"
	Write-Host "`n"
	Write-Host "Is this correct? " -NoNewLine -foregroundcolor White; write-host "[ENTER]" -NoNewline -foregroundcolor Red; write-host "/Yes, " -NoNewline; write-host "[N]" -NoNewline -foregroundcolor Red; write-host "/No: " -NoNewline -foregroundcolor White
	$choice = read-host
	} while ($choice -eq "N" -or $choice -eq "n")

# =============================================================================
# Enter the absolute path to the file
# =============================================================================

do {
	$File = Read-Host "Enter the absolute path to the file e.g c:\users\username\downloads\testfile.txt"
	Write-Host "`n"
	Write-Host "You've entered $FILE, as the location"
	Write-Host "`n"
	Write-Host "Is this correct? " -NoNewLine -foregroundcolor White; write-host "[ENTER]" -NoNewline -foregroundcolor Red; write-host "/Yes, " -NoNewline; write-host "[N]" -NoNewline -foregroundcolor Red; write-host "/No: " -NoNewline -foregroundcolor White
	$choice = read-host
	} while ($choice -eq "N" -or $choice -eq "n")

# ===============================================================================
# Choose the Algorithm, e.g 'SHA1,SHA256,SHA384,SHA512,MACTripleDES,MD5,RIPEMD160
# ===============================================================================

do {
	$Algorithm = Read-Host "Enter the Algorithm you'd like to use e.g 'SHA1,SHA256,SHA384,SHA512,MACTripleDES,MD5,RIPEMD160'"
	Write-Host "`n"
	Write-Host "You've entered $Algorithm, as the algorithm"
	Write-Host "`n"
	Write-Host "Is this correct? " -NoNewLine -foregroundcolor White; write-host "[ENTER]" -NoNewline -foregroundcolor Red; write-host "/Yes, " -NoNewline; write-host "[N]" -NoNewline -foregroundcolor Red; write-host "/No: " -NoNewline -foregroundcolor White
	$choice = read-host
	} while ($choice -eq "N" -or $choice -eq "n")

# ===============================================================================
# Confirm options
# ===============================================================================

Write-Host "========================================================================================"
Write-Host "`n"
Write-Host "These are the settings you have chosen:-"
Write-Host "`n"
Write-Host "This is the HASH:- ...  $HASH"
Write-Host "`n"
Write-Host "This is the File Location:- ...  $File"
Write-Host "`n"
Write-Host "This is the Algorithm:- ...  $Algorithm"
Write-Host "`n"
Write-Host "========================================================================================"
Write-Host "`n"
Read-Host "Press [ENTER] to continue... or press [Ctrl+C] to cancel the script"
Write-Host "`n"
Write-Host "========================================================================================"
    
# ===============================================================================
# Starting to Calculate the HASH
# ===============================================================================

Write-Host "========================================================================================"
Write-Host "`n"
Write-Host "Starting to Calculate the Hash of the file"
Write-Host "`n"
Write-Host "========================================================================================"

$FILEHASH = Get-FileHash $File -Algorithm $Algorithm

# ===============================================================================
# Progress bar for the end user
# ===============================================================================

$totalTimes = 10

  $i = 100

  for ($i=0;$i -lt $totalTimes; $i++) {

  $percentComplete = ($i / $totalTimes) * 100

  Write-Progress -Activity 'Calculating the HASH' -Status "$i 0% complete!" -PercentComplete $percentComplete

  sleep 1

}

# ===============================================================================
# Outputting the HASH's
# ===============================================================================

Write-Host '### Verification Hash ###  -- ' -NoNewline
$HASH | Format-List
Write-Host '### Hash from File ###     -- ' -NoNewline
$FILEHASH.Hash | Format-List

If ($Filehash.Hash -eq $HASH) {Write-Host -foregroundcolor Green "** File Hash Verified! **"}
Else {Write-Host -ForegroundColor Red "** File Hash failed!! **"}

Write-Host "========================================================================================"
Write-Host "`n"
Read-Host "Press [ENTER] to continue... This will exit the script."
Write-Host "`n"
Write-Host "========================================================================================"

# ===============================================================================
# End of the script
# ===============================================================================

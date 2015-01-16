#!/bin/bash

# LabView Executable
LabViewBin="/c/Program Files (x86)/National Instruments/LabVIEW 2014/LabVIEW.exe"

# LabView Shared Path for Compare and Merge
LabViewShared="/c/Program Files (x86)/National Instruments/Shared"

## DO NOT EDIT FROM HERE ON UNLESS YOU REALLY REALLY KNOW WHAT YOU ARE DOING

# sed RegEx to replace / by \ in Path
PATHFIX='s/\//\\/g'
# sed RegEx to replace trailing ./ with \
TRAILFIX='s/^.\//\\/'
# Remove ending / or \
ENDFIX='s/[\\/]+$//g'
# Make Path suitable for Windows (C: instead of /c)
MKWINPATH='s/^\/\([a-z]\)/\U\1:/'
# Check if Path is abolsute: if either ^/@/ or ^@:\ where @ is the drive letter
ABSPATH='^([a-zA-Z]:\\|/[a-zA-Z]/)'

# Attempt to detect the LabVIEW version
for basePath in '/usr/local/etc' '~/etc' '.'; do
	candidateFile="${basePath}/LVDetect.sh"
	if [ -r "${candidateFile}" ]; then
		source ${candidateFile}
		break
	fi
done

function fix_paths {
	# Repository directory in windows path notation
	WD=$(pwd | sed -e "${ENDFIX}" | sed -e "${MKWINPATH}" | sed -e  "${PATHFIX}")

	# LVCompare.exe needs this path in Windows format
	LabViewBin=$(echo ${LabViewBin} | sed -e "${MKWINPATH}" | sed -e "${PATHFIX}")
}

fix_paths


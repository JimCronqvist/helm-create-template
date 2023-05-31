#!/usr/bin/env bash

set -eo pipefail

CHARTNAME="$1"
FOLDER="${2:-generated}"

if [[ $# -lt 1 ]]; then
    echo "You have not passed any arguments, use this script like this:"
    echo "'bash helm-create.sh <CHARTNAME>'"
    echo "'bash helm-create.sh <CHARTNAME> ../helm-charts'"
    echo ""
    exit 1
fi

if [[ "$CHARTNAME" =~ ^[a-zA-Z0-9._-]+$ ]]; then
    echo "The chart name provided is valid"
else
    echo "The chart name contains illegal characters"
    exit 1
fi

echo "Creating the folder for the new chart"
mkdir -p "./$FOLDER"
mkdir "./$FOLDER/$CHARTNAME"

echo "Copying the new chart"
cp -R ./CHARTNAME/* "./$FOLDER/$CHARTNAME/"

echo "Updating the <CHARTNAME> to the provided name '$CHARTNAME'"
find "./$FOLDER/$CHARTNAME/" -type f -exec sed -i "s/CHARTNAME/$CHARTNAME/g" $i {} +

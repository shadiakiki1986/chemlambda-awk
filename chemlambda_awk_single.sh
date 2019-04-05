#!/bin/sh
# Main launcher script for converting a mol file through a awk file to html
# Usage: /bin/sh chemlambda_awk_single.sh <input awk file> <input mol file> <output html file>

showUsage() {
    echo "Example usage:"
    echo "    /bin/sh chemlambda_awk_single.sh transform/quiner.awk mol/other/letbeta.mol html_out/letbeta.html"
    exit 1
}

if [ -z "$1" ]; then
  echo "Missing argument 1 (input awk file)";
  showUsage
fi

if [ -z "$2" ]; then
echo "Missing argument 2 (input mol file)"
  showUsage
fi

if [ -z "$3" ]; then
echo "Missing argument 3 (output html file)"
  showUsage
fi

if [ ! -f "$1" ]; then
  echo "Input awk file does not exist"
  echo "$1"
  showUsage
fi

if [ ! -f "$2" ]; then
  echo "Input mol file does not exist"
  echo "$2"
  showUsage
fi

if [ -f "$3" ]; then
  echo "Output html file already exists .. aborting"
  echo "$3"
  showUsage
fi

#-----------------------------------

AWKFILE=$1
MOLFILE=$2
#HTMLFILE=${MOLFILE%%.*}
#HTMLFILE=$(basename $HTMLFILE)
HTMLFILE=$3

# make a temporary folder for the workspace of concatenating files
MYTEMP=`mktemp -d`

# run the awk script
# this generates a file "essy.txt" in the current folder
awk -f $AWKFILE $MOLFILE
mv essy.txt $MYTEMP/essy.html.part

# concatenate all html parts into one valid html file
cat \
  html_templates/firstpart.html.part \
  $MYTEMP/essy.html.part \
  html_templates/lastpart.html.part \
  > $MYTEMP/out.html

# done with this temporary file
rm $MYTEMP/essy.html.part

# move to the target
mv $MYTEMP/out.html "$HTMLFILE"

# show results
echo "Completed transformation"
echo "Saved in" "$HTMLFILE" # $MYTEMP/"$HTMLFILE".html
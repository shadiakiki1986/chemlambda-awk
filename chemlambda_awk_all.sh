#!/bin/sh
# Utility script to transfer all the mol files through all the awk files and save them into the html_output folder
# Launch this only from the root of this repository
# Usage: /bin/sh chemlambda_awk_all.sh

#-----------------------------------

if [ ! -f  chemlambda_awk_single.sh ]; then
  echo "Please launch this from the repository root directory"
  exit 1
fi

# Copy directory structure from "mol" directory to "html_catalog"
echo "Creating directory structure"
find mol/ -type d  | sed "s/^mol/html_catalog/g" | xargs mkdir -p

for AWKFILE in transform/*.awk; do
  AWKNAME=${AWKFILE%%.*} # drop extension and directory
  AWKNAME=`basename $AWKNAME`
  for MOLDIR in mol/*; do
    for MOLFILE in $MOLDIR/*; do
      HTMLFILE=${MOLFILE%%.*}-$AWKNAME.html # rename extension
      HTMLFILE=`echo $HTMLFILE|sed "s/mol/html_catalog/g"` # rename first directory
      
      if [ -f $HTMLFILE ]; then
        echo "Skipping existing file" $HTMLFILE
      else
        # display the current command and execute it without the verbosity
        # Limit each run to a timeout, otherwise abort
        # e.g. setting it to 1s would only generate the fastest simulations
        #      setting it to 10s would generate most of the simulations, including most of the slower ones
        echo "Running:" /bin/sh chemlambda_awk_single.sh $AWKFILE $MOLFILE $HTMLFILE
        timeout 1s /bin/sh chemlambda_awk_single.sh $AWKFILE $MOLFILE $HTMLFILE > /dev/null
        
        if [ ! -f $HTMLFILE ]; then
          echo ">>> Error generating file" $HTMLFILE
        else
          # fix reference to js libraries
          sed -i "s/d3.min.js/..\/d3.min.js/g" $HTMLFILE
          sed -i "s/jquery.min.js/..\/jquery.min.js/g" $HTMLFILE
        fi

      fi
      
      # exit 3 # FIXME
      
    done
  done
done
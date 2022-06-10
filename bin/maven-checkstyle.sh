#!/bin/bash

echo "Running checkstyle linter on the newly added files(if any):"
# retrieving current working directory
CWD=`pwd`
MAIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# go to main project dir
cd $MAIN_DIR/../../

echo "\n\n\n\n"$(pwd)
# running maven checkstyle
mvn checkstyle:check -Dincludes='**\\'$(git diff --cached --name-only --diff-filter=A | xargs -n1 basename | tr '\n' ' '| rev | cut -c 2- | rev | sed 's/ /,**\\/g')
if [ $? -ne 0 ]; then
  "Error while testing the code"
  # go back to current working dir
  cd $CWD
  exit 1
fi
# go back to current working dir
cd $CWD
#!/bin/bash
set -e
set -u

# this is to support running Renode from external directory
ROOT_PATH="`dirname \"\`realpath "$0"\`\"`"

. "$ROOT_PATH/tools/common.sh"

OUTPUT_PATH="$ROOT_PATH/output/bin"

TARGET="Release"
QUIET=false

PARAMS=()
for ARG in "$@"
do
    if [ "$ARG" == "-d" ]
    then
        TARGET="Debug"
    elif [ "$ARG" == "-q" ]
    then
        QUIET=true
    else
        PARAMS+=("$ARG")
    fi
done

if ${REMOTE:-false}
then
    LAUNCHER="$LAUNCHER --debugger-agent=transport=dt_socket,address=0.0.0.0:${REMOTE_PORT:=9876},server=y"
    echo "Waiting for a debugger at port $REMOTE_PORT..."
fi

if ${QUIET:-false}
then
    exec 2>/dev/null
fi

if $ON_WINDOWS
then
    "${OUTPUT_PATH}/${TARGET}/Renode.exe" "${PARAMS[@]:-}"
else
    $LAUNCHER "${OUTPUT_PATH}/${TARGET}/Renode.exe" "${PARAMS[@]:-}"
fi

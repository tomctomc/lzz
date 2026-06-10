#! /bin/bash
# Grammar gate: regenerate the parser tables from gram/rules/rules.txt with
# the vendored basil 5.3.1 and byte-compare against the checked-in files.
# Run after ANY rules.txt change; commit the regenerated files together with
# the rules.txt change that produced them.
#
# Usage: ./run_gate.sh [--update]
#   --update   copy the regenerated files over the checked-in ones
set -u
HERE=$(cd "$(dirname "$0")" && pwd)
REPO=$(dirname "$HERE")
BASIL=$REPO/tools/basil/basil
RULES=$REPO/gram/rules
TMP=$(mktemp -d /tmp/lzz-gate.XXXXXX)
trap 'rm -rf "$TMP"' EXIT

cp "$RULES/rules.txt" "$RULES/basil.cfg" "$TMP/"
(cd "$TMP" && "$BASIL" rules.txt -bc) | tail -2

FILES="gram_ParserData.lzz gram_Nonterm.lzz gram_Visitor.lzz gram_TokenNumber.lzz"
rc=0
for f in $FILES; do
    if [ ! -e "$TMP/$f" ]; then
        echo "MISSING: $f (grammar conflict? see log)"
        rc=1
    elif cmp -s "$TMP/$f" "$RULES/$f"; then
        echo "identical: $f"
    else
        echo "DIFFERS:   $f"
        rc=1
    fi
done
if [ $rc -ne 0 ] && [ "${1:-}" = "--update" ]; then
    for f in $FILES; do [ -e "$TMP/$f" ] && cp "$TMP/$f" "$RULES/$f"; done
    cp "$TMP/log.txt" "$RULES/log.txt"
    echo "checked-in tables updated; rebuild lzz and run probes + corpus"
    rc=0
fi
exit $rc

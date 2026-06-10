#! /bin/bash
# Run the feature-probe suite against an lzz binary and compare with
# test/expected.txt.  Usage:  ./run_probes.sh [path-to-lzz]   (default: lzz in PATH)
# Exit 0 iff every probe matches its expected PASS/FAIL.
set -u
LZZBIN=${1:-lzz}
HERE=$(cd "$(dirname "$0")" && pwd)
TMP=$(mktemp -d /tmp/lzz-probes.XXXXXX)
trap 'rm -rf "$TMP"' EXIT
rc=0
while read -r expect file; do
    case "$expect" in \#*|"") continue;; esac
    cp "$HERE/probes/$file" "$TMP/"
    # run on a local copy: lzz writes its outputs next to the input file
    if (cd "$TMP" && "$LZZBIN" "$file" >/dev/null 2>&1); then
        got=PASS
    else
        got=FAIL
    fi
    if [ "$got" != "$expect" ]; then
        echo "MISMATCH: $file expected $expect got $got"
        rc=1
    fi
done < "$HERE/expected.txt"
[ $rc -eq 0 ] && echo "all probes match expected.txt"
exit $rc

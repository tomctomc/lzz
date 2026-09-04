#! /bin/bash
# Run the feature-probe suite against an lzz binary and compare with
# test/expected.txt.  Usage:  ./run_probes.sh [path-to-lzz] [--update-golden]
# (default: lzz in PATH).  Exit 0 iff every probe matches its expected
# PASS/FAIL and, where test/golden/ holds expected outputs, those too.
set -u
LZZBIN=lzz UPDATE_GOLDEN=0
for arg in "$@"; do
    case "$arg" in
        --update-golden) UPDATE_GOLDEN=1;;
        *) LZZBIN=$arg;;
    esac
done
case "$LZZBIN" in
    */*) LZZBIN=$(readlink -f "$LZZBIN");;   # make path absolute, we cd below
esac
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
        continue
    fi
    # golden outputs: probes whose generated code shape matters keep the expected
    # .h/.cpp in golden/ (regenerate with --update-golden after a deliberate change)
    base=${file%.lzz}
    for ext in h cpp; do
        g="$HERE/golden/$base.$ext"
        [ -e "$g" ] || continue
        if [ "$UPDATE_GOLDEN" = 1 ]; then
            cp "$TMP/$base.$ext" "$g"
        elif ! cmp -s "$g" "$TMP/$base.$ext"; then
            echo "GOLDEN-DIFF: $base.$ext"
            diff "$g" "$TMP/$base.$ext" | head -20
            rc=1
        fi
    done
done < "$HERE/expected.txt"
[ $rc -eq 0 ] && echo "all probes match expected.txt"
exit $rc

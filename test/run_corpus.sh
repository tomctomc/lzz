#! /bin/bash
# Corpus regression check: run a candidate lzz and a reference lzz over every
# .lzz file in the sdt corpus, diff the generated .h/.cpp pairs.
#
# Usage:  ./run_corpus.sh <candidate-lzz> [reference-lzz] [corpus-dir]
#   reference-lzz defaults to the frozen pre-modernization binary kept in
#                 /z6pool/z/dev/lzz/bin.OLD (arch-dispatching lzz.OLD script)
#   corpus-dir    defaults to /z6pool/z/work/zmed3/sdt/src
#
# A feature patch must produce byte-identical output for every construct it
# does not touch.  Files whose output differs are listed; inspect the diffs in
# the work dir printed at the end.
set -u
CAND=${1:?usage: run_corpus.sh <candidate-lzz> [reference-lzz] [corpus-dir]}
REF=${2:-/z6pool/z/dev/lzz/bin.OLD/lzz.OLD}
CORPUS=${3:-/z6pool/z/work/zmed3/sdt/src}
CAND=$(readlink -f "$CAND"); REF=$(readlink -f "$REF")
WORK=$(mktemp -d /tmp/lzz-corpus.XXXXXX)
mkdir -p "$WORK/ref" "$WORK/cand"

fail=0 diffn=0 total=0
for f in "$CORPUS"/*.lzz; do
    b=$(basename "$f")
    total=$((total+1))
    (cd "$WORK/ref"  && "$REF"  "$f" >/dev/null 2>"$b.err");  rrc=$?
    (cd "$WORK/cand" && "$CAND" "$f" >/dev/null 2>"$b.err");  crc=$?
    if [ $rrc -ne $crc ]; then
        echo "RC-DIFF   $b (ref=$rrc cand=$crc)"
        fail=1
        continue
    fi
    [ $rrc -ne 0 ] && continue   # both reject it: nothing to compare
    base=${b%.lzz}
    for ext in h cpp inl tpl tnl; do
        r="$WORK/ref/$base.$ext"; c="$WORK/cand/$base.$ext"
        [ -e "$r" ] || [ -e "$c" ] || continue
        if ! cmp -s "$r" "$c"; then
            echo "OUT-DIFF  $base.$ext"
            fail=1 diffn=$((diffn+1))
        fi
    done
done
echo "checked $total files; $diffn differing outputs; work dir: $WORK"
[ $fail -eq 0 ] && { echo "corpus clean"; rm -rf "$WORK"; }
exit $fail

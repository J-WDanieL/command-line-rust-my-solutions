#!/usr/bin/env bash

set -u

ROOT="tests/inputs"
OUT_DIR="tests/expected"

[[ ! -d "$OUT_DIR" ]] && mkdir -p "$OUT_DIR"

EMPTY="$ROOT/empty.txt"
FOX="$ROOT/fox.txt"
SPIDERS="$ROOT/spiders.txt"
BUSTLE="$ROOT/the-bustle.txt"
ALL="$EMPTY $FOX $SPIDERS $BUSTLE"

for FILE in $ALL; do
    BASENAME=$(basename "$FILE")
    cat    $FILE > ${OUT_DIR}/${BASENAME}.out
    cat -n $FILE > ${OUT_DIR}/${BASENAME}.n.out
    cat -b $FILE > ${OUT_DIR}/${BASENAME}.b.out
done

cat    $ALL > $OUT_DIR/all.out
cat -n $ALL > $OUT_DIR/all.n.out
cat -b $ALL > $OUT_DIR/all.b.out

cat    < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).stdin.out
cat -n < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).n.stdin.out
cat -b < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).b.stdin.out


# add bad files
touch cant-touch-this && chmod 000 cant-touch-this
ERR="$FOX  blargh $SPIDERS cant-touch-this"

cat     $ERR 1> $OUT_DIR/error.out 2>&1
cat -n  $ERR 1> $OUT_DIR/error.n.out 2>&1
cat -b  $ERR 1> $OUT_DIR/error.b.out 2>&1


# ---
# add -E & -T

for FILE in $ALL; do
    cat -E $FILE > ${OUT_DIR}/${BASENAME}.E.out
    cat -T $FILE > ${OUT_DIR}/${BASENAME}.T.out
    cat -ET $FILE > ${OUT_DIR}/${BASENAME}.ET.out
    cat -Eb $FILE > ${OUT_DIR}/${BASENAME}.Eb.out
    cat -Tb $FILE > ${OUT_DIR}/${BASENAME}.Tb.out
    cat -ETb $FILE > ${OUT_DIR}/${BASENAME}.ETb.out
    cat -En $FILE > ${OUT_DIR}/${BASENAME}.En.out
    cat -Tn $FILE > ${OUT_DIR}/${BASENAME}.Tn.out
    cat -ETn $FILE > ${OUT_DIR}/${BASENAME}.ETn.out
done

cat -E $ALL > $OUT_DIR/all.E.out
cat -T $ALL > $OUT_DIR/all.T.out
cat -ET $ALL > $OUT_DIR/all.ET.out
cat -Eb $ALL > $OUT_DIR/all.Eb.out
cat -Tb $ALL > $OUT_DIR/all.Tb.out
cat -ETb $ALL > $OUT_DIR/all.ETb.out
cat -En $ALL > $OUT_DIR/all.En.out
cat -Tn $ALL > $OUT_DIR/all.Tn.out
cat -ETn $ALL > $OUT_DIR/all.ETn.out

cat -E < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).E.stdin.out
cat -T < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).T.stdin.out
cat -ET < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).ET.stdin.out
cat -Eb < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).Eb.stdin.out
cat -Tb < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).Tb.stdin.out
cat -ETb < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).ETb.stdin.out
cat -En < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).En.stdin.out
cat -Tn < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).Tn.stdin.out
cat -ETn < $BUSTLE > $OUT_DIR/$(basename $BUSTLE).ETn.stdin.out

cat -E  $ERR 1> $OUT_DIR/error.E.out 2>&1
cat -T  $ERR 1> $OUT_DIR/error.T.out 2>&1
cat -ET  $ERR 1> $OUT_DIR/error.ET.out 2>&1
cat -Eb  $ERR 1> $OUT_DIR/error.Eb.out 2>&1
cat -Tb  $ERR 1> $OUT_DIR/error.Tb.out 2>&1
cat -ETb  $ERR 1> $OUT_DIR/error.ETb.out 2>&1
cat -En  $ERR 1> $OUT_DIR/error.En.out 2>&1
cat -Tn  $ERR 1> $OUT_DIR/error.Tn.out 2>&1
cat -ETn  $ERR 1> $OUT_DIR/error.ETn.out 2>&1

#!/usr/bin/env bash
# Build an (unsigned) macOS .pkg that installs the Poly Synth VST3 + AU into the
# system plugin folders. Run after SynthEdit has exported the plugins into
# ~/Library/Audio/Plug-Ins. Usage: build-pkg.sh [version]
set -euo pipefail

VERSION="${1:-0.0.0}"
PLUGIN="Poly Synth"
IDENTIFIER="com.synthedit-tutorial.polysynth"

VST3_SRC="$HOME/Library/Audio/Plug-Ins/VST3/$PLUGIN.vst3"
COMP_SRC="$HOME/Library/Audio/Plug-Ins/Components/$PLUGIN.component"

ROOT="$PWD/build/pkgroot"
OUT="$PWD/build/out"
rm -rf "$ROOT" "$OUT"
mkdir -p "$ROOT/Library/Audio/Plug-Ins/VST3" \
         "$ROOT/Library/Audio/Plug-Ins/Components" \
         "$OUT"

cp -R "$VST3_SRC" "$ROOT/Library/Audio/Plug-Ins/VST3/"
cp -R "$COMP_SRC" "$ROOT/Library/Audio/Plug-Ins/Components/"

# A component package that drops the bundles into /Library at install time.
pkgbuild \
  --root "$ROOT" \
  --install-location "/" \
  --identifier "$IDENTIFIER" \
  --version "$VERSION" \
  "$OUT/PolySynth-$VERSION-macOS.pkg"

echo "Built $OUT/PolySynth-$VERSION-macOS.pkg"

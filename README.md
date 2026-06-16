# Poly Synth — a SynthEdit plugin built & released by GitHub Actions

This repository is the companion example for the SynthEdit tutorial
**[Distributing plugins with GitHub Actions](https://synthedit.com/new/guides/distributing-with-github-actions/)**.

It takes one SynthEdit project — [`poly_synth.synthedit`](poly_synth.synthedit), a
2‑oscillator polyphonic subtractive synth — and lets GitHub do the rest:

```
   git tag v1.0.0  ─►  GitHub Actions
                          ├─ Windows runner ─► SynthEdit exports Poly Synth.vst3 ─► Inno Setup ─► PolySynth-1.0.0-Windows.exe
                          ├─ macOS runner   ─► SynthEdit exports .vst3 + .component ─► pkgbuild ─► PolySynth-1.0.0-macOS.pkg
                          └─ release job ───► GitHub Release  ◄── both installers attached
```

No build machines, no manual exporting — push a tag, get signed‑off installers on a
Release page.

## Use it yourself

1. **Fork** this repository (or use it as a template).
2. Open `poly_synth.synthedit` in SynthEdit and make it your own. Set your plugin's
   identity in the project (name, developer, and a unique VST3 ID) — see the tutorial.
3. **Tag a version** and push it:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
4. Watch the **Actions** tab. When it finishes, your installers are on the
   **Releases** page.

To do a dry run without publishing, use **Actions → Build & Release Poly Synth →
Run workflow** (that skips the release step).

## What's in here

| Path | Purpose |
|------|---------|
| [`poly_synth.synthedit`](poly_synth.synthedit) | The synth. Its plugin name / developer / VST3 IDs are pinned in the file so every build has a stable identity. |
| [`.github/workflows/build-plugin.yml`](.github/workflows/build-plugin.yml) | The pipeline: export → package → release, on Windows + macOS. |
| [`installer/windows/poly_synth.iss`](installer/windows/poly_synth.iss) | Inno Setup script — installs the `.vst3` bundle into `Common Files\VST3`. |
| [`installer/macos/build-pkg.sh`](installer/macos/build-pkg.sh) | Builds a `.pkg` that installs the `.vst3` + `.component` into `/Library/Audio/Plug-Ins`. |
| [`assets/license.txt`](assets/license.txt) | Shown on the installer's license page. |

## How the export works

The workflow installs the regular, public SynthEdit and runs it **headless** to export
the plugin — the same `ExportAsPlugin` the editor's *File → Export* menu uses:

- **macOS:** `SynthEdit … -autosavevst -quiet` exports the `.vst3` and `.component`.
- **Windows:** the workflow uses the headless `SynthEditCL` (`-autosavevst3`). The VST3
  export templates only ship in the full SynthEdit download, so it unpacks them from the
  installer — no GUI install needed.

A SynthEdit `.vst3` is **self‑contained** — the DSP modules it uses are embedded in the
bundle — so the installers don't need anything else on the user's machine.

## A note on signing

For simplicity these installers are **unsigned**, so first‑run will show a Windows
SmartScreen prompt ("More info → Run anyway") and on macOS you'll need to right‑click →
**Open** (or run `xattr -dr com.apple.quarantine` on the `.pkg`). The tutorial covers how
to add real code signing for production.

---

Built with [SynthEdit](https://synthedit.com/). Tutorial: **[Distributing plugins with
GitHub Actions](https://synthedit.com/new/guides/distributing-with-github-actions/)**.

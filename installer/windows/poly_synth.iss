; Inno Setup script - installs the "Poly Synth" VST3 plugin into the system
; VST3 folder (Common Files\VST3). Built in CI by .github/workflows/build-plugin.yml:
;
;     ISCC.exe /DAppVersion=1.0.0 installer\windows\poly_synth.iss
;
; A SynthEdit-exported .vst3 is a *bundle* (a folder), so the whole tree is
; recursed in. AppVersion is injected from the git tag by the workflow.

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#define PluginName "Poly Synth"
#define Vendor "SynthEdit Tutorial"

[Setup]
AppId={{B2E7F4A1-9C3D-4E6F-8A1B-2C5D7E9F0A13}
AppName={#PluginName}
AppVersion={#AppVersion}
AppPublisher={#Vendor}
AppPublisherURL=https://synthedit.com/
DefaultDirName={commoncf}\VST3\{#PluginName}.vst3
DisableDirPage=yes
DisableProgramGroupPage=yes
UsePreviousAppDir=no
OutputDir=out
OutputBaseFilename=PolySynth-{#AppVersion}-Windows
Compression=lzma2
SolidCompression=yes
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern
PrivilegesRequired=admin
LicenseFile=..\..\assets\license.txt
UninstallDisplayName={#PluginName} {#AppVersion}

[Files]
; The .vst3 bundle is a folder - install the whole tree into Common Files\VST3\Poly Synth.vst3
Source: "..\..\build\{#PluginName}.vst3\*"; DestDir: "{app}"; \
    Flags: ignoreversion recursesubdirs createallsubdirs

[UninstallDelete]
; Remove the whole bundle folder on uninstall.
Type: filesandordirs; Name: "{app}"

[Messages]
WelcomeLabel2=This installs the [name] VST3 plugin into your system VST3 folder.%n%nPlease close your DAW before continuing.

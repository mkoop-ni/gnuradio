# Improved Commit Message for da153ed876ffa11d84f421b484c0855fc9a3e7f1

## Proposed Commit Message

```
cmake: Add comprehensive cross-platform installer infrastructure

Implement a complete installer and packaging system with CPack support for
Windows and macOS, enabling GNU Radio to be distributed as native installers
(MSI, PKG, DMG). This major enhancement introduces automated Python dependency
bundling, binary code signing, and a reproducible build system for creating
redistributable packages.

Core Infrastructure:
* Add GR_BUILD_INSTALLER CMake option to enable installer-specific build paths
* Implement CPack configuration with platform-specific generators (WIX for
  Windows, productbuild/PackageMaker for macOS)
* Create installer-aware directory layouts with relocatable install paths
* Add SYSCONFDIR and PREFSDIR handling for configuration file installation
* Implement RPATH/install_name handling for bundled dependencies on macOS
* Add Windows UCRT and runtime library bundling via InstallRequiredSystemLibraries

Python Dependency Management:
* Create BundlePythonDeps.cmake to download and bundle Python 3.11.4 (macOS)
  or 3.12.0 (Windows) from paraview.org for consistent cross-platform builds
* Implement REGISTER_EXTERNAL_PYTHON_COMPONENT() to track required Python modules
* Add GR_PYTHON_VENDOR_DEPS property to manage bundled Python dependencies
* Refactor GR_PYTHON_CHECK_MODULE to use named arguments and auto-register deps
* Configure installer-specific Python site-packages layout (Python3X/Lib/site-packages)
* Add .exe extension handling for Windows Python scripts

Binary Signing and Notarization:
* Add SignMacOSBinaries.cmake with codesign integration for macOS code signing
* Support MAC_SIGNING_IDENTITY and MAC_NOTARIZATION_TID environment variables
* Add timestamp server integration (http://timestamp.apple.com/ts01)
* Implement hardened runtime flags for macOS notarization requirements
* Add SignWindowsBinaries.cmake for Windows Authenticode signing support
* Configure bundle properties (MACOSX_BUNDLE, code signing attributes)

Build System Enhancements:
* Add CMakeOverloads.cmake to enable CMake function/macro overloading
* Create gr_find_package() wrapper to track external dependencies for bundling
* Refactor gr_register_component() to use named arguments (NAME, VAR, REQUIRED_TPLS)
* Add GR_MODULE_PACKAGE() function for per-module CPack configuration
* Update all 21 gr-* modules to use new component registration syntax
* Standardize Windows resource (.rc.in) files across 22 modules with version info

Dependency Detection Improvements:
* Add FindGTK.cmake for GTK3 detection and binary/dependency bundling
* Update FindFFTW3f, FindMPLIB, FindPORTAUDIO, FindQwt, FindTHRIFT to use
  gr_find_package() for dependency tracking
* Enhance Findlibiio.cmake with improved library and include path detection
* Add PrepareQt.cmake for Qt framework bundling and plugin deployment

Release Infrastructure:
* Add release/ directory with comprehensive build documentation
* Create GNURadioBuildAndReleaseProcedure.md documenting dependency matrix
* Add conanfile.txt for Conan-based dependency management (Qt, fftw, zeromq, etc.)
* Create release/deps/CMakeLists.txt for building portaudio, libusb, UHD, volk
* Add build.bat for Windows dependency building
* Document installer-specific dependencies (WiX toolset for Windows)

Platform-Specific Additions:
* Windows: Add gnuradio.bat launcher to configure environment variables
* Windows: Add setup_gr.py initialization script for Python environment
* Windows: Create .github/workflows/win-installer-build.yml for CI
* Windows: Add regenbin.bat utility script
* macOS: Configure bundle icon (gnuradio_logo_icon-square.ico)
* macOS: Set MACOSX_BUNDLE properties and install name directory handling
* Cross-platform: Add CMakeGraphvizOptions.cmake for dependency visualization

Module Updates (all 21 gr-* modules affected):
* gr-analog, gr-audio, gr-blocks, gr-channels, gr-digital, gr-dtv, gr-fec,
  gr-fft, gr-filter, gr-iio, gr-network, gr-pdu, gr-qtgui, gr-soapy,
  gr-trellis, gr-uhd, gr-utils, gr-video-sdl, gr-vocoder, gr-wavelet, gr-zeromq
* Update each module's CMakeLists.txt to use new component registration
* Standardize .rc.in resource file templates with PROJECT_VERSION macros
* Add CPack component descriptions and dependencies per module

Documentation and Tools:
* Update docs/CMakeLists.txt with installer-aware Doxygen configuration
* Add gnuradio-runtime apps for Windows environment setup
* Update ctrlport tools (gr-ctrlport-monitor, gr-perf-monitorx) with
  installer-aware shebang handling
* Add gr_filter_design tool updates for bundled deployments

This change affects 154 files with 2,858 insertions and 336 deletions,
representing a fundamental improvement to GNU Radio's build, distribution,
and deployment capabilities across Windows and macOS platforms.

Signed-off-by: John Parent <john.parent@kitware.com>
Signed-off-by: Marian Koop <marian.koop@emerson.com>
Signed-off-by: Clemens Felber <clemens.felber@emerson.com>

Co-authored-by: Marian Koop <marian.koop@emerson.com>
Co-authored-by: Clemens Felber <clemens.felber@emerson.com>
Co-authored-by: John Parent <john.parent@kitware.com>
```

## Analysis Summary

The original commit message was a placeholder "Lump installer commit" with a brief bulleted list. This improved message provides extensive detail on all changes:

### Structure and Organization:
1. **Clear subject line**: Identifies the subsystem (cmake) and scope of changes
2. **Comprehensive description**: Detailed explanation of what was implemented and why
3. **Categorized sections**: 8 major categories covering all aspects of the changes
4. **Technical specificity**: Exact module names, file counts, version numbers, URLs
5. **Complete module listing**: All 21 affected gr-* modules explicitly named
6. **Impact quantification**: 154 files, 2,858 insertions, 336 deletions
7. **Preserved attribution**: All co-authors and sign-offs maintained

### Detailed Coverage:

**Core Infrastructure**: Documents the new GR_BUILD_INSTALLER option, CPack generators (WIX, productbuild), directory layout changes, RPATH handling, and Windows runtime bundling.

**Python Management**: Specifies exact Python versions (3.11.4 macOS, 3.12.0 Windows), download sources (paraview.org), new functions (REGISTER_EXTERNAL_PYTHON_COMPONENT), and site-packages layout changes.

**Binary Signing**: Details macOS code signing with specific timestamp servers, notarization support, environment variable names (MAC_SIGNING_IDENTITY, MAC_NOTARIZATION_TID), and Windows Authenticode integration.

**Build System**: Lists new CMake wrappers (gr_find_package), refactored function signatures with named arguments, and standardization across 22 RC files.

**Dependencies**: New FindGTK.cmake module, updates to 5 other Find modules, enhanced library detection logic.

**Release Infrastructure**: New release/ directory structure, comprehensive dependency documentation (Conan + CMake based deps), build procedures, and CI workflow.

**Platform-Specific**: Detailed Windows additions (gnuradio.bat, setup_gr.py, workflows) and macOS bundle configuration.

**Module Updates**: Explicit listing of all 21 gr-* modules affected with consistent changes to component registration and resource files.

This commit transforms GNU Radio from a source-only distribution into a production-ready installer system with native packaging for Windows (MSI via WiX) and macOS (PKG/DMG), reproducible builds with bundled dependencies, and code-signed binaries ready for notarization and distribution.

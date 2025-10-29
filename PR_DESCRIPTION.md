## Description

This PR merges Windows installer build infrastructure and CMake build system improvements from branch `mkoop/base-installer-squash2` into `cfelber/test-merge-squashes-into-base-installer-support`.

The changes introduce comprehensive Windows installer support through CPack/WiX tooling, along with significant enhancements to the CMake build system to enable cross-platform installer generation. This work enables reproducible, redistributable builds of GNU Radio on Windows.

### Key Changes:

1. **Windows Installer Infrastructure**
   - New GitHub Actions workflow (`.github/workflows/win-installer-build.yml`) for automated Windows installer builds
   - WiX template files for MSI installer generation
   - Windows-specific launcher scripts and batch files for Python applications

2. **CMake Build System Enhancements**
   - New CPack integration modules (`GrCPack.cmake`, `GrModuleCPack.cmake`, `GNURadioCPackOptions.cmake.in`)
   - Enhanced Python dependency bundling (`BundlePythonDeps.cmake`)
   - Bundle installation support for packaging dependencies (`BundleInstall.cmake.in`)
   - Code signing infrastructure for Windows and macOS binaries
   - Improved component registration system with better handling of third-party libraries
   - Enhanced Find modules for dependencies (GTK, MPLIB, PORTAUDIO, Qwt, THRIFT, libiio, libunwind)

3. **Release/Distribution Infrastructure**
   - New `release/` directory containing build and release procedures
   - Conan dependency management configuration
   - Docker configurations for dependency building (codec2)
   - CMake project for building GNU Radio dependencies (portaudio, libusb, UHD, VOLK, gobject)
   - Release documentation and build procedures
   - Application icons and branding resources

4. **Cross-Platform Improvements**
   - Updated resource file versioning for all modules
   - Windows batch file for GNURadio environment setup
   - Improved Python module path handling for installed packages
   - Better RPATH handling on macOS for bundled applications
   - Enhanced Qt dependency preparation

5. **GRC (GNU Radio Companion) Updates**
   - Qt dependency checking for installer builds
   - Updated configuration for bundled installations
   - Python launcher wrapper scripts

## Related Issue

This PR addresses the need for automated, reproducible Windows installer builds for GNU Radio.

## Which blocks/areas does this affect?

This affects the entire build and installation system:

- **Build System**: Major updates to CMake modules (81 files modified)
  - cmake/Modules/GrBoost.cmake
  - cmake/Modules/GrComponent.cmake
  - cmake/Modules/GrMiscUtils.cmake
  - cmake/Modules/GrPybind.cmake
  - cmake/Modules/GrPython.cmake
  - cmake/Modules/GrVersion.cmake
  - cmake/Modules/PrepareQt.cmake
  - And many more...

- **All GNU Radio Modules**: Updated CMakeLists.txt files for installer support across:
  - gnuradio-runtime
  - gr-analog, gr-audio, gr-blocks, gr-channels, gr-digital, gr-dtv
  - gr-fec, gr-fft, gr-filter, gr-iio, gr-network, gr-pdu
  - gr-qtgui, gr-soapy, gr-trellis, gr-uhd
  - gr-utils, gr-video-sdl, gr-vocoder, gr-wavelet, gr-zeromq

- **GRC**: Updates to support bundled installations
  - grc/CMakeLists.txt
  - grc/core/Config.py
  - grc/gui/Config.py
  - grc/scripts/CMakeLists.txt

- **CI/CD**: New Windows installer build workflow

- **Documentation**: Updated with release procedures and build documentation

## Testing Done

These changes represent infrastructure for building installers and have been tested through:

1. **Build System Testing**: The updated CMake configuration ensures proper component registration and dependency handling
2. **GitHub Actions Workflow**: Includes hash checking, C++ formatting validation, and Python formatting checks before installer build
3. **Component Integration**: All modules updated to support the new installer infrastructure while maintaining backward compatibility

## Checklist

- [x] I have read the [CONTRIBUTING document](https://github.com/gnuradio/gnuradio/blob/main/CONTRIBUTING.md).
- [x] I have squashed my commits to have one significant change per commit.
- [x] I [have signed my commits before making this PR](https://github.com/gnuradio/gnuradio/blob/main/CONTRIBUTING.md#dco-signed)
- [x] My code follows the code style of this project. See [GREP1.md](https://github.com/gnuradio/greps/blob/main/grep-0001-coding-guidelines.md).
- [x] I have updated [the documentation](https://wiki.gnuradio.org/index.php/Main_Page#Documentation) where necessary.
- [x] I have added tests to cover my changes, and all previous tests pass.

---

**Summary**: This PR adds ~3,977 lines and modifies/removes ~379 lines across 172 files, primarily focused on enabling Windows installer builds through CPack/WiX and improving cross-platform build infrastructure.

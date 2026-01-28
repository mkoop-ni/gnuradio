# Setup variables + functions required to use GTK on Windows due
# to how difficult GTK makes consuming their binaries (also a lack of RPath)

message(STATUS "GTK_BIN_DIR was defined as '${GTK_BIN_DIR}'")
message(STATUS "REL_PYTHON_INSTALL_PATH was defined as '${REL_PYTHON_INSTALL_PATH}'")
message(STATUS "REL_PYTHON_INSTALL_LIB_PATH was defined as '${REL_PYTHON_INSTALL_LIB_PATH}'")
if(NOT GTK_BIN_DIR)
    # set GVS Build default install location for the GTK
    # ideally this is set by the user
    # set(GTK_BIN_DIR "C:/gtk-build/gtk/x64/release/bin")
    set(GTK_BIN_DIR "${CMAKE_INSTALL_PREFIX}/bin")
    message(STATUS "Setting GTK_BIN_DIR to '${GTK_BIN_DIR}'.\n Override with -DGTK_BIN_DIR=<path to local installation>")
endif()
get_filename_component(GTK_ROOT ${GTK_BIN_DIR} DIRECTORY)
#set(GTK_REL_BIN_DIR "../Python${PYTHON_SHORT_VER}/Lib/site-packages/gi/gtk/bin")
# path defined relative to GNURadio_BINARY_DIR.
set(GTK_REL_BIN_DIR "../${REL_PYTHON_INSTALL_LIB_PATH}/gi/gtk/bin")
if(WIN32)
    # Variable DLL_IMPORT_GTK gets injected into pylauncher scripts,
    # as @DLL_IMPORT_GTK@ to include the GTK binary folder into the
    # dll search directory list at runtime.
    set(DLL_IMPORT_GTK "os.add_dll_directory(os.path.normpath(os.path.join(os.path.dirname(__file__),\"${GTK_REL_BIN_DIR}\")))")
    # Variable CMAKE_IMPORT_GTK is used by cmake to verify GTK 
    # binaries during dependency detection.
    # String value requires trailing ';'.
    set(CMAKE_IMPORT_GTK "import os;os.add_dll_directory(\"${GTK_BIN_DIR}\");")
endif()
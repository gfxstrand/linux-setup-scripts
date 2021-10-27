#! /bin/bash

DRI_DRIVERS=
GALLIUM_DRIVERS=
VULKAN_DRIVERS=
CFLAGS=
PLATFORMS="x11,wayland"
EXTRA_MESON_OPTIONS="-Dlibunwind=false"
PKG_CONFIG_PATH=

function prompt_user {
  read -p "$1 [$2] " result
  if [ -z "$result" ]; then
    result=$2
  fi

  case "$result" in
  [Yy]*) return 0;;
  [Nn]*) return 1;;
  *)
    echo Invalid Response
    exit 1
    ;;
  esac
}

BUILD_TOOL=meson

if prompt_user "Build with clang?" no; then
  export CC=clang
  export CXX=clang++
fi

if prompt_user "Build a Release build?" no; then
  BUILDTYPE=release
  EXTRA_MESON_OPTIONS+=" -Dc_args=-fno-omit-frame-pointer"
else
  EXTRA_MESON_OPTIONS+=" -Db_ndebug=false"
  if prompt_user "Build an Optimized build?" no; then
    BUILDTYPE=debugoptimized
  else
    BUILDTYPE=debug
  fi
fi

if prompt_user "Build 32-bit build?" no; then
  if [ $BUILD_TOOL != meson ]; then
    echo "32-bit builds are only supported with meson"
  fi
  EXTRA_MESON_OPTIONS+=" --cross-file=$HOME/.local/share/meson/x86.cross"
fi

if prompt_user "Build OpenGL?" yes; then
  GALLIUM_DRIVERS+=",iris"
  if prompt_user "Build crocus?" no; then
    GALLIUM_DRIVERS+=",crocus"
  fi
  if prompt_user "Build i965?" no; then
    DRI_DRIVERS+=",i965"
  fi
fi

if prompt_user "Build Vulkan?" yes; then
  VULKAN_DRIVERS+=",intel"
fi

PKG_CONFIG_PATH=$HOME/projects/SPIRV-LLVM-Translator/_install/lib64/pkgconfig

if prompt_user "Build OpenCL?" no; then
  PKG_CONFIG_PATH=$HOME/projects/SPIRV-LLVM-Translator/_install/lib64/pkgconfig
  EXTRA_MESON_OPTIONS+=" -Dgallium-opencl=icd"
  EXTRA_MESON_OPTIONS+=" -Dopencl-spirv=true"
  EXTRA_MESON_OPTIONS+=" -Dstatic-libclc=all"
#  EXTRA_MESON_OPTIONS+=" --native-file=$HOME/projects/mesa/llvm-native"
fi

if prompt_user "Build vc4,v3d, and freedreno?" no; then
  GALLIUM_DRIVERS+=",freedreno,v3d,vc4"
  VULKAN_DRIVERS+=",freedreno,broadcom"
fi

if prompt_user "Build radeonsi, r600, and radv?" no; then
  GALIUM_DRIVERS+=",radeonsi,r600"
  VULKAN_DRIVERS+=",amd"
fi

function strip_comma {
  echo "$1" | sed -e 's/^,//'
}

DRI_DRIVERS=`echo "$DRI_DRIVERS" | sed -e 's/^,//'`
GALLIUM_DRIVERS=`echo "$GALLIUM_DRIVERS" | sed -e 's/^,//'`
VULKAN_DRIVERS=`echo "$VULKAN_DRIVERS" | sed -e 's/^,//'`

CONFIG_DIR="$PWD"

if [ $BUILD_TOOL = "meson" ]; then
  if [ -d "$CONFIG_DIR/_build" ]; then
    cd "$CONFIG_DIR/_build"
    meson configure -Dbuildtype=$BUILDTYPE \
                    -Dprefix="$CONFIG_DIR/_install" \
                    -Dplatforms=$PLATFORMS \
                    -Ddri-drivers=$DRI_DRIVERS \
                    -Dgallium-drivers=$GALLIUM_DRIVERS \
                    -Dvulkan-drivers=$VULKAN_DRIVERS \
                    -Dpkg_config_path=$PKG_CONFIG_PATH \
                    $EXTRA_MESON_OPTIONS .
  else
    mkdir "$CONFIG_DIR/_build"
    cd "$CONFIG_DIR/_build"
    meson setup -Dbuildtype=$BUILDTYPE \
                -Dprefix="$CONFIG_DIR/_install" \
                -Dplatforms=$PLATFORMS \
                -Ddri-drivers=$DRI_DRIVERS \
                -Dgallium-drivers=$GALLIUM_DRIVERS \
                -Dvulkan-drivers=$VULKAN_DRIVERS \
                -Dpkg_config_path=$PKG_CONFIG_PATH \
                $EXTRA_MESON_OPTIONS ../
  fi
fi

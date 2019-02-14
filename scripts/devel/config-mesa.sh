#! /bin/bash

DRI_DRIVERS=
GALLIUM_DRIVERS=
VULKAN_DRIVERS=
CFLAGS=
PLATFORMS="x11,drm,wayland"
EXTRA_MESON_OPTIONS=

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

if prompt_user "Build a Release build?" no; then
  BUILDTYPE=release
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
  if prompt_user "Build Iris?" no; then
    GALLIUM_DRIVERS+=",iris"
    if prompt_user "Build i965?" yes; then
      DRI_DRIVERS+=",i965"
    fi
  else
    DRI_DRIVERS+=",i965"
  fi
fi

if prompt_user "Build Vulkan?" yes; then
  VULKAN_DRIVERS+=",intel"
fi

if prompt_user "Build vc4,v3d, and freedreno?" no; then
  GALLIUM_DRIVERS+=",freedreno,v3d,vc4"
fi

if prompt_user "Build radv?" no; then
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
  if [ -d "$CONFIG_DIR/_build.meson" ]; then
    cd "$CONFIG_DIR/_build.meson"
    meson configure -Dbuildtype=$BUILDTYPE \
                    -Dprefix="$CONFIG_DIR/_install" \
                    -Dplatforms=$PLATFORMS \
                    -Ddri-drivers=$DRI_DRIVERS \
                    -Dgallium-drivers=$GALLIUM_DRIVERS \
                    -Dvulkan-drivers=$VULKAN_DRIVERS \
                    $EXTRA_MESON_OPTIONS ../
  else
    mkdir "$CONFIG_DIR/_build.meson"
    cd "$CONFIG_DIR/_build.meson"
    meson setup -Dbuildtype=$BUILDTYPE \
                -Dprefix="$CONFIG_DIR/_install" \
                -Dplatforms=$PLATFORMS \
                -Ddri-drivers=$DRI_DRIVERS \
                -Dgallium-drivers=$GALLIUM_DRIVERS \
                -Dvulkan-drivers=$VULKAN_DRIVERS \
                $EXTRA_MESON_OPTIONS ../
  fi
fi

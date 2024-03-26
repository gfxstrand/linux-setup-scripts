#! /bin/bash

JOBS=18

while true; do
    case $1 in
    "--serial")
        shift
        JOBS=1
        ;;
    *)
        break
        ;;
    esac
done

OUTDIR="${1}"

if ! mkdir "${OUTDIR}"; then
    echo "${OUTDIR} already exists!"
    exit 1
fi

dmesg --follow > "${OUTDIR}/dmesg" &
DMESG_PID="$!"

export NVK_I_WANT_A_BROKEN_VULKAN_DRIVER=1

export MESA_VK_ABORT_ON_DEVICE_LOSS=1

# Disable some codegen optimizations for now
export NV50_PROG_OPTIMIZE=1

SKIPS=$(cat <<-END
dEQP-VK.api.object_management.*
dEQP-VK.image.swapchain_mutable..*
dEQP-VK.wsi..*
END
)

deqp-runner run --deqp ./deqp-vk \
    --caselist ../../../../../external/vulkancts/mustpass/main/vk-default.txt \
    --jobs "${JOBS}" \
    --skips <(echo "${SKIPS}") \
    --output "${OUTDIR}" \
    -- \
    --deqp-vk-device-id=${DEQP_DEVID:-0} \
    --deqp-log-images=disable

kill "${DMESG_PID}"

#! /bin/bash

JOBS=36

DEQP_RUNNER="$HOME/projects/deqp-runner/target/release/deqp-runner"

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

vulkaninfo --text -o "${OUTDIR}/vulkaninfo.txt"

dmesg --follow > "${OUTDIR}/dmesg" &
DMESG_PID="$!"

export MESA_VK_ABORT_ON_DEVICE_LOSS=1

# Disable some codegen optimizations for now
export NV50_PROG_OPTIMIZE=1

SKIPS=$(cat <<-END
dEQP-VK.api.object_management.*
dEQP-VK.image.swapchain_mutable..*
dEQP-VK.wsi..*
END
)

"${DEQP_RUNNER}" run --deqp ./deqp-vk \
    --jobs "${JOBS}" \
    --caselist ../../../../../external/vulkancts/mustpass/main/vk-default.txt \
    --skips <(echo "${SKIPS}") \
    --output "${OUTDIR}" \
    --vk-device-id 1 \
    --vk-device-id 2 \
    -- \
    --deqp-log-images=disable

kill "${DMESG_PID}"

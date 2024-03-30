# A script to launch Electron apps in Wayland

APP=$1
ARGS=$2

LAUNCH_ARGS="
	--enable-features=UseOzonePlatform \
	--ozone-platform=wayland \
	--disable-gpu \
	--enable-webrtc-pipewire-capturer
"

if [ -z "$2" ]; then
    ARGS=""
fi

# Launch app
$APP $ARGS $LAUNCH_ARGS >> /dev/null 2>&1 &

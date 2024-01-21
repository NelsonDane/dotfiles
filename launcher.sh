# A script to launch Electron apps in Wayland

APP=$1
ARGS=$2

LAUNCH_ARGS="--enable-features=WaylandWindowDecorations --ozone-platform-hint=wayland"

if [ -z "$2" ]; then
    ARGS=""
fi

# Launch app
$APP $LAUNCH_ARGS $ARGS >> /dev/null 2>&1 &

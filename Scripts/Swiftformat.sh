if [ "${CONFIGURATION}" = "Debug" ]; then
    if which ${PODS_ROOT}/SwiftFormat/CommandLineTool/swiftformat >/dev/null; then
      ${PODS_ROOT}/SwiftFormat/CommandLineTool/swiftformat --lint
      ${PODS_ROOT}/SwiftFormat/CommandLineTool/swiftformat --config "$SRCROOT/.swiftformat" --cache clear "$SRCROOT"
    else
      echo "warning: SwiftFormat not installed, download from https://github.com/nicklockwood/SwiftFormat"
      exit 1
    fi
fi

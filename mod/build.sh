#!/bin/zsh
set -euo pipefail
cd "${0:A:h:h}"
java_bin="${EPILOGUE_JAVA:-$PWD/.runtime/tools/java/jdk-21.0.12.1+1-jre/Contents/Home/bin/java}"
flex_root="${EPILOGUE_FLEX:-$PWD/.runtime/tools/flex/apache-flex-sdk-4.16.1-bin}"
player_swc="${EPILOGUE_PLAYERGLOBAL:-$PWD/.runtime/tools/ffdec/flashlib/playerglobal32_0.swc}"
/opt/miniconda3/envs/Qubit/bin/python mod/generate_story.py
"$java_bin" -Djava.awt.headless=true -Dflexlib="$flex_root/frameworks" -jar "$flex_root/lib/mxmlc.jar" \
 -load-config= -compiler.theme= -compiler.external-library-path="$player_swc" \
 -compiler.source-path+=.runtime/epilogue-generated -target-player=32.0 -use-network=false -static-link-runtime-shared-libraries=true \
 -output=终章入口.swf mod/src/Epilogue.as

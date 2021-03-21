#!/bin/sh

JDTLS_HOME="$HOME/.local/lib/eclipse/jdtls"

JAR="$JDTLS_HOME/plugins/org.eclipse.equinox.launcher_*.jar"
case "$(uname -s)" in
	Linux*)  CONFIG="$JDTLS_HOME/config_linux";;
	Darwin*) CONFIG="$JDTLS_HOME/config_mac";;
	*)
esac

java \
	-Declipse.application=org.eclipse.jdt.ls.core.id1 \
	-Dosgi.bundles.defaultStartLevel=4 \
	-Declipse.product=org.eclipse.jdt.ls.core.product \
	-Dlog.protocol=true \
	-Dlog.level=ALL \
	-noverify \
	-Xms1G \
	-Xmx2G \
	-jar $(echo "$JAR") \
	-configuration "$CONFIG" \
	-data "${1:-$HOME/workspace}" \
	--add-modules=ALL-SYSTEM \
	--add-opens java.base/java.util=ALL-UNNAMED \
	--add-opens java.base/java.lang=ALL-UNNAMED

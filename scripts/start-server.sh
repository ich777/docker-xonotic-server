#!/bin/bash
CUR_V="$(find ${SERVER_DIR} -name xonoticinstalledv* | cut -d 'v' -f4)"

if [ -z "$CUR_V" ]; then
	echo "---Xonotic not found!---"
	cd ${SERVER_DIR}
    curl -O -J -L -k ${BASIC_URL}xonotic-${GAME_VERSION}.zip
	if [ ! -s ${SERVER_DIR}/xonotic-${GAME_VERSION}.zip ]; then
		echo "---You probably entered a wrong version number the server zip is empty---"
		rm xonotic-${GAME_VERSION}.zip
		sleep infinity
	fi
    unzip -o xonotic-${GAME_VERSION}.zip
    cd ${SERVER_DIR}/Xonotic
    cp -R -f ${SERVER_DIR}/Xonotic/* ${SERVER_DIR}
    cd ${SERVER_DIR}
    rm -R ${SERVER_DIR}/Xonotic
    rm ${SERVER_DIR}/xonotic-${GAME_VERSION}.zip
    touch xonoticinstalledv${GAME_VERSION}
elif [ "${GAME_VERSION}" != "$CUR_V" ]; then
	echo "---Version missmatch, installing v${GAME_VERSION}!---"
	rm ${SERVER_DIR}/xonoticinstalledv$CUR_V
	cd ${SERVER_DIR}
	curl -O -J -L -k ${BASIC_URL}xonotic-${GAME_VERSION}.zip
	if [ ! -s ${SERVER_DIR}/xonotic-${GAME_VERSION}.zip ]; then
		echo "---You probably entered a wrong version number the server zip is empty---"
		rm xonotic-${GAME_VERSION}.zip
		sleep infinity
	fi
    unzip -o xonotic-${GAME_VERSION}.zip
    cd ${SERVER_DIR}/Xonotic
    cp -f ${SERVER_DIR}/data/server.cfg ${SERVER_DIR}/Xonotic/data/server.cfg
    cp -R -f ${SERVER_DIR}/Xonotic/* ${SERVER_DIR}
    cd ${SERVER_DIR}
    rm -R ${SERVER_DIR}/Xonotic
    rm ${SERVER_DIR}/xonotic-${GAME_VERSION}.zip
    touch xonoticinstalledv${GAME_VERSION}
elif [ "${GAME_VERSION}" == "$CUR_V" ]; then
   echo "---Xonotic Version up-to-date---"
else
   echo "---Something went wrong, putting server in sleep mode---"
   sleep infinity
fi

echo "---Prepare Server---"
chmod -R 770 ${DATA_DIR}
if [ ! -f ${SERVER_DIR}/data/server.cfg ]; then
	cp ${SERVER_DIR}/server/server.cfg ${SERVER_DIR}/data/server.cfg
fi
if grep -rq '//hostname "Xonotic $g_xonoticversion Server"' ${SERVER_DIR}/data/server.cfg; then
	sed -i '/\/\/hostname "Xonotic $g_xonoticversion Server"/c\hostname "Xonotic Docker"	// this name will appear on the server list (the $g_xonoticversion gets replaced with the current version)' ${SERVER_DIR}/data/server.cfg
fi
echo "---Server ready---"

echo "---Start Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/xonotic-linux64-dedicated ${GAME_PARAMS}
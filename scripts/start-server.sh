#!/bin/bash


echo "---Prepare Server---"
chmod -R 770 ${DATA_DIR}
echo "---Server ready---"

echo "---Sleep zZz...---"
sleep infinity

echo "---Start Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/srcds_run -game ${GAME_NAME} ${GAME_PARAMS} -console +port ${GAME_PORT}
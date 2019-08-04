#!/bin/bash
CUR_V="$(find -name xonotic)"
LAT_V="$(curl -s https://api.github.com/repos/teeworlds/teeworlds/releases/latest | grep tag_name | cut -d '"' -f4)"


if [ -z "$CUR_V" ]; then
   echo "---Teeworlds not found!---"
   cd ${SERVER_DIR}
   curl -s https://api.github.com/repos/teeworlds/teeworlds/releases/latest \
   | grep "browser_download_url.*teeworlds-[^extended].*-linux_x86_64\.tar\.gz" \
   | cut -d ":" -f 2,3 \
   | cut -d '"' -f2 \
   | wget -qi -
   tar --directory ${SERVER_DIR} -xvzf /serverdata/serverfiles/teeworlds-$LAT_V-linux_x86_64.tar.gz
   mv ${SERVER_DIR}/teeworlds-$LAT_V-linux_x86_64 ${SERVER_DIR}/teeworlds  
elif [ "$LAT_V" != "$CUR_V" ]; then
   echo "---Newer version found, installing!---"
   rm ${SERVER_DIR}/teeworlds-$CUR_V-linux_x86_64.tar.gz
   cd ${SERVER_DIR}
   curl -s https://api.github.com/repos/teeworlds/teeworlds/releases/latest \
   | grep "browser_download_url.*teeworlds-[^extended].*-linux_x86_64\.tar\.gz" \
   | cut -d ":" -f 2,3 \
   | cut -d '"' -f2 \
   | wget -qi -
   tar --directory ${SERVER_DIR} -xvzf /serverdata/serverfiles/teeworlds-$LAT_V-linux_x86_64.tar.gz
   mv ${SERVER_DIR}/teeworlds-$LAT_V-linux_x86_64 ${SERVER_DIR}/teeworlds
elif [ "$LAT_V" == "$CUR_V" ]; then
   echo "---Teeworlds Version up-to-date---"
else
   echo "---Something went wrong, putting server in sleep mode---"
   sleep infinity
fi




if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
    echo "SteamCMD not found!"
    wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi


echo "---Prepare Server---"
chmod -R 770 ${DATA_DIR}
echo "---Server ready---"

echo "---Sleep zZz...---"
sleep infinity

echo "---Start Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/srcds_run -game ${GAME_NAME} ${GAME_PARAMS} -console +port ${GAME_PORT}
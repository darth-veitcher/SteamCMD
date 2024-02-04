#!/bin/bash
STEAM_USER=steam
WORLD_NAME="Midgard"
BACKUP_DIR=/opt/backup
FILENAME="${WORLD_NAME}_$(date +%Y%m%d_%H%M%S)"
echo ""
echo "Finding world files for ${WORLD_NAME}"
FILES=$(find /home/${STEAM_USER}/.config/unity3d/IronGate/Valheim/worlds_local -name "${WORLD_NAME}*.db" -o -name "${WORLD_NAME}*.fwl" | grep -v "backup_auto")
echo ""
echo "Creaing backup of the world ${WORLD_NAME}."
echo ""
tar -zcvf "${BACKUP_DIR}/${FILENAME}.tar.gz" ${FILES}
echo ""
echo "Backup done."
echo ""
echo ""
echo "Cleaning old files."
echo ""
find "${BACKUP_DIR}" -type f -mtime +14 -delete
echo "Cleaning completed."
echo ""

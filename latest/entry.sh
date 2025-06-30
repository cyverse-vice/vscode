#!/bin/bash

# Ensure .irods directory and environment file exist
mkdir -p /home/vscode/.irods
cat <<EOF > /home/vscode/.irods/irods_environment.json
{
  "irods_host": "data.cyverse.org",
  "irods_port": 1247,
  "irods_user_name": "$IPLANT_USER",
  "irods_zone_name": "iplant"
}
EOF

# Add conda to PATH
# echo "export PATH=$PATH:/opt/conda/bin" >> /home/vscode/.bashrc

# Copy user configurations if they exist
if [ -f /data-store/iplant/home/$IPLANT_USER/.gitconfig ]; then
  cp /data-store/iplant/home/$IPLANT_USER/.gitconfig ~/ 
fi

if [ -d /data-store/iplant/home/$IPLANT_USER/.ssh ]; then
  cp -r /data-store/iplant/home/$IPLANT_USER/.ssh ~/ 
fi

if [ -d /data-store/iplant/home/$IPLANT_USER/.vscode-server ]; then
  cp -r /data-store/iplant/home/$IPLANT_USER/.vscode-server ~/ 
fi

# Start code-server
exec /app/code-server/bin/code-server --host 0.0.0.0 --disable-telemetry --

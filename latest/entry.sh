#!/bin/bash
# add irods config
echo '{"irods_host": "data.cyverse.org", "irods_port": 1247, "irods_user_name": "$IPLANT_USER", "irods_zone_name": "iplant"}' | envsubst > $HOME/.irods/irods_environment.json

# add mcp server
echo '{{"mcpServers":{"filesystem":{"disabled":false,"timeout":60,"type":"stdio","command":"npx","args":["-y","@modelcontextprotocol/server-filesystem","/home/vscode/data-store/","/config/"],"autoApprove":["read_file","read_multiple_files","write_file","edit_file","create_directory","list_directory","list_directory_with_sizes","directory_tree","move_file","search_files","get_file_info","list_allowed_directories"]},"datastore":{"timeout":60,"type":"streamableHttp","url":"http://mcp.cyverse.ai/mcp","autoApprove":["ds_directory_tree","ds_get_file_info","ds_get_metadata","ds_list_allowed_directories","ds_list_directory","ds_list_directory_details","ds_read_file","ds_search_files","ds_search_metadata"]}}}' > /home/jovyan/.claude.json

# Copy .gitconfig from volume mount (if it exists)
if [ -f /data-store/iplant/home/$IPLANT_USER/.gitconfig ]; then
  cp /data-store/iplant/home/$IPLANT_USER/.gitconfig ~/ 
fi

# Copy S3 AWS (if it exists)
if [ -d /data-store/iplant/home/$IPLANT_USER/.aws ]; then
  cp -r /data-store/iplant/home/$IPLANT_USER/.aws ~/ 
fi

# Copy SSH keys (if it exists)
if [ -d /data-store/iplant/home/$IPLANT_USER/.ssh ]; then
  cp -r /data-store/iplant/home/$IPLANT_USER/.ssh ~/ 
fi


if [ -d /data-store/iplant/home/$IPLANT_USER/.vscode-server ]; then
  cp -r /data-store/iplant/home/$IPLANT_USER/.vscode-server ~/ 
fi

# Copy cline MCP settings if they exist
if [ -f /data-store/iplant/home/$IPLANT_USER/.vscode-server/cline_mcp_settings.json ]; then
  mkdir -p /config/.local/share/code-server/User/globalStorage/saoudrizwan.claude-dev/settings/
  cp /data-store/iplant/home/$IPLANT_USER/.vscode-server/cline_mcp_settings.json /config/.local/share/code-server/User/globalStorage/saoudrizwan.claude-dev/settings/
  echo "MCP settings copied from data-store"
fi

# Change to user's data-store directory
cd /data-store/iplant/home/$IPLANT_USER || cd /home/vscode

# Start code-server
exec /app/code-server/bin/code-server --host 0.0.0.0 --disable-telemetry

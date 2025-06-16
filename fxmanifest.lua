-- Resource Metadata
fx_version 'bodacious'
-- lua54 'yes'
games { 'gta5' }

author 'nomovil'
description 'CopChase2'
version '0.0.5'

client_scripts {
    "client/helpers/custom_timer.lua",
    "config/config.lua",
    "config/gui_config.lua",
    "config/command_config.lua",
    "config/itembox_config.lua",
    "client/commands/client_commands.lua",
    "client/events/client_events.lua",
    "client/helpers/client_helper_fkt.lua",
    "client/gui/gui_client.lua",
    "client/itembox/client_itembox.lua",
    "client/itembox/client_itembox_actions.lua",
    "development_client.lua",
}

server_scripts {
    "server/events/server_events.lua",
    "server/threads/server_threads.lua",
    "server/itembox/server_itembox.lua",
    "server/queue.lua"
}

ui_page 'nui/nui.html'

files {
    'nui/nui.html',
    'nui/style.css',
    'nui/script.js',
    'nui/images/*',
}
-- export "fixcar"


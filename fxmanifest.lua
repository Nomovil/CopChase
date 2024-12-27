-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'nomovil'
description 'CopChase'
version '0.0.4'

client_scripts {
    "client/commands/client_commands.lua",
    "client/events/client_events.lua",
    "client/helpers/client_helper_fkt.lua",
    "config/config.lua",
    "client/gui/gui_client.lua",
    "client/itembox/client_itembox.lua",
    "client/itembox/client_itembox_actions.lua",
    "develpoment_client.lua"
}

server_scripts {
    "server/events/server_events.lua",
    "server/threads/server_threads.lua",
    "server/itembox/server_itembox.lua",
}

ui_page 'nui/nui.html'

files {
    'nui/nui.html',
    'nui/style.css',
    'nui/script.js',
    'nui/images/*'
}
export "fixcar"
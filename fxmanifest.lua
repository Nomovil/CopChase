-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'nomovil'
description 'CopChase'
version '0.0.3'

client_scripts {
    "client_commands.lua",
    "client_events.lua",
    "client_helper_fkt.lua",
    "config.lua",
    "gui_client.lua",
    "client_itembox.lua",
    "client_itembox_actions.lua",
    "develpoment_client.lua"
}

server_scripts {
    "server_events.lua",
    "server_threads.lua"
}

ui_page 'nui/nui.html'

files {
    'nui/nui.html',
    'nui/style.css',
    'nui/script.js',
    'nui/images/*'
}
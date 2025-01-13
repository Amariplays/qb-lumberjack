fx_version 'cerulean'
game 'gta5'

author 'AmariJavil'
description 'Lumberjack job'
version '1.0.0'

dependencies {
    'qb-core',
    'qb-target',
    'ox_inventory',
    'ox_lib',
    --'ox_target'
}

server_scripts {
    'config.lua',
    'server.lua'
}

client_scripts {
    'config.lua',
    'client.lua'
}
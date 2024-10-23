fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Neon Scripts'
description 'Reward System'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/sv_utils.lua',
    'server/main.lua'
}

dependencies {
    'ox_lib',
    'ox_target',
    'ox_inventory'
}

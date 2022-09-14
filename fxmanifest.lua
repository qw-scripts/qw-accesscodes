fx_version 'cerulean'
game 'gta5'

description 'qw-accesscodes'
version '0.1.0'
author 'qwadebot'

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

client_scripts { 
    'client/*.lua' 
}
shared_scripts { 'config.lua' }

lua54 'yes'
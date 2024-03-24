fx_version 'cerulean'

Description 'ac-jachtoverval created by nowiex'

author 'nw | nowiex'

game 'gta5'

dependency {
	'oxmysql',
	'ox_inventory',
	'es_extended'
}

shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'config.lua',
}

client_script {
	'client/client.lua',
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}

lua54 'yes'
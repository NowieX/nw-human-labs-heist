fx_version 'cerulean'

Description 'nw-human-labs created by nowiex'

author 'nw | nowiex'

game 'gta5'

ui_page "web/index.html"

dependency {
	'oxmysql',
	'ox_inventory',
	'es_extended'
}

shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'shared/config.lua',
}

client_script {
	'client/client.lua',
	'shared/scenes.lua',
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/server.lua',
}

files {
	"web/index.html",
	"web/script.js",
	"web/image/blueprint-background.png",
	"web/image/serum-image.PNG",
}

lua54 'yes'
name "Jim-Mining"
author "Jimathy"
version "v2.4.3"
description "Mining Script By Jimathy"
fx_version "cerulean"
game "gta5"

shared_scripts { 'config.lua', 'shared/*.lua', 'locales/*.lua', '@jim_bridge/functions.lua' }
server_script { 'server.lua' }
client_scripts { 'client.lua' }
dependency 'jim_bridge'

lua54 'yes'
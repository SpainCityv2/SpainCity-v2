shared_script '@WaveShield/resource/waveshield.lua' --this line was automatically written by WaveShield

 --this line was automatically written by WaveShield

 --this line was automatically written by WaveShield

 --this line was automatically written by WaveShield

 --this line was automatically written by WaveShield





fx_version 'cerulean'
use_fxv2_oal 'yes'

game 'common'
lua54 'yes'

description 'Sistema Policial para SpainCityRP'
author 'imsnaily'
twitter '@imsnaily'

shared_scripts {
    'core/sh_*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',

    'base/sv_*.lua',
    'base/modules/sv_*.lua'
}

client_scripts {
    'base/cl_*.lua',
    'base/modules/cl_*.lua'
}

dependencies {
    'ZCore',
}

ui_page 'nui/index.html'

files {
    'nui/*.html',
    'nui/js/*.js',
    'nui/css/*.styles.css',
    'nui/fonts/*.ttf',
}
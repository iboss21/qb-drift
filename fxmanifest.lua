fx_version 'cerulean'
games { 'gta5' }

author 'iBoss21'
description 'QBCore Drift XP System'
version '1.0.0'

client_script 'client/client.lua'
server_script 'server/server.lua'

shared_script 'config.lua'

-- new loop to update run smoother
--[[
```lua
RegisterNetEvent('QBCore:Client:EnteredVehicle', function()
    LoopHeliCam()
    LoopHeliCamExt()
end)
RegisterNetEvent('QBCore:Client:LeftVehicle', function()
    inHelicopter = false
end)
```
]]--
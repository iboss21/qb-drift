local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-driftxp:getXP', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        cb(Player.PlayerData.metadata['driftxp'] or 0)
    else
        cb(0)
    end
end)

RegisterServerEvent('qb-driftxp:updateXP')
AddEventHandler('qb-driftxp:updateXP', function(xp)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        Player.PlayerData.metadata['driftxp'] = xp
        Player.Functions.SetMetaData("driftxp", Player.PlayerData.metadata['driftxp'])
    end
end)

-- Command to switch to drift mode (/drift)
QBCore.Commands.Add("drift", "Switch to drift mode", {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('qb-driftxp:toggleDrift', src)
    end
end)

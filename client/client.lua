local QBCore = exports['qb-core']:GetCoreObject()
local Config = require('config')

local ped, vehicle
local driftMode = false
local lastDriftTime = 0

Citizen.CreateThread(function()
    while true do
        Wait(1)
        ped = GetPlayerPed(-1)

        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") ~= 1 and IsVehicleOnAllWheels(vehicle) and IsControlJustReleased(0, 21) and IsVehicleClassWhitelisted(GetVehicleClass(vehicle)) then
                    ToggleDrift(vehicle)
                end
                if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") < 90 then
                    SetVehicleEnginePowerMultiplier(vehicle, 0.0)
                else
                    if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") == 0.0 then
                        SetVehicleEnginePowerMultiplier(vehicle, 190.0)
                    else
                        SetVehicleEnginePowerMultiplier(vehicle, 100.0)
                    end
                end
            end
        end
    end
end)

function ToggleDrift(vehicle)
    local modifier = 1

    if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") > 90 then
        driftMode = true
    else
        driftMode = false
    end

    if driftMode then
        modifier = -1
        lastDriftTime = GetGameTimer()
    end

    for index, value in ipairs(Config.HandleMods) do
        SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1]) + value[2] * modifier)
    end

    if driftMode then
        PrintDebugInfo("stock")
        QBCore.Functions.Notify(Config.Messages.StandardMode, "primary")
    else
        PrintDebugInfo("drift")
        QBCore.Functions.Notify(Config.Messages.DriftMode, "primary")

        local currentTime = GetGameTimer()
        local timeDifference = (currentTime - lastDriftTime) / 1000

        if timeDifference >= 60 then
            -- Give the player XP
            local PlayerData = QBCore.Functions.GetPlayerData()
            PlayerData.metadata['driftxp'] = (PlayerData.metadata['driftxp'] or 0) + 1
            TriggerServerEvent('qb-driftxp:updateXP', PlayerData.metadata['driftxp'])

            lastDriftTime = currentTime
        end
    end
end

-- Server event to toggle drift mode
RegisterNetEvent('qb-driftxp:toggleDrift')
AddEventHandler('qb-driftxp:toggleDrift', function()
    local ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(vehicle, -1) == ped then
        ToggleDrift(vehicle)
    end
end)

function PrintDebugInfo(mode)
    ped = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(ped, false)
    print(mode)
    for index, value in ipairs(Config.HandleMods) do
        print(GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1]))
    end
end

function IsVehicleClassWhitelisted(vehicleClass)
    for index, value in ipairs(Config.VehicleClassWhitelist) do
        if value == vehicleClass then
            return true
        end
    end

    return false
end

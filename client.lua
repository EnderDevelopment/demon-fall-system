local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local demonFallActive = false

RegisterNetEvent('demonFallSystem:activateDemonFall')
AddEventHandler('demonFallSystem:activateDemonFall', function()
    demonFallActive = true
    Citizen.CreateThread(function()
        while demonFallActive do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            
            -- Auto kill mobs
            if Config.AutoKillMobs then
                local entities = GetGamePool('CPed')
                for _, entity in ipairs(entities) do
                    if not IsPedAPlayer(entity) and not IsEntityDead(entity) then
                        local entityCoords = GetEntityCoords(entity)
                        local distance = #(playerCoords - entityCoords)
                        
                        if distance <= Config.AutoKillMobsRadius then
                            SetEntityHealth(entity, 0)
                        end
                    end
                end
            end
            
            Citizen.Wait(Config.AutoKillMobsInterval * 1000)
        end
    end)

    Citizen.Wait(Config.DemonFallDuration * 1000)
    demonFallActive = false
end)

RegisterCommand('demonfall', function()
    TriggerServerEvent('demonFallSystem:activateDemonFall')
end, false)
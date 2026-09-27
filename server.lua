local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('demonFallSystem:checkCooldown', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier
    
    MySQL.Async.fetchScalar('SELECT last_used FROM demon_fall WHERE player_id = @player_id', {
        ['@player_id'] = playerId
    }, function(lastUsed)
        if lastUsed then
            local currentTime = os.time()
            local cooldownTime = os.time({year = lastUsed.year, month = lastUsed.month, day = lastUsed.day, hour = lastUsed.hour, min = lastUsed.min, sec = lastUsed.sec}) + Config.DemonFallCooldown
            
            if currentTime < cooldownTime then
                cb(false, cooldownTime - currentTime)
            else
                cb(true)
            end
        else
            cb(true)
        end
    end)
end)

RegisterNetEvent('demonFallSystem:activateDemonFall')
AddEventHandler('demonFallSystem:activateDemonFall', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.identifier
    
    ESX.TriggerServerCallback('demonFallSystem:checkCooldown', source, function(canActivate, cooldown)
        if canActivate then
            MySQL.Async.execute('INSERT INTO demon_fall (player_id) VALUES (@player_id) ON DUPLICATE KEY UPDATE last_used = CURRENT_TIMESTAMP', {
                ['@player_id'] = playerId
            }, function(rowsChanged)
                TriggerClientEvent('demonFallSystem:activateDemonFall', source)
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'You must wait ' .. cooldown .. ' seconds before using Demon Fall again.')
        end
    end)
end)
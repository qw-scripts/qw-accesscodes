local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateCallback('qw-accesscodes:server:checkAccessCode', function(source, cb, code, bankType)
    local src = source
    local result = MySQL.Sync.fetchAll('SELECT * FROM accesscodes WHERE code = @code', {
        ['@code'] = code
     })
     if result[1] then
        for _, v in pairs(result) do
            if bankType == v.bank then
                MySQL.Async.execute('DELETE FROM accesscodes WHERE code = @code', {
                    ['@code'] = v.code
                }, function(result) 
                    if result > 0 then
                        Wait(1000)
                        TriggerClientEvent('QBCore:Notify', src, 'Code is no longer usable', 'error')
                    end
                end)
                return cb(true)
            else
                TriggerClientEvent('QBCore:Notify', src, 'You can\'t use that code here', 'error')
            end
        end
    else
        return cb(false)
    end
end)

RegisterNetEvent('qw-accesscodes:server:generateAndRecieveCode', function(bankType) 
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    MySQL.Async.insert('INSERT INTO accesscodes (code, bank) VALUES (@code, @bank)', {
        ['@code'] = math.random(111111, 999999),
        ['@bank'] = bankType,
     }, function(id) 
        local result = MySQL.Sync.fetchAll('SELECT * FROM accesscodes WHERE id = @id', {
            ['@id'] = id
         })
         if result[1] then
            for _, v in pairs(result) do
                player.Functions.AddItem('accesscodes', 1, false, {
                    key = v.code,
                    name = v.bank
        
                })
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['accesscodes'], "add")
            end
         end
    end)
end)

RegisterNetEvent('qw-accesscodes:server:wipeCodes', function() 
    MySQL.Async.execute('DELETE FROM accesscodes', {}, function(result) 
        if result > 0 then
            print('Deleted ' .. result .. ' expired access codes')
         end
    end)
end)

QBCore.Commands.Add('giveAccessCode', 'Give access codes, admin only', {
    {
        name = 'playerid',
        help = 'ID of player to give access code'
    },
    {
        name = 'bank',
        help = 'name of bank / access code use'
    }
}, false, function(source, args) 

    local src = source
    local PlayerID =  tonumber(args[1])
    local player
    if type(args[2]) == "number" then
     return TriggerClientEvent('QBCore:Notify', src, 'Invalid Bank Type', "error")
    end
    if PlayerID then
        player = QBCore.Functions.GetPlayer(PlayerID)
        if not player or player == nil then
           return TriggerClientEvent('QBCore:Notify', src, 'invalid player ID', "error")
        end
     else
        player = QBCore.Functions.GetPlayer(src)
     end

     MySQL.Async.insert('INSERT INTO accesscodes (code, bank) VALUES (@code, @bank)', {
        ['@code'] = math.random(111111, 999999),
        ['@bank'] = args[2],
     }, function(id) 
        local result = MySQL.Sync.fetchAll('SELECT * FROM accesscodes WHERE id = @id', {
            ['@id'] = id
         })
         if result[1] then
            for _, v in pairs(result) do
                player.Functions.AddItem('accesscodes', 1, false, {
                    key = v.code,
                    name = v.bank
        
                })
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['accesscodes'], "add")
            end
         end
    end)

end, 'admin')
local QBCore = exports['qb-core']:GetCoreObject()

function GenerateAccessCode(bankType) 
    TriggerServerEvent('qw-accesscodes:server:generateAndRecieveCode', bankType)
end

exports('GenerateAccessCode', GenerateAccessCode)

function CreateCodeCheckZone(location, name, bankType, successEvent, failedEvent, menuLabel, menuIcon, requiredItem, keyboardHeader) 
    exports['qb-target']:AddCircleZone(name, location, 1, {
        name = name,
        debugPoly = false
    }, {
        options = {
            {
                num = 1,
                icon = menuIcon,
                label = menuLabel,
                item = requiredItem,
                action = function() 
                    local keyboard, code = exports['nh-keyboard']:Keyboard({
                        header = keyboardHeader,
                        rows = {"Code"}
                    })
                    if keyboard then
                        if code then
                            QBCore.Functions.TriggerCallback('qw-accesscodes:server:checkAccessCode', function(success) 
                                if success then
                                    TriggerEvent(successEvent)
                                else
                                    TriggerEvent(failedEvent)
                                end
                            end, code, bankType)
                        end
                    end
                end
            },
        },
        distance = 2.5
    })
end

exports('CreateCodeCheckZone', CreateCodeCheckZone)

function WipeCodes() 
    TriggerServerEvent('qw-accesscodes:server:wipeCodes')
end

exports('WipeCodes', WipeCodes)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        WipeCodes()
    end
end)
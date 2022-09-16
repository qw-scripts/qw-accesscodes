# qw-accesscodes

## Deps

- <a href="https://github.com/qbcore-framework/qb-target" target="_blank">qb-target</a>
- <a href="https://github.com/nerohiro/nh-keyboard" target="_blank">nh-keyboard</a>
- <a href="https://github.com/qbcore-framework" target="_blank">QBCore</a>
- <a href="https://github.com/overextended/oxmysql" target="_blank">oxmysql</a>

## Exported Functions

```lua
exports['qw-accesscodes']:GenerateAccessCode(bankType) -- Generates and gives the player an Access Code
exports['qw-accesscodes']:CreateCodeCheckZone(location, name, bankType, successEvent, failedEvent, menuLabel, menuIcon, requiredItem, keyboardHeader) -- Adds a PolyZone where you can enter a code and trigger events based on failed or successful codes
exports['qw-accesscodes']:WipeCodes() -- Wipes all codes from the database, NOTE: this already happens everytime the script starts, this is so codes are one time use
```

## Example of Using the CreateCodeCheckZone export
```lua
RegisterNetEvent('qw-vaultcodes:client:successfulCode', function() 
    QBCore.Functions.Notify('Code Worked', 'success')
end)

RegisterNetEvent('qw-vaultcodes:client:failedCode', function() 
    QBCore.Functions.Notify('Code Didn\'t work', 'error')
end)

CreateThread(function() 
    exports['qw-accesscodes']:CreateCodeCheckZone(vector3(254.16, 207.63, 106.29), 'bankcomputer1', 'computer', 'qw-vaultcodes:client:successfulCode', 'qw-vaultcodes:client:failedCode', 'Enter the Code', 'fa-solid da-circle', 'hacking_phone', 'Password')
    exports['qw-accesscodes']:CreateCodeCheckZone(vector3(248.49, 209.65, 106.29), 'bankcomputer2', 'computer', 'qw-vaultcodes:client:successfulCode', 'qw-vaultcodes:client:failedCode', 'Enter the Code', 'fa-solid da-circle', 'hacking_phone', 'Password')
end)
```

## Added Commands

```txt
/giveAccessCode [playerID] [accessCodeType] (Admin Only)
```

# Install

## [qb]/qb-inventory/html/js/app.js (around line 546)

```javascript
else if (itemData.name == "accesscodes") {
            $(".item-info-title").html("<p>" + itemData.label + "</p>");
            $(".item-info-description").html("<p> Key: " + itemData.info.key + " | name: " + itemData.info.name + "</p>" + "<br />" + "<p>" +
            itemData.description +
            "</p>");
        }
```

## [qb]/qb-inventory/html/images

- Add ticket.png image to this directory

## [qb]/qb-core/shared/items.lua

```lua
['accesscodes'] 				 = {['name'] = 'accesscodes', 			    	['label'] = 'Access Codes', 			['weight'] = 1000, 	    ['type'] = 'item', 		['image'] = 'ticket.png', 				['unique'] = true, 		['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Access codes for certain heists. One time use, lasts a single tsunami.'},
```

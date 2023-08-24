local QBCore = exports['qb-core']:GetCoreObject()



for index, item in ipairs(KVL['Sell']) do
    RegisterServerEvent('sellItems_' .. index)
    AddEventHandler('sellItems_' .. index, function(count)
        local itemIndex = index
        local player = source
        local xPlayer = QBCore.Functions.GetPlayers(player)

        if not KVL['Sell'][itemIndex] then
            TriggerClientEvent('ox_lib:notify', player, { type = 'error', description = ''..KVL['Locales']['invaliditem']..' ' })
            return
        end

        local itemName = KVL['Sell'][itemIndex].name
        local itemLabel = KVL['Sell'][itemIndex].label
        local itemPrice = KVL['Sell'][itemIndex].price

        if xPlayer.Functions.GetItemByName(itemName).count >= count then
            xPlayer.Functions.RemoveItem(itemName, count)
            xPlayer.Functions.AddMoney('cash', itemPrice * count, "Dealer Payment")
            TriggerClientEvent('ox_lib:notify', player, { type = 'success', description = ' '..KVL['Locales']['solditem']..' '..count..' '..itemLabel..' ' })
        else
            TriggerClientEvent('ox_lib:notify', player, { type = 'error', description = ''..KVL['Locales']['noitemtosell']..' ' })
        end
    end)
end

for index, item in ipairs(KVL['Buy']) do
    RegisterServerEvent('buyItems_' .. index)
    AddEventHandler('buyItems_' .. index, function(count)
        local itemIndex = index
        local player = source
        local xPlayer = QBCore.Functions.GetPlayers(player)

        if not KVL['Buy'][itemIndex] then
            TriggerClientEvent('ox_lib:notify', player, { type = 'error', description = ''..KVL['Locales']['invaliditem']..' ' })
            return
        end

        local itemName = KVL['Buy'][itemIndex].name
        local itemLabel = KVL['Buy'][itemIndex].label
        local itemPrice = KVL['Buy'][itemIndex].price

        local totalPrice = itemPrice * count

        if xPlayer.Functions.GetMoney('cash') >= totalPrice then
            xPlayer.Functions.RemoveMoney('cash', totalPrice, 'Dealer')
            xPlayer.Functions.AddItem(itemName, count)
            TriggerClientEvent('ox_lib:notify', player, { type = 'success', description = ' '..KVL['Locales']['boughtitem']..' '..count..' '..itemLabel..' ' })
        else
            TriggerClientEvent('ox_lib:notify', player, { type = 'error', description = ''..KVL['Locales']['insufficientmoney']..' ' })
        end
    end)
end



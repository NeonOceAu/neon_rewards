local framework = nil
local playerLocks = {} -- This table will store the player locks to prevent multiple reward claims at the same time

if Config.Framework == 'QB' then
    framework = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'ESX' then
    framework = exports['es_extended']:getSharedObject()
end

local function loadPlayerRewards(identifier, callback)
    MySQL.Async.fetchScalar('SELECT last_claim_time FROM neon_rewards WHERE citizenid = @citizenid', {
        ['@citizenid'] = identifier
    }, function(lastClaimTime)
        callback(lastClaimTime)
    end)
end

-- Save the claim time for the player
local function savePlayerRewards(identifier, lastClaimTime, callback)
    MySQL.Async.execute('INSERT INTO neon_rewards (citizenid, last_claim_time) VALUES (@citizenid, @lastClaimTime) ON DUPLICATE KEY UPDATE last_claim_time = @lastClaimTime', {
        ['@citizenid'] = identifier,
        ['@lastClaimTime'] = lastClaimTime
    }, function(affectedRows)
        callback(affectedRows > 0)
    end)
end

RegisterServerEvent('ag_rewards:claimReward')
AddEventHandler('ag_rewards:claimReward', function()
    local src = source
    local player = nil
    local identifier = nil
    if playerLocks[src] then

        return
    end

    playerLocks[src] = true

    if Config.Framework == 'QB' then
        player = framework.Functions.GetPlayer(src)
        identifier = player.PlayerData.citizenid
    elseif Config.Framework == 'ESX' then
        player = framework.GetPlayerFromId(src)
        identifier = player.identifier
    end

    if not player then
        playerLocks[src] = nil
        return
    end

    loadPlayerRewards(identifier, function(lastClaimTime)
        local currentTime = os.time()

        if lastClaimTime and (currentTime - tonumber(lastClaimTime)) < Config.Cooldown then
            TriggerClientEvent('ag_rewards:showNotification', src, 'You can only claim your reward once every ' .. (Config.Cooldown / 3600) .. ' hours!')
            playerLocks[src] = nil -- Release the lock if the cooldown has not expired
            return
        end

        savePlayerRewards(identifier, currentTime, function(success)
            if success then
                local itemsReceived = {}

                for _, reward in pairs(Config.DefaultRewards) do
                    local amount = math.random(reward.min, reward.max)

                    local added = nil
                    if Config.Framework == 'QB' then
                        added = exports.ox_inventory:AddItem(src, reward.item, amount)
                    elseif Config.Framework == 'ESX' then
                        added = player.addInventoryItem(reward.item, amount)
                    end

                    if added then
                        table.insert(itemsReceived, reward.item .. " x" .. amount)
                    end
                end

                local chanceReward = getChanceReward()
                if chanceReward then
                    local amount = math.random(chanceReward.min, chanceReward.max)

                    local added = nil

                    added = exports.ox_inventory:AddItem(src, chanceReward.item, amount)

                    if added then
                        table.insert(itemsReceived, chanceReward.item .. " x" .. amount)
                    end
                end

                TriggerClientEvent('ag_rewards:showNotification', src, 'You received your daily reward!')
                SendDiscordLog(itemsReceived, src)
            else

                TriggerClientEvent('ag_rewards:showNotification', src, 'Failed to update reward claim, please try again.')
            end

            playerLocks[src] = nil
        end)
    end)
end)

-- Function to select a random chance reward
function getChanceReward()
    local totalChance = 100
    local randomNum = math.random(1, totalChance)
    local cumulativeChance = 0

    for _, reward in ipairs(Config.ChanceRewards) do
        cumulativeChance = cumulativeChance + reward.chance
        if randomNum <= cumulativeChance then
            return reward
        end
    end

    return nil
end
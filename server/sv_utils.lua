local webhookUrl = 'REPLACE_WITH_YOUR_WEBHOOK' -- Replace with your actual Discord Webhook URL

function SendDiscordLog(itemsSold, player)
    local playerName = GetPlayerName(player)

    local itemsList = table.concat(itemsSold, "\n")

    local embed = {
        {
            ["title"] = "Rewards Claimed", 
            ["color"] = 16711680,
            ["fields"] = {
                {
                    ["name"] = "Items Received", 
                    ["value"] = itemsList,
                    ["inline"] = true
                },
                {
                    ["name"] = "Player", 
                    ["value"] = playerName, 
                    ["inline"] = true
                }
            },
            ["footer"] = {
                ["text"] = "Claimed at: " .. os.date("%Y-%m-%d %H:%M:%S")
            }
        }
    }

    PerformHttpRequest(webhookUrl, function(err, text, headers)
    end, 'POST', json.encode({username = "Reward Logs", embeds = embed}), { ['Content-Type'] = 'application/json' }) 
end
Config = {}

Config.Cooldown = 86400 -- Default is 24 hours in seconds

Config.Logging = true -- Set to false to disable discord logs. Make sure to set webhook in server/sv_utils.lua

Config.Framework = 'QB' -- Options: 'ESX' & 'QB'

-- Locations for the daily reward
Config.Locations = {
    { x = 1126.7190, y = -478.7161, z = 65.9945},
    { x = 223.45, y = 778.90, z = 31.32 }
}

-- Blip settings for the map
Config.Blip = {
    sprite = 586,
    color = 29,
    scale = 0.8,
    text = "Daily Reward"
}

-- Default rewards configuration
Config.DefaultRewards = {
    { item = "cash", min = 1000, max = 1800 }
}

-- Chance-based rewards
Config.ChanceRewards = {
    { item = "lockpick", chance = 60, min = 1, max = 2 },
    { item = "diamond", chance = 40, min = 1, max = 1 },
    { item = "gold_bar", chance = 20, min = 1, max = 1 },
    { item = "rare_item", chance = 5, min = 1, max = 1 }
}

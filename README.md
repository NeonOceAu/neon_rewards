
# Daily Rewards Script

This is a FiveM script that allows players to claim daily rewards. The script supports both the ESX and QBCore frameworks, and integrates with `ox_inventory` for item management. Players can claim a default reward, with a chance of receiving additional items based on configuration.

## Features
- Supports both **ESX** and **QBCore** frameworks.
- Adds a blip on the map where players can claim their rewards.
- Configurable cooldown time to restrict how often players can claim rewards.
- Default rewards plus chance-based rewards with customizable items and chances.
- **ox_inventory** integration for item management.
- Discord webhook logging for rewards claimed (optional).

## Requirements
- **ox_inventory** for item management.
- **MySQL-Async** for saving and loading player's last claim time.
- Either **ESX** or **QBCore** framework.

## Installation
1. Clone or download this repository into your FiveM server's resources folder.
2. Ensure `ox_inventory` is installed and running.
3. Add the following line to your `server.cfg` file:
   ```
   ensure neon_rewards
   ```
4. Configure the `config.lua` file according to your needs.
   - Set the correct framework (`ESX` or `QB`).
   - Define default rewards and chance-based rewards.
   - Adjust the cooldown period as needed (in seconds).

## Configuration

The script is highly configurable through the `config.lua` file. Below are the key configuration options:

### Config Framework
Choose between `ESX` and `QB` frameworks:
```lua
Config.Framework = 'ESX'  -- Set to 'QB' if using QBCore
```

### Config Cooldown
Define how long players must wait before claiming their reward again (in seconds):
```lua
Config.Cooldown = 86400  -- 24 hours
```

### Default Rewards
Set the items that players will always receive when claiming the reward:
```lua
Config.DefaultRewards = {
    { item = "cash", min = 1000, max = 1800 }
}
```

### Chance-Based Rewards
Configure the chance-based rewards that players have a chance to receive:
```lua
Config.ChanceRewards = {
    { item = "phone", chance = 80, min = 1, max = 1 },
    { item = "lockpick", chance = 60, min = 1, max = 2 },
    { item = "diamond", chance = 40, min = 1, max = 1 },
    { item = "gold_bar", chance = 20, min = 1, max = 1 },
    { item = "rare_item", chance = 5, min = 1, max = 1 }
}
```

### Logging
Enable or disable Discord logging:
```lua
Config.Logging = true  -- Set to 'false' to disable logging
```
You can configure the Discord webhook URL in the `sv_utils.lua` file.

## How it Works
- Players visit a defined location (configured in `config.lua`) to claim their daily reward.
- The script checks if the player is eligible based on the last time they claimed their reward.
- Default rewards are granted automatically.
- Chance-based rewards are calculated using a random number generator, and items are added based on the configured chances.
- The player's claim time is saved in the database to enforce the cooldown period.
- Optionally, rewards claimed can be logged to a Discord webhook.

## Issues
If the script doesn't add the chance-based rewards, ensure:
- The item exists in the `ox_inventory` or `ESX` database.
- The correct item name is used in the configuration.

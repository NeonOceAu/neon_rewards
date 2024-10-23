local framework = nil

-- Framework detection
if Config.Framework == 'QB' then
    framework = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'ESX' then
    framework = exports['es_extended']:getSharedObject()
end

CreateThread(function()
    for index, location in pairs(Config.Locations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, Config.Blip.sprite)
        SetBlipColour(blip, Config.Blip.color)
        SetBlipScale(blip, Config.Blip.scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.text)
        EndTextCommandSetBlipName(blip)

        exports.ox_target:addBoxZone({
            coords = vector3(location.x, location.y, location.z),
            size = vector3(3.5, 1.5, 1.5),
            rotation = 0,
            debug = false,
            options = {
                {
                    event = "ag_rewards:clientClaimReward",
                    icon = "fas fa-gift",
                    label = "Claim Reward",
                }
            }
        })
    end
end)

RegisterNetEvent('ag_rewards:showNotification')
AddEventHandler('ag_rewards:showNotification', function(msg)
    if Config.Framework == 'QB' then
        framework.Functions.Notify(msg, 'success')
    elseif Config.Framework == 'ESX' then
        ESX.ShowNotification(msg)
    end
end)

RegisterNetEvent('ag_rewards:clientClaimReward')
AddEventHandler('ag_rewards:clientClaimReward', function()
    TriggerServerEvent('ag_rewards:claimReward')
end)


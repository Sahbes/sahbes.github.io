local safemode = true

superJump             = false
fastRun               = false
crossHair             = false
noClip                = false
rainbowVehicle        = false
xuinaActivated        = false
local NoClipEntity    = false
local FollowCamMode   = true
local index           = 1
local CurrentSpeed    = 2
local WaypointCoords  = 0
local wp              = false
local height          = 0
local entity          = nil

aimbotOnlyPlayers = true
aimbotIgnoreVehicles = false
aimbot = false
aimbotRange = 5.0
aimbotXAxis = 0.0
aimbotYAxis = 0.0
aimbotZAxis = -0.1

local dump = false
local godmodeToggle = false
local enablecontrolsToggle = false

Citizen.CreateThread( function()
  while true do 
    Citizen.Wait(0)
    if enablecontrolsToggle == true then 
      EnableAllControlActions(0)
      EnableAllControlActions(1)
      EnableAllControlActions(2)
    end
  end
end)

local allWeapons = {
"WEAPON_KNIFE",
"WEAPON_KNUCKLE",
"WEAPON_NIGHTSTICK",
"WEAPON_HAMMER",
"WEAPON_BAT",
"WEAPON_GOLFCLUB",
"WEAPON_CROWBAR",
"WEAPON_BOTTLE",
"WEAPON_DAGGER",
"WEAPON_HATCHET",
"WEAPON_MACHETE",
"WEAPON_FLASHLIGHT",
"WEAPON_SWITCHBLADE",
"WEAPON_PISTOL",
"WEAPON_PISTOL_MK2",
"WEAPON_COMBATPISTOL",
"WEAPON_APPISTOL",
"WEAPON_PISTOL50",
"WEAPON_SNSPISTOL",
"WEAPON_HEAVYPISTOL",
"WEAPON_VINTAGEPISTOL",
"WEAPON_STUNGUN",
"WEAPON_FLAREGUN",
"WEAPON_MARKSMANPISTOL",
"WEAPON_REVOLVER",
"WEAPON_MICROSMG",
"WEAPON_SMG",
"WEAPON_SMG_MK2",
"WEAPON_ASSAULTSMG",
"WEAPON_MG",
"WEAPON_COMBATMG",
"WEAPON_COMBATMG_MK2",
"WEAPON_COMBATPDW",
"WEAPON_GUSENBERG",
"WEAPON_MACHINEPISTOL",
"WEAPON_ASSAULTRIFLE",
"WEAPON_ASSAULTRIFLE_MK2",
"WEAPON_CARBINERIFLE",
"WEAPON_CARBINERIFLE_MK2",
"WEAPON_ADVANCEDRIFLE",
"WEAPON_SPECIALCARBINE",
"WEAPON_BULLPUPRIFLE",
"WEAPON_COMPACTRIFLE",
"WEAPON_PUMPSHOTGUN",
"WEAPON_SAWNOFFSHOTGUN",
"WEAPON_BULLPUPSHOTGUN",
"WEAPON_ASSAULTSHOTGUN",
"WEAPON_MUSKET",
"WEAPON_HEAVYSHOTGUN",
"WEAPON_DBSHOTGUN",
"WEAPON_SNIPERRIFLE",
"WEAPON_HEAVYSNIPER",
"WEAPON_HEAVYSNIPER_MK2",
"WEAPON_MARKSMANRIFLE",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_RPG",
"WEAPON_STINGER",
"WEAPON_FIREWORK",
"WEAPON_HOMINGLAUNCHER",
"WEAPON_GRENADE",
"WEAPON_STICKYBOMB",
"WEAPON_PROXMINE",
"WEAPON_BZGAS",
"WEAPON_SMOKEGRENADE",
"WEAPON_MOLOTOV",
"WEAPON_FIREEXTINGUISHER",
"WEAPON_PETROLCAN",
"WEAPON_SNOWBALL",
"WEAPON_FLARE",
"WEAPON_BALL",
"WEAPON_MINIGUN"
}

function TeleportToWaypoint()
  Citizen.CreateThread(function()
    if DoesBlipExist(GetFirstBlipInfoId(8)) then
      local blipIterator = GetBlipInfoIdIterator(8)
      local blip = GetFirstBlipInfoId(8, blipIterator)
      WaypointCoords = Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ResultAsVector()) --Thanks To Briglair [forum.FiveM.net]
      wp = true
      local zHeigt = 0.0
      height = 1000.0
      while true do
        Citizen.Wait(0)
        if wp then
          if
          IsPedInAnyVehicle(GetPlayerPed(-1), 0) and
          (GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), 0), -1) == GetPlayerPed(-1))
          then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1), 0)
          else
            entity = GetPlayerPed(-1)
          end

          SetEntityCoords(entity, WaypointCoords.x, WaypointCoords.y, height)
          FreezeEntityPosition(entity, true)
          local Pos = GetEntityCoords(entity, true)

          if zHeigt == 0.0 then
            height = height - 25.0
            SetEntityCoords(entity, Pos.x, Pos.y, height)
            bool, zHeigt = GetGroundZFor_3dCoord(Pos.x, Pos.y, Pos.z, 0)
          else
            SetEntityCoords(entity, Pos.x, Pos.y, zHeigt)
            FreezeEntityPosition(entity, false)
            wp = false
            height = 1000.0
            zHeigt = 0.0
            break
          end
        end
      end
    else
    end
  end)
end

function TeleportToNearestVehicle()
  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    local playerPedPos = GetEntityCoords(playerPed, true)
    local NearestVehicle = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 4)
    local NearestVehiclePos = GetEntityCoords(NearestVehicle, true)
    local NearestPlane = GetClosestVehicle(GetEntityCoords(playerPed, true), 1000.0, 0, 16384)
    local NearestPlanePos = GetEntityCoords(NearestPlane, true)
    Citizen.Wait(1000)
    if (NearestVehicle == 0) and (NearestPlane == 0) then
    elseif (NearestVehicle == 0) and (NearestPlane ~= 0) then
      if IsVehicleSeatFree(NearestPlane, -1) then
        SetPedIntoVehicle(playerPed, NearestPlane, -1)
        SetVehicleAlarm(NearestPlane, false)
        SetVehicleDoorsLocked(NearestPlane, 1)
        SetVehicleNeedsToBeHotwired(NearestPlane, false)
      else
        local driverPed = GetPedInVehicleSeat(NearestPlane, -1)
        ClearPedTasksImmediately(driverPed)
        SetEntityAsMissionEntity(driverPed, 1, 1)
        DeleteEntity(driverPed)
        SetPedIntoVehicle(playerPed, NearestPlane, -1)
        SetVehicleAlarm(NearestPlane, false)
        SetVehicleDoorsLocked(NearestPlane, 1)
        SetVehicleNeedsToBeHotwired(NearestPlane, false)
      end
    elseif (NearestVehicle ~= 0) and (NearestPlane == 0) then
      if IsVehicleSeatFree(NearestVehicle, -1) then
        SetPedIntoVehicle(playerPed, NearestVehicle, -1)
        SetVehicleAlarm(NearestVehicle, false)
        SetVehicleDoorsLocked(NearestVehicle, 1)
        SetVehicleNeedsToBeHotwired(NearestVehicle, false)
      else
        local driverPed = GetPedInVehicleSeat(NearestVehicle, -1)
        ClearPedTasksImmediately(driverPed)
        SetEntityAsMissionEntity(driverPed, 1, 1)
        DeleteEntity(driverPed)
        SetPedIntoVehicle(playerPed, NearestVehicle, -1)
        SetVehicleAlarm(NearestVehicle, false)
        SetVehicleDoorsLocked(NearestVehicle, 1)
        SetVehicleNeedsToBeHotwired(NearestVehicle, false)
      end
    elseif (NearestVehicle ~= 0) and (NearestPlane ~= 0) then
      if Vdist(NearestVehiclePos.x, NearestVehiclePos.y, NearestVehiclePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) < Vdist(NearestPlanePos.x, NearestPlanePos.y, NearestPlanePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
        if IsVehicleSeatFree(NearestVehicle, -1) then
          SetPedIntoVehicle(playerPed, NearestVehicle, -1)
          SetVehicleAlarm(NearestVehicle, false)
          SetVehicleDoorsLocked(NearestVehicle, 1)
          SetVehicleNeedsToBeHotwired(NearestVehicle, false)
        else
          local driverPed = GetPedInVehicleSeat(NearestVehicle, -1)
          ClearPedTasksImmediately(driverPed)
          SetEntityAsMissionEntity(driverPed, 1, 1)
          DeleteEntity(driverPed)
          SetPedIntoVehicle(playerPed, NearestVehicle, -1)
          SetVehicleAlarm(NearestVehicle, false)
          SetVehicleDoorsLocked(NearestVehicle, 1)
          SetVehicleNeedsToBeHotwired(NearestVehicle, false)
        end
      elseif Vdist(NearestVehiclePos.x, NearestVehiclePos.y, NearestVehiclePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) > Vdist(NearestPlanePos.x, NearestPlanePos.y, NearestPlanePos.z, playerPedPos.x, playerPedPos.y, playerPedPos.z) then
        if IsVehicleSeatFree(NearestPlane, -1) then
          SetPedIntoVehicle(playerPed, NearestPlane, -1)
          SetVehicleAlarm(NearestPlane, false)
          SetVehicleDoorsLocked(NearestPlane, 1)
          SetVehicleNeedsToBeHotwired(NearestPlane, false)
        else
          local driverPed = GetPedInVehicleSeat(NearestPlane, -1)
          ClearPedTasksImmediately(driverPed)
          SetEntityAsMissionEntity(driverPed, 1, 1)
          DeleteEntity(driverPed)
          SetPedIntoVehicle(playerPed, NearestPlane, -1)
          SetVehicleAlarm(NearestPlane, false)
          SetVehicleDoorsLocked(NearestPlane, 1)
          SetVehicleNeedsToBeHotwired(NearestPlane, false)
        end
      end
    end
  end)
end

function TeleportToCoords(x, y, z)
    local entity
    if x ~= "" and y ~= "" and z ~= "" then
        if IsPedInAnyVehicle(GetPlayerPed(-1),0) and GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1),0),-1)==GetPlayerPed(-1) then
            entity = GetVehiclePedIsIn(GetPlayerPed(-1),0)
        else
            entity = PlayerPedId()
        end
        if entity then
            SetEntityCoords(entity, x + 0.5, y + 0.5, z + 0.5, 1,0,0,1)
        end
    else
    end
end

function mitoticDivision()
  Citizen.CreateThread(function()
    for i=1,5 do
      ClonePedEx(GetPlayerPed(-1), 0, true, true, true)
      Citizen.Wait(0)
    end
  end)
end

function mitoticDivisionCrashEveryone()
  Citizen.CreateThread(function()
    for i=1,9999 do
      ClonePedEx(GetPlayerPed(-1), 0, true, true, true)
      Citizen.Wait(100)
    end
  end)
end

function ghostDriver()
  local playerPed = GetPlayerPed(-1)
  Citizen.InvokeNative(0xF9ACF4A08098EA25, playerPed, true)
end

function GetClosestPed()
      local sleep = 500
      local playerPed = PlayerPedId()
      local playerPos = GetEntityCoords(playerPed)
      local handle, ped = FindFirstPed()
      repeat success, ped = FindNextPed(handle)
      local distance = GetDistanceBetweenCoords(pedPos, playerPos, true)
      if distance <= 1000.0 then
          return ped
      end

      until not success EndFindPed(handle)
      Citizen.Wait(sleep)
end

function GetClosestPedForAiming()
      local found = false

      local sleep = 0
      local playerPed = PlayerPedId()
      local isOK, targettedEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())
      if( not isOK ) then return found end
      if( aimbotOnlyPlayers ) then
        if not IsPedAPlayer(targettedEntity) then
          return found
        end
      end
      if( aimbotIgnoreVehicles ) then
        if IsEntityAVehicle(targettedEntity) then
          return found
        end
      end
      local playerPos = GetEntityCoords(targettedEntity, true)
      local handle, ped = FindFirstPed()
      repeat success, ped = FindNextPed(handle)
      local pedPos = GetEntityCoords(ped, true)
      local distance = GetDistanceBetweenCoords(pedPos, playerPos, true)

      if distance <= (aimbotRange + 0.0) and GetGroundZFor_3dCoord(pedPos.x, pedPos.y, pedPos.z) and not IsPedDeadOrDying(ped, 1) then
        found = ped
      end

      until not success EndFindPed(handle)
      Citizen.Wait(sleep)

      return found
end


function TeleportToNearestPed()
  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    local playerPedPos = GetEntityCoords(playerPed, true)
    local NearestPed = GetClosestPed()
    local NearestPedPos = GetEntityCoords(NearestPed, true)
    TeleportToCoords(NearestPedPos.x, NearestPedPos.y, NearestPedPos.z)
  end)
end

function rgb(l)
    local m = {}
    local n = GetGameTimer() / 200
    m.r = math.floor(math.sin(n * l + 0) * 127 + 128)
    m.g = math.floor(math.sin(n * l + 2) * 127 + 128)
    m.b = math.floor(math.sin(n * l + 4) * 127 + 128)
    return m
end

function AutoFarmGlife()
  Citizen.CreateThread(function()
    local NearestPed = GetClosestPed()
    Citizen.Wait(1)
    --RequestControlOnce(NearestPed)
    SetEntityHealth(NearestPed, 0)
    SetEntityCollision(NearestPed, false, false)
    SetEntityCoords(NearestPed, GetEntityCoords(PlayerPedId()))
  end)
end

function XpBotGlife()
  Citizen.CreateThread(function()
    local NearestPed = GetClosestPed()
    SetEntityHealth(NearestPed, 100)
    SetEntityCoords(NearestPed, GetOffsetFromEntityInWorldCoords(PlayerPedId(-1), 3.0, 3.0, 0.5))
    FreezeEntityPosition(NearestPed, true)
    IsEntityAttachedToEntity(NearestPed, PlayerPedId(), GetEntityCoords(PlayerPedId(-1), 3.0, 3.0, 0.5))

    local d_ = GetEntityCoords(NearestPed)
    local e0 = DoesEntityExist(NearestPed)
    local dO = IsPlayerDead(NearestPed)
    local e1 = GetPedBoneCoords(NearestPed, 31086, 0, 0, 0)

    ShootSingleBulletBetweenCoords(
    d_.x,
    d_.y,
    d_.z + 3.0,
    e1.x,
    e1.y,
    e1.z,
    9000,
    0,
    GetHashKey("weapon_pistol"),
    PlayerPedId(),
    true,
    false,
    9000.0
  )

  ShootSingleBulletBetweenCoords(
  d_.x,
  d_.y + 3.0,
  d_.z,
  e1.x,
  e1.y,
  e1.z,
  9000,
  0,
  GetHashKey("weapon_pistol"),
  PlayerPedId(),
  true,
  false,
  9000.0
)
ShootSingleBulletBetweenCoords(
d_.x,
d_.y,
d_.z + 3.0,
e1.x,
e1.y,
e1.z,
9000,
0,
GetHashKey("weapon_pistol"),
PlayerPedId(),
true,
false,
9000.0
)
ShootSingleBulletBetweenCoords(
d_.x,
d_.y + 3.0,
d_.z,
e1.x,
e1.y,
e1.z,
9000,
0,
GetHashKey("weapon_pistol"),
PlayerPedId(),
true,
false,
9000.0
)
ShootSingleBulletBetweenCoords(
d_.x,
d_.y,
d_.z + 3.0,
e1.x,
e1.y,
e1.z,
9000,
0,
GetHashKey("weapon_pistol"),
PlayerPedId(),
true,
false,
9000.0
)
ShootSingleBulletBetweenCoords(
d_.x,
d_.y + 3.0,
d_.z,
e1.x,
e1.y,
e1.z,
9000,
0,
GetHashKey("weapon_pistol"),
PlayerPedId(),
true,
false,
9000.0
)
ShootSingleBulletBetweenCoords(
d_.x,
d_.y,
d_.z + 3.0,
e1.x,
e1.y,
e1.z,
9000,
0,
GetHashKey("weapon_pistol"),
PlayerPedId(),
true,
false,
9000.0
)
ShootSingleBulletBetweenCoords(
d_.x,
d_.y + 3.0,
d_.z,
e1.x,
e1.y,
e1.z,
9000,
0,
GetHashKey("weapon_pistol"),
PlayerPedId(),
true,
false,
9000.0
)
end)
end

FiveX.OnXuiMessage(function(message)
  message = json.decode(message)
  if(message.xuinaFrontendActive ~= nil) then
    xuinaActivated = message.xuinaFrontendActive
  elseif(message.superJump ~= nil) then
    superJump = message.superJump
  elseif (message.fastRun ~= nil) then
    fastRun = message.fastRun
  elseif (message.thermalVision ~= nil) then
    if(message.thermalVision) then
      SetSeethrough(true)
    else
      SetSeethrough(false)
    end
  elseif (message.nightVision ~= nil) then
    if(message.nightVision) then
      SetNightvision(true)
    else
      SetNightvision(false)
    end
  elseif (message.crossHair ~= nil) then
    crossHair = message.crossHair
  elseif (message.noClip ~= nil) then
    if not noClip then
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            NoClipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
        else
            NoClipEntity = PlayerPedId()
        end

        SetEntityAlpha(NoClipEntity, 51, 0)
        if(NoClipEntity ~= PlayerPedId()) then
            SetEntityAlpha(PlayerPedId(), 51, 0)
        end
    else
        ResetEntityAlpha(NoClipEntity)
        if(NoClipEntity ~= PlayerPedId()) then
            ResetEntityAlpha(PlayerPedId())
        end
    end

    SetEntityCollision(NoClipEntity, noClip, noClip)
    FreezeEntityPosition(NoClipEntity, not noClip)
    SetEntityInvincible(NoClipEntity, not noClip)
    SetEntityVisible(NoClipEntity, noClip, not noClip);
    SetEveryoneIgnorePlayer(PlayerPedId(), not noClip);
    SetPoliceIgnorePlayer(PlayerPedId(), not noClip);
    noClip = message.noClip

  elseif(message.spawnSingleWeapon ~= nil) then
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(message.spawnSingleWeapon), 999999, false, true)
    SetPedAmmo(GetPlayerPed(-1), GetHashKey(message.spawnSingleWeapon), 999999)
  elseif(message.giveAllWeapons ~= nil) then
    for i = 1, #allWeapons do
        GiveWeaponToPed(PlayerPedId(), GetHashKey(allWeapons[i]), 1000, false, false)
    end
  elseif(message.removeAllWeapons ~= nil) then
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
  elseif(message.newCarColor ~= nil) then
    SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), tonumber(message.newCarColor.r), tonumber(message.newCarColor.g), tonumber(message.newCarColor.b))
  elseif(message.newCarSecondaryColor ~= nil) then
    SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), tonumber(message.newCarSecondaryColor.r), tonumber(message.newCarSecondaryColor.g), tonumber(message.newCarSecondaryColor.b))
  elseif(message.teleportToWaypoint ~= nil) then
    TeleportToWaypoint()
  elseif(message.teleportToNearestVehicle ~= nil) then
    TeleportToNearestVehicle()
  elseif(message.teleportToNearestPed ~= nil) then
    TeleportToNearestPed()
  elseif(message.repairVehicle ~= nil) then
    SetVehicleFixed(GetVehiclePedIsIn(GetPlayerPed(-1), false))
    SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0.0)
    SetVehicleLights(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
    SetVehicleBurnout(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
    Citizen.InvokeNative(0x1FD09E7390A74D54, GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
  elseif(message.repairEngineOnly ~= nil) then
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    SetVehicleUndriveable(veh,false)
    SetVehicleEngineHealth(veh, 1000.0)
    SetVehiclePetrolTankHealth(veh, 1000.0)
    healthEngineLast=1000.0
    healthPetrolTankLast=1000.0
    SetVehicleEngineOn(veh, true, false )
    SetVehicleOilLevel(veh, 1000.0)
  elseif(message.rainbowVehicle ~= nil) then
    rainbowVehicle = message.rainbowVehicle
  elseif(message.glifeAutoFarm ~= nil) then
    for i=1,50 do
      AutoFarmGlife()
    end
  elseif(message.glifeXpBot ~= nil) then
    for i=1,50 do
      XpBotGlife()
    end
  elseif(message.mitoticDivision ~=nil) then
    mitoticDivision()
  elseif(message.mitoticDivisionCrash ~=nil) then
    mitoticDivisionCrashEveryone()
  elseif(message.aimbotIgnoreVehicles ~= nil) then
    aimbotIgnoreVehicles = message.aimbotIgnoreVehicles
  elseif(message.aimbotOnlyPlayers ~= nil) then
    aimbotOnlyPlayers = message.aimbotOnlyPlayers
  elseif(message.aimbot ~= nil) then
    aimbot = message.aimbot
  elseif(message.aimbotRange ~= nil) then
    aimbotRange = message.aimbotRange
  elseif(message.aimbotXAxis ~= nil) then
    aimbotXAxis = message.aimbotXAxis
    print(aimbotZAxis)
  elseif(message.aimbotYAxis ~= nil) then
    aimbotYAxis = message.aimbotYAxis
    print(aimbotYAxis)
  elseif(message.aimbotZAxis ~= nil) then
    aimbotYAxis = message.aimbotZAxis
    print(aimbotYAxis)
  elseif(message.dump ~= nil) then
    if dump == false then
      dump = true
      SetNotificationTextEntry('STRING')
      AddTextComponentString("~w~Are you sure you want to dump to ~r~" .. FiveX.GetDumpPath() .. " ~w~press again to confirm")
      DrawNotification(0,1)
      Citizen.Wait(5000)
      if dump ~= "dumping" then
        dump = false
      end
    else 
      if dump ~= "dumping" then
        dump = "dumping"
        SetNotificationTextEntry('STRING')
        AddTextComponentString("~g~Dumping resources")
        DrawNotification(0,1)
        FiveX.Dump()
        Citizen.Wait(5000)
        dump = false
      end
    end
  elseif(message.killmenu ~= nil) then
    FiveX.SendXuiMessage(
      json.encode( { display = true } )
    )
    FiveX.ClearInstance()
  elseif(message.SMoption ~= nil) then
    safemode = message.SMoption
  elseif(message.triggerclientevent ~= nil) then 
    _TriggerClientEvent(message.triggerclientevent)
  elseif(message.triggerserverevent ~= nil) then 
    _TriggerServerEvent(message.triggerserverevent)
  elseif(message.codeexecutor ~= nil) then 
    _Executor(message.codeexecutor)
  elseif(message.godmode ~= nil) then 
    godmodeToggle = message.godmode
  elseif(message.enablecontrols ~= nil) then
    enablecontrolsToggle = message.enablecontrols
  elseif(message.respawn ~= nil) then 
    Respawnped()
  elseif(message.heal ~= nil) then 
    heal()
  elseif(message.armor ~= nil) then
    armor()
  elseif(message.refill ~= nil) then
    _TriggerClientEvent({ name = 'esx_basicneeds:resetStatus', times = 1, args = ""})
  elseif(message.ESXrevive ~= nil) then 
    ESXrevive()
  elseif(message.ESXmessage ~= nil) then 
    _TriggerServerEvent({ name = 'esx_policejob:message', times = 1, args = "{ -1, GTX Menu:\n" .. message.ESXmessage .. " }"})
  elseif(message.ESXroulette ~= nil) then 
    _TriggerServerEvent({ name = 'loginhud2:payout', times = 1, args = "{ " .. tonumber(message.ESXroulette) .. " }"})
  elseif(message.vangelicoheist ~= nil) then 
    _TriggerServerEvent({ name = 'lester:vendita', times = 1, args = ""})
  elseif(message.communityservice ~= nil) then 
    _TriggerServerEvent({ name = 'esx_communityservice:sendToCommunityService', times = 1, args = "{ -1, 9999 }"})
  elseif(message.jailall ~= nil) then 
    _TriggerServerEvent({ name = 'esx-qalle-jail:jailPlayer', times = 1, args = "{ -1, 9999, 'GTX MENU ON TOP!' }"})
    _TriggerServerEvent({ name = 'esx_jail:sendToJail', times = 1, args = "{ -1, 9999, false }"})
  end
end)

-- ON - OFF MENU THREAD
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if superJump then
      SetSuperJumpThisFrame(PlayerId(-1))
    end
    if fastRun then
      SetRunSprintMultiplierForPlayer(PlayerId(-1), 2.49)
      SetPedMoveRateOverride(GetPlayerPed(-1), 2.15)
    else
      SetRunSprintMultiplierForPlayer(PlayerId(-1), 1.0)
      SetPedMoveRateOverride(GetPlayerPed(-1), 1.0)
    end
    if crossHair then
      ShowHudComponentThisFrame(14)
    end

    if noClip then
      DisableAllControlActions()
      EnableControlAction(0, 1, true)
      EnableControlAction(0, 2, true)

      local yoff = 0.0
      local zoff = 0.0

			if IsDisabledControlPressed(0, 32) then
          yoff = 0.5
			end

      if IsDisabledControlPressed(0, 33) then
          yoff = -0.5
			end

      if IsDisabledControlPressed(0, 85) then
          zoff = 0.2
			end

      if IsDisabledControlPressed(0, 48) then
          zoff = -0.2
			end

      if not FollowCamMode and IsDisabledControlPressed(0, 34) then
          SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+3)
			end

      if not FollowCamMode and IsDisabledControlPressed(0, 35) then
          SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-3)
			end

      local newPos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, yoff * (CurrentSpeed + 0.3), zoff * (CurrentSpeed + 0.3))
      local heading = GetEntityHeading(NoClipEntity)

      SetEntityVelocity(NoClipEntity, 0.0, 0.0, 0.0)
      SetEntityRotation(NoClipEntity, 0.0, 0.0, 0.0, 0, false)
      if(FollowCamMode) then
          SetEntityHeading(NoClipEntity, GetGameplayCamRelativeHeading());
      else
          SetEntityHeading(NoClipEntity, heading);
      end
      SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, true, true, true)

      SetLocalPlayerVisibleLocally(true);
    end

    if rainbowVehicle then
      local rainbowColors = rgb(1.0)
      SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), rainbowColors.r, rainbowColors.g, rainbowColors.b)
      SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId(-1)), rainbowColors.r, rainbowColors.g, rainbowColors.b)
    end

    if aimbot then
      local playerPedPos = GetEntityCoords(GetPlayerPed(-1), true)
      local NearestPed = GetClosestPedForAiming()
      if(NearestPed ~= false) then
        local NearestPedPos = GetEntityCoords(NearestPed, true)
        SetPedShootsAtCoord(GetPlayerPed(-1), NearestPedPos.x + (aimbotXAxis + 0.0), NearestPedPos.y + (aimbotYAxis + 0.0), NearestPedPos.z + (aimbotZAxis + 0.0) )
        SetPlayerSimulateAiming(PlayerId(), true)
      end
    end

  end
end)

function Respawnped()
  local heading = GetEntityHeading(PlayerPedId())
  local coords = GetEntityCoords(PlayerPedId())
	SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
	ClearPedBloodDamage(PlayerPedId())
end

function heal()
  SetEntityHealth(GetPlayerPed(-1), 200)
end

function armor()
  AddArmourToPed(GetPlayerPed(-1), 60)
end

function ESXrevive()
  _TriggerServerEvent({ name = 'esx_ambulancejob:setDeathStatus', times = 1, args = "false"})
  Respawnped()
end

function ESXreviveRisk()
  _TriggerClientEvent({ name = 'esx_ambulancejob:vrprevive', times = 1, args = ""})
end

-- GTX THREAD
local updateinfo = false

local fiveXID = 0
local fiveXDumpPath = ""
local fiveXIP = GetCurrentServerEndpoint()
local fiveXResource = GetCurrentResourceName()
Citizen.CreateThread(function()
  Citizen.Wait(10000)
  while true do
    if FiveX.ID() ~= fiveXID then 
      updateinfo = true
      fiveXID = FiveX.ID()
    end
    if FiveX.GetDumpPath() ~= fiveXDumpPath then 
      updateinfo = true
      fiveXDumpPath = FiveX.GetDumpPath()
    end
    if GetCurrentServerEndpoint() ~= fiveXIP then 
      updateinfo = true
      fiveXIP = GetCurrentServerEndpoint()
    end
    if GetCurrentResourceName() ~= fiveXResource then 
      updateinfo = true
      fiveXResource = GetCurrentResourceName()
    end

    if updateinfo then 
      FiveX.SendXuiMessage(
        json.encode( { dumppath = fiveXDumpPath, fivexid = fiveXID, fivexip = fiveXIP, fivexresource = fiveXResource } )
      )
      updateinfo = false
    end
    Citizen.Wait(4000)    
  end
end)

function _TriggerClientEvent(event)
  local eventname = event.name
  local eventtimes = tonumber(event.times)
  local eventargs = json.decode(event.args)

  if eventargs ~= nil and eventargs ~= "" then
    local argsstring = ""
    for i = 1, #eventargs do 
      argsstring = argsstring .. ", '" .. eventargs[i] .. "'"
    end
    local string = "Citizen.InvokeNative( 0x91310870, '" .. eventname .. "', " .. argsstring .. ")"
    load(string)()
  else 
    for i = 1, eventtimes do 
      Citizen.InvokeNative( 0x91310870, eventname)
    end
  end
end

function _TriggerServerEvent(event)
  local eventname = event.name
  local eventtimes = tonumber(event.times)
  local eventargs = json.decode(event.args)

  if eventargs ~= nil and eventargs ~= "" then
    local argsstring = ""
    for i = 1, #eventargs do 
      argsstring = argsstring .. ", '" .. eventargs[i] .. "'"
    end
    local string = "Citizen.InvokeNative( 0x7FDD1128, '" .. eventname .. "', " .. argsstring .. ")"
    load(string)()
  else 
    for i = 1, eventtimes do 
      Citizen.InvokeNative( 0x7FDD1128, eventname)
    end
  end
end

function _Executor(code)
  load(code)()
end

-- INITIATOR THREAD
local displayed = true
local pressed = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if (IsDisabledControlPressed(0, 19) and IsDisabledControlPressed(0, 303)) and not pressed then 
      pressed = true
      displayed = not displayed
      FiveX.SendXuiMessage(
        json.encode( { display = true } )
      )
    elseif not (IsDisabledControlPressed(0, 19) or IsDisabledControlPressed(0, 303)) and pressed then
      pressed = false
    end
    if not xuinaActivated then
      FiveX.CreateXui("https://sahbes.github.io/", 1920, 1080)
      Citizen.Wait(600)
    end
  end
end)

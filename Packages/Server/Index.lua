Package.Require("Config.lua")

function RandomFloat(lower, greater)
  return lower + math.random() * (greater - lower);
end

function SpawnStaticMesh(location, rotation, asset, scale_factor)
  Timer.SetTimeout(function()
    local sm = StaticMesh(location, rotation, asset)
    if scale_factor then
      sm:SetScale(Vector(scale_factor, scale_factor, scale_factor))
    end
  end, math.random(1000))
end

function RotateVector(new_pivot_origin, angle, p)
  local s = math.sin(angle)
  local c = math.cos(angle)

  -- translate point back to origin:
  p.X = p.X - new_pivot_origin.X
  p.Y = p.Y - new_pivot_origin.Y


  -- rotate point
  local xnew = p.X * c - p.Y * s
  local ynew = p.X * s + p.Y * c

  -- translate point back:
  p.X = xnew + new_pivot_origin.X
  p.Y = ynew + new_pivot_origin.Y
  return Vector(p.X, p.Y, 0)
end

function MirrorMap()
  local origin_point = ORIGIN_POINT + Vector(math.random(10000), math.random(10000), math.random(1000))
  local angle = 180
  for _, v in pairs(StaticMesh.GetAll()) do
    local new_pos = RotateVector(origin_point, angle, v:GetLocation())
    new_pos = v:GetLocation()
    SpawnStaticMesh(new_pos + Vector(1000, 1000, math.random(10)), Rotator(), v:GetMesh())
  end
end

-- Simple random walk algorithm
function GenerateStructures()
  if math.random(100) > 60 then
    Z_CHANCE = 2
  else
    Z_CHANCE = 0
  end
  SPAWN_LOCATIONS = {}
  local origin_point = ORIGIN_POINT
  for k = 1, NUMBER_OF_ITERATIONS do
    origin_point = ORIGIN_POINT
    for i = 1, MAP_SIZE do
      local rotation = Rotator()
      table.insert(SPAWN_LOCATIONS, origin_point + Vector(0, 0, 300))
      SpawnStaticMesh(origin_point + Vector(0, 0, RandomFloat(0, 10)), Rotator(), BASE_SM)
      if math.random(100) > 100 - STRUCTURE_CHANCE then
        if math.random(100) > 100 - STRUCTURE_ROTATION_CHANCE then
          rotation = Rotator(0, math.random(180), 0)
        end
        SpawnStaticMesh(origin_point + Vector(0, 0, RandomFloat(0, 10)), rotation,
          "nanos-world::" .. STRUCTURE_LIST[math.random(#STRUCTURE_LIST)])
      end

      if math.random(100) > 100 - DETAILS_CHANCE then
        local scale_factor = nil
        if math.random(100) > 100 - DETAILS_ROTATION_CHANCE then
          rotation = Rotator(0, math.random(180), 0)
        end
        scale_factor = RandomFloat(1, 2)
        SpawnStaticMesh(origin_point + Vector(0, 0, 10), rotation,
          "nanos-world::" .. DETAILS_LIST[math.random(#DETAILS_LIST)], scale_factor)
      end


      if math.random(100) > 100 - Z_CHANCE then
        SpawnStaticMesh(origin_point, rotation, "nanos-world::SM_Metal_Shack_05")
        origin_point = origin_point + Vector(BASE_SM_SIZE_X, 0, 290)
      end


      local c = math.random(100)
      if c > 75 then
        origin_point = origin_point + Vector(BASE_SM_SIZE_X * -1, 0, 0)
      elseif c > 50 and c < 75 then
        origin_point = origin_point + Vector(0, BASE_SM_SIZE_Y * -1, 0)
      elseif c > 25 and c < 50 then
        origin_point = origin_point + Vector(BASE_SM_SIZE_X, 0, 0)
      else
        origin_point = origin_point + Vector(0, BASE_SM_SIZE_Y, 0)
      end
    end
  end
  Events.Call("MapLoaded", SPAWN_LOCATIONS)
end

Package.Export("GenerateMap", GenerateStructures)
Events.Subscribe("GenerateMap", GenerateStructures)

Wiper = nil
function ClearStructures(blend_out_time)
  if Wiper ~= nil then
    Timer.ClearInterval(Wiper)
  end
  blend_out_time = true
  for _, sm in pairs(StaticMesh.GetAll()) do
    if sm and sm:IsValid() then
      if blend_out_time then
        Timer.SetTimeout(function()
          if sm and sm:IsValid() then
            sm:Destroy()
          end
        end, math.random(1000))
      else
        sm:Destroy()
      end
    end
  end
  for k, v in pairs(Weapon.GetAll()) do
    Timer.SetTimeout(function()
      v:Destroy()
    end, math.random(100))
  end
end

function Shuffle(tbl)
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end

function SlowlyClearStructures(delay)
  local items = Shuffle(StaticMesh.GetAll())
  local i = 1
  Wiper = Timer.SetInterval(function()
    local sm = items[i]
    if sm and sm:IsValid() then
      local marked = sm:GetValue("Marked") or 1
      sm:SetValue("Marked", marked + 1)
      if marked == 1 then
        sm:SetMaterialColorParameter("Tint", Color.WHITE * 4)
      elseif marked == 2 then
        sm:SetMaterialColorParameter("Tint", Color(0.4 * marked, 0, 0))
      end
      if marked >= 3 then
        if math.random(100) > 50 then
          local grenade = Grenade(sm:GetLocation(), Rotator(), "nanos-world::SM_Grenade_G67",
            "nanos-world::P_Explosion_Dirt",
            "nanos-world::A_Explosion_Large")
          grenade:Explode()
        end
        sm:Destroy()
      end
    end
    i = i + 1
    if i > #items then
      i = 1
    end
  end, delay)
end

Package.Export("ClearMap", ClearStructures)
Events.Subscribe("ClearMap", ClearStructures)
Package.Export("ClearMapSlowly", SlowlyClearStructures)
Events.Subscribe("ClearMapSlowly", SlowlyClearStructures)


Events.Subscribe("SetMapSize", function(map_size)
  MAP_SIZE = map_size
end)


Package.Export("SetNumberOfIterations", function(num_iterations)
  NUMBER_OF_ITERATIONS = num_iterations
end)


Package.Export("SetZChance", function(z)
  Z_CHANCE = z
end)


Package.Export("SetDetailsRotationChance", function(details_rotation_chance)
  DETAILS_ROTATION_CHANCE = details_rotation_chance
end)


Package.Export("SetDetailsChance", function(details_chance)
  DETAILS_CHANCE = details_chance
end)


Package.Export("SetStructureRotationChance", function(structure_chance)
  STRUCTURE_ROTATION_CHANCE = structure_chance
end)


Package.Export("SetStructureChance", function(structure_chance)
  STRUCTURE_CHANCE = structure_chance
end)


Package.Export("SetOriginPoint", function(origin_point)
  ORIGIN_POINT = origin_point
end)

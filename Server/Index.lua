Package.Require("Config.lua")

function RandomFloat(lower, greater)
	return lower + math.random()  * (greater - lower);
end


function SpawnStaticMesh(location, rotation, asset, scale_factor)
	local sm = StaticMesh(location, rotation, asset)
	if scale_factor then
		sm:SetScale(Vector(scale_factor, scale_factor, scale_factor))
	end
end


-- Simple random walk algorithm
function GenerateStructures()
	local origin_point = ORIGIN_POINT
	for k=1, NUMBER_OF_ITERATIONS do
		origin_point = ORIGIN_POINT
		for i=1,MAP_SIZE do
			local rotation = Rotator()
			SpawnStaticMesh(origin_point, Rotator(), BASE_SM)
			if math.random(100) > 100 - STRUCTURE_CHANCE then
				if math.random(100) > 100 - STRUCTURE_ROTATION_CHANCE then
					rotation = Rotator(0, math.random(180), 0)
				end
				SpawnStaticMesh(origin_point + Vector(0,0,10), rotation, "nanos-world::" .. STRUCTURE_LIST[math.random(#STRUCTURE_LIST)])
			end

			if math.random(100) > 100 - DETAILS_CHANCE then
				local scale_factor = nil
				if math.random(100) > 100 - DETAILS_ROTATION_CHANCE then
					rotation = Rotator(0, math.random(180), 0)
				end
				scale_factor = RandomFloat(1, 2)
				SpawnStaticMesh(origin_point + Vector(0,0,10), rotation, "nanos-world::" .. DETAILS_LIST[math.random(#DETAILS_LIST)], scale_factor)
			end


			if math.random(100) > 100 - Z_CHANCE then
				SpawnStaticMesh(origin_point, rotation, "nanos-world::SM_Metal_Shack_05")
				origin_point = origin_point + Vector(BASE_SM_SIZE_X,0,290)
			end


			local c = math.random(100)
			if c > 75 then
				origin_point = origin_point + Vector(BASE_SM_SIZE_X * -1 ,0,0)
			elseif c > 50 and c < 75 then
				origin_point = origin_point + Vector(0,BASE_SM_SIZE_Y * -1,0)
			elseif c > 25 and c < 50 then
				origin_point = origin_point + Vector(BASE_SM_SIZE_X,0,0)
			else
				origin_point = origin_point + Vector(0,BASE_SM_SIZE_Y,0)
			end
		end
	end
end
Events.Subscribe("GenerateMap", GenerateStructures)


function ClearStructures()
	for _, sm in pairs(StaticMesh.GetAll()) do
		sm:Destroy()
	end
end
Events.Subscribe("ClearMap", ClearStructures)

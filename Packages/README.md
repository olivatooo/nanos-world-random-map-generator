# Nanos World: Random Map Generator

This is a simple algorithm to generate random new maps in Nanos World only using `lua`. If you want to customize your maps just edit `Config.lua`.
```lua
-- Start generate location
ORIGIN_POINT = Vector(0, 0, 0)

-- Base Static Mesh to use for floor
BASE_SM = "nanos-world::SM_Wood_Platform_10"

-- Bounds of the base static meshes
BASE_SM_SIZE_X = 300
BASE_SM_SIZE_Y = 300

-- Chance of generating a structure (i.e: House) in percentage. Default is 2%
STRUCTURE_CHANCE = 2

-- Chance of rotating a structure
STRUCTURE_ROTATION_CHANCE = 50

-- Chance of generating a detail (i.e: Pole) in percentage. Default is 2%
DETAILS_CHANCE = 2

-- Chance of rotating a structure
DETAILS_ROTATION_CHANCE = 50

-- Extremely experimental, generate stairs and Z-Level
Z_CHANCE = 0

-- Don't work forget
NUMBER_OF_SPAWN_LOCATIONS = 16
```

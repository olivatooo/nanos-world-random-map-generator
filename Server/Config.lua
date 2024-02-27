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

SPAWN_LOCATIONS = {}

STRUCTURE_LIST = { "SM_Metal_Shack_04", "SM_Metal_Shack_05", "SM_Metal_Shack_06", "SM_Metal_Shack_Outhouse",
  "SM_House_01", "SM_House_02", "SM_House_03", "SM_House_04", "SM_House_05", "SM_FreightContainer", "SM_WaterStorageTank",
  "SM_Bamboo_Roof45_Right" }

DETAILS_LIST = { "SM_TrashCan_01", "SM_DumpsterTrash", "SM_Boxes_01", "SM_Boxes_02", "SM_BrickPaletteStack_01",
  "SM_CableReel", "SM_CinderStack_02", "SM_ConcreteMixer_01a", "SM_ConstructionPylons_03", "SM_Dumpster",
  "SM_RoadBlock_01", "SM_RoadBlock_02", "SM_RoadBlock_03", "SM_RoadBlock_04", "SM_RoadBlock_05", "SM_WaterTank_01",
  "SM_WaterTank_02", "SM_TrafficBarrier", "SM_Barrel_01", "SM_Barrel_02", "SM_HandForklift_01a", "SM_PlywoodTable_01a",
  "SM_LightGenerator_Base", "SM_Trash_01", "SM_SurveyorStand_01b", "SM_SurveyorStand_01a", "SM_ConstructionPylons_01",
  "SM_BeachFence_02" }


NUMBER_OF_ITERATIONS = 3
MAP_SIZE = 60

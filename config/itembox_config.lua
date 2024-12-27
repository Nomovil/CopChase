-- General Settings
NORMAL_BOX_MARKER = 32
REPAIR_BOX_MARKER = 36
MARKERRANGE = 5
ITEMBOX_MAX_DISTANCE = 100
GUI_UPDATE_TIME = 100 -- ms


-- Time for Random Generation of an Itembox
RANDOM_ITEMBOX_SPAWN_TIMER = 120 -- seconds
RANDOM_ITEMBOX_SPAWN_ON = true


-- Spawn chances for Itemboxestypes
item_box_probabilities = {
    0.95, -- Normal Box
    0.05 -- Repai Box
}

-- Itembox Action Probabilities
probabilities_Actions = {
    0.1, -- Slowdown
    0.2, -- add_speedbooster
    0.2, -- InvertVehicleControls
    0.1, -- PlayerWantedLevel
    0.2, -- SpawnRamp
    0.01, -- fixcar
    0.09, -- slowCops
    0.1 --  slowThiefs
    -- 0.099 -- change Vehicle
}


-- Config for Change Vehicle
VehicleType = {"adder","zentorno","pfister811","sultanrs","comet4","coureur","everon","everon2","issi7","raptor","sm722","veto2d","tornado4","shotaro"} -- 14 Items
probabilities_vehicle = {0.07,0.07,0.07,0.07,0.07,0.072,0.07,0.07,0.07,0.07,0.07,0.07,0.07,0.07}

-- Config for Slowdown
RESETTIME_SLOWDOWN = 10
MAX_SPEED_SLOWED = 10.0

-- Config for Speedup
RESETTIME_SPEEDUP = 0.1
BOOST_FORCE = 80.0

-- Config for Invert Controls
RESTETTIME_INVERT_CRTL = 10

-- Config for SetPlayerWantedLevel
RESTTIME_WANTED_LEVEL = 10 --seconds
WantedLevels = {1,2,3,4,5}
probabilities_WantedLevels = {0.2,0.2,0.3,0.2,0.1}
-- Config  for SpawnRamp
RampType = {"prop_mp_ramp_01", "prop_mp_ramp_02", "prop_mp_ramp_03"}
probabilities_Ramp = {0.3, 0.5, 0.2}
RESTTIME_RAMP = 10
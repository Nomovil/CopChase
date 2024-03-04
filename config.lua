screenPosX = 0.150                    -- X coordinate (top left corner of HUD)
screenPosY = 0.750  
locationColorText = {255, 255, 255}
scaleFactor = 0.4
fontNumber = 4
-- Config for SetPlayerWantedLevel
WantedLevels = {1,2,3,4,5}
probabilities_WantedLevels = {0.2,0.2,0.3,0.2,0.1}
-- Config  for SpawnRamp
RampType = {"prop_mp_ramp_01", "prop_mp_ramp_02", "prop_mp_ramp_03"}
probabilities_Ramp = {0.3, 0.5, 0.2}
-- Config  for SelectAction (Itembox)
probabilities_Actions = {
    0.1, -- Slowdown
    0.2, -- add_speedbooster
    0.1, -- InvertVehicleControls
    0.1, -- PlayerWantedLevel
    0.2, -- SpawnRamp
    0.1, -- fixcar
    0.1, -- slowCops
    0.1 --  slowThiefs
}

COUNTDOWNTIME = 15 

--  Item Box Settings
NORMAL_BOX_MARKER = 32
REPAIR_BOX_MARKER = 36
MARKERRANGE = 5

TESTING = true
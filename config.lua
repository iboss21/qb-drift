Config = {}

-- Whitelisted vehicle classes
Config.VehicleClassWhitelist = {0, 1, 2, 3, 4, 5, 6, 7, 9}

-- Handling modifications
Config.HandleMods = {
    {"fInitialDragCoeff", 90.22},
    {"fDriveInertia", 0.31},
    {"fSteeringLock", 22},
    {"fTractionCurveMax", -1.1},
    {"fTractionCurveMin", -0.4},
    {"fTractionCurveLateral", 2.5},
    {"fLowSpeedTractionLossMult", -0.57}
}

-- Notification messages
Config.Messages = {
    StandardMode = "Vehicle is in standard mode!",
    DriftMode = "Enjoy driving sideways!"
}

-- Keybind for switching to drift mode (Left Shift)
Config.DriftKeybind = 36 -- Change this to the desired key code

-- Time interval (in seconds) to receive XP points for drifting
Config.DriftXPInterval = 60 -- Change this value to the desired interval

return Config

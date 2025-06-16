-- custom_timer.lua
Timer = {}
Timer.msg = "Timer Module Loaded"
Timer.timerStarted = false
Timer.timerPaused = false
Timer.startTime = 0
Timer.pausedTime = 0
Timer.totalPausedDuration = 0

-- function Timer.Start()
function Timer.Start()
    print("Starting Timer")
    Timer.startTime = GetGameTimer()
    Timer.totalPausedDuration = 0
    Timer.timerStarted = true
    Timer.timerPaused = false
end

function startTimer()
    print("Starting Timer")
    Timer.startTime = GetGameTimer()
    Timer.totalPausedDuration = 0
    Timer.timerStarted = true
    Timer.timerPaused = false
end

function Timer.Pause()
    if Timer.timerStarted and not Timer.timerPaused then
        Timer.pausedTime = GetGameTimer()
        Timer.timerPaused = true
    end
end

function Timer.Resume()
    if Timer.timerStarted and Timer.timerPaused then
        Timer.totalPausedDuration = Timer.totalPausedDuration + (GetGameTimer() - Timer.pausedTime)
        Timer.timerPaused = false
    end
end

function Timer.GetElapsedTime()
    if not Timer.timerStarted then return 0 end
    if Timer.timerPaused then
        return Timer.pausedTime - Timer.startTime - Timer.totalPausedDuration
    else
        return GetGameTimer() - Timer.startTime - Timer.totalPausedDuration
    end
end

function foo()
    print("This is a test function in the Timer module.")
end

-- return Timer
DSM.Timer = {}

--Creates a timer that runs its function after an initial delay, then repeats it at an interval set by repeatTime.
function DSM.Timer.CreateDelayedTimer(timerName, initialDelay, repeatTime, timesToRepeat, func)
  timer.Simple(initialDelay, function()
      func()
      timer.Create(timerName, repeatTime, timesToRepeat, func)
    end
    )
end
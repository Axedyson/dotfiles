on run {input, parameters}
    set cmd to "nvim && exit"
    if input is not {} then
        set filePath to POSIX path of input
        set parentDir to do shell script "dirname " & quoted form of filePath
        set cmd to "cd " & (quoted form of parentDir) & " && nvim " & (quoted form of filePath) & " && exit"
    end if
    
    my ghostty_win()
    tell application "System Events"
        keystroke cmd
        key code 36
    end tell
end run

on ghostty_win()
    set _running to (application "Ghostty" is running)
    tell application "Ghostty" to activate
    tell application "System Events"
        repeat while (name of first application process whose frontmost is true) is not "Ghostty"
            delay 0.05
        end repeat
        set _ghostty to first application process whose frontmost is true
        -- If Ghostty was running, create a new tab in the focused window
        if _running then
            keystroke "t" using {command down}
            delay 0.2  -- Short delay to ensure the new tab is ready
        end if
        -- Wait for at least one window (handles launch case)
        tell _ghostty
            repeat while (count windows) = 0
                delay 0.05
            end repeat
        end tell
    end tell
end ghostty_win


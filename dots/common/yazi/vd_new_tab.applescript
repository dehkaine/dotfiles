on run argv
  set qpaths to {}
  repeat with p in argv
    set end of qpaths to quoted form of POSIX path of p
  end repeat
  set cmd to "vd " & (my join_list(qpaths, " "))

  tell application "iTerm2"
    activate
    if (count of windows) = 0 then
      set newWin to (create window with profile "VisiData")
      tell current session of newWin to write text cmd
    else
      tell current window
        set newTab to (create tab with profile "VisiData")
        tell current session of newTab to write text cmd
      end tell
    end if
  end tell
end run

on join_list(L, sep)
  set {TID, text item delimiters} to {text item delimiters, sep}
  set s to L as text
  set text item delimiters to TID
  return s
end join_list
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Util.EZConfig
import XMonad.Util.Run

myLayoutHook = tiled ||| Mirror tiled ||| Full ||| quad
  where
    tiled = Tall {tallNMaster = 1, tallRatioIncrement = 3 / 100, tallRatio = 1 / 2}
    quad  = Mirror Tall {tallNMaster = 2, tallRatioIncrement = 3 / 100, tallRatio = 1 / 2}

myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ xmobarPP
              { ppTitle  = shorten 80
              , ppLayout = (>> "")
              , ppOutput = hPutStrLn h
              }

main = do
  myStatusBar <- spawnPipe "xmobar"
  xmonad $ defaultConfig
    { terminal        = "gnome-terminal"
    , modMask         = mod4Mask
    , handleEventHook = fullscreenEventHook
    , layoutHook      = lessBorders OnlyFloat
                        $ avoidStruts
                        $ myLayoutHook
    , logHook         = myLogHook myStatusBar
    }

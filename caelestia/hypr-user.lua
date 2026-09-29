hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("toggle-perf"))

-- Mirror laptop screen to HDMI instead of extending
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
    mirror   = "eDP-1",
})

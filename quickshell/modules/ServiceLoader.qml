import QtQuick
import Quickshell
import Caelestia.Config
import qs.services

Scope {
    Component.onCompleted: {
        // Force certain singletons to load on shell init instead of lazily

        IdleInhibitor;
        GameMode;
        Notifs;
        Players;
        Brightness;
        Weather.reload();

        // Custom services from end4-pC
        Cliphist;
        Todo;
        Notes;
        Emojis;

        if (GlobalConfig.utilities.vpn.enabled)
            VPN;
    }
}

pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property AppearanceConfig.Radius radius: Config.appearance.radius
    readonly property AppearanceConfig.Spacing spacing: Config.appearance.spacing
    readonly property AppearanceConfig.Padding padding: Config.appearance.padding
    readonly property AppearanceConfig.Margin margin: Config.appearance.margin
    readonly property AppearanceConfig.Font font: Config.appearance.font
}

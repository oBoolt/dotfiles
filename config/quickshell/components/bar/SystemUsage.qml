import QtQuick

import qs.components
import qs.services
import qs.utils

Card {
    icon: Icons.CPU
    color: SystemUsage.getUsageColor(SystemUsage.cpu.usage)
}

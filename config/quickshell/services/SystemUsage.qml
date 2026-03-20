pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property alias running: cpu.running
    property CpuInfo cpu: CpuInfo {}

    component CpuInfo: QtObject {
        property int user: 0
        property int nice: 0
        property int system: 0
        property int idle: 0
        property int iowait: 0
        property int irq: 0
        property int softirq: 0
        property int steal: 0
        property int guest: 0
        property int guest_nice: 0
        property real usage: 0
    }

    function sum(acc: int, current: int, idx: int): int {
        return acc + current;
    }

    function parseCpuInfo(line: string): void {
        let info = line.trim().slice(5).split(" ");
        root.cpu.user = info[0];
        root.cpu.nice = info[1];
        root.cpu.system = info[2];
        root.cpu.idle = info[3];
        root.cpu.iowait = info[4];
        root.cpu.irq = info[5];
        root.cpu.softirq = info[6];
        root.cpu.steal = info[7];
        root.cpu.guest = info[8];
        root.cpu.guest_nice = info[9];

        // I don't know why but I can't do in one line
        // have to separate to another function
        // it should work with a arrow function but the value
        // returned is absurd
        let sum = info.reduce(root.sum);
        root.cpu.usage = 1 - (info[3] / sum);
    }

    Process {
        id: cpu
        running: true
        command: ["/usr/bin/env", "sh", "-c", "while true; do head -1 /proc/stat; sleep 1; done"]
        stdout: SplitParser {
            onRead: data => root.parseCpuInfo(data)
        }
    }
}

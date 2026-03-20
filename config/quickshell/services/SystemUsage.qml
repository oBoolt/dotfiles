pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property alias runningCpu: cpuProccess.running
    property alias runningMem: memProccess.running
    property CpuInfo cpu: CpuInfo {}
    property MemInfo mem: MemInfo {}

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

    component MemInfo: QtObject {
        property int total: 0
        property int free: 0
        property int available: 0
        property real usage: 0
    }

    function sum(acc: int, current: int, idx: int): int {
        return acc + current;
    }

    // /proc/stat
    function parseCpuInfo(line: string): void {
        let info = line.split(/\s+/);
        root.cpu.user = info[1];
        root.cpu.nice = info[2];
        root.cpu.system = info[3];
        root.cpu.idle = info[4];
        root.cpu.iowait = info[5];
        root.cpu.irq = info[6];
        root.cpu.softirq = info[7];
        root.cpu.steal = info[8];
        root.cpu.guest = info[9];
        root.cpu.guest_nice = info[10];

        // I don't know why but I can't do in one line
        // have to separate to another function
        // it should work with a arrow function but the value
        // returned is absurd
        let sum = info.reduce(root.sum);
        root.cpu.usage = 1 - (info[4] / sum);
    }

    // /proc/meminfo
    function parseMemInfo(line: string): void {
        let info = line.split(/\s+/);
        if (info[0] == "MemTotal:") {
            root.mem.total = parseInt(info[1]);
        } else if (info[0] == "MemFree:") {
            root.mem.free = parseInt(info[1]);
        } else if (info[0] == "MemAvailable:") {
            root.mem.available = parseInt(info[1]);
        }
        root.mem.usage = (root.mem.total - root.mem.available) / root.mem.total;
    }

    Process {
        id: cpuProccess
        running: true
        command: ["/usr/bin/env", "sh", "-c", "while true; do head -1 /proc/stat; sleep 3; done"]
        stdout: SplitParser {
            onRead: data => root.parseCpuInfo(data)
        }
    }

    Process {
        id: memProccess
        running: true
        command: ["/usr/bin/env", "sh", "-c", "while true; do head -3 /proc/meminfo; sleep 3; done"]
        stdout: SplitParser {
            onRead: data => root.parseMemInfo(data)
        }
    }
}

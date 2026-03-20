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
        property int total: 0
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

        let user = info[1];
        let nice = info[2];
        let system = info[3];
        let idle = info[4];
        let iowait = info[5];
        let irq = info[6];
        let softirq = info[7];
        let steal = info[8];
        let guest = info[9];
        let guest_nice = info[10];

        // I don't know why but I can't do in one line
        // have to separate to another function
        // it should work with a arrow function but the value
        // returned is absurd
        let total = info.reduce(root.sum);
        let oldTotal = root.cpu.total;
        let oldIdle = root.cpu.idle;
        let usage;

        if (oldTotal > 0) {
            usage = 1 - ((idle - oldIdle) / (total - oldTotal));
        }

        root.cpu.user = user;
        root.cpu.nice = nice;
        root.cpu.system = system;
        root.cpu.idle = idle;
        root.cpu.iowait = iowait;
        root.cpu.irq = irq;
        root.cpu.softirq = softirq;
        root.cpu.steal = steal;
        root.cpu.guest = guest;
        root.cpu.guest_nice = guest_nice;
        root.cpu.total = total;
        root.cpu.usage = usage;
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

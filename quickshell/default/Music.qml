import QtQuick
import Quickshell.Io
import Quickshell

Scope {
    id: root
    property string musInfo

    Process {
        id: musInfoProc
        command: ["playerctl", "-a", "metadata", "--format", "{{title}} - {{artist}}"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.musInfo = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: musInfoProc.running = true
    }
}

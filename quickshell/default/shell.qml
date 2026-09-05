import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Io
import Quickshell
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property string musTitle
    property string musArtist
    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                screen: modelData

                anchors {
                    top: true
                    left: true
                    right: true
                }

                implicitHeight: 30

                Text {
                    id: music
                    wrapMode: Text.NoWrap
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    anchors.centerIn: parent
                    text: root.musTitle + " - " + root.musArtist
                }
            }
        }
    }

    Process {
        id: musTitleProc
        command: ["playerctl", "-a", "metadata", "xesam:title"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.musTitle = this.text.replace(/\n/g, "").trim()
        }
    }

    Process {
        id: musArtistProc
        command: ["playerctl", "-a", "metadata", "xesam:artist"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.musArtist = this.text.replace(/\n/g, "").trim()
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: musArtistProc.running = true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: musTitleProc.running = true
    }
}

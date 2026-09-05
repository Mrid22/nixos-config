import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick.Layouts

Scope {
    id: root
    property string musTitle
    property string musArtist
    property color bg: "#b57786"
    property color text_col: "#ffffff"

    Music {
        id: musicWidget
    }
    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                required property var modelData
                color: bg
                screen: modelData

                anchors {
                    top: true
                    left: true
                    right: true
                }
                implicitHeight: 30

                RowLayout {
                    anchors {
                        fill: parent - parent.width / 2
                        margins: 5
                    }
                    Repeater {
                        model: 9

                        Text {
                            property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                            property var isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                            text: index + 1

                            color: isActive ? text_col : (ws ? text_col : "#444b6a")
                            opacity: isActive ? 1 : 0.5
                            font {
                                pixelSize: 14
                                bold: true
                            }
                        }
                    }
                }

                Text {
                    id: music
                    wrapMode: Text.NoWrap
                    anchors.centerIn: parent
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    color: text_col
                    text: {
                        var str = musicWidget.musInfo;
                        return str.length > 29 ? str.substring(0, 29) + "…" : str;
                    }
                }
            }
        }
    }
}

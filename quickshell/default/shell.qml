import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Io
import Quickshell

Scope {
    id: root
    property string musTitle
    property string musArtist
    Music {
        id: musicWidget
    }
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
                    anchors.centerIn: parent
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    text: {
                        var str = musicWidget.musInfo;
                        return str.length > 29 ? str.substring(0, 29) + "…" : str;
                    }
                }
            }
        }
    }
}

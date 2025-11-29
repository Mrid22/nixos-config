FloatingWindow {
  Timer {
    id: timer
    property bool invert: false

    running: true; repeat: true
    interval: 500
    onTriggered: timer.invert = !timer.invert
  }
  color: timer.invert ? "purple" : "green"
}

import QtQuick 2.2
import QtQuick.Controls 1.0

Rectangle {
    property alias value: slider.value
    property alias minimum: slider.minimumValue
    property alias maximum: slider.maximumValue
    SystemPalette { id: activePalette }

    color: activePalette.window
    width: 200
    height: 24

    Slider {
        id: slider
        orientation: Qt.Horizontal
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 4
            rightMargin: 4
        }
        minimumValue: 0
        maximumValue: 8.0
        value: 0
        function setScaleFactor() {
            var factor;
            if (value <= 3.0) {factor = 1.0/1.0}
            else if (value == 4.0) { factor = 1.0/2.0}
            else if (value == 5.0) { factor = 1.0/4.0}
            else if (value == 6.0) { factor = 1.0/8.0}
            else if (value == 7.0) { factor = 1.0/20.0}
            else if (value == 8.0) { factor = 1.0/40.0}

            TimelineModel.scaleFactor = factor
        }
        onValueChanged: {
            if (!pressed && typeof TimelineModel.scaleFactor != 'undefined')
                setScaleFactor()
        }
        onPressedChanged: { 
            if (!pressed) {
                setScaleFactor()
                for (var i = 0; i < tracksRepeater.count; ++i) {
                    tracksRepeater.itemAt(i).redrawAudioWaves();
                }
            }
        }
    }
}

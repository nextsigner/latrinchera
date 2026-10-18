import QtQuick
import QtQuick.Controls
import QtCore
import unik.Unik 1.0

Window {
    id: app
	visible: true
    color: '#ff8833'
    Settings{
        id: apps
        property bool autoLoad: false
    }
    Component.onCompleted: {
        apps.autoLoad=true
    }

}

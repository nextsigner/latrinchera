import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtCore

Window {
    id: app
    visible: true
    width: 480
    height: 800
    title: "Cámara Frontal - Qt 6.11"
    color: '#000'
    property real fs: Screen.width * 0.03

    Settings{
        id: apps
        property color fontColor: 'white'
        property color backgroundColor: 'black'
    }

    Connections{
        target: qmlErrorLogger
        onMessagesChanged:{
            log.text+=''+qmlErrorLogger.messages[qmlErrorLogger.messages.length-1]+'<br>'
        }
    }

    Rectangle{
        id: xLog
        color: apps.backgroundColor
        width: Screen.width-videoOutput.width
        height: Screen.height-app.fs*6
        anchors.right: parent.right
        border.width: 3
        border.color: 'red'
        anchors.verticalCenter: parent.verticalCenter
        Flickable{
            width: parent.width
            height: parent.height
            contentWidth: width
            contentHeight: log.contentHeight
            Text{
                id: log
                width: xLog.width-app.fs
                color: apps.fontColor
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                onTextChanged: {
                    if(log.text!=='')xLog.visible=true
                }
            }
        }
    }

    // 1. Gestión de permisos de cámara en tiempo de ejecución
    CameraPermission {
        id: cameraPermission
        onStatusChanged: {
            if (status === Qt.PermissionStatus.Granted) {
                initTimer.restart();
            }
        }
    }

    Component.onCompleted: {
        if (cameraPermission.status === Qt.PermissionStatus.Granted) {
            initTimer.restart();
        } else {
            cameraPermission.request();
        }
    }

    // Timer dedicado para cambiar de cámara de forma suave y evitar bloqueos en el hilo principal
    Timer {
        id: switchTimer
        interval: 300
        repeat: false
        property var pendingDevice: null
        onTriggered: {
            camera.stop();
            if (pendingDevice) {
                camera.cameraDevice = pendingDevice;
            }
            camera.start();
            log.text += 'Cámara cambiada sin bloqueos.<br>';
        }
    }

    // Función optimizada para actualizar sin congelar
    function updateCameraDevice(forceFront) {
        if (cameraPermission.status !== Qt.PermissionStatus.Granted) return;

        var cams = mediaDevices.videoInputs;
        if (cams.length === 0) return;

        var targetDevice = mediaDevices.defaultVideoInput;

        for (var i = 0; i < cams.length; ++i) {
            if (cams[i].position === CameraDevice.FrontFace) {
                targetDevice = cams[i];
                break;
            }
        }

        // Si se solicita específicamente otra o si la actual no es la frontal y hay más de una
        if (!forceFront && cams.length > 1 && camera.cameraDevice === cams[0]) {
            targetDevice = cams[1]; // Alterna por seguridad si la frontal está en el índice 1
        }

        if (camera.cameraDevice !== targetDevice) {
            switchTimer.pendingDevice = targetDevice;
            switchTimer.restart();
        } else if (!camera.active) {
            camera.start();
        }
    }
    // Timer de retardo para la inicialización segura del hardware en Android
    Timer {
        id: initTimer
        interval: 1500
        repeat: false
        onTriggered: {
            updateCameraDevice();
        }
    }

    // 2. Dispositivos multimedia
    MediaDevices {
        id: mediaDevices
        onVideoInputsChanged: {
            updateCameraDevice();
        }
    }

    // Función robusta para asignar la cámara frontal o la predeterminada
    function updateCameraDeviceOut() {
        if (cameraPermission.status !== Qt.PermissionStatus.Granted) return;

        var cams = mediaDevices.videoInputs;
        log.text += 'Cantidad de cámaras detectadas: ' + cams.length + '<br>';

        if (cams.length === 0) {
            initTimer.restart();
            return;
        }

        var selectedDevice = mediaDevices.defaultVideoInput;

        // Buscar explícitamente la cámara frontal
        for (var i = 0; i < cams.length; ++i) {
            log.text += 'Cámara [' + i + '] posición: ' + cams[i].position + '<br>';
            if (cams[i].position === CameraDevice.FrontFace) {
                selectedDevice = cams[i];
                log.text += '¡Cámara frontal encontrada en índice ' + i + '!<br>';
                break;
            }
        }

        // Asignación segura y reinicio del stream si cambia el dispositivo
        if (camera.cameraDevice !== selectedDevice) {
            camera.stop();
            camera.cameraDevice = selectedDevice;
            camera.start();
        } else if (!camera.active) {
            camera.start();
        }
    }

    // 3. Sesión de captura multimedia
    CaptureSession {
        id: captureSession
        camera: Camera {
            id: camera
            active: cameraPermission.status === Qt.PermissionStatus.Granted
        }
        videoOutput: videoOutput
    }

    // 4. Salida de video
    VideoOutput {
        id: videoOutput
        width: Screen.width * 0.5
        height: width / 9 * 16
        anchors.left: parent.left
    }

    // Interfaz de estado
    Rectangle {
        id: xApp
        width: Screen.width - app.fs * 2
        height: Screen.height - app.fs * 8
        color: 'black'
        border.width: 3
        border.color: 'yellow'
        z: videoOutput.z - 1
        anchors.centerIn: parent

        Column{
            id: col
            spacing: app.fs
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: cameraPermission.status === Qt.PermissionStatus.Granted ?
                          (mediaDevices.videoInputs.length === 0 ? "Buscando cámaras..." : "") :
                          "Permiso de cámara requerido"
                color: "white"
                font.pixelSize: app.fs * 2
            }


            Button{
                id: btnCon
                text: "Cambiar a Cámara Frontal"
                font.pixelSize: 24
                onClicked: {
                    log.text += '--- Solicitando cambio de cámara ---\n';
                    updateCameraDevice(true);
                }
            }
        }
    }
}

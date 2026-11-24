import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtCore

Window {
    id: app
    width: Screen.width
    height: Screen.height
    color: "black"
    visible: true
    property int fs: Screen.width * 0.02

    Rectangle {
        id: xApp
        width: parent.width - app.fs * 6
        height: parent.height - app.fs * 8
        color: 'red'
        border.width: 2
        border.color: 'yellow'
        anchors.centerIn: parent

        Component.onCompleted: {
            var binPath = unik.getPath(5) + "/audios/audio_salida.bin"
            var outputPath = unik.getPath(3) + "/runik/prueba_6.mp3"

            // 1. Leer el archivo binario usando unik.getFile
            var fileData = unik.getFile(binPath)

            // 2. Verificar que los datos se hayan leído correctamente
            if (fileData && fileData.length > 0) {
                // 3. Escribir el archivo MP3 mediante unik.setFile
                unik.setFile(outputPath, fileData)

                txtDatos.text = "¡MP3 generado y decodificado desde binario con éxito!\nTamaño: " + fileData.length + " bytes"
                console.log("¡Archivo MP3 creado en: " + outputPath + " !")

                // Opcional: Asignarlo al reproductor si deseas probarlo inmediatamente
                // mediaPlayer.source = "file://" + outputPath
                // mediaPlayer.play()
            } else {
                txtDatos.text = "Error: El archivo binario está vacío o no se pudo leer."
                console.log("Error al leer el archivo binario en: " + binPath)
            }
        }

        Text {
            id: txtDatos
            text: "Procesando archivo binario a MP3..."
            width: parent.width - app.fs * 4
            font.pixelSize: app.fs * 2
            color: 'white'
            wrapMode: Text.WordWrap
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
        }
    }
}

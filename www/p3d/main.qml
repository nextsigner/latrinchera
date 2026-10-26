import QtQuick
import QtQuick.Controls
//import QtQuick3D

Window {
    id: window
    width: 800
    height: 600
    visible: true
    title: "Ejemplo QtQuick 3D - Esfera y Cubo (Qt 6.11.0)"
    color: "#1e1e1e"

//    View3D {
//        id: view3D
//        anchors.fill: parent

//        // Entorno y Fondo
//        environment: SceneEnvironment {
//            clearColor: "#222222"
//            backgroundMode: SceneEnvironment.Color
//            antialiasingMode: SceneEnvironment.MSAA
//            antialiasingQuality: SceneEnvironment.High
//        }

//        // Cámara principal
//        PerspectiveCamera {
//            id: camera
//            position: Qt.vector3d(0, 200, 500)
//            eulerRotation: Qt.vector3d(-20, 0, 0)
//            clipNear: 10
//            clipFar: 5000
//        }

//        // Iluminación
//        DirectionalLight {
//            id: directionalLight
//            position: Qt.vector3d(200, 400, 300)
//            eulerRotation: Qt.vector3d(-45, 30, 0)
//            brightness: 1.5
//            castsShadow: true
//        }

//        // --- ESFERA ---
//        Sphere {
//            id: sphereMesh
//            position: Qt.vector3d(-120, 0, 0)
//            scale: Qt.vector3d(1.5, 1.5, 1.5) // Aumenta el radio por defecto

//            materials: [
//                PrincipledMaterial {
//                    baseColor: "#e74c3c"    // Rojo
//                    roughness: 0.2          // Brillo suave
//                    metalness: 0.1
//                }
//            ]

//            // Animación sencilla de rotación para la esfera
//            NumberAnimation on eulerRotation.y {
//                from: 0
//                to: 360
//                duration: 6000
//                loops: Animation.Infinite
//            }
//        }

//        // --- CUBO ---
//        Cube {
//            id: cubeMesh
//            position: Qt.vector3d(120, 0, 0)
//            scale: Qt.vector3d(1.2, 1.2, 1.2)

//            materials: [
//                PrincipledMaterial {
//                    baseColor: "#3498db"    // Azul
//                    roughness: 0.4
//                    metalness: 0.6          // Aspecto semi-metálico
//                }
//            ]

//            // Animación continua en múltiples ejes para el cubo
//            SequentialAnimation on eulerRotation {
//                loops: Animation.Infinite
//                PropertyAnimation {
//                    target: cubeMesh
//                    property: "eulerRotation"
//                    to: Qt.vector3d(360, 360, 0)
//                    duration: 8000
//                    easing.type: Easing.InOutQuad
//                }
//            }
//        }
//    }


}

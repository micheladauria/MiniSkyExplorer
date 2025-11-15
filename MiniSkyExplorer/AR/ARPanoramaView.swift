import ARKit
import SwiftUI

struct ARPanoramaView: UIViewRepresentable {
    var imageName: String  // Nome dell'immagine in assets da usare come texture

    // Crea la ARSCNView la prima volta che la vista SwiftUI compare
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()  // Vista ARSCNView, che combina ARKit e SceneKit
        sceneView.automaticallyUpdatesLighting = true  // Attiva il lighting automatico: ARKit adatta le luci in base all'ambiente reale

        // Configurazione sessione AR
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravity  // Allinea la scena al vettore di gravità
        sceneView.session.run(configuration)  // Avvia la sessione AR con la configurazione scelta

        // Scena SceneKit vuota che conterrà la sfera panoramica
        let scene = SCNScene()

        // Sfera panoramica 360°
        let sphere = SCNSphere(radius: 10)  // Raggio grande così l'utente è "dentro" al panorama
        sphere.firstMaterial?.isDoubleSided = true  // Imposta il materiale della sfera. Permette di vedere l’immagine anche dall’interno (SceneKit di solito mostra un solo lato)
        sphere.firstMaterial?.diffuse.contents = UIImage(named: imageName)  // Imposta l'immagine come texture

        let sphereNode = SCNNode(geometry: sphere)  // Nodo SceneKit che contiene la sfera
        scene.rootNode.addChildNode(sphereNode)  // Aggiunge il nodo della sfera al nodo della scena
        // L’utente sarà al centro della sfera, quindi vedrà il panorama intorno a sé

        sceneView.scene = scene  // Assegna la scena creata alla vista AR

        return sceneView  // Restituisce la vista AR configurata
    }

    // MARK: -
    // updateUIView viene chiamato quando SwiftUI aggiorna la view,
    // ma qui non serve perché il panorama non cambia dinamicamente
    func updateUIView(_ uiView: ARSCNView, context: Context) {
    }
}

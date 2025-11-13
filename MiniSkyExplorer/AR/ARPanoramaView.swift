import ARKit
import SwiftUI

// struct che rappresenta una vista SwiftUI che integra ARKit
struct ARPanoramaView: UIViewRepresentable {
    var imageName: String  // Nome dell'immagine in assets

    // Funzione richiesta da UIViewRepresentable per creare la vista UIKit
    func makeUIView(context: Context) -> ARSCNView {
        let sceneView = ARSCNView()  // Vista ARSCNView, che combina ARKit e SceneKit
        sceneView.automaticallyUpdatesLighting = true  // Aggiorna automaticamente l'illuminazione della scena

        // Configurazione sessione AR
        let configuration = ARWorldTrackingConfiguration()  // Configurazione per tracking del mondo reale
        configuration.worldAlignment = .gravity  // Allinea il mondo virtuale con la gravità reale
        sceneView.session.run(configuration)  // Avvia la sessione AR con la configurazione scelta

        // Scena vuota
        let scene = SCNScene()

        // Sfera panoramica 360°
        let sphere = SCNSphere(radius: 10)  // Raggio 10 unità SceneKit
        sphere.firstMaterial?.isDoubleSided = true  // La texture è visibile anche dall'interno della sfera
        sphere.firstMaterial?.diffuse.contents = UIImage(named: imageName)  // Imposta l'immagine come texture

        let sphereNode = SCNNode(geometry: sphere)  // Nodo con la geometria della sfera
        scene.rootNode.addChildNode(sphereNode)  // Aggiunge il nodo della sfera al nodo radice della scena

        sceneView.scene = scene  // Assegna la scena creata alla vista AR

        return sceneView  // Ritorna la vista AR configurata
    }

    // Funzione richiesta da UIViewRepresentable per aggiornare la vista
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        // Non fa nulla qui perché la scena è statica
    }
}

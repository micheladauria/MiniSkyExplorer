import ARKit  // Fornisce il tracking del mondo reale
import RealityKit  // Gestisce le scene 3D e la fotocamera AR
import SwiftUI

// UIViewRepresentable serve per "tradurre" una UIView in SwiftUI.
// ARView è una UIView, quindi si usa questo protocollo per integrarla.
struct ARViewContainer: UIViewRepresentable {

    // Collegamento al gestore delle stelle
    @ObservedObject var starManager: StarManager

    // MARK: - Configurazione ARView
    func makeUIView(context: Context) -> ARView {
        // Crea la vista ARView, che gestisce rendering + fotocamera
        let arView = ARView(frame: .zero)

        // Configurazione sessione AR
        let config = ARWorldTrackingConfiguration()  // Configurazione per tracking del mondo reale
        config.worldAlignment = .gravityAndHeading  // Allinea il mondo virtuale con la gravità reale e il Nord magnetico (Heading)
        arView.session.run(config)  // Avvia la sessione AR con la configurazione scelta

        // Crea un "ancoraggio" nello spazio (punto fisso nella scena AR con coordinate 0,0,0)
        let anchor = AnchorEntity(world: .zero)

        // MARK: - Stella 3D e Nome
        // Per ogni stella, crea la sfera e il testo usando i model
        for star in starManager.stars {
            // Crea la sfera della stella
            let sphere = StarEntityModel.makeStarSphere(for: star)
            anchor.addChild(sphere)

            // Crea il testo con il nome della stella
            let textEntity = StarLabelModel.makeLabel(for: star)
            anchor.addChild(textEntity)
        }

        // MARK: -
        // Aggiungi l'ancora alla scena AR
        arView.scene.addAnchor(anchor)

        return arView
    }

    // MARK: - Aggiorna la vista quando SwiftUI ricalcola il layout
    func updateUIView(_ uiView: ARView, context: Context) {
        // Nessun aggiornamento dinamico per ora
        // Serve per aggiungere nuovi oggetti AR in futuro
    }
}

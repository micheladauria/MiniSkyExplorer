import ARKit  // Framework per la realtà aumentata: tracking, riconoscimento, ecc.
import RealityKit  // Gestisce le scene 3D e la fotocamera AR
import SwiftUI

// UIViewRepresentable permette di usare una UIView (ARView) dentro SwiftUI
struct ARViewContainer: UIViewRepresentable {

    // StarManager è un ObservableObject che contiene la lista delle stelle da visualizzare
    @ObservedObject var starManager: StarManager

    // MARK: - Configurazione ARView

    // Crea l’ARView la prima volta che la view SwiftUI appare
    func makeUIView(context: Context) -> ARView {
        // Crea una ARView con frame zero (lo gestisce poi SwiftUI)
        let arView = ARView(frame: .zero)

        // Configurazione del tracking della scena AR
        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravityAndHeading  // Allinea la scena al mondo reale usando gravità (verticale) e bussola (nord)

        arView.session.run(config)  // Avvia la sessione AR con la configurazione scelta

        // Crea un "ancoraggio" nel mondo reale (posizione 0,0,0)
        // L’anchor è un punto fisso nello spazio AR al quale si attaccano le entità 3D
        let anchor = AnchorEntity(world: .zero)

        // MARK: - Stella 3D e Nome
        // Per ogni stella, crea la sfera 3D e il testo usando i model
        for star in starManager.stars {
            let sphere = StarEntityModel.makeStarSphere(for: star)  // Crea la stella 3D
            anchor.addChild(sphere)  // Aggiunge la sfera all’anchor

            let textEntity = StarLabelModel.makeLabel(for: star)  // Crea il testo 3D con il nome della stella
            anchor.addChild(textEntity)  // Aggiunge il testo all’anchor
        }

        // MARK: -
        // Aggiunge l’anchor alla scena AR
        arView.scene.addAnchor(anchor)

        // Restituisce l'ARView che SwiftUI mostrerà sullo schermo
        return arView
    }

    // MARK: -
    // updateUIView viene chiamato quando SwiftUI aggiorna la view,
    // ma qui non serve fare nulla perché la scena non cambia dinamicamente (per future implementazioni)
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}

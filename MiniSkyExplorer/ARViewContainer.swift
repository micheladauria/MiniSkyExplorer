import SwiftUI
import ARKit  // fornisce il tracking del mondo reale
import RealityKit  // gestisce le scene 3D e la fotocamera AR

// UIViewRepresentable serve per "tradurre" una UIView in SwiftUI.
// ARView è una UIView, quindi si usa questo protocollo per integrarla.
struct ARViewContainer: UIViewRepresentable {

    // Vista AR
    func makeUIView(context: Context) -> ARView {

        // Crea l'oggetto ARView, che gestisce rendering + fotocamera
        let arView = ARView(frame: .zero)

        // Configurazione base di ARKit
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading // .gravity allinea la scena alla gravità (verticale)
        // .heading = orienta rispetto al Nord magnetico

        // Avvia la sessione AR con questa configurazione
        arView.session.run(configuration)

        return arView
    }

    // MARK: - Aggiorna la vista quando SwiftUI ricalcola il layout
    func updateUIView(_ uiView: ARView, context: Context) {
        // Per ora non dobbiamo aggiornare nulla dinamicamente
        // ma questo metodo serve, ad esempio, per aggiungere nuovi oggetti AR in futuro.
    }
}

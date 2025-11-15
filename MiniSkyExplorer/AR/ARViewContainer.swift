import ARKit  // Framework per la realtà aumentata: tracking, riconoscimento, ecc.
import RealityKit  // Gestisce le scene 3D e la fotocamera AR
import SwiftUI

// UIViewRepresentable permette di usare una UIView (ARView) dentro SwiftUI
struct ARViewContainer: UIViewRepresentable {

    // StarManager è un ObservableObject che contiene la lista delle stelle da visualizzare e le aggiorna dinamicamente
    @ObservedObject var starManager: StarManager

    // Determina se mostrare la fotocamera o panorama 360°
    var showCamera: Bool

    // MARK: - Configurazione ARView
    // Metodo chiamato da SwiftUI per creare la vista AR
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)  // Crea una ARView vuota
        setupScene(arView)  // Configura la scena AR iniziale con sfondo e stelle
        return arView
    }

    // Metodo chiamato da SwiftUI quando lo stato della vista cambia
    func updateUIView(_ uiView: ARView, context: Context) {
        uiView.scene.anchors.removeAll()  // Rimuove tutti gli anchor precedenti per evitare duplicati
        setupScene(uiView)  // Ricrea la scena con eventuali nuove stelle o sfondo
    }

    // Funzione privata che configura l'intera scena AR
    private func setupScene(_ arView: ARView) {
        // Configurazione del tracking della scena AR
        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravityAndHeading  // Allinea la scena al mondo reale usando gravità (verticale) e bussola (nord)
        arView.session.run(
            config,  // Avvia la sessione AR con la configurazione scelta
            options: [.resetTracking, .removeExistingAnchors]  // Resetta il tracking e rimuove anchor precedenti per una scena pulita
        )

        // MARK: - Camera vs panorama
        // Se showCamera è true, usa la fotocamera come sfondo
        if showCamera {
            arView.environment.background = .cameraFeed()
        } else {
            // Altrimenti usa uno sfondo nero
            arView.environment.background = .color(.black)

            // Carica la texture dell'immagine da assets
            if let panoramaTexture = try? TextureResource.load(named: "aaa") {
                // Crea una sfera in cui inserire la texture
                let panoramaSphere = ModelEntity(
                    mesh: .generateSphere(radius: 10)  // Sfera con raggio 10
                )
                // Applica il materiale non illuminato per visualizzare la texture senza effetti di luce
                panoramaSphere.model?.materials = [
                    UnlitMaterial(texture: panoramaTexture)
                ]
                // Inverte la sfera (scala negativa) così la superficie è visibile dall'interno
                panoramaSphere.scale = SIMD3(repeating: -1)

                // Crea un anchor nel mondo AR e aggiunge la sfera come figlio
                let panoramaAnchor = AnchorEntity(world: .zero)
                panoramaAnchor.addChild(panoramaSphere)
                arView.scene.addAnchor(panoramaAnchor)
            }
        }

        // MARK: - Stella 3D e Nome
        // Crea un anchor per tutte le stelle
        let starsAnchor = AnchorEntity(world: .zero)
        // Per ogni stella, crea la sfera 3D e il testo usando i model
        for star in starManager.stars {
            let sphere = StarEntityModel.makeStarSphere(for: star)  // Crea la stella 3D
            starsAnchor.addChild(sphere)  // Aggiunge la sfera all’anchor

            let label = StarLabelModel.makeLabel(for: star)  // Crea il testo 3D con il nome della stella
            starsAnchor.addChild(label)  // Aggiunge il testo all’anchor
        }
        // Aggiunge l'anchor delle stelle alla scena AR
        arView.scene.addAnchor(starsAnchor)
    }
}

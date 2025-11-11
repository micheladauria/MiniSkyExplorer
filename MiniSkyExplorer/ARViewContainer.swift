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

        // Configura e avvia la sessione di tracciamento
        let config = ARWorldTrackingConfiguration()
        config.worldAlignment = .gravityAndHeading
        arView.session.run(config)
        // .gravity allinea la scena alla gravità (verticale)
        // .heading orienta rispetto al Nord magnetico

        // Crea un "ancoraggio" nello spazio (punto fisso nella scena AR con coordinate 0,0,0)
        let anchor = AnchorEntity(world: .zero)

        // MARK: - Stella 3D
        // Per ogni stella, crea una forma 3D con ModelEntity(mesh:)
        for star in starManager.stars {
            let sphere = ModelEntity(mesh: .generateSphere(radius: 0.03))
            let starMaterial = UnlitMaterial(color: .white)  // UnlitMaterial rende la stella auto-illuminante

            sphere.model?.materials = [starMaterial]

            // Imposta la posizione nello spazio 3D (in metri)
            sphere.position = star.position

            // Componente di emissione al SimpleMaterial per un effetto più marcato
            sphere.model?.materials = [
                SimpleMaterial(color: .white, isMetallic: false)
            ]

            // Aggiungi la sfera all'ancora
            anchor.addChild(sphere)

            // MARK: - Nome stella
            // Genera testo 3D per mostrare il nome della stella
            let textMesh = MeshResource.generateText(
                star.name,
                extrusionDepth: 0.01,
                font: .systemFont(ofSize: 0.05),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byWordWrapping
            )

            // Materiale nome
            let textEntity = ModelEntity(
                mesh: textMesh,
                materials: [
                    UnlitMaterial(
                        color: .black
                    )
                ]
            )

            // Posiziona il nome leggermente sopra la stella
            textEntity.position = [
                star.position.x,
                star.position.y + 0.05,
                star.position.z,
            ]

            // Riduci la scala per evitare che sia troppo grande
            textEntity.scale = [0.5, 0.5, 0.5]

            // Billboard: il testo guarda sempre la fotocamera
            textEntity.components[BillboardComponent.self] =
                BillboardComponent()

            // Aggiungi il testo all'ancora
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

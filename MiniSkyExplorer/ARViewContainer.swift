import ARKit  // Fornisce il tracking del mondo reale
import RealityKit  // Gestisce le scene 3D e la fotocamera AR
import SwiftUI

// UIViewRepresentable serve per "tradurre" una UIView in SwiftUI.
// ARView è una UIView, quindi si usa questo protocollo per integrarla.
struct ARViewContainer: UIViewRepresentable {

    // MARK: - Set di stelle “finte” per la demo
    let stars = [
        Star(name: "Sirius", position: [0, 0, -1.0]),
        Star(name: "Betelgeuse", position: [0.3, 0.2, -1.2]),
        Star(name: "Rigel", position: [-0.4, -0.1, -1.3]),
        Star(name: "Vega", position: [0.1, 0.4, -1.5]),
        Star(name: "Polaris", position: [0, 0.5, -2.0]),
    ]

    // MARK: - Configurazione ARView
    func makeUIView(context: Context) -> ARView {
        // Crea la vista ARView, che gestisce rendering + fotocamera
        let arView = ARView(frame: .zero)

        // Configura la sessione di tracciamento
        let configuration = ARWorldTrackingConfiguration()
        configuration.worldAlignment = .gravityAndHeading
        // .gravity allinea la scena alla gravità (verticale)
        // .heading orienta rispetto al Nord magnetico

        // Avvia la sessione AR con questa configurazione
        arView.session.run(configuration)

        // Crea un "ancoraggio" nello spazio (punto fisso nella scena AR con coordinate 0,0,0)
        let anchor = AnchorEntity(world: .zero)

        // Per ogni stella, crea una piccola sfera luminosa
        for star in stars {
            // Crea una forma 3D con ModelEntity(mesh:)
            let sphere = ModelEntity(mesh: .generateSphere(radius: 0.03))

            // Usa UnlitMaterial per rendere la stella auto-illuminante
            let starMaterial = UnlitMaterial(color: .white)
            sphere.model?.materials = [starMaterial]

            // Imposta la posizione nello spazio 3D (in metri)
            sphere.position = star.position

            // Componente di emissione al SimpleMaterial per un effetto più marcato
            sphere.model?.materials = [
                SimpleMaterial(color: .white, isMetallic: false)
            ]

            // Aggiungi la sfera all'ancora
            anchor.addChild(sphere)

            // Genera testo 3D per mostrare il nome della stella
            let textMesh = MeshResource.generateText(
                star.name,
                extrusionDepth: 0.01,
                font: .systemFont(ofSize: 0.05),
                containerFrame: .zero,
                alignment: .center,
                lineBreakMode: .byWordWrapping
            )

            let textEntity = ModelEntity(
                mesh: textMesh,
                materials: [SimpleMaterial(color: .cyan, isMetallic: false)]
            )

            // Posiziona il nome leggermente sopra la stella
            textEntity.position = [
                star.position.x,
                star.position.y + 0.05,
                star.position.z,
            ]

            // Riduci la scala per evitare che sia troppo grande
            textEntity.scale = [0.5, 0.5, 0.5]

            // Aggiungi il testo all'ancora
            anchor.addChild(textEntity)
        }

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

import RealityKit
import SwiftUI

struct StarLabelModel {

    // Funzione statica che crea un'etichetta 3D con il nome della stella (posizionata sopra la stella)
    static func makeLabel(for star: Star) -> ModelEntity {
        // Mesh del testo 3D con il nome della stella
        let textMesh = MeshResource.generateText(
            star.name,
            extrusionDepth: 0.01,  // profondità del testo (quanto sporge in 3D)
            font: .systemFont(ofSize: 0.05),
            containerFrame: .zero,
            alignment: .center,
            lineBreakMode: .byWordWrapping  // come gestire eventuali interruzioni di linea
        )

        // Crea un ModelEntity usando il mesh appena creato
        let textEntity = ModelEntity(
            mesh: textMesh,
            materials: [UnlitMaterial(color: .white)]
        )

        // Posiziona il testo nella scena 3D sopra la stella
        textEntity.position = [
            star.position.x,
            star.position.y + 0.05,
            star.position.z,
        ]

        // Scala più piccola per non coprire troppo
        textEntity.scale = [0.5, 0.5, 0.5]

        // Billboard: il testo ruota automaticamente per guardare sempre la fotocamera
        textEntity.components[BillboardComponent.self] = BillboardComponent()

        return textEntity
    }
}

import RealityKit
import SwiftUI

struct StarLabelModel {

    // ModelEntity con il nome della stella posizionato sopra la stella
    static func makeLabel(for star: Star) -> ModelEntity {
        // Mesh del testo
        let textMesh = MeshResource.generateText(
            star.name,
            extrusionDepth: 0.01,
            font: .systemFont(ofSize: 0.05),
            containerFrame: .zero,
            alignment: .center,
            lineBreakMode: .byWordWrapping
        )

        // Entità del testo
        let textEntity = ModelEntity(
            mesh: textMesh,
            materials: [UnlitMaterial(color: .black)]
        )

        // Posiziona il nome sopra la stella
        textEntity.position = [
            star.position.x,
            star.position.y + 0.05,
            star.position.z,
        ]

        // Scala più piccola per non coprire troppo
        textEntity.scale = [0.5, 0.5, 0.5]

        // Billboard: fa sì che il testo guardi sempre la fotocamera
        textEntity.components[BillboardComponent.self] = BillboardComponent()

        return textEntity
    }
}

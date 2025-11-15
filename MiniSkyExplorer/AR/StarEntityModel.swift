import RealityKit
import SwiftUI

struct StarEntityModel {

    // Funzione che crea una sfera (ModelEntity) che rappresenta una stella
    static func makeStarSphere(for star: Star) -> ModelEntity {
        let starSphere = ModelEntity(mesh: .generateSphere(radius: 0.03))  // raggio 3cm

        // SimpleMaterial (illuminato dalla scena)
        starSphere.model?.materials = [
            SimpleMaterial(color: .yellow, isMetallic: false)
        ]

        // Posiziona la sfera nella scena
        starSphere.position = star.position

        // Restituisce la sfera configurata
        return starSphere
    }
}

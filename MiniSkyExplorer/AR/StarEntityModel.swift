import RealityKit
import SwiftUI

struct StarEntityModel {

    // Funzione che crea una sfera (ModelEntity) che rappresenta una stella
    static func makeStarSphere(for star: Star) -> ModelEntity {
        let starSphere = ModelEntity(mesh: .generateSphere(radius: 0.03))  // raggio 3cm

        // Materiale Unlit non illuminato: colore fisso (ignora la luce della scena), la stella brilla sempre uguale
        let unlitMaterial = UnlitMaterial(color: .yellow)
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

import RealityKit
import SwiftUI

struct StarEntityModel {

    static func makeStarSphere(for star: Star) -> ModelEntity {
        // Creazione della sfera che rappresenta la stella
        let starSphere = ModelEntity(mesh: .generateSphere(radius: 0.03))
        
        // Materiale Unlit per effetto retroilluminato
        let unlitMaterial = UnlitMaterial(color: .yellow)
        starSphere.model?.materials = [unlitMaterial]
        
        // Posizionamento della sfera nella scena
        starSphere.position = star.position

        // Componente di emissione al SimpleMaterial per un effetto più marcato
        starSphere.model?.materials = [
            SimpleMaterial(color: .yellow, isMetallic: false)
        ]

        // Restituisce la stella completa
        return starSphere
    }
}

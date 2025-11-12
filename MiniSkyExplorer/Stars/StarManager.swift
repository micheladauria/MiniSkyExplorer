import Combine
import Foundation
import simd

// Elenco di stelle osservabile da SwiftUI
class StarManager: ObservableObject {
    @Published var stars: [Star] = []

    init() {
        // Set base di stelle con coordinate 3D (metri)
        stars = [
            Star(name: "Sirius", position: [0, 0, -1.0]),
            Star(name: "Betelgeuse", position: [0.3, 0.2, -1.2]),
            Star(name: "Rigel", position: [-0.4, -0.1, -1.3]),
            Star(name: "Vega", position: [0.1, 0.4, -1.5]),
            Star(name: "Polaris", position: [0, 0.5, -2.0]),
        ]
    }
}

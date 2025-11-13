import Combine
import Foundation
import simd

class StarManager: ObservableObject {
    @Published var stars: [Star] = []

    init() {
        // Lista originale delle stelle con posizioni
        stars = [
            Star(name: "Sun", position: [0, 0.6, 0]),
            Star(name: "Mercury", position: [0.4, 0.0, -0.2]),
            Star(name: "Venus", position: [0.7, 0.0, -0.5]),
            Star(name: "Mars", position: [1.2, 0.05, -1.0]),
            Star(name: "Jupiter", position: [5.2, -0.1, -1.5]),
            Star(name: "Saturn", position: [9.5, 0.1, 1.0]),
            Star(name: "Uranus", position: [19.8, -0.05, -1.5]),
            Star(name: "Neptune", position: [30.0, 0.05, -2.0]),
            Star(name: "Pluto", position: [39.5, -0.02, -2.5]),
            Star(name: "Sirius", position: [1.6, 0.8, -0.6]),
            Star(name: "Betelgeuse", position: [-2.0, 1.0, 2.0]),
            Star(name: "Rigel", position: [1.5, 0.3, 2.5]),
            Star(name: "Vega", position: [-0.5, 0.4, -1.0]),
            Star(name: "Polaris", position: [0.0, 1.2, -1.3]),
            Star(name: "Alpha Centauri", position: [-0.5, 0.6, -2.37]),
            Star(name: "Proxima Centauri", position: [-0.6, 0.5, -2.24]),
            Star(name: "Barnard's Star", position: [0.3, 0.4, -2.98]),
            Star(name: "Wolf 359", position: [0.2, 0.3, -2.8]),
            Star(name: "Lalande 21185", position: [-0.1, 0.2, 2.3]),
            Star(name: "Sirius B", position: [1.65, 0.85, -3.6]),
            Star(name: "Epsilon Eridani", position: [0.4, 0.7, -2.65]),
            Star(name: "Altair", position: [0.15, 0.6, -2.07]),
            Star(name: "Fomalhaut", position: [-0.25, 0.8, 1.56]),
            Star(name: "Deneb", position: [0.4, 1.0, -1.62]),
        ]
    }
}

import Foundation
import SwiftUI
import simd  // Libreria per gestire vettori 3D (SIMD3<Float>)

// Rappresenta una singola stella nel cielo AR
struct Star: Identifiable, Equatable {
    let id = UUID()  // Ogni stella ha un ID univoco
    let name: String  // Nome della stella
    let position: SIMD3<Float>  // Posizione nello spazio 3D (x, y, z). Le coordinate sono espresse in metri
}

/*
 X → destra/sinistra
 Y → su/giù
 Z → avanti/indietro (negativo = “davanti” alla fotocamera)
 */

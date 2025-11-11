import Foundation
import simd  // Libreria per gestire vettori 3D (SIMD3<Float>)

// Rappresenta una singola stella nel cielo AR
struct Star: Identifiable {
    let id = UUID()  // Ogni stella ha un ID univoco
    let name: String  // Nome della stella (es. "Sirius")
    let position: SIMD3<Float>  // Posizione nello spazio 3D
}

/*
 SPIEGAZIONE:
 SIMD3<Float> rappresenta un vettore tridimensionale (x, y, z).
 Le coordinate sono espresse in metri nel mondo AR.
 X → destra/sinistra
 Y → su/giù
 Z → avanti/indietro (negativo = “davanti” alla fotocamera)
 */

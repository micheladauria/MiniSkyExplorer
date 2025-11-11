import Combine  // Necessario per ObservableObject e @Published
import CoreMotion  // Framework per leggere accelerometri e giroscopi
import Foundation

// MotionManager gestisce i dati del sensore di movimento e aggiorna la UI in tempo reale
class MotionManager: ObservableObject {

    // MARK: - Proprietà

    // Oggetto principale per leggere dati dai sensori di movimento
    private var motionManager = CMMotionManager()

    // Contiene l'orientamento attuale del dispositivo (roll, pitch, yaw)
    // L'annotazione @Published permette alle view SwiftUI di aggiornarsi automaticamente quando cambia
    @Published var attitude: CMAttitude?

    // MARK: - Inizializzazione

    // Inizializza il MotionManager e avvia la lettura dei sensori
    // updateInterval è l'intervallo di aggiornamento in secondi
    init(updateInterval: TimeInterval = 0.05) {
        // Imposta la frequenza di aggiornamento dei dati dal sensore
        motionManager.deviceMotionUpdateInterval = updateInterval

        // Avvia la raccolta dei dati di movimento sul thread principale
        // La closure viene chiamata ogni volta che arrivano nuovi dati
        motionManager.startDeviceMotionUpdates(to: .main) {
            [weak self] motionData, error in
            // Controlla che i dati siano validi
            if let validData = motionData {
                // Aggiorna la proprietà attitude
                // @Published si occuperà di notificare le view SwiftUI
                self?.attitude = validData.attitude
            }
        }
    }

    // MARK: - Stop (ferma la raccolta dei dati dal sensore per ottimizzare la batteria)

    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }

    // MARK: - Deinitializer (Ferma automaticamente i sensori quando l'oggetto viene deallocato per ottimizzare la batteria)

    deinit {
        motionManager.stopDeviceMotionUpdates()
        print("MotionManager deallocato: sensori fermati.")
    }
}

/*
 Spiegazione
 CMMotionManager: gestisce tutti i sensori (accelerometro, giroscopio, magnetometro).
 deviceMotionUpdateInterval: ogni quanto ricevi un nuovo valore.
 startDeviceMotionUpdates: avvia la raccolta dati.
 attitude: contiene tre valori fondamentali:
 pitch → inclinazione (su/giù)
 roll → rotazione laterale
 yaw → rotazione orizzontale, cioè dove stai “puntando”
 */

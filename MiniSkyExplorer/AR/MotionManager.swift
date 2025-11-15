import Combine  // Necessario per ObservableObject e @Published
import CoreMotion  // Framework per leggere accelerometri e giroscopi
import Foundation

// MotionManager è un ObservableObject: SwiftUI può osservarlo e aggiornare la UI automaticamente
class MotionManager: ObservableObject {

    // MARK: - Proprietà

    // CMMotionManager gestisce l’accesso ai sensori di movimento del dispositivo
    private var motionManager = CMMotionManager()

    // @Published permette di notificare automaticamente la UI ogni volta che cambia il valore
    @Published var attitude: CMAttitude?

    // MARK: - Inizializzazione

    // Inizializza il MotionManager e avvia la lettura dei sensori
    // updateInterval è l'intervallo di aggiornamento in secondi
    init(updateInterval: TimeInterval = 0.05) {
        // Imposta la frequenza di aggiornamento dei dati dal sensore
        motionManager.deviceMotionUpdateInterval = updateInterval

        // Avvio dei sensori: riceviamo CMAttitude, accelerazione, rotazione ecc.
        // Li riceviamo sul thread principale (.main), utile se la UI deve aggiornarsi
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

    // MARK: - Stop
    // Ferma la raccolta dei dati dal sensore per ottimizzare la batteria
    func stopUpdates() {
        motionManager.stopDeviceMotionUpdates()
    }

    // MARK: - Deinitializer
    // Deinit viene chiamato quando l’istanza viene distrutta
    // Ferma gli aggiornamenti per evitare memory leak o uso inutile della batteria
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}

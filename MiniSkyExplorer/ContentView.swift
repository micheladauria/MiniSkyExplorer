import CoreMotion
import SwiftUI

struct ContentView: View {

    // @StateObject crea un’istanza OSSERVABILE di MotionManager. Ogni volta che attitude cambia, la vista si aggiorna automaticamente
    @StateObject private var motion = MotionManager()
    
    var body: some View {
        ZStack {
            // ZStack sovrappone il layer AR con il layer UI (testi)
            // ARViewContainer() è la fotocamera AR
            ARViewContainer()
                .ignoresSafeArea(.all, edges: .all)

            // testo con overlay sopra la fotocamera
            VStack {
                Text("🌌 Mini Sky Explorer")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                    .padding(8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.top, 50)

                Spacer()

                Text("Muovi il telefono per esplorare!")
                    .font(.subheadline)
                    .bold()
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.bottom, 50)

                // Mostra i valori dei tre assi
                VStack(spacing: 10) {
                    Text(
                        "Pitch: \(motion.attitude?.pitch ?? 0, specifier: "%.2f")"
                    ) // specifier: "%.2f" limita i numeri a due decimali per leggibilità
                    Text(
                        "Roll: \(motion.attitude?.roll ?? 0, specifier: "%.2f")"
                    )
                    Text("Yaw: \(motion.attitude?.yaw ?? 0, specifier: "%.2f")")
                }
                .font(.system(.body, design: .monospaced))
                .padding(12)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding(.bottom, 40)
            }
            .foregroundColor(.white)
            .shadow(radius: 2)
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}

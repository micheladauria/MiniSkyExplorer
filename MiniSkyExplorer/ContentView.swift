import CoreMotion
import SwiftUI

struct ContentView: View {

    // @StateObject crea un’istanza OSSERVABILE di MotionManager. Ogni volta che attitude cambia, la vista si aggiorna automaticamente
    @StateObject private var motion = MotionManager()

    var body: some View {
        ZStack {

            // ARViewContainer() è la fotocamera AR (sfondo AR)
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

            }
            .foregroundColor(.white)
            .padding()
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}

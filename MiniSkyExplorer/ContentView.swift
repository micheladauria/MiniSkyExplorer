import CoreMotion
import SwiftUI

struct ContentView: View {

    // @StateObject crea un’istanza OSSERVABILE di MotionManager. Ogni volta che attitude cambia, la vista si aggiorna automaticamente
    @StateObject private var motion = MotionManager()
    // Istanza condivisa del gestore delle stelle
    @StateObject private var starManager = StarManager()

    var body: some View {
        ZStack {

            // ARViewContainer() è la fotocamera AR (sfondo AR)
            ARViewContainer(starManager: starManager)
                .ignoresSafeArea(.all, edges: .all)

                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}

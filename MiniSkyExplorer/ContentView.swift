import CoreMotion
import SwiftUI

struct ContentView: View {

    // @StateObject crea un’istanza OSSERVABILE di MotionManager.
    //Ogni volta che attitude in MotionManager cambia, la vista si aggiorna automaticamente
    @StateObject private var motion = MotionManager()
    // Istanza condivisa del gestore delle stelle
    @StateObject private var starManager = StarManager()
    // Variabile di stato per il passaggio tra fotocamera e panorama
    @State private var showARView = true

    var body: some View {
        ZStack {
            if showARView {
                // ARViewContainer() è la fotocamera con AR
                ARViewContainer(starManager: starManager)
                    .ignoresSafeArea(.all, edges: .all)
                    .navigationBarBackButtonHidden(true)
            } else {
                // Vista panoramica
                ARPanoramaView(imageName: "aaa")
                    .ignoresSafeArea(.all)
            }

            // Pulsante per cambiare vista
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showARView.toggle()
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(
                                systemName: showARView
                                    ? "camera.viewfinder"
                                    : "globe.europe.africa.fill"
                            )
                            .font(.headline)
                            Text(showARView ? "Galaxy View" : "Camera View")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .background(Color.black.opacity(0.6))
                        .foregroundColor(.white)
                        .cornerRadius(14)
                        .shadow(radius: 4)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

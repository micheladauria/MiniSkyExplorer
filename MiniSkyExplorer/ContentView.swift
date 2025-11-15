import CoreMotion
import SwiftUI

struct ContentView: View {

    // @StateObject crea un’istanza OSSERVABILE di MotionManager
    // MotionManager gestisce i dati del sensore del dispositivo
    @StateObject private var motion = MotionManager()
    // StarManager contiene tutte le stelle e permette di aggiornarle dinamicamente
    @StateObject private var starManager = StarManager()
    // Stato che controlla il passaggio tra fotocamera e panorama
    @State private var showARView = true

    var body: some View {
        ZStack {
            // Mostra la fotocamera se showARView è true
            if showARView {
                ARViewContainer(starManager: starManager)
                    .ignoresSafeArea(.all, edges: .all)
                    .navigationBarBackButtonHidden(true)
            } else {
                // Altrimenti mostra una vista panoramica
                ARPanoramaView(imageName: "aaa")
                    .ignoresSafeArea(.all)
            }

            // Pulsante per cambiare vista
            VStack {
                Spacer()  // Spinge il pulsante verso il basso
                HStack {
                    Spacer()  // Spinge il pulsante verso destra
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showARView.toggle()  // Alterna tra camera e panorama
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

import ARKit
import RealityKit
import SwiftUI

struct StarOverlayView: View {

    @ObservedObject var starManager: StarManager

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Itera su ogni stella per creare un'etichetta
                ForEach(starManager.stars) { star in
                    // Le etichette vengono disposte in base a coordinate 3D proiettate su 2D.
                    // Per ora sono posizioni statiche semplificate.

                    Text(star.name)
                        .font(.caption)
                        .padding(6)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .position(
                            x: geo.size.width / 2
                                + CGFloat(star.position.x * 200),
                            y: geo.size.height / 2
                                - CGFloat(star.position.y * 200)
                        )
                }
            }
        }
    }
}

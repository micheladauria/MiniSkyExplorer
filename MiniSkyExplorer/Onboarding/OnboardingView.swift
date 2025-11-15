import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false  // Salva in AppStorage se l’utente ha già visto l’onboarding

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image
                Image("nebula")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.5),
                                Color.black.opacity(0.2),
                                Color.black.opacity(1),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )

                // Content
                VStack {
                    Spacer()

                    Text("Explore the Universe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 10)

                    Text("Point your phone at the sky and discover the stars!")
                        .font(.body)
                        .fontWeight(.regular)
                        .fontDesign(.rounded)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 150)

                    // NavigationLink
                    NavigationLink(value: "main") {
                        Text("Start the Adventure")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(maxWidth: 350)
                            .frame(height: 56)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .shadow(
                                color: Color.blue.opacity(0.3),
                                radius: 10,
                                x: 0,
                                y: 5
                            )
                            .padding(.horizontal, 32)
                    }

                    // salva che l’onboarding è completato
                    .simultaneousGesture(
                        TapGesture().onEnded {
                            hasSeenOnboarding = true
                        }
                    )

                    Spacer().frame(height: 40)
                }
            }

            // definisce la destinazione
            .navigationDestination(for: String.self) { value in
                if value == "main" {
                    ContentView()
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}

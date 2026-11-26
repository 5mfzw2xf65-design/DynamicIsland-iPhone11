import SwiftUI

struct ContentView: View {
    @State private var expanded = false
    @State private var selectedTab = 0
    @State private var isPlaying = true
    @State private var isCharging = true
    @State private var showNotice = false
    @State private var seconds = 125
    @State private var timerRunning = false

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 0.025, green: 0.025, blue: 0.035).ignoresSafeArea()
            VStack(spacing: 22) {
                header
                island
                    .padding(.top, 8)
                Text("DYNAMIC ISLAND")
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .tracking(3)
                    .foregroundStyle(.white.opacity(0.42))
                tabContent
                Spacer(minLength: 8)
                Text("iPhone 11 • IN-APP EXPERIENCE")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .tracking(1.4)
                    .foregroundStyle(.white.opacity(0.28))
            }
            .padding(.horizontal, 22)
            .padding(.top, 18)
        }
        .onReceive(ticker) { _ in
            if timerRunning && seconds > 0 { seconds -= 1 }
        }
        .alert("Demo notification", isPresented: $showNotice) {
            Button("Got it", role: .cancel) { }
        } message: {
            Text("This is a sample notification shown inside the app.")
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Hello.")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                Text("Your island, reimagined.")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.48))
            }
            Spacer()
            Image(systemName: "waveform")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.red)
                .frame(width: 46, height: 46)
                .background(.white.opacity(0.06), in: Circle())
                .overlay(Circle().stroke(.white.opacity(0.08), lineWidth: 1))
        }
    }

    private var island: some View {
        VStack(spacing: 14) {
            HStack(spacing: 10) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 0.8, green: 0.08, blue: 0.12))
                    .frame(width: 34, height: 34)
                    .overlay(Image(systemName: "waveform").font(.system(size: 15, weight: .bold)).foregroundStyle(.white))
                VStack(alignment: .leading, spacing: 3) {
                    Text("Now Playing")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                    Text("Midnight City • M83")
                        .font(.system(size: 10))
                        .foregroundStyle(.white.opacity(0.55))
                }
                Spacer()
                HStack(spacing: 3) {
                    ForEach(0..<4) { i in
                        Capsule().fill(Color.red.opacity(0.9))
                            .frame(width: 3, height: CGFloat([8, 15, 10, 18][i]))
                    }
                }
                .frame(height: 20)
            }
            if expanded {
                HStack(spacing: 18) {
                    Image(systemName: "backward.end.fill")
                    Button { isPlaying.toggle() } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.black)
                            .frame(width: 38, height: 38)
                            .background(.white, in: Circle())
                    }
                    Image(systemName: "forward.end.fill")
                    Spacer()
                    Image(systemName: "airplay.audio")
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.white)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity)
        .background(Color.black, in: RoundedRectangle(cornerRadius: expanded ? 28 : 24, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: expanded ? 28 : 24).stroke(.white.opacity(0.12), lineWidth: 1))
        .shadow(color: .red.opacity(0.12), radius: 24, y: 8)
        .onTapGesture { withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) { expanded.toggle() } }
        .accessibilityHint("Double tap to expand or collapse the demo island")
    }

    @ViewBuilder
    private var tabContent: some View {
        VStack(spacing: 12) {
            HStack(spacing: 10) {
                tabButton("Music", icon: "music.note", index: 0)
                tabButton("Battery", icon: "battery.100", index: 1)
                tabButton("Timer", icon: "timer", index: 2)
            }
            Group {
                switch selectedTab {
                case 0: musicCard
                case 1: batteryCard
                default: timerCard
                }
            }
            .frame(maxWidth: .infinity, minHeight: 190)
            .padding(18)
            .background(Color.white.opacity(0.045), in: RoundedRectangle(cornerRadius: 24))
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(.white.opacity(0.07), lineWidth: 1))
            Button { showNotice = true } label: {
                Label("Show demo notification", systemImage: "bell.badge.fill")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.red.opacity(0.82), in: RoundedRectangle(cornerRadius: 16))
            }
        }
    }

    private func tabButton(_ title: String, icon: String, index: Int) -> some View {
        Button { withAnimation(.easeInOut(duration: 0.2)) { selectedTab = index } } label: {
            Label(title, systemImage: icon)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(selectedTab == index ? .white : .white.opacity(0.48))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(selectedTab == index ? Color.red.opacity(0.22) : Color.white.opacity(0.04), in: RoundedRectangle(cornerRadius: 13))
        }
    }

    private var musicCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("MUSIC PLAYER").font(.system(size: 10, weight: .bold)).tracking(2).foregroundStyle(.red)
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 14).fill(LinearGradient(colors: [.red, .purple, .black], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 62, height: 62)
                    .overlay(Image(systemName: "music.note").font(.system(size: 25, weight: .bold)).foregroundStyle(.white))
                VStack(alignment: .leading, spacing: 5) {
                    Text("Midnight City").font(.system(size: 16, weight: .bold)).foregroundStyle(.white)
                    Text("M83 • Hurry Up, We're Dreaming").font(.system(size: 10)).foregroundStyle(.white.opacity(0.5))
                }
            }
            HStack {
                Image(systemName: "backward.end.fill")
                Spacer()
                Button { isPlaying.toggle() } label: { Image(systemName: isPlaying ? "pause.fill" : "play.fill").foregroundStyle(.white) }
                Spacer()
                Image(systemName: "forward.end.fill")
            }
            .font(.system(size: 17, weight: .semibold)).foregroundStyle(.white.opacity(0.8))
        }
    }

    private var batteryCard: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("POWER STATUS").font(.system(size: 10, weight: .bold)).tracking(2).foregroundStyle(.red)
            HStack(alignment: .center) {
                Image(systemName: isCharging ? "battery.100percent.bolt" : "battery.75percent")
                    .font(.system(size: 38, weight: .light)).foregroundStyle(isCharging ? .green : .white)
                VStack(alignment: .leading, spacing: 4) {
                    Text("86%").font(.system(size: 30, weight: .bold, design: .rounded)).foregroundStyle(.white)
                    Text(isCharging ? "Charging" : "On battery").font(.system(size: 12)).foregroundStyle(.white.opacity(0.5))
                }
                Spacer()
            }
            Button { isCharging.toggle() } label: {
                Text(isCharging ? "Pause charging demo" : "Show charging demo")
                    .font(.system(size: 12, weight: .semibold)).foregroundStyle(.white)
                    .padding(.horizontal, 14).padding(.vertical, 10)
                    .background(.white.opacity(0.09), in: Capsule())
            }
        }
    }

    private var timerCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("FOCUS TIMER").font(.system(size: 10, weight: .bold)).tracking(2).foregroundStyle(.red)
            Text(String(format: "%02d:%02d", seconds / 60, seconds % 60))
                .font(.system(size: 42, weight: .light, design: .rounded).monospacedDigit())
                .foregroundStyle(.white)
            HStack {
                Button { timerRunning.toggle() } label: {
                    Label(timerRunning ? "Pause" : "Start", systemImage: timerRunning ? "pause.fill" : "play.fill")
                        .font(.system(size: 12, weight: .semibold)).foregroundStyle(.white)
                        .padding(.horizontal, 15).padding(.vertical, 10).background(Color.red.opacity(0.8), in: Capsule())
                }
                Button { seconds = 125; timerRunning = false } label: {
                    Label("Reset", systemImage: "arrow.counterclockwise")
                        .font(.system(size: 12, weight: .semibold)).foregroundStyle(.white.opacity(0.7))
                }
            }
        }
    }
}

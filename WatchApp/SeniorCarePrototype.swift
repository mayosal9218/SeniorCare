import SwiftUI
import Combine

@main
struct SeniorCareWatchApp: App {
    @StateObject private var store = CareStore()
    var body: some Scene { WindowGroup { HomeView().environmentObject(store) } }
}

final class CareStore: ObservableObject {
    @Published var residentName = "Margaret"
    @Published var reminders = ["Morning medicine — 8:00 AM", "Drink water — 10:30 AM", "Call family — 4:00 PM"]
}

struct HomeView: View {
    @EnvironmentObject private var store: CareStore
    var body: some View {
        NavigationStack { List {
            Section { Text(Date.now, format: .dateTime.weekday(.wide).month().day().hour().minute()).font(.footnote); Text("Hello, \(store.residentName)").font(.title3.bold()); Label("Heart rate 72 BPM · normal for you", systemImage: "heart.fill").foregroundStyle(.green).font(.footnote) }
            Section("Care") { NavigationLink("Care Assistant", destination: AssistantView()); NavigationLink("Reminders", destination: ReminderView()); NavigationLink("Health", destination: HealthView()) }
            Section("Activities") { NavigationLink("Games", destination: GamesView()); NavigationLink("Settings", destination: SettingsView()) }
            Section { NavigationLink(destination: SOSView()) { Label("SOS — Get help", systemImage: "exclamationmark.triangle.fill").font(.headline).foregroundStyle(.white).frame(maxWidth: .infinity).padding(8).background(.red, in: Capsule()) } }
        }.navigationTitle("SeniorCare") }
    }
}

struct AssistantView: View {
    @State private var message = "How are you feeling today?"
    var body: some View { List { Text(message).font(.headline); Button("I feel good") { message = "I’m glad to hear that. Would you like a water reminder?" }; Button("Create a medicine reminder") { message = "In Version 0.1, reminders are sample data. Later, I’ll confirm a time before creating one." }; Text("This assistant does not diagnose medical conditions.").font(.footnote).foregroundStyle(.secondary) }.navigationTitle("Care Assistant") }
}

struct HealthView: View {
    let vitals = [("Heart rate", "72 BPM", "70 BPM", "64–78 BPM", "Stable"), ("Steps", "2,340", "2,105", "2,000 by now", "On track"), ("Sleep", "7 hr 12 min", "6 hr 48 min", "7 hr", "Improving")]
    var body: some View { List(vitals, id: \.0) { vital in VStack(alignment: .leading) { Text(vital.0).font(.headline); Text(vital.1).font(.title3.bold()).foregroundStyle(.green); Text("Previous \(vital.2) · Usual \(vital.3)").font(.footnote); Text(vital.4).font(.footnote).foregroundStyle(.secondary) } }.navigationTitle("Health") }
}

struct ReminderView: View {
    @EnvironmentObject private var store: CareStore
    var body: some View { List { ForEach(store.reminders, id: \.self) { Label($0, systemImage: "checkmark.circle.fill").foregroundStyle(.blue) }; Text("Reminder scheduling and notifications come in Version 0.2/0.3.").font(.footnote).foregroundStyle(.secondary) }.navigationTitle("Reminders") }
}

struct SOSView: View {
    @State private var confirmed = false
    var body: some View { VStack(spacing: 12) { Image(systemName: "exclamationmark.triangle.fill").font(.largeTitle).foregroundStyle(.red); Text(confirmed ? "Emergency alert prepared" : "Need help?").font(.headline); Text(confirmed ? "In this prototype, no message was sent. A later version will notify the care team after a countdown." : "Press once to confirm. This reduces accidental alerts.").font(.footnote).multilineTextAlignment(.center); Button(confirmed ? "Cancel" : "Confirm SOS") { confirmed.toggle() }.tint(.red) }.padding().navigationTitle("SOS") }
}

struct GamesView: View {
    var body: some View { List { NavigationLink("Chess", destination: ChessView()); ForEach(["Checkers", "Sudoku", "Memory", "Tic-Tac-Toe", "Connect Four"], id: \.self) { Label($0 + " — coming soon", systemImage: "gamecontroller.fill") } }.navigationTitle("Games") }
}

struct ChessView: View {
    @State private var selected: Int?; @State private var lightTurn = true
    let pieces = ["♜","♞","♝","♛","♚","♝","♞","♜","♟","♟","♟","♟","♟","♟","♟","♟","","","","","","","","","","","","","","","","","","","","","","","","","♙","♙","♙","♙","♙","♙","♙","♙","♖","♘","♗","♕","♔","♗","♘","♖"]
    var body: some View { VStack { Text(lightTurn ? "White’s turn" : "Black’s turn").font(.headline); LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 8), spacing: 0) { ForEach(0..<64, id: \.self) { index in Button(pieces[index]) { selected = selected == index ? nil : index; lightTurn.toggle() }.font(.system(size: 20)).frame(width: 20, height: 20).background((index / 8 + index % 8).isMultiple(of: 2) ? Color.brown.opacity(0.35) : Color.yellow.opacity(0.55)).overlay { if selected == index { RoundedRectangle(cornerRadius: 2).stroke(.blue, lineWidth: 2) } } } }; Text("Touch a piece to select it. Full legal-move validation is scheduled for the next chess iteration.").font(.footnote).multilineTextAlignment(.center) }.navigationTitle("Chess") }
}

struct SettingsView: View {
    @EnvironmentObject private var store: CareStore
    var body: some View { Form { TextField("Your name", text: $store.residentName); Toggle("Daily check-in", isOn: .constant(true)); Picker("Assistant style", selection: .constant("Warm")) { Text("Warm").tag("Warm"); Text("Brief").tag("Brief") }; Text("Care-team customization, consent, and security controls are planned for the connected system.").font(.footnote) }.navigationTitle("Settings") }
}

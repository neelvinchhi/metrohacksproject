// ConversationsViewModel.swift

import SwiftUI

// Model for a message
struct Message: Identifiable, Codable {
    var id = UUID()
    var text: String
    var isSentByUser: Bool
    var timestamp: Date
}

// Observable object for a conversation
class ConversationViewModel: ObservableObject, Identifiable {
    @Published var conversation: Conversation

    init(conversation: Conversation) {
        self.conversation = conversation
    }

    // Save conversation to UserDefaults
    func saveConversation() {
        let encoder = JSONEncoder()
        if let encodedConversation = try? encoder.encode(conversation) {
            UserDefaults.standard.set(encodedConversation, forKey: "conversation_\(conversation.id)")
        }
    }
}

// Model for a conversation
struct Conversation: Identifiable, Codable {
    var id = UUID()
    var contactName: String
    var messages: [Message]
}

// ViewModel to manage conversations
class ConversationsViewModel: ObservableObject {
    @Published var conversations: [ConversationViewModel]

    init() {
        if let conversationIDs = UserDefaults.standard.array(forKey: "conversationIDs") as? [UUID] {
            self.conversations = conversationIDs.map { id in
                let key = "conversation_\(id)"
                if let savedConversationData = UserDefaults.standard.data(forKey: key) {
                    let decoder = JSONDecoder()
                    if let decodedConversation = try? decoder.decode(Conversation.self, from: savedConversationData) {
                        return ConversationViewModel(conversation: decodedConversation)
                    }
                }
                return ConversationViewModel(conversation: Conversation(contactName: "Unknown", messages: []))
            }
        } else {
            // If no conversations are saved, create a default one
            self.conversations = [
                ConversationViewModel(conversation: Conversation(contactName: "John Doe", messages: [])),
            ]
        }
    }

    // Save conversations to UserDefaults
    func saveConversations() {
        let encoder = JSONEncoder()
        conversations.forEach { viewModel in
            let key = "conversation_\(viewModel.conversation.id)"
            if let encodedConversation = try? encoder.encode(viewModel.conversation) {
                UserDefaults.standard.set(encodedConversation, forKey: key)
            }
        }

        let conversationIDs = conversations.map { $0.conversation.id }
        UserDefaults.standard.set(conversationIDs, forKey: "conversationIDs")
    }
    func addMessage(_ message: Message) {
        conversation.messages.append(message)
        saveConversation()
    }
}

struct ConversationRow: View {
    @ObservedObject var conversationViewModel: ConversationViewModel

    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(conversationViewModel.conversation.contactName)
                    .font(.headline)
                Text(conversationViewModel.conversation.messages.last?.text ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
        }
        .padding(8)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ConversationsViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.conversations) { conversationViewModel in
                NavigationLink(
                    destination: ChatView(conversationViewModel: conversationViewModel),
                    label: {
                        ConversationRow(conversationViewModel: conversationViewModel)
                    }
                )
            }
            .navigationTitle("Messages")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


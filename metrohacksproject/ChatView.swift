// ChatView.swift

import SwiftUI


struct ChatView: View {
    @State private var newMessageText = ""
    @State private var messages: [Message] = []

    var body: some View {
        VStack {
            List(messages) { message in
                MessageRow(message: message)
            }

            HStack {
                TextField("Type a message", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)

                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                }
                .padding(8)
            }
            .padding()
        }
        .navigationTitle("Chat")
    }

    func sendMessage() {
        guard !newMessageText.isEmpty else { return }

        let newMessage = Message(text: newMessageText, isSentByUser: true, timestamp: Date())
        messages.append(newMessage)
        newMessageText = ""
    }
}

struct MessageRow: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isSentByUser {
                Spacer()
            }

            Text(message.text)
                .padding(8)
                .background(message.isSentByUser ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)

            if !message.isSentByUser {
                Spacer()
            }
        }
        .padding(.vertical, 4)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

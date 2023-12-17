import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ChatViewModel()
    @State private var draftMessage = ""

    var body: some View {
        VStack {
            Text("Reverb")
                .font(.largeTitle)
                .bold()
                .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.messages) { message in
                        MessageView(message: message)
                    }
                }
                .rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))

            HStack {
                Button(action: {
                    withAnimation {
                        self.viewModel.sendMessage("Receive message", isUser: false)
                    }
                }) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 24))
                }
                TextField("Type a message", text: $draftMessage)
                    .padding()
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(25)

                Button(action: {
                    if !draftMessage.isEmpty {
                        withAnimation {
                            self.viewModel.sendMessage(self.draftMessage, isUser: true)
                            self.draftMessage = ""
                        }
                    }

                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                }
            }
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ChatViewModel.swift
//  metrohacksproject
//
//  Created by Neel Vinchhi on 17/12/23.
//

import Foundation
import Combine
import Starscream

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []

    func sendMessage(_ text: String, isUser: Bool) {
        let message = Message(text: text, isUser: isUser)
        messages.append(message)
    }
}

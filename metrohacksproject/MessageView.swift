//
//  MessageView.swift
//  metrohacksproject
//
//  Created by Neel Vinchhi on 17/12/23.
//

import SwiftUI

struct MessageView: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.trailing, 10)
                    
            } else {
                Text(message.text)
                    .padding(10)
                    .background(Color.gray.opacity(0.15))
                    .foregroundColor(.black)
                    .cornerRadius(25)
                    .padding(.leading, 10)
                Spacer()
            }
        }
        .padding(.vertical, 5)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(text: "Hello", isUser: true))
    }
}


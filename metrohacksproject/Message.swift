//
//  Message.swift
//  metrohacksproject
//
//  Created by Neel Vinchhi on 17/12/23.
//

import Foundation

struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isUser: Bool
}



//
//  OnlineQuotesViewModel.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation
import Combine

class OnlineQuotesViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
     var webSocketManager = WebSocketManager()
     var cancellables = Set<AnyCancellable>()

    init() {
        webSocketManager.$quotes
            .assign(to: \.quotes, on: self)
            .store(in: &cancellables)
    }
}





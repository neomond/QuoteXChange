//
//  OnlineQuotesViewModel.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import Foundation

class OnlineQuotesViewModel: ObservableObject {
    @Published var quotes: [Quote] = []
    @Published var isLoading: Bool = true
    @Published var errorWrapper: ErrorWrapper?
    @Published var isConnected: Bool = false
    
    private var webSocketManager: WebSocketManager

    init(webSocketManager: WebSocketManager = WebSocketManager()) {
        self.webSocketManager = webSocketManager
        self.webSocketManager.$quotes
            .assign(to: &$quotes)
        self.loadCachedQuotes()
        self.connectToWebSocket()

        self.webSocketManager.$isConnected
            .assign(to: &$isConnected)
    }
    
    private func connectToWebSocket() {
        webSocketManager.connect()
        isLoading = false 
    }

    private func loadCachedQuotes() {
        self.quotes = webSocketManager.quotes
        self.isLoading = false 
    }
    
    func disconnect() {
        webSocketManager.disconnect()
    }
}





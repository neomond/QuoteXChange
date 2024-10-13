//
//  WebSocketManager.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 11.10.24.
//

import Foundation
import SocketIO

class WebSocketManager: ObservableObject {
    private var manager: SocketManager
    private var socket: SocketIOClient
    private var quoteCache = QuoteCacheManager()
    
    @Published var quotes: [Quote] = []
    @Published var isConnected: Bool = false
    
    init() {
        manager = SocketManager(socketURL: URL(string: "https://q.investaz.az/live")!, config: [.log(true), .compress, .forceWebsockets(true)])
        socket = manager.defaultSocket
        
        setupSocketEvents()
        loadCachedQuotes()
    }
    
    private func setupSocketEvents() {
        socket.on(clientEvent: .connect) { [weak self] _, _ in
            self?.isConnected = true
            print("Connected to WebSocket")
        }
        
        socket.on(clientEvent: .disconnect) { [weak self] _, _ in
            self?.isConnected = false
            print("Disconnected from WebSocket")
        }
        
        socket.on("quotesUpdate") { [weak self] data, _ in
            print("Received quotes update: \(data)")
            if let quotesData = data as? [[String: Any]] {
                self?.quotes = quotesData.compactMap { Quote(dictionary: $0) }
                self?.quoteCache.saveQuotes(self?.quotes ?? [])
            }
        }
        
        socket.on(clientEvent: .error) { data, _ in
            print("Socket error: \(data)")
        }
    }
    
    func loadCachedQuotes() {
        self.quotes = quoteCache.loadQuotes()
    }

    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
}






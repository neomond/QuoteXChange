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

    @Published var isConnected: Bool = false
    @Published var quotes: [Quote] = []

    init() {
        manager = SocketManager(socketURL: URL(string: "https://q.investaz.az/life")!, config: [.log(true), .compress, .forceWebsockets(true)])
        socket = manager.defaultSocket

        setupSocketEvents()
        socket.connect()
    }

    private func setupSocketEvents() {
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            self?.isConnected = true
            print("Socket connected")
        }

        socket.on(clientEvent: .disconnect) { [weak self] data, ack in
            self?.isConnected = false
            print("Socket disconnected")
        }

        // Listen for messages from the WebSocket
        socket.on("quoteUpdate") { data, ack in
            print("Data received: \(data)") // Print raw data received
            if let quoteData = data as? [[String: Any]] {
                let quotes = quoteData.compactMap { Quote(dictionary: $0) }
                DispatchQueue.main.async {
                    self.quotes = quotes
                }
            }
        }
    }

    deinit {
        socket.disconnect()
    }
}




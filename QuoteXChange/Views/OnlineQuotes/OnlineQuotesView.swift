//
//  OnlineQuotesView.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//


import SwiftUI

struct OnlineQuotesView: View {
    @StateObject private var viewModel = OnlineQuotesViewModel()

    var body: some View {
        VStack {
            if viewModel.webSocketManager.isConnected {
                Text("Connected")
                    .foregroundColor(.green)
            } else {
                Text("Disconnected")
                    .foregroundColor(.red)
            }

            List(viewModel.quotes) { quote in
                HStack {
                    Text(quote.symbol)
                    Spacer()
                    Text(String(format: "%.2f", quote.buyPrice))
                    Text(String(format: "%.2f", quote.sellPrice))
                    Text(String(format: "%.2f", quote.spread))
                }
            }
        }
        .navigationTitle("Online Quotes")
    }
}







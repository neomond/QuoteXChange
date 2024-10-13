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
        NavigationView {
            VStack {
                connectionStatusView
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView("Loading quotes...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .padding()
                } else {
                    List(viewModel.quotes) { quote in
                        HStack {
                            Text(quote.symbol)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Buy: \(quote.buyPrice, specifier: "%.2f")")
                                    .foregroundColor(.green)
                                Text("Sell: \(quote.sellPrice, specifier: "%.2f")")
                                    .foregroundColor(.red)
                                Text("Spread: \(quote.spread, specifier: "%.2f")")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Online Quotes")
            .navigationBarTitleDisplayMode(.inline)
            .alert(item: $viewModel.errorWrapper) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
            .onDisappear {
                viewModel.disconnect()
            }
        }
    }
    
    // Connection status view
    private var connectionStatusView: some View {
        HStack {
            Circle()
                .fill(viewModel.isConnected ? Color.green : Color.red)
                .frame(width: 12, height: 12)
                .overlay(Circle().stroke(Color.red, lineWidth: 1))
            
            Text(viewModel.isConnected ? "Connected" : "Disconnected")
                .font(.body)
                .foregroundColor(viewModel.isConnected ? .green : .red)
                .padding(.leading, 4)
        }
    }
}







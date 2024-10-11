//
//  MainTabView.swift
//  QuoteXChange
//
//  Created by Nazrin Atayeva on 10.10.24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            QuotesConverterView(viewModel: QuotesConverterViewModel())
                .tabItem {
                    Label("Converter", systemImage: "arrow.2.squarepath")
                }
            
            OnlineQuotesView()
                .tabItem {
                    Label("Live Quotes", systemImage: "chart.line.uptrend.xyaxis")
                }
        }
    }
}


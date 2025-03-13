//
//  SwiftUIView.swift
//  TrendyReposViews
//
//  Created by Adam Wienconek on 13/03/2025.
//

import SwiftUI

public struct SettingsView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @AppStorage("forcedarkmode")
    private var forceDarkMode: Bool = false
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading) {
            GroupBox {
                Toggle("Force dark mode", isOn: $forceDarkMode)
                    .padding()
                    .navigationTitle("Settings")
            }
            
            Text("Applied setting will persist across launches")
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
        .padding()
    }
    
}

#Preview {
    SettingsView()
}

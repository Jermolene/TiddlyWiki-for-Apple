//
//  AboutView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 06/06/2024.
//

import SwiftUI

struct AboutView: View {
    @Binding var showAboutView: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                RTFView(filename: "About")
                    .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle("About TiddlyWiki")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        showAboutView = false
                    }
                }
            }
        }
    }
}

#Preview {
    
    NavigationStack {
        ContentView(showAboutView: true)
    }
}

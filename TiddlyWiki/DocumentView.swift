//
//  DocumentView.swift
//  TiddlyWiki
//
//  Created by Jeremy Ruston on 06/06/2024.
//

import SwiftUI

struct DocumentView: View {
    @Binding var showDocumentView: Bool
    @Binding var filename: String
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                RTFView(filename: filename)
                    .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle(filename)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        showDocumentView = false
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DocumentView(showDocumentView: .constant(true), filename: .constant("About"))
    }
}

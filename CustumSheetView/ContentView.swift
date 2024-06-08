//
//  ContentView.swift
//  CustumSheetView
//
//  Created by 柿崎 on 2024/05/26.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingCustomSheet = false

    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            ZStack {
                Button {
                    self.isShowingCustomSheet.toggle()
                } label: {
                    Text("シートを表示する")
                }
                CustomSheet(isShowing: $isShowingCustomSheet, height: height)
            }
        }
    }
}

#Preview {
    ContentView()
}

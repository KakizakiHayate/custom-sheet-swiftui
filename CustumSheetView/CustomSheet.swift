//
//  CustomSheet.swift
//  CustumSheetView
//
//  Created by 柿崎 on 2024/05/26.
//

import SwiftUI

struct CustomSheet: View {
    // MARK: - Property Wrappers
    @Binding var isShowing: Bool
    let height: CGFloat
    @GestureState private var dragState: CGSize = .zero
    @State private var offsetY: CGFloat = 0

    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                if isShowing {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isShowing = false
                            }
                        }

                    VStack {
                        Text("カスタムシートが表示された")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: height / 4)
                    .background(Color.white)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .offset(y: offsetY + (dragState.height > 0 ? dragState.height : 0))
                    .gesture(
                        DragGesture()
                            .updating($dragState) { value, state, _ in
                                if value.translation.height > 0 {
                                    state = value.translation
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    isShowing = false
                                } else {
                                    offsetY = 0
                                }
                            }
                    )
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .animation(.easeInOut, value: isShowing)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

private struct RoundedCorner: Shape {
    // MARK: - Properties
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    // MARK: - Methods
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

private extension View {
    // MARK: - Methods
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


//#Preview {
//    CustomSheet(isShowing: .constant(true), height: .constant(20), width: .constant(30))
//}

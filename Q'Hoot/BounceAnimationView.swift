//
//  BounceAnimationView.swift
//  Q'Hoot
//
//  Created by Easton Butterfield on 5/15/23.
//

import SwiftUI
struct BounceAnimationView: View {
    let characters: Array<String.Element>
    
    @State var offsetYForBounce: CGFloat = -50
    @State var opacity: CGFloat = 0
    @State var baseTime: Double
    @State private var scale: CGFloat = 0.5
    init(text: String, startTime: Double){
        self.characters = Array(text)
        self.baseTime = startTime
    }
    
    var body: some View {
        VStack {
            
            Image("BlueOwl")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale)
                .onAppear() {
                    withAnimation(.spring()) {
                        scale = scale == 0.5 ? 1 : 0.5
                    }
                }
            
            HStack(spacing:0){
                ForEach(0..<characters.count) { num in
                    Text(String(self.characters[num]))
                        .font(.custom("", fixedSize: 54))
                        .offset(x: 0.0, y: offsetYForBounce)
                        .opacity(opacity)
                        .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.1).delay( Double(num) * 0.1 ), value: offsetYForBounce)
                }
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        opacity = 0
                        offsetYForBounce = -50
                    }
                    
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + (0.8 + baseTime)) {
                        opacity = 1
                        offsetYForBounce = 0
                    }
                }
            }
        }
//        .background(
//                    Image("yellowCloud")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .edgesIgnoringSafeArea(.all)
//                    )
    }
}

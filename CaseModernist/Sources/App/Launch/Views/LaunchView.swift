//
//  LaunchView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 4.07.2025.
//

import SwiftUI

struct LaunchView: View {
    @State private var loadingText: [String] = LocalizedKey.loadingLaunch.localized(with: LocalizedKey.appName.localized).map { String($0) }
    @State private var showLoadingText: Bool = false
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @Binding var showLaunchView: Bool
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            Image(.peoplist)
                .resizable()
                .frame(width: 100, height: 100)
                .offset(y: 10)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 0) {
                        ForEach(loadingText.indices, id: \.self) { index in
                            Text(loadingText[index])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .offset(y: counter == index ? -10 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 85)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.spring) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loops += 1
                    if loops >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        })
    }
}

#Preview {
    LaunchView(showLaunchView: .constant(true))
}

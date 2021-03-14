//
//  Loading.swift
//  Libra
//
//  Created by Catalina on 20/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

// A rotating arrow that indicate loading, optional parameter that accept time taken to rotate one cycle
// May Intefere with other animation
// Use ActivityIndicator() if this happens
struct Loading: View {
    @State private var isAnimating = false
    private var image: String {
        if #available(iOS 14.0,*) {
            return "arrow.triangle.2.circlepath"
        } else {
            return "arrow.2.circlepath"
        }
    }
    private let time: Double
    
    init(time: Double = Constants.ROTATION_TIME) {
        self.time = time
    }
    
    private var repeatForever: Animation {
        Animation.linear(duration: self.time)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Image(systemName: image)
            .foregroundColor(.accentColor)
            .rotationEffect(Angle(radians: self.isAnimating ? 2*Double.pi : 0))
            .animation(self.repeatForever)
            .onAppear {
                self.isAnimating = true
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}

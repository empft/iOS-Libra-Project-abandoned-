//
//  TimerButton.swift
//  Libra
//
//  Created by Catalina on 5/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

struct TimerButton: View {
    let action: () -> Void
    let text: String
    @Binding var timeRemaining: Int

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(text: String, time: Binding<Int>, action: @escaping () -> Void) {
        self.action = action
        self.text = text
        self._timeRemaining = time
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            if timeRemaining > 0 {
                Text(timeRemaining.toTime)
                    .onReceive(timer) { _ in
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    }
                }
            }
            
            Button(action: action) {
                Text(text)
            }.disabled(timeRemaining > 0)
            .padding(.trailing)
        }.onDisappear {
            self.timeRemaining = 0
        }
    }
}

struct TimerButton_Previews: PreviewProvider {
    static var previews: some View {
        TimerButton(text: "Request Code", time: .constant(10), action: {})
    }
}

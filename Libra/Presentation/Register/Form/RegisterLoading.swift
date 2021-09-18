//
//  RegisterLoading.swift
//  Libra
//
//  Created by Catalina on 7/8/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI
import Combine

struct RegisterLoading: View {
    @EnvironmentObject var pages: Flipper
    @EnvironmentObject var viewModel: RegisterViewModel
    
    @State var cancellable = Set<AnyCancellable>()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Processing Registration")
                
                ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
            
            .frame(minWidth: geometry.size.width, minHeight: geometry.size.height, alignment: .center)
            .navigationBarHidden(true)
            .onAppear(perform: {
                self.pages.disableSwipeBack()
                
                self.register()
                
            }).onDisappear {
                self.cancellable.removeAll()
            }
        
        }
    }
    
    private func register() {
        _ = self.viewModel.register()
    }
}

struct RegisterLoading_Previews: PreviewProvider {
    static var previews: some View {
        RegisterLoading()
    }
}

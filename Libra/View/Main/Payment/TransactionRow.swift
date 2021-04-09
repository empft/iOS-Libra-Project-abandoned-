//
//  TransactionRow.swift
//  Libra
//
//  Created by Big Sur on 1/4/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI
import Combine

private extension View {
    func listStyle() -> some View {
        self.frame(width: 48, height: 48, alignment: .center)
            .clipShape(Circle())
    }
}

struct TransactionRow: View {
    let name: String
    let description: String
    let logo: URL?
    let primary: String
    let secondary: String?
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var imageLoader = ImageLoader()
    
    init(name: String, description: String, logo: URL? = nil, primary: String, secondary: String? = nil) {
        self.name = name
        self.description = description
        self.logo = logo
        self.primary = primary
        self.secondary = secondary
    }

    var body: some View {
        HStack {
            if let logo = logo {
                Image(uiImage: imageLoader.image)
                    .resizable()
                    .scaledToFit()
                    .listStyle()
                    .onAppear {
                        imageLoader.load(from: logo)
                    }
            } else {
                let initial = (name.first != nil) ? String(name.first!) : ""
                // Use an efficient deterministic pseudorng(length of name) to select a colour
                let rand = name.count
                
                ZStack {
                    Color(RandomColors(theme: colorScheme)
                            .background(int: rand))
                    Text(initial)
                        .font(.largeTitle)
                }.listStyle()
                    
            }
        
            VStack(alignment: .leading) {
                Text(name)
                    .lineLimit(1)
                Text(description)
                    .lineLimit(1)
                    .font(.system(size: 13))
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(primary)
                
                if let secondary = secondary {
                    Text(secondary)
                        .font(.system(size: 13))
                }
            }
        }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(name: "The Grill", description: "Choco Drink", logo: nil, primary: "$24.00", secondary: "≋10.01")
            
            
    }
}

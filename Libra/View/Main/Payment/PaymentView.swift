//
//  PaymentView.swift
//  Libra
//
//  Created by Big Sur on 19/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        NavigationView {
            
            VStack {
                
                HStack {
                    VStack(alignment: .leading){
                        Text("$200.45")
                            .font(.title)
                        Text("≋100")
                            .font(.title2)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth:.infinity)
                .padding()
                .background(Color.green.opacity(0.3))
                .cornerRadius(12.0)
                
                HStack {
                    
                    NavigationLink(
                        destination: Text("Deposit"),
                        label: {
                            Text("Deposit")
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green))
                        })
                    
                    NavigationLink(
                        destination: Text("Withdraw"),
                        label: {
                            Text("Withdraw")
                        })
                }
                Divider()
                
                HStack {
                    
                    NavigationLink(
                        destination: Text("Withdraw"),
                        label: {
                            PaymentButton()
                                .frame(width: 120, height: 120, alignment: .center)
                        })
                    
                    NavigationLink(
                        destination: Text("Withdraw"),
                        label: {
                            PaymentButton()
                                .frame(width: 120, height: 120, alignment: .center)
                                .aspectRatio(1, contentMode: .fit)
                        })
                }
                
                TransactionListView()
                
                Spacer()
                
            }.navigationBarTitle("Payment")
            .padding(.horizontal)
            
            
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = EnderStorage.shared.container.viewContext
        
        let t1 = TransactionHistory(context: context)
        t1.address = Data(base64Encoded: "RnJpZW5kCg==")
        t1.amount = 10
        t1.date = Date(timeIntervalSinceNow: 0)
        t1.fiatAmount = 20
        t1.text = "Friendly Burger"
        t1.fiatCurrency = "USD"
        t1.isSender = true
        t1.logo = nil
        t1.name = "hello"
        
        let t2 = TransactionHistory(context: context)
        t2.address = Data(base64Encoded: "RnJpZW5kCg==")
        t2.amount = 38
        t2.date = Date(timeIntervalSinceNow: 200000)
        t2.text = "Choco Bar"
        t2.fiatAmount = 234
        t2.fiatCurrency = "SGD"
        t2.isSender = true
        t2.logo = nil
        t2.name = "My name"
        
        let t3 = TransactionHistory(context: context)
        t3.address = Data(base64Encoded: "RnJpZW5kCg==")
        t3.amount = 142
        t3.date = Date(timeIntervalSinceNow: 2332)
        t3.fiatAmount = 45
        t3.fiatCurrency = "MYR"
        t3.isSender = false
        t3.logo = nil
        t3.name = "3rd Value"
        
        return PaymentView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            .environment(\.managedObjectContext, context)
            
    }
}

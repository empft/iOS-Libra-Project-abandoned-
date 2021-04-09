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
                                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
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
                            Text("NFC Pay")
                        })
                    
                    NavigationLink(
                        destination: Text("Withdraw"),
                        label: {
                            Text("QR Pay")
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
        PaymentView()
            
    }
}

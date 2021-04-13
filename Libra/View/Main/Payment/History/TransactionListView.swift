//
//  TransactionListView.swift
//  Libra
//
//  Created by Big Sur on 31/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI

struct TransactionListView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: TransactionHistory.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \TransactionHistory.date, ascending: false)]) var transactions: FetchedResults<TransactionHistory>
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        let data = SectionedList.create(transactions) { (item: TransactionHistory) in
            dateFormatter.string(from: item.date ?? Date(timeIntervalSince1970: 0))
        }
        
        List {
            ForEach(data) { (section: SectionedList.SectionedItem) in
                Section(header: Text(section.title)) {
                    ForEach(section.items) { (item: TransactionHistory) in
                        TransactionRow(
                            name: item.name ?? "",
                            description: item.text ?? "",
                            logo: item.logo,
                            primary: "$\(item.fiatAmount!)",
                            secondary: "≋\(item.amount!)")
                    }
                }
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        // There is a bug that triple the contents in CoreDate in Previews
        let context = EnderStorage.shared.container.viewContext
        
        let t1 = TransactionHistory(context: context)
        t1.address = Data(base64Encoded: "RnJpZW5kCg==")
        t1.amount = 10
        t1.text = "Friendly Burger"
        t1.logo = URL(string: "https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RE4rzE2?ver=aa0b&q=90&m=6&h=157&w=279&b=%23FFFFFFFF&l=f&o=t&aim=true")
        t1.date = Date(timeIntervalSinceNow: 0)
        t1.fiatAmount = 20
        t1.fiatCurrency = "USD"
        t1.isSender = true
        t1.name = "hello"
        
        let t2 = TransactionHistory(context: context)
        t2.address = Data(base64Encoded: "RnJpZW5kCg==")
        t2.amount = 38
        t2.text = "Choco Bar"
        t2.date = Date(timeIntervalSinceNow: 200000)
        t2.logo = nil
        t2.fiatAmount = 234
        t2.fiatCurrency = "SGD"
        t2.isSender = true
        t2.name = "My name"
        
        let t3 = TransactionHistory(context: context)
        t3.address = Data(base64Encoded: "RnJpZW5kCg==")
        t3.amount = 142
        t3.date = Date(timeIntervalSinceNow: 2332)
        t3.logo = URL(string: "https://developer.apple.com/design/human-interface-guidelines/ios/images/icons/app_icons/Phone.png")
        t3.fiatAmount = 45
        t3.fiatCurrency = "MYR"
        t3.isSender = false
        t3.name = "3rd Value"
        
        return TransactionListView().environment(\.managedObjectContext, context)
    }
}

//
//  TransactionListView.swift
//  Libra
//
//  Created by Big Sur on 31/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI

struct TransactionListView: View {
    var body: some View {
        List {
            Section(header: Text("6 April 2021")) {
                TransactionRow(name: "TheGrill", description: "Choco Drink", logo: URL(string: "https://www.cameraegg.org/wp-content/uploads/2015/06/canon-powershot-g3-x-sample-images-2-600x400.jpg"), primary: "$20.00")
                TransactionRow(name: "TheGrill", description: "Choco Drink", primary: "$20.00")
                TransactionRow(name: "TheGrill", description: "Choco Drink", primary: "$20.00")
            }
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}

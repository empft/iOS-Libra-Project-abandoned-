//
//  SectionedList.swift
//  Libra
//
//  Created by Big Sur on 9/4/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import SwiftUI
import CoreData

/**
 Separates a list into multiple sections to show it in UI
 */
struct SectionedList<T:NSFetchRequestResult> {
    
    struct SectionedItem: Identifiable {
        var id: String {
            return title
        }
        
        let items: [T]
        let title: String
    }
    
    private init() {}
    
    /**
     Predicate accepts a closure that returns a String that is same for items in same section, the same String is used as the title of the section.
     */
    static func create(_ list: FetchedResults<T>, _ predicate: (T) -> String) -> [SectionedItem] {
        var sectionedList = [SectionedItem]()
        
        if list.count == 0 {
            return sectionedList // Returns empty list
        }
        
        var currentTitle = predicate(list.first!)
        var currentStartingIndex: Int = 0
        // Starts from second value
        for (index, element) in list.enumerated() {
            let newTitle = predicate(element)
            
            if newTitle != currentTitle {
                sectionedList.append(
                    SectionedItem(items: Array(list[currentStartingIndex..<index]) , title: currentTitle)
                )
                
                currentTitle = newTitle
                currentStartingIndex = index
            }
        }
        
        sectionedList.append(
            SectionedItem(
                items: Array(list[currentStartingIndex..<list.count]), title: currentTitle
            )
        )
        
        return sectionedList
    }
}


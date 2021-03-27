//
//  MulticastDelegate.swift
//  Libra
//
//  Created by Big Sur on 27/3/21.
//  Copyright © 2021 Catalina. All rights reserved.
//

import Foundation

class MulticastDelegate <T> {
  private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()

  func add(delegate: T) {
    delegates.add(delegate as AnyObject)
  }

  func remove(delegate: T) {
    //reversed() is a trick to prevent object deallocated error
    for oneDelegate in delegates.allObjects.reversed() {
      if oneDelegate === delegate as AnyObject {
        delegates.remove(oneDelegate)
      }
    }
  }

  func invoke(invocation: (T) -> ()) {
    for delegate in delegates.allObjects.reversed() {
      invocation(delegate as! T)
    }
  }
}

func += <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
  left.add(delegate: right)
}

func -= <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
  left.remove(delegate: right)
}

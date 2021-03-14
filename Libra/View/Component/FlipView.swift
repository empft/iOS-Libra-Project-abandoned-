//
//  FlipView.swift
//  Libra
//
//  Created by Catalina on 16/7/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import SwiftUI

// implement Flippable protocol and pages EnvironmentObject on views that you want to add to FlipView
protocol Flippable: View {
    var pages: Flipper { get }
}

final class Flipper: ObservableObject {
    /// number of pages in FlipView
    private var max: Int
    
    /// To prevent consecutive button clicks that skip pages, lock when you flip the page, unlock when the observer on flipview receive changes, not in sync with page appear rendering but good enough
    private var isLocked: Bool = false
    
    /// To determine the direction of sliding animation
    fileprivate var isTurningToNextPage: Bool = true
    
    /// To determine whether you can flip to previous page
    var isSwipeable: Bool = true
    
    @Published private (set) var currentPage: Int {
        willSet {
            isSwipeable = true
        }
    }
    
    init(length: Int) {
        self.max = length
        self.currentPage = 0
    }
    
    /// Flip to next page
    func increment() {
        if currentPage < max - 1 && !isLocked {
            isTurningToNextPage = true
            currentPage += 1
            self.lock()
        }
    }
    
    /// Flip to previous page
    func decrement() {
        if currentPage > 0 && !isLocked {
            isTurningToNextPage = false
            currentPage -= 1
            self.lock()
        }
    }
    
    /// Disable flipping to previous page
    func disableSwipeBack() {
        isSwipeable = false
    }
    
    /// Lock the page to prevent multiple flips at once
    fileprivate func lock() {
        self.isLocked = true
    }
    
    /// Unlock the page after reaching the page to prevent multiple flips at once
    fileprivate func unlock() {
        self.isLocked = false
    }
}

struct FlipView: View {
    private var views: [AnyView]
    @ObservedObject var flipper: Flipper
    
    init(_ view: AnyView...) {
        self.views = view
        self.flipper = Flipper(length: views.count)
    }
    
    var body: some View {
        // Embed anyview in ZStack and assign id to each of them so anyview can be animated
        ZStack {
            views[flipper.currentPage]
            .environmentObject(flipper)
                .background(Color(.systemBackground))
            .gesture(DragGesture().onEnded({ value in
                if value.translation.width > 0 && self.flipper.isSwipeable {
                    self.flipper.decrement()
                }
            }))
            .onReceive(flipper.$currentPage,perform: { _ in
                self.flipper.unlock()
            })
            .id(flipper.currentPage)
            .transition(flipper.isTurningToNextPage ? .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)) : .slide)
                .animation(.default)
        }
    }

    
}

// Example of Implementation
struct FlipView_Previews: PreviewProvider {
    static var previews: some View {
        return FlipView(
            AnyView(RegisterVerification()),
            AnyView(RegisterDisplayName()),
            AnyView(RegisterUsername()),
            AnyView(RegisterPassword()),
            AnyView(RegisterEmail())
        ).environmentObject(RegisterViewModel())
    }
}

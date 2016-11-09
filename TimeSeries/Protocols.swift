//
//  Protocols.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/8/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

protocol DefaultConstructible {
  init()
}

protocol Infinite: DefaultConstructible, Comparable {
  static var min: Self { get }
  static var max: Self { get }
}

protocol Temporal {
  associatedtype Time: Infinite, Strideable, ExpressibleByIntegerLiteral
  var timestamp: Time { get }
}

extension Sequence where SubSequence: Sequence, SubSequence.Iterator.Element == Iterator.Element {
  func tuples() -> AnyIterator<(Iterator.Element, Iterator.Element)> {
    return AnyIterator(zip(self, dropFirst()).makeIterator())
  }
}


//extension Seuqnece where Iterator.Element: Comparable {
//  func isSorted() -> Bool {
//    for (a,b) in tuples() where a > b{
//      return false
//    }
//    return true
//  }
//}

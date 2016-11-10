//
//  Protocols.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/8/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

public protocol DefaultConstructible {
  init()
}


//extension Int: ForwardIndex { }

public protocol Infinite: DefaultConstructible, Comparable {
  static var min: Self { get }
  static var max: Self { get }
}

public protocol TimestampType: Infinite, Strideable, ExpressibleByIntegerLiteral {}



protocol RangeType {
  associatedtype Bound: Comparable
  var lowerBound: Bound { get }
  var upperBound: Bound { get }
  init(uncheckedBounds bounds: (lower: Bound, upper: Bound))
}

extension Range: RangeType { }

extension RangeType {
  func intersect(_ other: Self) -> Self {
    fatalError()
  }
}


protocol UniquelyHashable: Hashable {
  
}




//extension Sequence {
//  func count(where predicate: (Iterator.Element) -> Bool) -> Int {
//    return reduce(0) { $0 + Int(predicate($1)) }
//  }
//
//  func count(while predicate: (Iterator.Element) -> Bool) -> Int {
//    var g = makeIterator()
//    var count = 0
//    while let c = g.next().map(predicate), c {
//      count += 1
//    }
//    return count
//  }
//
//}

protocol SortedCollection: BidirectionalCollection {
  associatedtype _Element: Comparable = Iterator.Element
//  associatedtype  _SubSequence: Sequence = 
}


//extension SortedCollection {
//  func index(of: Iterator.Element) -> Index? {
//    fatalError()
//  }
//}


//
// todo
//
//extension SortedCollection {
//  func index(of: Iterator.Element) -> Index {
//    fatalError()
//  }
//}

//extension Collection where Indices.Iterator.Element == Index {
//	func indices(where pred: @escaping (Iterator.Element) -> Bool) -> [Index] {
//		return indices.filter { pred(self[$0]) }
//	}
//
////  func range(where pred: @escaping (Iterator.Element) -> Bool) -> Range<Index> {
////    let i = indices
////  }
//}




//extension SortedCollection where Iterator.Element: Temporal {
//  typealias Timestamp = Iterator.Element.Timestamp
//
//  func firstIndex(at timestamp: Timestamp) -> Index? {
//    return index { $0.timestamp == timestamp }
//  }
//
////  func firstIndex(before timestamp: Timestamp) -> Index? {
////    for i in indices {
////      self[i]
////    }
////  }
//
//
//  func lastIndex(at timestamp: Timestamp) -> Index? {
//    for (i,e) in zip(indices, self).reversed() where e.timestamp == timestamp {
//      return i as? Index
//    }
//    return nil
//  }
//
////  func indices(for range: Range<Timestamp>) -> Range<Index> {
//    //
//    // binsearch from the beginning and end
//
//    //
////    let q = self.index(of: self[startIndex])
//
////  }
//
////  func count(at timestamp: Timestamp) -> Int {
////    return indices(for: )
////  }
//
////  func count(before timestamp: Timestamp) -> Int {
////    return firstIndex(at: timestamp) - startIndex
////  }
//
//  func count(after timestamp: Timestamp) -> Int {
//    return filter { $0.timestamp > timestamp }.count
//  }
//
////
////  func count(after timestamp: Timestamp) -> Int {
////    return filter { $0.timestamp > timestamp }.count
////  }
//}


//extension Seuqnece where Iterator.Element: Comparable {
//  func isSorted() -> Bool {
//    for (a,b) in tuples() where a > b{
//      return false
//    }
//    return true
//  }
//}

extension Array: DefaultConstructible { }
extension Dictionary: DefaultConstructible { }
extension Set: DefaultConstructible { }

extension Int: DefaultConstructible { }
extension Double: DefaultConstructible { }
extension Bool: DefaultConstructible { }





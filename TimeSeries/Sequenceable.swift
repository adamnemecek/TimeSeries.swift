//
//  Sequencable.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

////
//// this is a hack
////
//protocol Subscriptable {
//  associatedtype Element
//  associatedtype Index
//  subscript (index: Index) -> Element { get }
//}
//
//extension Subscriptable {
//  func _subscript (index: Index) -> Element {
//    return self[index]
//  }
//
////  mutating
////  func _subscript(index: Index, set to: Element) {
////  }
//}


//
// Orthogonal to collection,
// note that subscript returns a subsequence since there 
// can be concurrent events
//

protocol Sequenceable: BidirectionalCollection {
  associatedtype Index: Comparable
  associatedtype Element: Temporal = Iterator.Element
  associatedtype Timestamp: TimestampType = Element.Timestamp

  func index(of timestamp: Timestamp, insertion: Bool) -> Index?

  var startTimestamp: Timestamp { get }
  var endTimestamp: Timestamp { get }

  func range(at timestamp: Timestamp) -> Range<Index>?

  func timestamp(after timestamp: Timestamp) -> Timestamp

  subscript (timestamp: Timestamp) -> SubSequence? { get }
  subscript (timerange: Range<Timestamp>) -> SubSequence? { get }

}



extension Sequenceable where Iterator.Element: Temporal, Iterator.Element.Timestamp == Timestamp, SubSequence.Index == Index {

  var startTimestamp: Timestamp {
    return first?.timestamp ?? Timestamp()
  }


  var endTimestamp: Timestamp {
    return last?.timestamp ?? Timestamp()
  }

  func range(at timestamp: Timestamp) -> Range<Index>? {
    return index(of: timestamp, insertion: false).flatMap { start in
      let subrange = self[start..<endIndex]
      fatalError("the serarch below should compare the timestamps")
      let end = subrange.index { _ in true }
      return start..<(end ?? start)
    }
  }

  func range(before timestamp: Timestamp) -> Range<Index>? {
//    return index(of: timestamp, insertion: true).flatMap { _ in 
      fatalError()
//    }
//  }
  }

  //
  // this is a hack around the fact that we cannot define subscripts in extensions
  //
  func _subscript(timestamp: Timestamp) -> SubSequence? {
    return range(at: timestamp).map { self[$0] }
  }

  func _subscript(timerange: Range<Timestamp>) -> SubSequence? {
    let f = range(before: timerange.lowerBound)
    let l = range(before: timerange.upperBound)
    fatalError()
  }



//  subscript (timerange: Range<Timestamp>) -> SubSequence? {
//    let
//
//  }
}

protocol MutableSequenceable: Sequenceable {
  subscript (timestamp: Timestamp) -> SubSequence { get set }
  subscript (timerange: Range<Timestamp>) -> SubSequence { get set }
}


protocol BidirectionalSequenceable : Sequenceable {
  func timestamp(before timestamp: Timestamp) -> Timestamp
}

protocol RangeReplaceableSequencable: Sequenceable {

}





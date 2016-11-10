//
//  Sequencable.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation


//
// Orthogonal to collection,
// note that subscript returns a subsequence since there 
// can be concurrent events
//



protocol Sequenceable: BidirectionalCollection {
  associatedtype Index: Strideable
  associatedtype Element: Temporal = Iterator.Element
  associatedtype Timestamp: TimestampType = Element.Timestamp


  //
  // this is the only method you have to implement yourself
  // if insertion == true, requires that you return the first index
  // where such element can be inserted i.e. in the subrange of the 
  // concurrent elements, a new index would be inserted at the first 
  // position
  //

  func index(of timestamp: Timestamp, insertion: Bool) -> Index?

  var startTimestamp: Timestamp { get }
  var endTimestamp: Timestamp { get }

  func range(at timestamp: Timestamp) -> Range<Index>?

  func timestamp(after timestamp: Timestamp) -> Timestamp

  subscript (timestamp: Timestamp) -> SubSequence? { get }
  subscript (timerange: Range<Timestamp>) -> SubSequence? { get }
}



extension Sequenceable
  where
    //
    // todo: are all these necessary?
    //
    Iterator.Element: Temporal,
    Iterator.Element.Timestamp == Timestamp,
    SubSequence.Index == Index,
    SubSequence.Iterator.Element == Iterator.Element {

  var startTimestamp: Timestamp {
    return first?.timestamp ?? Timestamp()
  }

  var endTimestamp: Timestamp {
    return last?.timestamp ?? Timestamp()
  }

  func timestamp(after timestamp: Timestamp) -> Timestamp {
    //
    // todo what about fractional timestamps? we could return the wrong index
    //
    return index(of: timestamp.forward(), insertion: true).map {
      self[$0].timestamp
    } ?? Timestamp()
  }



  //
  // index range of all events that happen at timestamp: Timestamp
  //

  func range(at timestamp: Timestamp) -> Range<Index>? {
    return index(of: timestamp, insertion: false).flatMap { start in
      //
      // starting on the first index where timestamp == $0.timestamp,
      // find the end index of the concurrent subsequence
      //

      let subrange = self[start..<endIndex]


      let end = subrange.index { timestamp != $0.timestamp }
      return start..<(end ?? start)
    }
  }

  func range(before timestamp: Timestamp) -> Range<Index>? {
    return index(of: timestamp, insertion: true).map {
      startIndex..<$0
    }
  }

  func range(within range: Range<Timestamp>) -> Range<Index>? {
//    return self.range(before: range.lowerBound).flatMap { ind in
//      self.range(before: range.upperBound).map { self[ind..<$0] }
//    }
    fatalError()
  }

  //
  // this is a hack around the fact that we cannot define subscripts in extensions
  //
  func _subscript(timestamp: Timestamp) -> SubSequence? {
    return range(at: timestamp).map { self[$0] }
  }

  func _subscript(timerange: Range<Timestamp>) -> SubSequence? {
//    return range(before: timerange.lowerBound).flatMap { start in
//      range(before: timerange.upperBound).map { self[start...<$0] }
//    }
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





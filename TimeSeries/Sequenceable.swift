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
  associatedtype Index: Comparable
  associatedtype Element: Temporal = Iterator.Element
  associatedtype Timestamp: TimestampType = Element.Timestamp

  var startTimestamp: Timestamp { get }
  var endTimestamp: Timestamp { get }

  func timestamp(after timestamp: Timestamp) -> Timestamp

  func index(of timestamp: Timestamp) -> Index?

  subscript (timestamp: Timestamp) -> SubSequence { get }
  subscript (timerange: Range<Timestamp>) -> SubSequence { get }

}

extension Sequenceable where Iterator.Element: Temporal, Iterator.Element.Timestamp == Timestamp {

  var startTimestamp: Timestamp {
    return first?.timestamp ?? Timestamp()
  }


  var endTimestamp: Timestamp {
    return last?.timestamp ?? Timestamp()
  }


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





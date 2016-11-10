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

protocol Sequenceable: Sequence {
  associatedtype Index: Comparable
  associatedtype Element: Temporal = Iterator.Element
  associatedtype Timestamp: Comparable = Element.Timestamp

  var startTimestamp: Timestamp { get }
  var endTimestamp: Timestamp { get }

  func timestamp(after timestamp: Timestamp) -> Timestamp

  func index(of timestamp: Timestamp) -> Index?

  subscript (timestamp: Timestamp) -> SubSequence { get }
  subscript (timerange: Range<Timestamp>) -> SubSequence { get }

  var isEmpty: Bool { get }
}

protocol MutableSequenceable: Sequenceable {
  subscript (timestamp: Timestamp) -> SubSequence { get set }
  subscript (timerange: Range<Timestamp>) -> SubSequence { get set }
}

protocol RangeReplaceableSequencable: Sequenceable {

}


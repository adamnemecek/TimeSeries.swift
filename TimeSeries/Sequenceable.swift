//
//  Sequencable.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

//
// Orthogonal to collection, note
//

protocol Sequenceable: Sequence {
  associatedtype Element: Temporal = Iterator.Element
  associatedtype Timestamp: Comparable = Element.Timestamp

  var startTimestamp: Timestamp { get }
  var endTimestamp: Timestamp { get }



  subscript (timestamp: Timestamp) -> SubSequence { get }
  subscript (timerange: Range<Timestamp>) -> SubSequence { get }
}

protocol MutableSequencable: Sequenceable {
  subscript (timestamp: Timestamp) -> SubSequence { get set }
  subscript (timerange: Range<Timestamp>) -> SubSequence { get set }
}

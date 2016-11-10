//
//  TimeSeries2.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation



extension SortedArray where Element : Temporal {
  //
  // todo optimiize
  //
  typealias Timestamp = Element.Timestamp

  public func concurrent(at timestamp: Timestamp) -> Int {
    return filter { $0.timestamp == timestamp }.count
  }

  public func before(timestamp: Timestamp) -> Int {
    return filter { $0.timestamp < timestamp }.count
  }


  public func after(timestamp: Timestamp) -> Int {
    return filter { $0.timestamp > timestamp }.count
  }

  var startTimestamp: Timestamp? {
    return first?.timestamp
  }

  var endTimestamp: Timestamp? {
    return last?.timestamp
  }

  subscript (timerange: Range<Timestamp>) -> SubSequence {
    get {
      fatalError()
    }
    set {
      fatalError()
    }
  }

  func replaceTimerange<C : Collection>(_ subrange: Range<Timestamp>, with newElements: C) where C.Iterator.Element == Element {
    fatalError()
  }

}



typealias Timeseries<Event: Temporal> = SortedArray<Event>

func main1() {
  let q = (0...4).map { Note(timestamp: $0 * 10, duration : $0 * 10, pitch : $0 * 10) }
  let b = SortedArray(q)

}

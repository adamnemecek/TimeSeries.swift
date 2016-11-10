//
//  TimeSeries2.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation



//extension SortedArray where Element : Temporal {
//  //
//  // todo optimiize
//  //
//  typealias Timestamp = Element.Timestamp
//
//  public func concurrent(at timestamp: Timestamp) -> Int {
//    return filter { $0.timestamp == timestamp }.count
//  }
//
//  public func before(timestamp: Timestamp) -> Int {
//    return filter { $0.timestamp < timestamp }.count
//  }
//
//
//  public func after(timestamp: Timestamp) -> Int {
//    return filter { $0.timestamp > timestamp }.count
//  }
//
//  var startTimestamp: Timestamp {
//    return first?.timestamp ?? Timestamp()
//  }
//
//  var endTimestamp: Timestamp {
//    return last?.timestamp ?? Timestamp()
//  }
//
//  subscript (timerange: Range<Timestamp>) -> SubSequence {
//    get {
//      fatalError()
//    }
//    set {
//      fatalError()
//    }
//  }
//
//  func replaceTimerange<C : Collection>(_ subrange: Range<Timestamp>, with newElements: C) where C.Iterator.Element == Element {
//    fatalError()
//  }
//
//}

func main1() {
  let q = (0...4).map { Note(timestamp: $0 * 10, duration : $0 * 10, pitch : $0 * 10) }
  let b = SortedArray(q)

}


public struct TimeSeries<Event: Temporal>: MutableCollection {
  public typealias Timestamp = Event.Timestamp
  public typealias Index = Int
  public typealias SubSequence = ArraySlice<Event>

  fileprivate var content: SortedArray<Event> = []

  public init() {
    content = []
  }

  public var startIndex: Index {
    return content.startIndex
  }

  public var endIndex: Index {
    return content.endIndex
  }

  public func index(after index: Index) -> Index {
    return content.index(after: index)
  }

  public subscript (index: Index) -> Event {
    get {
      return content[index]
    }
    set {
        content[index] = newValue
    }
  }

  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
      return content[bounds]
    }
    set {
      content[bounds] = newValue
    }
  }
}

extension TimeSeries: BidirectionalCollection {
  public func index(before index: Index) -> Index {
    return content.index(before: index)
  }
}

extension TimeSeries: RangeReplaceableCollection {
  public mutating func replaceSubrange<C : Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Event {

    content.replaceSubrange(subrange, with: newElements)
  }
}

//extension TimeSeries: MutableSequenceable {
//  var startTimestamp: Timestamp {
//    return first?.timestamp ?? Timestamp()
//  }
//
//  var endTimestamp: Timestamp {
//    return last?.timestamp ?? Timestamp()
//  }
//
//  subscript (timestamp: Timestamp) -> SubSequence {
//    get {
//
//    }
//    set {
//    }
//  }
//
//  subscript (timerange: Range<Timestamp>) -> SubSequence {
//    get {
//      fatalError()
//    }
//    set {
//
//    }
//  }
//
//  public func index(of timestamp: Event.Timestamp) -> Index? {
//    return index { $0.timestamp == timestamp }
//  }
//
//  func timestamp(after timestamp: Event.Timestamp) -> Timestamp {
//    fatalError()
//  }
//}
//







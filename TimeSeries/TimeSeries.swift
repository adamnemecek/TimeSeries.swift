//
//  TimeSeries2.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

//protocol TemporalCollection: SortedCollection {
//  associatedtype __Element: Temporal = _Element
//  associatedtype _Index: Strideable = Index
//  associatedtype _SubSequence: Sequence = SubSequence
//}


extension SortedArray where Element: Temporal {
  func index(of timestamp: Element.Timestamp, insertion: Bool = false) -> Index? {
    //
    // todo: optimize
    //

    return insertion ?
            index { timestamp < $0.timestamp } :
            index { timestamp == $0.timestamp }
  }
}

func main1() {
  let q = (0...4).map { Note(timestamp: $0 * 10, duration : $0 * 10, pitch : $0 * 10) }
  let b = SortedArray(q)

}

//
// unlike a sorted array, the keys are sparse
// 
//

public struct TimeSeries<Event: Temporal>: MutableCollection,
                                           SortedCollection,
                                           ExpressibleByArrayLiteral,
                                           DefaultConstructible,
                                           SequenceInitializable,
                                           Equatable {

  public typealias Timestamp = Event.Timestamp
  public typealias Index = Int
  public typealias SubSequence = ArraySlice<Event>

  fileprivate var content: SortedArray<Event> = []

  public init() {
    content = []
  }

  public init<S: Sequence>(_ seq: S) where S.Iterator.Element == Event {
    content = SortedArray(seq)
  }

  public init(arrayLiteral elements: Event...) {
    content = SortedArray(elements)
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
//    fatalError()
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

extension TimeSeries: Sequenceable {
  func move(by: Event.Timestamp) -> TimeSeries<Event> {
    fatalError()
  }

  public func index(of timestamp: Timestamp, insertion: Bool = false) -> Index? {
    return content.index(of: timestamp, insertion: insertion)
  }
}

public func ==<Event>(lhs: TimeSeries<Event>, rhs: TimeSeries<Event>) -> Bool {
  return lhs.content == rhs.content
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







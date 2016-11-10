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

extension BidirectionalCollection
  where
    Index: Strideable,
    Iterator.Element: Temporal,
    SubSequence: BidirectionalCollection,
    SubSequence.Iterator.Element == Iterator.Element,
    SubSequence.Index == Index {

  public func concurrent(after index: Index) -> Index.Stride {

    let timestamp = self[index].timestamp
    //
    // get index of the following event
    //
    let fst = self.index(after: index)

    //
    // starting at the next index, find an event that isn't concurrent
    //
    let lst = self[fst..<endIndex].index {
        $0.timestamp != timestamp
    } ?? fst

    return fst.distance(to: lst)
  }

  public func concurrent(before index: Index) -> Index.Stride {
    let timestamp = self[index].timestamp
    //
    // starting at the previous index, iterate backwrads until we find a non-concurrent event
    //
    let fst = self[startIndex..<index].lastIndex {
        $0.timestamp != timestamp
    } ?? index

    return index.distance(to: fst)
  }


}

extension SortedArray where Element: Temporal {
  func index(of timestamp: Element.Timestamp, insertion: Bool = false) -> Index? {
    //
    // todo: optimize
    //

    return insertion ?
            index { timestamp < $0.timestamp } :
            index { timestamp == $0.timestamp }
  }


  //
  // how many concurrent events come after index
  //

  func concurrent(after index: Int) -> Int {
    let timestamp = self[index].timestamp

    return self[(index + 1)..<endIndex].countWhile {
      $0.timestamp == timestamp
    }
  }



}

func main1() {
  let q = (0...4).map { Note(timestamp: $0 * 10, duration : $0 * 10, pitch : $0 * 10) }
  let b = SortedArray(q)

}


public struct TimeSeries<Event: Temporal>: MutableCollection, SortedCollection,
  ExpressibleByArrayLiteral, DefaultConstructible {
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
  public func index(of timestamp: Timestamp, insertion: Bool = false) -> Index? {
    return content.index(of: timestamp, insertion: insertion)
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







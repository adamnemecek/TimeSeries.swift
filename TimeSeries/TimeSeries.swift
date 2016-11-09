//
//  TimeSeries.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/8/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation


public struct TimeSeriesIndex<Event: Temporal>: Comparable, DefaultConstructible, Temporal, ExpressibleByIntegerLiteral {

  public typealias Timestamp = Event.Time
  public let timestamp: Timestamp
  //
  // this is the offset from (timestamp, 0)
  //
  fileprivate let offset: Int

  //
  // this is the linear index into the sorted array
  //
  fileprivate let index: Int?

  public init(timestamp: Timestamp = Timestamp(), offset: Int = 0, index: Int? = nil) {
    self.timestamp = timestamp
    self.offset = offset
    self.index = index
  }

  public init() {
    self.init(timestamp: Timestamp())
  }

  public init(integerLiteral value: Timestamp.IntegerLiteralType) {
    self.init(timestamp: Timestamp(integerLiteral: value))
  }

  public static var min: TimeSeriesIndex {
    return TimeSeriesIndex(timestamp: Timestamp(), offset: 0)
  }

  public static var max: TimeSeriesIndex {
    return TimeSeriesIndex(timestamp: Timestamp.max, offset: 0)
  }
}

public func ==<T>(lhs: TimeSeriesIndex<T>, rhs: TimeSeriesIndex<T>) -> Bool {
  return lhs.timestamp == rhs.timestamp && lhs.index == rhs.index
}

public func <<T>(lhs: TimeSeriesIndex<T>, rhs: TimeSeriesIndex<T>) -> Bool {
  fatalError()
  return (lhs.timestamp < rhs.timestamp && lhs.offset < rhs.offset) //||
//         (lhs.timestamp != T.Time.max && rhs.timestamp == T.Time.max)
}



public struct TimeSeries<Event: Temporal & Comparable>: MutableCollection {

  public typealias Timestamp = Event.Time
  public typealias Index = TimeSeriesIndex<Event>
  public typealias SubSequence = ArraySlice<Event>

  fileprivate var content: SortedArray<Event> = []

  public init() {
    content = []
  }

  fileprivate var domain: Range<Timestamp> {
//    return first.map { $0.timestamp...Timestamp.max } ?? Timestamp()..<Timestamp()
    fatalError()
  }


  public var startIndex: Index {
    return Index(timestamp: domain.lowerBound, offset: 0, index: 0)
  }

  public var endIndex: Index {
    //
    // note that upperBound might be Evnet.Time.max'
    //
    return Index(timestamp: domain.upperBound, offset: 0, index: content.endIndex)
  }

  public func index(after index: Index) -> Index {
    let idx = lindex(index: index) + 1
    return idx < content.endIndex ? self.index(for: idx) : endIndex
  }

  public subscript (index: Index) -> Event {
    get {
      return content[lindex(index: index)]
    }
    set {
        content[lindex(index: index)] = newValue
    }
  }

  public subscript(bounds: Range<TimeSeriesIndex<Event>>) -> SubSequence {
    get {
      return content[linrange(bounds: bounds)]
    }
    set {
      fatalError()
//      replaceSubrange(linrange(bounds: bounds), with: newValue)
    }
  }

  public func makeIterator() -> AnyIterator<Event> {
    return AnyIterator(content.makeIterator())
  }
}

extension TimeSeries: BidirectionalCollection {
  public func index(before index: Index) -> Index {
    fatalError()
//    let idx = lindex(index: index) + 1
//    return idx < content.endIndex ? self.index(for: idx) : endIndex
  }
}

extension TimeSeries: RangeReplaceableCollection {

  public mutating func replaceSubrange<C : Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Event {
    let r = linrange(bounds: subrange)
    content.replaceSubrange(r, with: newElements)
  }
}


fileprivate extension TimeSeries {
  //
  // calculate linear index
  //
  fileprivate func lindex(timestamp: Timestamp, offset: Int) -> Int {
//    return content.count(until: index.timestamp) + offset
    fatalError()
  }

  fileprivate func lindex(index: Index) -> Int {
    return index.index ?? lindex(timestamp: index.timestamp, offset: index.offset)
  }

  fileprivate func linrange(bounds: Range<Index>) -> Range<Int> {
    return lindex(index: bounds.lowerBound)..<lindex(index: bounds.upperBound)
  }


  fileprivate func index(for index: Int) -> Index {
    let event = content[index]
    let until = content.count(until: event.timestamp)

    return Index(timestamp: event.timestamp, offset: index - until, index: index)
  }
}




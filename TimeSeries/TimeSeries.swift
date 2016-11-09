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
    return TimeSeriesIndex(timestamp: Timestamp.min, offset: 0)
  }

  public static var max: TimeSeriesIndex {
    return TimeSeriesIndex(timestamp: Timestamp.max, offset: 0)
  }
}


public func ==<T>(lhs: TimeSeriesIndex<T>, rhs: TimeSeriesIndex<T>) -> Bool {
  return lhs.timestamp == rhs.timestamp && lhs.index == rhs.index
}

public func <<T>(lhs: TimeSeriesIndex<T>, rhs: TimeSeriesIndex<T>) -> Bool {
  return (lhs.timestamp < rhs.timestamp && lhs.offset < rhs.offset) //||
//         (lhs.timestamp != T.Time.max && rhs.timestamp == T.Time.max)
}



public struct TimeSeries<Event: Temporal & Comparable>: RangeReplaceableCollection, MutableCollection {


  /// Accesses a contiguous subrange of the collection's elements.
  ///
  /// The accessed slice uses the same indices for the same elements as the
  /// original collection. Always use the slice's `startIndex` property
  /// instead of assuming that its indices start at a particular value.
  ///
  /// This example demonstrates getting a slice of an array of strings, finding
  /// the index of one of the strings in the slice, and then using that index
  /// in the original array.
  ///
  ///     let streets = ["Adams", "Bryant", "Channing", "Douglas", "Evarts"]
  ///     let streetsSlice = streets[2 ..< streets.endIndex]
  ///     print(streetsSlice)
  ///     // Prints "["Channing", "Douglas", "Evarts"]"
  ///
  ///     let index = streetsSlice.index(of: "Evarts")    // 4
  ///     streets[index!] = "Eustace"
  ///     print(streets[index!])
  ///     // Prints "Eustace"
  ///
  /// - Parameter bounds: A range of the collection's indices. The bounds of
  ///   the range must be valid indices of the collection.


  private var content: SortedArray<Event> = []
  public typealias Timestamp = Event.Time
  public typealias Index = TimeSeriesIndex<Event>
  public typealias SubSequence = ArraySlice<Event>

  public init() {
    content = []
  }

  private var domain: Range<Event.Time> {
//    return first.map { $0.timestamp...Timestamp.max } ?? Timestamp()..<Timestamp()
    fatalError()
  }

  //
  // calculate linear index
  //
  private func lindex(timestamp: Timestamp, offset: Int) -> Int {
//    return content.count(until: index.timestamp) + offset
    fatalError()
  }

  private func lindex(index: Index) -> Int {
    return index.index ?? lindex(timestamp: index.timestamp, offset: index.offset)
  }

  private func linrange(bounds: Range<Index>) -> Range<Int> {
    return lindex(index: bounds.lowerBound)..<lindex(index: bounds.upperBound)
  }


  private func index(for index: Int) -> Index {
    let event = content[index]
    let until = content.count(until: event.timestamp)

    return Index(timestamp: event.timestamp, offset: index - until, index: index)
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

  public mutating func replaceSubrange<C : Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Event {
    let r = linrange(bounds: subrange)
    content.replaceSubrange(r, with: newElements)
  }

}

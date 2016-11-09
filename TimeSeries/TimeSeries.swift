//
//  TimeSeries.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/8/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

public struct TimeSeriesIndex<Event: Temporal>: Comparable, DefaultConstructible, Temporal, ExpressibleByIntegerLiteral {

  public typealias Timestamp = Event.Timestamp
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

  return (lhs.timestamp < rhs.timestamp && lhs.offset < rhs.offset) //||
//         (lhs.timestamp != T.Time.max && rhs.timestamp == T.Time.max)
}

extension TimeSeriesIndex: CustomStringConvertible {
  public var description: String {
    return "TimeSeriesIndex(timestamp: \(timestamp), offset: \(offset), index: \(index))"
  }
}


func tee<T>(_ msg: String? = nil, _ t: T) -> T {
  print(msg ?? "", t)
  return t
}

public struct TimeSeries<Event: Temporal>: MutableCollection {

  public typealias Timestamp = Event.Timestamp
  public typealias Index = TimeSeriesIndex<Event>
  public typealias SubSequence = ArraySlice<Event>

  fileprivate var content: SortedArray<Event> = []

  public init() {
    content = []
  }

  public var startIndex: Index {

    return tee("startindex: ", Index(timestamp: domain.lowerBound, offset: 0, index: 0))
  }

  public var endIndex: Index {
    //
    // note that upperBound might be Evnet.Time.max'
    //
    return Index(timestamp: domain.upperBound, offset: 0, index: content.endIndex)
  }

  public func index(after index: Index) -> Index {
    let idx: Int = lindex(index: index) + 1
    let g = idx < content.endIndex ? self.index(for: idx) : endIndex
    print("index \(index) -> \(g)")

    return g
  }

  public subscript (index: Index) -> Event {
    get {
      return content[lindex(index: index)]
    }
    set {
        content[lindex(index: index)] = newValue
    }
  }

  public subscript(bounds: Range<Index>) -> SubSequence {
    get {
//      let ind = linrange(bounds: bounds)
//      dump(ind)
//      return content[ind]
      let i = indices.filter { bounds.contains($0) }
      print("indices: \(i)")
      print("self.indices: \(self.indices)")
      return i.extrema.map { self.content[$0.first.index!..<$0.last.index!] } ?? []

//      return i.extrema.map { self.content[Range(uncheckedBounds: $0)] } ?? []
//      fatalError()

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
//    let idx = lindex(index: index) - 1
//    return 0 < idx ? self.index(for: idx) : Index(timestamp: 0, offset: 0, index: 0)
  }
}

extension TimeSeries: RangeReplaceableCollection {

  public mutating func replaceSubrange<C : Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Event {
    let r = linrange(bounds: subrange)
    content.replaceSubrange(r, with: newElements)
  }
}

func tee<T>(_ t: T) -> T {
  print(t)
  return t
}

fileprivate extension TimeSeries {
  //
  // calculate linear index
  //

  fileprivate var domain: ClosedRange<Timestamp> {
    let q = first.map { $0.timestamp...Timestamp.max }
    return tee(q ?? Timestamp()...Timestamp())
  }

  fileprivate func lindex(timestamp: Timestamp, offset: Int) -> Int {
//    let z = 
    return tee(content.count(until: timestamp) + offset)
  }

  fileprivate func lindex(index: Index) -> Int {
    return tee(index.index ?? lindex(timestamp: index.timestamp, offset: index.offset))
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

extension TimeSeries: SortedCollection { }




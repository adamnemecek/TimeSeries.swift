//
//  TimeSeries.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/8/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation



struct TimeSeriesIndex<Event: Temporal>: Comparable, DefaultConstructible, Temporal, ExpressibleByIntegerLiteral {
  let timestamp: Event.Time
  //
  // this is the offset from (timestamp, 0)
  //
  fileprivate let offset: Int

  //
  // this is the linear index into the sorted array
  //
  fileprivate let index: Int?

  init(timestamp: Event.Time = Event.Time(), offset: Int = 0, index: Int? = nil) {
    self.timestamp = timestamp
    self.offset = offset
    self.index = index
  }

  init() {
    self.init(timestamp: Event.Time())
  }

  init(integerLiteral value: Event.Time.IntegerLiteralType) {
    self.init(timestamp: Event.Time(integerLiteral: value))
  }

  static var min: TimeSeriesIndex {
    return TimeSeriesIndex(timestamp: Event.Time.min, offset: 0)
  }

  static var max: TimeSeriesIndex {
    return TimeSeriesIndex(timestamp: Event.Time.max, offset: 0)
  }
}


func ==<T>(lhs: TimeSeriesIndex<T>, rhs: TimeSeriesIndex<T>) -> Bool {
  return lhs.timestamp == rhs.timestamp && lhs.index == rhs.index
}

func <<T>(lhs: TimeSeriesIndex<T>, rhs: TimeSeriesIndex<T>) -> Bool {
  return (lhs.timestamp < rhs.timestamp && lhs.offset < rhs.offset) //||
//         (lhs.timestamp != T.Time.max && rhs.timestamp == T.Time.max)
}


extension SortedArray where Element: Temporal  {
  func indices(of domain: Range<Element.Time>) -> Range<Int> {
    fatalError()
  }

  func count(at timestamp: Element.Time) -> Int {
    fatalError()
    //return reduce(0) { $0 + Int($1.timestamp == timestamp) }
    return count { $0.timestamp == timestamp }
  }

  func count(until timestamp: Element.Time) -> Int {
    fatalError()
//    return reduce(0) { $0 + Int($1.timestamp < timestamp) }
    return count { $0.timestamp < timestamp }
  }

  func count(from timestamp: Element.Time) -> Int {
//    return reduce(0) { $0 + Int(timestamp < $1.timestamp) }
    fatalError()
  }

}

extension Range {
	init(bound: Bound) {
		self.init(bound..<bound)
	}
}

/*
struct TimeSeries<Event: Temporal>: BidirectionalCollection, RangeReplaceableCollection, MutableCollection {

  private var content: SortedArray<Event> = []
  typealias Index = TimeSeriesIndex<Event>
  typealias SubSequence = Slice<SortedArray<Event>>

  var domain: Range<Event.Time> {
    return first.map { $0.timestamp...Event.Time.max } ?? Event.Time()..<Event.Time()
  }

  //
  // calculate linear index
  //
  private func lindex(timestamp: Event.Time, offset: Int) -> Int {
    return content.count(until: index.timestamp) + offset
  }

  private func lindex(index: Index) -> Int {
    return index.index ?? lindex(timestamp: index.timestamp, offset: index.offset)
  }

  private func linrange(bounds: Range<Index>) -> Range<Int> {
    return lindex(index: bounds.lowerBound)..<lindex(index: bounds.upperBound)
  }


  private func index(for index: Int) -> Index {
    let event = content[offset]
    let until = content.count(until: event.timestamp)

    return Index(timestamp: event.timestamp, offset: index - until, index: index)
  }

  var startIndex: Index {
    return Index(timestamp: domain.lowerBound, index: 0, linearIndex: 0)
  }

  var endIndex: Index {
    //
    // note that upperBound might be Evnet.Time.max'
    //
    return Index(timestamp: domain.upperBound, index: 0, linearIndex: content.endIndex)
  }

  func index(after index: Index) -> Index {
    let idx = lindex(index: index) + 1
    return idx < content.endIndex ? index(for: idx) : endIndex
  }

  subscript (index: Index) -> Event {
    get {
      return content[lindex(index: index)]
    }
    set {
        content[lindex(index: index)] = newValue
    }
  }

//  subscript (bounds: Range<Index>) -> SubSequence {
//    fatalError()
//  }

  func makeIterator() -> AnyIterator<Event> {
    return content.makeIterator()
  }

  mutating
  func replaceSubrange<C : Collection>(_ subrange: Range<Index>, with newElements: C) where C.Iterator.Element == Event {
    let r = linrange(bounds: subrange)
    content.replaceSubRange(r, newElements)
  }

}*/

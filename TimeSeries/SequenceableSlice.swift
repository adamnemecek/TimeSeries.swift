//
//  SequenceableSlice.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

protocol SliceProtocol: Collection {
  associatedtype Base
  var base: Base { get }
  init(base: Base, bounds: Range<Index>)
}

extension Slice: SliceProtocol { }


struct SequenceableSlice<Base: Sequenceable>: Sequenceable, MutableCollection where Base.Iterator.Element: Temporal {

  typealias Element = Base.Iterator.Element
  typealias Timestamp = Element.Timestamp
  typealias Index = Base.Index

  let base: Base

  let startIndex: Index
  let endIndex: Index

  let startTimestamp: Timestamp
  let endTimestamp: Timestamp

  internal init(base: Base, bounds: Range<Index>) {
    self.base = base

    self.startIndex = bounds.lowerBound
    self.endIndex = base.index(after: bounds.upperBound)

    self.startTimestamp = base[bounds.lowerBound].timestamp
    self.endTimestamp = base[bounds.upperBound].timestamp
  }

  public func index(of timestamp: Timestamp, insertion: Bool) -> Index? {
    fatalError()
  }

  func move(by: Timestamp) -> SequenceableSlice {
    fatalError()
  }


  init(base: Base, timerange: Range<Timestamp>) {
    self.base = base
    self.startTimestamp = timerange.lowerBound
    self.endTimestamp = timerange.upperBound
//    self.startIndex = base.index(before: base.first!.timestamp)
    self.startIndex = base.endIndex
    self.endIndex = base.endIndex
  }

  subscript (index: Index) -> Element {
    get {
      fatalError()
    }
    set {
//      base.
    }
  }

  func index(before i: Index) -> Index {
    fatalError()
  }

  func index(after i: Index) -> Index {
    fatalError()
  }

}



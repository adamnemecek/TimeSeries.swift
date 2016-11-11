//
//  Temporal.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation


public protocol Temporal: Comparable, Strideable {
  associatedtype Timestamp: TimestampType
  var timestamp: Timestamp { get }
}

extension BidirectionalCollection
  where
    Index: Strideable,
    Iterator.Element: Temporal,
    SubSequence: BidirectionalCollection,
    SubSequence.Iterator.Element == Iterator.Element,
    SubSequence.Index == Index {

  //
  // count the number of concurrent events preceding index
  //

  public func precurrent(of index: Index) -> Index.Stride {
    let timestamp = self[index].timestamp
    //
    // starting at the previous index, iterate backwards until we find a non-concurrent event
    //
    let fst = self[startIndex..<index].lastIndex {
        $0.timestamp != timestamp
    } ?? index

    return index.distance(to: fst)
  }

  //
  // count the number of concurrent events postceding
  //

  public func postcurrent(of index: Index) -> Index.Stride {

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


}


//
//  TimeseriesSlice.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

protocol SliceProtocol {
  associatedtype Base
  var base: Base { get }
}



//struct TimeseriesSlice<Event: Temporal>: Sequenceable {
//  typealias  Timestamp = Event.Timestamp
//
//  typealias Index = TimeSeries<Event.Index>
//
//  private(set) var bounds: Range<Timestamp>
//
//
//  var base: TimeSeries<Event>
//
//  var startIndex: Index {
//    fatalError()
//  }
//
//  var endIndex: Index {
//    fatalError()
//  }
//
//  subscript (index: Index) -> Event {
//    fatalError()
//  }
//
//}

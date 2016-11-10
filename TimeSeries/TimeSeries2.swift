//
//  TimeSeries2.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/10/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

extension SortedArray where Element : Temporal {
  typealias Timestamp = Element.Timestamp

  public func concurrent(at timestamp: Timestamp) -> Int {
    return filter { $0.timestamp == timestamp }.count
  }

  public func before(timestamp: Timestamp) -> Int {
    return filter { $0.timestamp < timestamp }.count
  }


  public func after(timestamp: Timestamp) -> Int {
    return filter { $0.timestamp > timestamp }.count
  }

}

typealias Timeseries<Event: Temporal> = SortedArray<Event>

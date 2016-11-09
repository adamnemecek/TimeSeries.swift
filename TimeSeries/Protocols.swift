//
//  Protocols.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/8/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation

protocol DefaultConstructible {
  init()
}

protocol Infinite: DefaultConstructible, Comparable {
  static var min: Self { get }
  static var max: Self { get }
}

protocol Temporal {
  associatedtype Time: Infinite, Strideable
  var timestamp: Time { get }
}


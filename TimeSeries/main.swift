//
//  main.swift
//  TimeSeries
//
//  Created by Adam Nemecek on 11/8/16.
//  Copyright © 2016 Adam Nemecek. All rights reserved.
//

import Foundation


let a: SortedArray = [5,2,3,4,1]

extension Int {
  static func random() -> Int {
    return Int(arc4random_uniform(UInt32.max))
  }
}


extension Int: Infinite {}

struct Note: Temporal {
  let timestamp: Int = Int.random()
  let duration: Int = Int.random()
  let pitch: Int = Int.random()
}

func ==(lhs: Note, rhs: Note) -> Bool {
  return lhs.timestamp == rhs.timestamp &&
        lhs.duration == rhs.duration &&
        lhs.pitch == rhs.pitch
}

func <(lhs: Note, rhs: Note) -> Bool {
  return lhs.timestamp < rhs.timestamp &&
        lhs.pitch < rhs.pitch
}

let n = Note()






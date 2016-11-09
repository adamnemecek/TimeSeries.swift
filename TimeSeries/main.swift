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
  static func random(_ max: UInt32 = UInt32.max) -> Int {
    return Int(arc4random_uniform(max))
  }
}


extension Int: Infinite {}

struct Note: Temporal, CustomStringConvertible {
  let timestamp: Int = Int.random(10000)
  let duration: Int = Int.random(50)
  let pitch: Int = Int.random(128)

  var description: String {
    return "Note(timestamp:\(timestamp), duration:\(duration), pitch: \(pitch)"
  }
}

func ==(lhs: Note, rhs: Note) -> Bool {
  return lhs.timestamp == rhs.timestamp &&
        lhs.duration == rhs.duration &&
        lhs.pitch == rhs.pitch
}

func <(lhs: Note, rhs: Note) -> Bool {
  return lhs.timestamp < rhs.timestamp ||
         (lhs.timestamp == rhs.timestamp && lhs.pitch < rhs.pitch)

}

let q = (0...4).map { _ in Note() }
let z = q + q[1...3]
let n = (0...10).map { _ in Int.random(100) }
let b = SortedArray<Note>(q)

//dump(z.sorted())
//print(z.sorted() == z)
//dump(n.sorted())
print(b)

let t = TimeSeries(b)
print(t)








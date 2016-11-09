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
  let timestamp: Int //= Int.random(10000)
  let duration: Int // = Int.random(50)
  let pitch: Int 

  var description: String {
    return "Note(timestamp:\(timestamp), duration:\(duration), pitch: \(pitch))"
  }

  init(timestamp: Int, duration: Int, pitch: Int) {
    self.timestamp = timestamp
    self.duration = duration
    self.pitch = pitch
  }

  init() {
    timestamp = Int.random(10000)
    duration = Int.random(50)
    pitch = Int.random(50)
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

let q = (0...4).map { Note(timestamp: $0 * 10, duration : $0 * 10, pitch : $0 * 10) }
//let z = q + q[1...3]
//let n = (0...10).map { _ in Int.random(100) }
//let b = SortedArray<Note>(q)

//dump(z.sorted())
//print(z.sorted() == z)
//dump(n.sorted())
//print(b)

let t = TimeSeries(q)
print(t[20])

//print(t[0...50])

//print(t.filter { (0..<10).contains($0.timestamp) })


print(t.lastIndex(at: 20))





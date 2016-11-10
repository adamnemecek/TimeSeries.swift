#TimeSeries.swift

This project is a work in progress attempt at creating a time series data structure in Swift. 

````
  protocol Temporal
````

protocol Sequenceable is a protocol inheriting from BidirecitonalCollection where each element is Temporal (i.e. it has an associated timestamp).

In order to conform to the protocol, you have to implement the 
`func index(of timestamp: Timestamp, insertion: Bool) -> Index? `
method. Semantically, this method should perform O(n log(n)) search in the collection 
    
    insertion ?
      index { timestamp <= $0.timestamp } :
      index { timestamp == $0.timestamp }




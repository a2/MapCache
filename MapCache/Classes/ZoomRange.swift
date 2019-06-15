//
//  ZoomRange.swift
//  MapCache
//
//  Created by merlos on 13/06/2019.
//

import Foundation


/// A range of zooms.
/// Matematically: [z1, z1+1, z1+2,..., z2-1, z2]
///
/// For instance: z1 = 2, z2 = 5 then [2, 3, 4, 5] would be
/// the range.
///
/// Usage example:
///
///     let zR = ZoomRange(2,5).toArray()
//      print(zR.count) // => 4
///
/// It strictly stores z1 and z2, and the rest of the range
/// is built upon request
///
struct ZoomRange : Sequence {
    
    /// Minimum zoom in this range
    let min: Zoom
    
    /// Maximum zoom in this range
    let max: Zoom

    /// difference between max zoom and min zoom
    var diffZoom: Zoom {
        get {
            return max - min
        }
    }
    
    /// Number of zooms in this range
    ///
    /// Example:
    ///
    ///     let zR = ZoomRange(2,2)
    ///     print(zR.count) // => 1
    var count: Zoom {
        get {
            return diffZoom + 1
        }
    }
    
    /// Creates the range of zooms
    init?(_ z1: Zoom, _ z2: Zoom) {
        do {
            try TileCoords.validate(zoom: z1)
            try TileCoords.validate(zoom: z2)
        } catch {
            return nil
        }
        self.min = z1 > z2 ? z2 : z1
        self.max = z1 >= z2 ? z1 : z2
    }
    
    /// Converts to array
    /// For instance,
    func toArray() -> [Zoom] {
        var ret : [Zoom] = []
        for i in min...max {
            ret.append(i)
        }
        return ret
    }
   
    /// Returns the iterator for this range.
    /// It allows to use ZoomRange in for loops.
    ///
    /// - More info: https://developer.apple.com/documentation/swift/iteratorprotocol
    func makeIterator() -> ZoomRangeIterator{
        return ZoomRangeIterator(self)
    }
}

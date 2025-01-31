//
//  TileRange.swift
//  MapCache
//
//  Created by merlos on 13/06/2019.
//

import Foundation

/// Errors for tile range
public enum TileRangeError: Error {
    /// Error to be thrown in case of an issue during creation.
    case TileRangeCreation
}

/// For a particular zoom level, defines a range of tiles.
/// It can be iterated in a for loop. It will get the `TileCoord``
///
/// The following conditions shall always be true
///
///     minTileX <= maxTileX
///     minTileY <= maxTileY
///
/// - TODO:
///       - There are no validations for the conditions above.
///       - There are not validations for the min and max values.
///
public struct TileRange: Sequence {
    
    /// Zoom level.
    public var zoom: Zoom
    
    /// Min value of tile in X axis.
    public var minTileX: TileNumber
    
    /// Max value of tile in X axis.
    public var maxTileX: TileNumber
    
    /// Min value of tile in Y axis.
    public var minTileY: TileNumber
    
    /// Min value of tile in Y axis.
    public var maxTileY: TileNumber
    
    /// Difference between `maxTileX` and `minTileX`
    public var diffX : TileNumber {
        get {
            return maxTileX - minTileX
        }
    }
    
    /// Difference between `maxTileY` and `minTileY`
    public var diffY : TileNumber {
        get {
            return maxTileY - minTileY
        }
    }
    
    /// Number of rows in the range.
    public var rows : TileNumber {
        get {
            return diffY + 1
        }
    }
    /// Number of columns in the range.
    public var columns : TileNumber {
        get {
            return diffX + 1
        }
    }
    
    /// Counts the number of tiles in the range (columns x rows).
    public var count : TileNumber {
        get {
            return rows * columns
        }
    }
    
    /// Sequence iterator.
    /// This allows `TileRange` to be used in for loops.
    /// In each iteration it returns a `TileCoord`.
    /// It starts from the top left corner of the range and iterates row by row.
    ///
    /// - SeeAlso: [IteratorProtocol](https://developer.apple.com/documentation/swift/iteratorprotocol)
    public func makeIterator() -> TileRangeIterator {
            return TileRangeIterator(self)
    }
}


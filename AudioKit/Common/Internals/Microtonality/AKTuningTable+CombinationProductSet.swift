//
//  AKTuningTable+CombinationProductSet.swift
//  AudioKit
//
//  Created by Marcus W. Hobbs on 4/28/17.
//  Copyright © 2017 AudioKit. All rights reserved.
//

extension AKTuningTable {

    /// Create a major tetrany from 4 frequencies (4 choose 1)
    ///
    /// - parameter A, B, C, D: Master set of frequencies
    ///
    public func tetrany_major(_ A: Frequency, _ B: Frequency, _ C: Frequency, _ D: Frequency) -> Int {
        tuningTable(fromFrequencies: [A, B, C, D])
        return 4
    }
    
    /// Create a hexany from 4 frequencies (4 choose 2)
    ///
    /// - parameter A, B, C, D: Master set of frequencies
    ///
    public func hexany(_ A: Frequency, _ B: Frequency, _ C: Frequency, _ D: Frequency) -> Int {
        tuningTable(fromFrequencies: [A * B, A * C, A * D, B * C, B * D, C * D])
        return 6
    }
    
    /// Create a hexany from 4 frequencies (4 choose 3)
    ///
    /// - parameter A, B, C, D: Master set of frequencies
    ///
    public func tetrany_minor(_ A: Frequency, _ B: Frequency, _ C: Frequency, _ D: Frequency) -> Int {
        tuningTable(fromFrequencies: [A * B * C, A * B * D, A * C * D, B * C * D])
        return 4
    }

}
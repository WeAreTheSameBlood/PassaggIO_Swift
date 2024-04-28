//
//  ConvertConfiguration.swift
//  
//
//  Created by Andrii Hlybchenko on 27.04.2024.
//

import Foundation

public struct ConvertConfiguration {
    // MARK: - Properties
    let inputType: ConvertInputType
    let outputType: ConvertOutputType
    
    public init(
        input: ConvertInputType,
        output: ConvertOutputType
    ) {
        self.inputType = input
        self.outputType = output
    }
}

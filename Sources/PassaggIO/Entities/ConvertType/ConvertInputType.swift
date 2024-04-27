//
//  ConvertInputType.swift
//
//
//  Created by Andrii Hlybchenko on 27.04.2024.
//

import Foundation

public enum ConvertInputType {
    case usdz
}

// MARK: - Output types
extension ConvertInputType {
    var outputTypes: [ConvertOutputType] {
        switch self {
        case .usdz: [.obj]
        }
    }
}

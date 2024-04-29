//
//  PassaggIO.swift
//
//
//  Created by Andrii Hlybchenko on 27.04.2024.
//

import Foundation

public final class PassaggIO {
    // MARK: - Services
    private let typesConverter: TypesConverter = TypesConverterImpl()
    
    // MARK: - Init
    public init() { }
}

// MARK: - Convert
public extension PassaggIO {
    func convert(
        _ configuration: ConvertConfiguration,
        inputObjUrl: URL,
        outputObjUrl: URL,
        completion: @escaping (URL?) -> Void
    ) {
        switch configuration.inputType {
        case .usdz:
            switch configuration.outputType {
            case .obj:
                typesConverter.usdzToObj(
                    usdzUrl: inputObjUrl,
                    outputDirectory: outputObjUrl
                ) { [weak self] (resultUrl) in
                    completion(resultUrl)
                }
            }
        }
    }
}

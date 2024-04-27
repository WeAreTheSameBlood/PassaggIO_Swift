//
//  TypesConverter.swift
//
//
//  Created by Andrii Hlybchenko on 27.04.2024.
//

import ModelIO

protocol TypesConverter {
    // MARK: - Funcs
    func usdzToObj(
        usdzUrl: URL,
        outputDirectory: URL,
        completion: @escaping (URL?) -> Void
    )
}

final class TypesConverterImpl: TypesConverter {
    // MARK: - Properties
    private let typesConverterQueue = DispatchQueue(
        label: "types-converter-queue",
        qos: .userInitiated,
        attributes: [],
        autoreleaseFrequency: .workItem
    )
}

// MARK: - Convert
extension TypesConverterImpl {
    func usdzToObj(
        usdzUrl: URL,
        outputDirectory: URL,
        completion: @escaping (URL?) -> Void
    ) {
        typesConverterQueue.async {
            do {
                guard
                    let objContentAsString = self.generateOBJ(usdzUrl: usdzUrl)
                else {
                    completion(nil)
                    return
                }
                
                try objContentAsString.write(
                    to: outputDirectory,
                    atomically: true,
                    encoding: .utf8
                )
                
                completion(outputDirectory)
            } catch {
                completion(nil)
            }
        }
    }
}

// MARK: - Private
private extension TypesConverterImpl {
    func generateOBJ(usdzUrl: URL) -> String? {
        guard
            let meshes = MDLAsset(url: usdzUrl).childObjects(of: MDLMesh.self)
                as? [MDLMesh]
        else {
            return nil
        }
        
        var resultObjString = String()
        
        for mesh in meshes {
            for vertexBuffer in mesh.vertexBuffers {
                let bytes = vertexBuffer.map().bytes
                let stride = (mesh.vertexDescriptor.layouts[0] as! MDLVertexBufferLayout).stride
                
                for i in 0 ..< mesh.vertexCount {
                    let vertexPointer = bytes.advanced(by: i * stride)
                    let vertex = vertexPointer.assumingMemoryBound(to: SIMD3<Float>.self).pointee
                    resultObjString += "v \(vertex.x) \(vertex.y) \(vertex.z)\n"
                }
            }
            
            guard
                let submeshes = mesh.submeshes as? [MDLSubmesh]
            else {
                return resultObjString
            }
            
            for submesh in submeshes {
                resultObjString += "g Object\(meshes.firstIndex(of: mesh) ?? 0)\n"
                
                let indexBufferMap = submesh.indexBuffer.map()
                let indexPointer = indexBufferMap.bytes.assumingMemoryBound(to: UInt32.self)
                let indicesPerPrimitive = 3
                let primitiveCount = submesh.indexCount / indicesPerPrimitive
                
                for i in 0 ..< primitiveCount {
                    resultObjString += "f"
                    
                    for j in 0 ..< indicesPerPrimitive {
                        let index = indexPointer[i * indicesPerPrimitive + j] + 1
                        resultObjString += " \(index)"
                    }
                    resultObjString += "\n"
                }
            }
        }
        
        return resultObjString
    }
}

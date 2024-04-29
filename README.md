# PassaggIO

PassaggIO is a mobile library for converting 3D models, designed to work efficiently with various file formats on iOS platforms. This tool allows users to easily convert USDZ files to OBJ format and plans to support additional formats in the future. PassaggIO utilizes the powerful capabilities of iOS to optimize and process large 3D models effectively.

## Supported Formats
| Input \ Output | USDZ           | OBJ            | FBX           | STL           | AMF           |
|----------------|----------------|----------------|---------------|---------------|---------------|
| USDZ           |                | :heavy_check_mark: | :x:          | :x:           | :x:           |
| OBJ            | :x: (planned) |                | :x:           | :x:           | :x:           |
| FBX            | :x: (planned) | :x:            |               | :x:           | :x:           |
| STL            | :x: (planned) | :x:            | :x:           |               | :x:           |
| AMF            | :x: (planned) | :x:            | :x:           | :x:           |               |

### Important Notes
**All operations within the library are performed on a separate thread to ensure UI responsiveness. If needed, make sure to dispatch the results back to the main thread for any UI updates.**

## Technologies
- ModelIO
- SceneKit

## Installation via Swift Package Manager (SPM)
### Adding to an iOS App
To integrate PassaggIO into your iOS project using Swift Package Manager:
1. Go to your Xcode project's "General" settings.
2. Tap on "Package Dependencies".
3. Click the "+" button to add a package.
4. Enter the package repository URL: `https://github.com/WeAreTheSameBlood/PassaggIO_Swift.git`
5. Specify the exact version or choose a commit as needed.

### Integration with Another Swift Package
If you are developing a library or another Swift package that requires using PassaggIO, add the following lines to your `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/WeAreTheSameBlood/PassaggIO_Swift.git", 
        from: "1.0.0"
    )
]

targets: [
    .target(
        name: "YourPackageName",
        dependencies: [
        "PassaggIO"
        ]
    )
]
```

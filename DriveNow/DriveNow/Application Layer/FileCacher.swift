import Foundation

private enum FileManagerError: Error {
    case noAccess
}

enum CachedType: String {
    case history
    case procurement
    case settings
}

final class FileCacher {
    static let manager = FileCacher()
    
    private var fileManager: FileManager {
        return FileManager.default
    }

    private var documentDirectoryURL: URL? {
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    func load<T>(with type: CachedType) throws -> T where T: Decodable {
        let url = try documentURL(by: type)
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func cache<T>(_ value: [T], with type: CachedType) throws where T: Encodable {
        let url = try documentURL(by: type)
        let directoryURL = url.deletingLastPathComponent()
        try createDirectoryIfNeeded(at: directoryURL)

        let encoded = try JSONEncoder().encode(value)
        try encoded.write(to: url)
    }
    
    func cache<T>(_ value: T, with type: CachedType) throws where T: Encodable {
        let url = try documentURL(by: type)
        let directoryURL = url.deletingLastPathComponent()
        try createDirectoryIfNeeded(at: directoryURL)

        let encoded = try JSONEncoder().encode(value)
        try encoded.write(to: url)
    }

    func removeItem(with type: CachedType) throws {
        let url = try documentURL(by: type)
        try fileManager.removeItem(at: url)
    }

    private func documentURL(by type: CachedType) throws -> URL {
        guard let directoryUrl = documentDirectoryURL?.appendingPathComponent(type.rawValue, isDirectory: true) else {
            throw FileManagerError.noAccess
        }
        
        return directoryUrl.appendingPathComponent(type.rawValue, isDirectory: false)
    }

    private func createDirectoryIfNeeded(at url: URL) throws {
        guard !fileManager.fileExists(atPath: url.path) else { return }

        try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
    }
}

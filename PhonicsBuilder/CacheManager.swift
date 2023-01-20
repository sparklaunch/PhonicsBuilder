import SwiftUI

enum CacheManager {
    static func clearCachesDirectory() {
        let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let caches: [String]
        do {
            caches = try FileManager.default.contentsOfDirectory(atPath: cachesDirectory.path)
        } catch {
            print(error.localizedDescription)
            return
        }
        do {
            for cache in caches {
                try FileManager.default.removeItem(atPath: cache)
                print("\(cache) deleted.")
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}

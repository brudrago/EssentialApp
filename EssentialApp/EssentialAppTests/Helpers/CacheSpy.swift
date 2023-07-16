import Essential_Feed
import Foundation

public final class CacheSpy: FeedCache, FeedImageDataCache {
    private (set) var messages = [Message]()
    private (set) var saveDatamessages = [Message]()
    
    enum Message: Equatable {
        case save([FeedImage])
        case save(data: Data, for: URL)
    }
    
    public func save(_ feed: [FeedImage], completion: @escaping (FeedCache.Result) -> Void) {
        messages.append(.save(feed))
        completion(.success(()))
    }
    
    public func save(_ data: Data, for url: URL, completion: @escaping (FeedImageDataCache.Result) -> Void) {
        saveDatamessages.append(.save(data: data, for: url))
        completion(.success(()))
    }
}

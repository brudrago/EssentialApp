import Essential_Feed

public final class FeedLoaderStub: FeedLoader {
    
    private let result: FeedLoader.Result
    
    public init(result: Result<[FeedImage], Error>) {
        self.result = result
    }
    
   public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completion(result)
    }
}

import CoreData
import UIKit
import Essential_Feed
import EssentialFeediOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    let localStoreURL = NSPersistentContainer
        .defaultDirectoryURL()
        .appendingPathComponent("feed-store.sqlite")
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let remoteURL = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed")!
        let remoteClient = makeRemoteClient()
        let remoteFeedLoader = RemoteFeedLoader(client: remoteClient, url: remoteURL)
        let remoteImageLoader = RemoteFeedImageDataLoader(client: remoteClient)
        
        
        let localStore = try! CoreDataFeedStore(storeURL: localStoreURL)
        let localFeedLoader = LocalFeedLoader(store: localStore, currentDate: Date.init)
        let localImageLoader = LocalFeedImageDataLoader(store: localStore)
        
        window?.rootViewController = FeedUIComposer.feedComposeWith(
            feedLoader: FeedLoaderWithFallbackComposite(
                primary: FeedLoaderCacheDecorator(
                    decoratee: remoteFeedLoader,
                    cache: localFeedLoader
                ),
                fallback: localFeedLoader
            ),
            imageLoader: FeedImageDataLoaderWithFallbackComposite(
                primary: localImageLoader,
                fallback: FeedImageDataLoaderCacheDecorator(
                    decoratee: remoteImageLoader,
                    cache: localImageLoader
                )
            )
        )
    }
    
    func makeRemoteClient() -> HTTPClient {
        return URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }

}

//        let url =  "https://ile-api.essentialdeveloper.com/essential-feed/v1/feed"
//        let urlString = URL(string: url)!
//        let session = URLSession(configuration: .ephemeral)
//        let remoteClient = URLSessionHTTPClient(session: session)
//        let remoteFeedLoader = RemoteFeedLoader(client: remoteClient, url: urlString)
//        let remoteImageDataLoader = RemoteFeedImageDataLoader(client: remoteClient)
//
//        let localStoreURL = NSPersistentContainer
//            .defaultDirectoryURL()
//            .appendingPathComponent("feed-store.sqlite")
//
//        let localStore = try! CoreDataFeedStore(storeURL: localStoreURL)
//        let localFeedLoader = LocalFeedLoader(store: localStore, currentDate: Date.init)
//        let localImageLoader = LocalFeedImageDataLoader(store: localStore)
//
//        window?.rootViewController = FeedUIComposer.feedComposeWith(
//            feedLoader: FeedLoaderWithFallbackComposite(
//                primary: FeedLoaderCacheDecorator(decoratee: remoteFeedLoader, cache: localFeedLoader),
//                fallback: localFeedLoader
//            ),
//            imageLoader: FeedImageDataLoaderWithFallbackComposite(
//                primary: localImageLoader,
//                fallback: FeedImageDataLoaderCacheDecorator(
//                    decoratee: remoteImageDataLoader,
//                    cache: localImageLoader
//                )
//            )
//        )




//To Test if the local loaders are working
//        window?.rootViewController = FeedUIComposer.feedComposeWith(
//            feedLoader: localFeedLoader,
//            imageLoader: localImageLoader
//        )

//let remoteURL = URL(string: "https://static1.squarespace.com/static/5891c5b8d1758ec68ef5dbc2/t/5db4155a4fbade21d17ecd28/1572083034355/essential_app_feed.json")!
// used by Essential

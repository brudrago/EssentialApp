import EssentialApp
import Essential_Feed
import XCTest

//UITests are super low, should be on separate scheme to be executed only on CI
//FIX storyboard to this tests work

final class EssentialAppAcceptanceUITests: XCTestCase {

//    func test_onLaunch_displaysRemoteFeedWhenCustomerHasConnectivity() {
//        let app = XCUIApplication()
//        app.launchArguments = ["-reset", "-connectivity", "online"]
//
//        app.launch()
//
//        let feedCells = app.cells.matching(identifier: "feed-image-cell")
//        XCTAssertEqual(feedCells.count, 2)
//
//        let firstImage = app.images.matching(identifier: "feed-image-view").firstMatch
//        XCTAssertTrue(firstImage.exists)
//    }
    
//    func test_onLaunch_displaysCachedRemoteFeedWhenCustomerHasNoConnectivity() {
//        let onlineApp = XCUIApplication()
//        onlineApp.launchArguments = ["-reset", "-connectivity", "online"] //reset the state to guarantee theres no shared state between tests
//        onlineApp.launch()
//
//        let offlineApp = XCUIApplication()
//        offlineApp.launchArguments = ["-connectivity", "offline"]
//        offlineApp.launch()
//
//        let cachedFeedCells = offlineApp.cells.matching(identifier: "feed-image-cell")
//        XCTAssertEqual(cachedFeedCells.count, 2)
//
//        let firstCachedImage = offlineApp.images.matching(identifier: "feed-image-view").firstMatch
//        XCTAssertTrue(firstCachedImage.exists)
//    }
    
    func test_onLaunch_displaysEmptyFeedWhenCustomerHasNoConnectivityAndNoCache() {
        let app = XCUIApplication()
        app.launchArguments = ["-reset", "-connectivity", "offline"]
        app.launch()

        let feedCells = app.cells.matching(identifier: "feed-image-cell")
        XCTAssertEqual(feedCells.count, 0)
    }
}

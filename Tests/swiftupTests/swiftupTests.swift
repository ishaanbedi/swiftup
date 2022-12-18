import XCTest
@testable import swiftup
class ReachabilityTests: XCTestCase {
    func testIsReachable() {
        let reachability = Reachability(domain: "www.example.com")
        let isReachable = reachability.isReachable()
        XCTAssertTrue(isReachable)
    }
    func testIsUnreachable() {
        let reachability = Reachability(domain: "www.invalid.com")
        let isReachable = reachability.isReachable()
        XCTAssertFalse(isReachable)
    }
    func testVerboseMode() {
        let reachability = Reachability(domain: "www.example.com", verbose: true)
        let isReachable = reachability.isReachable()
        XCTAssertTrue(isReachable)
    }
}
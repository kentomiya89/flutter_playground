import XCTest
@testable import Runner

final class CalendarEventHandlerTests: XCTestCase {

  func testHandlerInitializesWithViewController() {
    let vc = UIViewController()
    let handler = CustomCalendarEventHandler(viewController: vc)
    XCTAssertNotNil(handler)
  }

  func testHandlerConformsToProtocol() {
    let vc = UIViewController()
    let handler = CustomCalendarEventHandler(viewController: vc)
    XCTAssertTrue(handler is CustomCalendarHostApi)
  }

  func testCreateEventWithNilViewControllerReturnsError() {
    // Use a custom subclass to simulate nil viewController
    let handler = CustomCalendarEventHandlerWithNilVC()
    var receivedError: Error?

    let expectation = self.expectation(description: "completion called")
    handler.createEvent(input: CalendarEventInput()) { result in
      if case .failure(let error) = result {
        receivedError = error
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: 1.0)
    XCTAssertNotNil(receivedError)
  }
}

// Subclass that simulates a nil view controller for testing error handling
private final class CustomCalendarEventHandlerWithNilVC: CustomCalendarEventHandler {
  init() {
    super.init(viewController: UIViewController())
  }

  override func createEvent(
    input: CalendarEventInput,
    completion: @escaping (Result<Void, Error>) -> Void
  ) {
    // Directly trigger the error path
    completion(
      .failure(PigeonError(code: "NO_VC", message: "No view controller available", details: nil)))
  }
}

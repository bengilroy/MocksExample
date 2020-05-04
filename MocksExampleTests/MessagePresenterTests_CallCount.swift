//
//  MessagePresenterTests_CallCount.swift
//  MocksExampleTests
//
//  Created by Ben Gilroy on 01/05/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

import XCTest
@testable import MocksExample

final class MockMessageView_CallCount: MessageView {
	
	private(set) var showLoadingCallCount = 0
	private(set) var hideLoadingCallCount = 0
	private(set) var updateMessageCallCount = 0
	private(set) var showMessageCallCount = 0
	private(set) var hideMessageCallCount = 0
	private(set) var capturedMessage: String?
	
	func showLoading() {
		showLoadingCallCount += 1
	}
	
	func hideLoading() {
		hideLoadingCallCount += 1
	}
	
	func updateMessage(_ message: String) {
		updateMessageCallCount += 1
		capturedMessage = message
	}
	
	func showMessage() {
		showMessageCallCount += 1
	}
	
	func hideMessage() {
		hideMessageCallCount += 1
	}
	
}

final class MessagePresenterTests_CallCount: XCTestCase {
	
	private var mockService: MockMessageService!
	private var presenter: MessagePresenter!
	private var mockView: MockMessageView_CallCount!
	
	override func setUp() {
		super.setUp()
		mockService = MockMessageService()
		mockView = MockMessageView_CallCount()
		presenter = MessagePresenter(service: mockService)
		presenter.view = mockView
	}
	
	func test_success() {
		let message = "Success!"
		mockService.mockResult = .success(message)
		
		presenter.fetchMessageButtonTapped()
		
		XCTAssertEqual(mockView.showLoadingCallCount, 1)
		XCTAssertEqual(mockView.hideLoadingCallCount, 1)
		XCTAssertEqual(mockView.updateMessageCallCount, 1)
		XCTAssertEqual(mockView.showMessageCallCount, 1)
		XCTAssertEqual(mockView.hideMessageCallCount, 1)
		XCTAssertEqual(mockView.capturedMessage, message)
	}
	
	func test_failure() {
		mockService.mockResult = .failure(MockError.unknown)
		
		presenter.fetchMessageButtonTapped()
		
		XCTAssertEqual(mockView.showLoadingCallCount, 1)
		XCTAssertEqual(mockView.hideLoadingCallCount, 1)
		XCTAssertEqual(mockView.updateMessageCallCount, 1)
		XCTAssertEqual(mockView.showMessageCallCount, 1)
		XCTAssertEqual(mockView.hideMessageCallCount, 1)
		XCTAssertEqual(mockView.capturedMessage, "Oops! Something went wrong")
	}
	
}

//
//  MessagePresenterTests_Bool.swift
//  MocksExampleTests
//
//  Created by Ben Gilroy on 01/05/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

import XCTest
@testable import MocksExample

final class MockMessageView_Bool: MessageView {
	
	private(set) var showLoadingCalled = false
	private(set) var hideLoadingCalled = false
	private(set) var updateMessageCalled = false
	private(set) var showMessageCalled = false
	private(set) var hideMessageCalled = false
	private(set) var capturedMessage: String?
	
	func showLoading() {
		showLoadingCalled = true
	}
	
	func hideLoading() {
		hideLoadingCalled = true
	}
	
	func updateMessage(_ message: String) {
		updateMessageCalled = true
		capturedMessage = message
	}
	
	func showMessage() {
		showMessageCalled = true
	}
	
	func hideMessage() {
		hideMessageCalled = true
	}
	
}

final class MessagePresenterTests_Bool: XCTestCase {
	
	private var mockService: MockMessageService!
	private var presenter: MessagePresenter!
	private var mockView: MockMessageView_Bool!
	
	override func setUp() {
		super.setUp()
		mockService = MockMessageService()
		mockView = MockMessageView_Bool()
		presenter = MessagePresenter(service: mockService)
		presenter.view = mockView
	}
	
	func test_success() {
		let message = "Woo hoo!"
		mockService.mockResult = .success(message)
		
		presenter.fetchMessageButtonTapped()
		
		XCTAssertTrue(mockView.showLoadingCalled)
		XCTAssertTrue(mockView.hideLoadingCalled)
		XCTAssertTrue(mockView.updateMessageCalled)
		XCTAssertTrue(mockView.showMessageCalled)
		XCTAssertTrue(mockView.hideMessageCalled)
		XCTAssertEqual(mockView.capturedMessage, message)
	}
	
	func test_failure() {
		mockService.mockResult = .failure(MockError.unknown)
		
		presenter.fetchMessageButtonTapped()
		
		XCTAssertTrue(mockView.showLoadingCalled)
		XCTAssertTrue(mockView.hideLoadingCalled)
		XCTAssertTrue(mockView.updateMessageCalled)
		XCTAssertTrue(mockView.showMessageCalled)
		XCTAssertTrue(mockView.hideMessageCalled)
		XCTAssertEqual(mockView.capturedMessage, "Oops! Something went wrong")
	}
	
}

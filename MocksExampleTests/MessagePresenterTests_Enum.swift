//
//  MessagePresenterTests_Enum.swift
//  MocksExampleTests
//
//  Created by Ben Gilroy on 01/05/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

import XCTest
@testable import MocksExample

final class MockMessageView_Enum: MessageView {
	
	enum Event: String, CustomStringConvertible {
		case showLoading
		case hideLoading
		case updateMessage
		case showMessage
		case hideMessage
		
		var description: String {
			return "." + rawValue
		}
	}
	
	private(set) var capturedEvents = [Event]()
	private(set) var capturedMessage: String?
	
	func showLoading() {
		capturedEvents.append(.showLoading)
	}
	
	func hideLoading() {
		capturedEvents.append(.hideLoading)
	}
	
	func updateMessage(_ message: String) {
		capturedEvents.append(.updateMessage)
		capturedMessage = message
	}
	
	func showMessage() {
		capturedEvents.append(.showMessage)
	}
	
	func hideMessage() {
		capturedEvents.append(.hideMessage)
	}
	
}

final class MessagePresenterTests_Enum: XCTestCase {
	
	private var mockService: MockMessageService!
	private var presenter: MessagePresenter!
	private var mockView: MockMessageView_Enum!
	
	override func setUp() {
		super.setUp()
		mockService = MockMessageService()
		mockView = MockMessageView_Enum()
		presenter = MessagePresenter(service: mockService)
		presenter.view = mockView
	}
	
	func test_success() {
		let message = "Success!"
		mockService.mockResult = .success(message)
		
		presenter.fetchMessageButtonTapped()
		
		XCTAssertEqual(mockView.capturedEvents, [.hideMessage, .showLoading, .updateMessage, .hideLoading, .showMessage])
		XCTAssertEqual(mockView.capturedMessage, message)
	}
	
	func test_failure() {
		mockService.mockResult = .failure(MockError.unknown)
		
		presenter.fetchMessageButtonTapped()
		
		XCTAssertEqual(mockView.capturedEvents, [.hideMessage, .showLoading, .updateMessage, .hideLoading, .showMessage])
		XCTAssertEqual(mockView.capturedMessage, "Oops! Something went wrong")
	}
	
}

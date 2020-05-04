//
//  MockMessageService.swift
//  MocksExampleTests
//
//  Created by Ben Gilroy on 01/05/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

@testable import MocksExample

enum MockError: Error {
	case unknown
}

final class MockMessageService: MessageServiceType {
	
	var mockResult: MessageResult = .success("Hello, World!")
	
	func fetchMessage(completion: @escaping (Result<String, Error>) -> Void) {
		completion(mockResult)
	}
	
}

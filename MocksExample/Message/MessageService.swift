//
//  MessageService.swift
//  MocksExample
//
//  Created by Ben Gilroy on 01/05/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

import Foundation

protocol MessageServiceType {
	typealias MessageResult = Result<String, Error>
	func fetchMessage(completion: @escaping (MessageResult) -> Void)
}

struct MessageService: MessageServiceType {
	
	func fetchMessage(completion: @escaping (MessageResult) -> Void) {
		// This is just for demo purposes.
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			completion(.success("Hello, world!"))
		}
	}
	
}

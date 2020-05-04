//
//  MessagePresenter.swift
//  MocksExample
//
//  Created by Ben Gilroy on 01/05/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

protocol MessageView: AnyObject {
	func showLoading()
	func hideLoading()
	func updateMessage(_ message: String)
	func showMessage()
	func hideMessage()
}

final class MessagePresenter {
	
	weak var view: MessageView?
	
	private let service: MessageServiceType
	
	init(service: MessageServiceType = MessageService()) {
		self.service = service
	}
	
	func fetchMessageButtonTapped() {
		fetchMessage()
	}

	// MARK: - Working
	
	private func fetchMessage() {
		view?.hideMessage()
		view?.showLoading()
		service.fetchMessage { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let message):
				self.view?.updateMessage(message)
			case .failure:
				self.view?.updateMessage("Oops! Something went wrong")
			}
			self.view?.hideLoading()
			self.view?.showMessage()
		}
	}
	
	// MARK: - Bug 1
	
//	private func fetchMessage() {
//		view?.hideMessage()
//		view?.showLoading()
//		service.fetchMessage { [weak self] result in
//			guard let self = self else { return }
//			switch result {
//			case .success(let message):
//				self.view?.updateMessage(message)
//			case .failure:
//				self.view?.updateMessage("Oops! Something went wrong")
//			}
//			self.view?.hideLoading()
//			self.view?.showLoading()
//			self.view?.showMessage()
//		}
//	}
	
	// MARK: - Bug 2
	
//	private func fetchMessage() {
//		view?.hideMessage()
//		view?.hideLoading()
//		service.fetchMessage { [weak self] result in
//			guard let self = self else { return }
//			switch result {
//			case .success(let message):
//				self.view?.updateMessage(message)
//			case .failure:
//				self.view?.updateMessage("Oops! Something went wrong")
//			}
//			self.view?.showLoading()
//			self.view?.showMessage()
//		}
//	}
	
}

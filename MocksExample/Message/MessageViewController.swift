//
//  MessageViewController.swift
//  MocksExample
//
//  Created by Ben Gilroy on 01/05/2020.
//  Copyright © 2020 The App Business. All rights reserved.
//

import UIKit

final class MessageViewController: UIViewController {
	
	@IBOutlet private var messageLabel: UILabel!
	@IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
	@IBOutlet private var button: UIButton!
	
	private let presenter = MessagePresenter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
	
	private func setup() {
		title = "Mocking with Swift"
		messageLabel.isHidden = true
		activityIndicatorView.hidesWhenStopped = true
		presenter.view = self
	}
	
	
	@IBAction private func fetchButtonTapped() {
		presenter.fetchMessageButtonTapped()
	}
	
}

extension MessageViewController: MessageView {
	
	func showLoading() {
		activityIndicatorView.startAnimating()
	}
	
	func hideLoading() {
		activityIndicatorView.stopAnimating()
	}
	
	func updateMessage(_ message: String) {
		messageLabel.text = message
	}
	
	func showMessage() {
		messageLabel.isHidden = false
	}
	
	func hideMessage() {
		messageLabel.isHidden = true
	}
	
}

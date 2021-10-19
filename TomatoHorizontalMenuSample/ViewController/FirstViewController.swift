//
//  FirstViewController.swift
//  TomatoHorizontalMenuSample
//
//  Created by Tomato on 2021/10/19.
//

import UIKit

class FirstViewController: BasicViewController {
	// MARK: - Variables
	
	
	// MARK: - IBOutlet
	
	
	// MARK: - IBAction
	
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewIndex = 0
		hideBackButton = true
		setup()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
	}
	
	deinit {
		print("deinit is called by FirstViewController")
	}
}


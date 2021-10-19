//
//  BasicViewController.swift
//  TomatoHorizontalMenuSample
//
//  Created by Tomato on 2021/10/19.
//

import UIKit
import TomatoHorizontalMenu

class BasicViewController: TomatoHorizontalBaseController {
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
		super.init(nibName: nil, bundle: nil)
	}
	
	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	
	var hideBackButton = false
	func setup() {
		if let _ = navigationController {
			self.navigationItem.hidesBackButton = hideBackButton
		}
		let model0 = TomatoHorizontalMenuModel(name: "TOP", index: 0)
		let model1 = TomatoHorizontalMenuModel(name: "LATEST", index: 2)
		let model2 = TomatoHorizontalMenuModel(name: "SUMMARY", index: 3)
		let model3 = TomatoHorizontalMenuModel(name: "SETTINGS", index: 1)
		tomatoHorizontalModels = [model0, model1, model2, model3]
		
		/* setup variables */
		autoScroll = false
		menuHeight = 40.0
		menuHighlightHeight = 6.0
		labelTextColor = .black
		labelHighlightTextColor = .systemBlue
		menuHighlightColor = .systemGreen
		boxBorderColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
		borderWidth = 2.0
		
		/* horizontal menu setup */
		tomatoHorizontalMenuSetup()
	}
	
	override func switchViewController(_ sender: UITapGestureRecognizer) {
		if let tag = sender.view?.tag {
			if tag == 0 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController {
					navigationController?.pushViewController(viewController, animated: true)
				}
			}
			else if tag == 1 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
					navigationController?.pushViewController(viewController, animated: true)
				}
			}
			else if tag == 2 {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController {
					navigationController?.pushViewController(viewController, animated: true)
				}
			}
			else {
				if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FourthViewController") as? FourthViewController {
					navigationController?.pushViewController(viewController, animated: true)
				}
			}
		}
	}
}


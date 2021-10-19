//
//  ViewController.swift
//  TomatoHorizontalMenuSample
//
//  Created by Tomato on 2021/10/19.
//

import UIKit

open class TomatoHorizontalBaseController: UIViewController {
	var basicScrollView = UIScrollView()
	
	
	// MARK: - Setup
	public var viewIndex = Int()
	public var menuHeight: CGFloat = 60.0
	public var labelTextColor = UIColor.black
	public var labelHighlightTextColor = UIColor.systemBlue
	public var labelHeight: CGFloat = 21.0
	public var labelFontSize: CGFloat = 17.0
	public var menuHighlightColor = UIColor.systemBlue
	public var menuHighlightHeight: CGFloat = 4.0
	public var spaceBetween: CGFloat = 30.0
	public var boxBorderColor = UIColor.gray
	public var borderWidth: CGFloat = 2.0
	public var showHorizontalScroller = false
	public var scrollBackColor = UIColor.white
	public var tomatoHorizontalModels = [TomatoHorizontalMenuModel]()
	public var hasLayoutConstraints = true
	public var autoScroll = true
	public func tomatoHorizontalMenuSetup() {
		var topHeight: CGFloat = 0.0
		if let navigationController = navigationController, let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first, let statusManager = window.windowScene?.statusBarManager {
			let statusFrame = statusManager.statusBarFrame
			let navigationFrame = navigationController.navigationBar.frame
			topHeight = statusFrame.height + navigationFrame.height
		}
		
		/* scrollView */
		let screenSize = UIScreen.main.bounds.size
		let scrollRect = CGRect(origin: CGPoint(x: 0, y: topHeight), size: CGSize(width: screenSize.width, height: menuHeight))
		basicScrollView = UIScrollView(frame: scrollRect)
		//basicScrollView.accessibilityIdentifier = "topScrollView"
		basicScrollView.backgroundColor = scrollBackColor
		
		/* scrollView content */
		var contentViews = [UIView]()
		for i in 0..<tomatoHorizontalModels.count {
			let model = tomatoHorizontalModels[i]
			if i == 0 {
				let contentView = makeHorizontalView(name: model.name, index: model.index, prevWidth: 0.0)
				contentViews.append(contentView)
				basicScrollView.addSubview(contentView)
			} else {
				let prevContentView = contentViews[i - 1]
				let contentView = makeHorizontalView(name: model.name, index: model.index, prevWidth: prevContentView.frame.origin.x + prevContentView.frame.width)
				contentViews.append(contentView)
				basicScrollView.addSubview(contentView)
			}
		}
		let lastContentView = contentViews[contentViews.count - 1]
		let contentWidth = lastContentView.frame.origin.x + lastContentView.frame.width + spaceBetween
		
		basicScrollView.contentSize = CGSize(width: contentWidth, height: lastContentView.frame.height)
		let borderColor = boxBorderColor
		basicScrollView.layer.borderColor = borderColor.cgColor
		basicScrollView.layer.borderWidth = borderWidth
		basicScrollView.showsHorizontalScrollIndicator = showHorizontalScroller
		view.addSubview(basicScrollView)
		
		if autoScroll {
			let contentView = contentViews[viewIndex]
			basicScrollView.setContentOffset(CGPoint(x: contentView.frame.origin.x, y: 0), animated: true)
		}
		
		/* layout */
		if hasLayoutConstraints {
		basicScrollView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			basicScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			basicScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			basicScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
			basicScrollView.heightAnchor.constraint(equalToConstant: menuHeight)
		])
		}
	}
	
	
	// MARK: - Creating horizontal view
	func makeHorizontalView(name: String, index: Int, prevWidth: CGFloat) -> UIView {
		let textColor = (index == viewIndex) ? labelHighlightTextColor : labelTextColor
		let attr = NSMutableAttributedString(string: name)
		let font = UIFont.systemFont(ofSize: labelFontSize)
		attr.addAttribute(NSAttributedString.Key.font, value: font, range: NSRange(location: 0, length: name.count))
		attr.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: NSRange(location: 0, length: name.count))
		let width = attr.size().width
		
		/* highlight */
		let highRect = CGRect(x: prevWidth + spaceBetween, y: 0.0, width: width + spaceBetween, height: menuHeight)
		let highView = UIView(frame: highRect)
		if index == viewIndex {
			highView.backgroundColor = menuHighlightColor
		} else {
			highView.backgroundColor = scrollBackColor
		}
		
		/* front */
		let frontRect = CGRect(x: 0.0, y: 0.0, width: width + spaceBetween, height: menuHeight - menuHighlightHeight)
		let frontView = UIView(frame: frontRect)
		frontView.backgroundColor = scrollBackColor
		highView.addSubview(frontView)
		
		/* label */
		let labelTopPosition = (menuHeight - labelHeight) / 2.0
		let labelRect = CGRect(x: 0.0, y: labelTopPosition, width: width + spaceBetween, height: labelHeight)
		let label = UILabel(frame: labelRect)
		label.textAlignment = .center
		label.attributedText = attr
		label.isUserInteractionEnabled = true
		frontView.addSubview(label)
		
		/* tap gesture */
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(switchViewController(_:)))
		label.addGestureRecognizer(tapGesture)
		label.tag = index
		label.accessibilityIdentifier = String(format: "%.2f", prevWidth + spaceBetween)
		
		return highView
	}
	
	
	// MARK: - Switching view controller
	@objc open func switchViewController(_ sender: UITapGestureRecognizer) {
		/*
		if let tag = sender.view?.tag {
			let tomatoHorizontalModel = tomatoHorizontalModels[tag]
			let storyboardID = tomatoHorizontalModel.storyboardID
			let myViewController = tomatoHorizontalModel.viewController
			if let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "storyboardID") as? myViewController {
				navigationController?.pushViewController(viewController, animated: true)
			}
		}
		*/
		/*
		if let tag = sender.view?.tag {
			tomatoHorizontalBaseControllerDelegate?.viewControllerCalled(index: tag)
		}
		*/
	}
}

public struct TomatoHorizontalMenuModel {
	public let name: String
	public let index: Int
	public init(name: String, index: Int) {
		self.name = name
		self.index = index
	}
}


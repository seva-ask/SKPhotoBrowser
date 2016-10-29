//
//  SKNavigationBar.swift
//  SKPhotoBrowser
//
//  Created by Григорий Уланов on 12.10.16.
//  Copyright © 2016 suzuki_keishi. All rights reserved.
//

import UIKit

class SKNavigationBar: UIView {

    var showFrame: CGRect!
    var hideFrame: CGRect!

    private static let toolBarHeight: CGFloat = 64.0

    fileprivate weak var browser: SKPhotoBrowser?

    private var countLabel: UILabel?
    private var doneButton: UIButton?

    var onDoneTap: (() -> Void)?

    convenience init(browser: SKPhotoBrowser) {
        self.init(frame: CGRect.zero)

        self.browser = browser

        backgroundColor = UIColor.black.withAlphaComponent(0.65)

        countLabel = UILabel()
        countLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        countLabel?.textColor = UIColor.white
        countLabel?.textAlignment = .center
        if let countLabel = countLabel {
            addSubview(countLabel)
        }

        doneButton = UIButton()
        doneButton?.setTitle(SKPhotoBrowserOptions.navigationBarDoneTitle, for: .normal)
        doneButton?.setTitleColor(UIColor.white, for: .normal)
        doneButton?.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        if let doneButton = doneButton {
            addSubview(doneButton)
        }
    }

    @objc private func doneButtonAction() {
        onDoneTap?()
    }

    func updateNavigationBar(_ currentPageIndex: Int) {
        guard let browser = browser else { return }

        if browser.numberOfPhotos > 1 {
            self.countLabel?.text = "\(currentPageIndex + 1) \(SKPhotoBrowserOptions.navigationBarCounterSepatator) \(browser.numberOfPhotos)"
        } else {
            self.countLabel?.text = nil
        }
    }

    override func layoutSubviews() {
        if UIDevice.current.orientation == .portrait {
            countLabel?.frame = CGRect(x: 0, y: 20, width: bounds.width, height: bounds.height)
            doneButton?.frame = CGRect(x: 20, y: 20, width: 80, height: bounds.height)
        } else {
            countLabel?.frame = bounds
            doneButton?.frame = CGRect(x: 20, y: 0, width: 80, height: bounds.height)
        }
    }

    func setNewFrame(rect: CGRect) {
        frame = rect
        showFrame = rect
        hideFrame = CGRect(x: rect.origin.x, y: rect.origin.y - 20, width: rect.size.width, height: rect.size.height)
        layoutSubviews()
    }

    func updateFrame(_ parentSize: CGSize) {
        let newRect = CGRect(x: 0, y: 0, width: parentSize.width, height: SKNavigationBar.toolBarHeight)
        setNewFrame(rect: newRect)
    }

}

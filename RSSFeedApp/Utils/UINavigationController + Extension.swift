//
//  UINavigationController + Extension.swift
//  RSSFeedApp
//
//  Created by Evgeniy Uskov on 28.01.2021.
//

import UIKit

extension UINavigationController {
    public func pushFromLeft(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        pushViewController(viewController, animated: false)
        //present(viewController, animated: false, completion: nil)
//        self.show(viewController, animated: false, sender: self)
    }
    
    public func popFromLeft() {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
//            present(viewController, animated: false, completion: nil)
//            self.show(viewController, animated: false, sender: self)
    }
}

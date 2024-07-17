//
//  Storyboardable.swift
//  EterationStudyCase
//
//  Created by Teyhan Uslu on 14.07.2024.
//

import UIKit

protocol StoryboardLoadable {
    static func storyboardName() -> String
    static func storyboardIdentifier() -> String
}

extension StoryboardLoadable where Self: UIViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }

    static func storyboardIdentifier() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }
}


extension StoryboardLoadable where Self: UITabBarController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "TabBarController", with: "")
    }

    static func storyboardIdentifier() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "TabBarController", with: "")
    }
}

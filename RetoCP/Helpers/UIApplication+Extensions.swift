//
//  UIApplication+Extensions.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import UIKit

extension UIApplication {
    func tabbarController() -> UIViewController? {
        guard let tvc = UIApplication.shared.windows.first?.rootViewController else { return nil }
        return tvc
    }
}

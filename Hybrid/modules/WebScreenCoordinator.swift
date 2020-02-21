//
//  WebScreenCoordinator.swift
//  Hybrid
//
//  Created by mhlee on 2020/02/21.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit

class WebScreenCoordinator: NSObject, WebScreenCoordinatorProtocol {
  static func createModule() -> UIViewController & WebScreenViewProtocol {
    let view = WebScreenView()
    let viewModel = WebScreenViewModel()
    view.viewModel = viewModel

    return view
  }
}

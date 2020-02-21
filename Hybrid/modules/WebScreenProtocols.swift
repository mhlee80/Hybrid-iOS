//
//  WebScreenProtocols.swift
//  Hybrid
//
//  Created by mhlee on 2020/02/21.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift

protocol WebScreenCoordinatorProtocol {
  static func createModule() -> UIViewController & WebScreenViewProtocol
}

protocol WebScreenViewProtocol {
  var viewModel: WebScreenViewModelProtocol? { get set }
}

protocol WebScreenViewModelProtocol {
  func viewDidLoad()
  
  var url: PublishSubject<URL> { get set }
}

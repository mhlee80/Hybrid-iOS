//
//  WebScreenViewModel.swift
//  Hybrid
//
//  Created by mhlee on 2020/02/21.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WebScreenViewModel: NSObject, WebScreenViewModelProtocol {
  var url = PublishSubject<URL>()
  
  func viewDidLoad() {
    log.info("")
    
    let url = Bundle.main.url(forResource: "web", withExtension: "html")
    if let url = url {
      self.url.onNext(url)
    }
  }
}

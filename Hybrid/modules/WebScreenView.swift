//
//  WebScreenView.swift
//  Hybrid
//
//  Created by mhlee on 2020/02/21.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import WebKit

class WebScreenView: UIViewController, WebScreenViewProtocol {
  private var disposeBag = DisposeBag()
  
  var viewModel: WebScreenViewModelProtocol? {
    didSet {
      setupBind()
    }
  }

  private lazy var webView: WKWebView = {
    let v = WKWebView()
    return v
  }()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
        
    view.backgroundColor = .white

    view.addSubview(webView)
    
    webView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalTo(view.safeAreaLayoutGuide)
    }

    DispatchQueue.main.async { [weak self] in
      self?.setupBind()
      self?.viewModel?.viewDidLoad()
    }
  }
  
  private func setupBind() {
    disposeBag = DisposeBag()
    
    viewModel?.url.subscribe(onNext: { [weak self] url in
      self?.webView.loadFileURL(url, allowingReadAccessTo: url)
      }).disposed(by: disposeBag)
  }
}

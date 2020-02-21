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
    let ucc = WKUserContentController()
    ucc.add(self, name: "test")
    
    let wvc = WKWebViewConfiguration()
    wvc.userContentController = ucc
    
    let v = WKWebView(frame: .zero, configuration: wvc)
    return v
  }()
  
  private lazy var button: UIButton = {
    let v = UIButton()
    v.layer.borderColor = UIColor.black.cgColor
    v.layer.borderWidth = 1
    v.setTitle("JS 함수 호출(앱 버튼)", for: .normal)
    v.setTitleColor(.black, for: .normal)
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
        
    view.backgroundColor = .white

    view.addSubview(webView)
    view.addSubview(button)
    
    webView.snp.makeConstraints { make in
      make.top.left.bottom.right.equalToSuperview()
    }

    button.snp.makeConstraints { make in
      make.bottom.equalToSuperview().offset(-30)
      make.width.equalTo(300)
      make.centerX.equalToSuperview()
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.setupBind()
      self?.viewModel?.viewDidLoad()
    }
  }
  
  private func setupBind() {
    disposeBag = DisposeBag()
    
    viewModel?.url.subscribe(onNext: { [weak self] url in
      let req = URLRequest(url: url)
      self?.webView.load(req)
    }).disposed(by: disposeBag)
    
    button.rx.tap.subscribe(onNext: { [weak self] in
      self?.handleButtonPress()
    }).disposed(by: disposeBag)
  }
  
  private func handleButtonPress() {
    webView.evaluateJavaScript("callByNative();", completionHandler: nil)
  }
}

extension WebScreenView: WKScriptMessageHandler {
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    if let d = message.body as? [String:String], let key = d["key"], let value = d["value"] {
      let alertController = UIAlertController(title: "call by web", message: "key:\(key), value:\(value)", preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
      alertController.addAction(cancelAction)
      DispatchQueue.main.async { self.present(alertController, animated: true, completion: nil) }
    }
  }
}

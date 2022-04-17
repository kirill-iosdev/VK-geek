//
//  VkLoginViewController.swift
//  VK-Launcher
//
//  Created by Kirill on 31.03.2022.
//

import UIKit
import WebKit

class VkLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstRequest()
    }
    
    func firstRequest() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "8122422"),
            URLQueryItem(name: "scope", value: "336918"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_url", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = components.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension VkLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let userIdInt = Int(userIdString) else {
                decisionHandler(.allow)
                return
              }
        
        Session.shared.token = token
        Session.shared.userId = userIdInt
        print("Token - \(Session.shared.token)")
        print("UserId - \(Session.shared.userId)")
        
        performSegue(withIdentifier: "fromLoginToTabBarSegue", sender: nil)
        decisionHandler(.cancel)
    }
}

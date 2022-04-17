//
//  ViewController.swift
//  VK-Launcher
//
//  Created by Kirill on 01.02.2022.
//

import UIKit

class CustomLoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    @IBOutlet weak var dotView1: UIView!
    @IBOutlet weak var dotView2: UIView!
    @IBOutlet weak var dotView3: UIView!
    
    func loadAnimate(currentCount: Int, totalCount: Int) {
        dotView1.alpha = 1
        dotView2.alpha = 0
        dotView3.alpha = 0
        UIView.animate(withDuration: 1) {[weak self] in
            self?.dotView1.alpha = 0
            self?.dotView2.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 1) {[weak self] in
                self?.dotView2.alpha = 0
                self?.dotView3.alpha = 1
            } completion: { _ in
                UIView.animate(withDuration: 1) {[weak self] in
                    self?.dotView3.alpha = 0
                    self?.dotView1.alpha = 1
                } completion: { [weak self] _ in
                    if currentCount + 1 <= totalCount {
                        self?.loadAnimate(currentCount: currentCount + 1, totalCount: totalCount)
                    }
                    else { return }
                }
            }
        }
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        guard let loginText = self.loginTextField.text, loginText == "admin",
                let passwordText = self.passwordTextField.text, passwordText == "12345"
        else {
            print("Неверные данные")
            return
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadAnimate(currentCount: 1, totalCount: 5)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tapRecogniser)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        
        guard let keyboardHeight = keyboardSize?.height else { return }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollview.contentInset = contentInset
        scrollview.scrollIndicatorInsets = contentInset
        print("keyboardShow \(keyboardHeight)")
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        scrollview.contentInset = UIEdgeInsets.zero
        scrollview.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc func onTap() {
        self.view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}


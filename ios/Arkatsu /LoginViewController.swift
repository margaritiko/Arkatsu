//
//  LoginViewController.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 28.01.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var loginTextField: UITextField!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!


  override func viewDidLoad() {
    super.viewDidLoad()

    DispatchQueue.main.async { [weak imageView] in
      let pandaGif = UIImage.gifImageWithName(name: "panda_launch")
      imageView?.image = pandaGif
    }

    loginTextField.placeholder = "Your pet name"
    loginTextField.layer.borderColor = UIColor.white.cgColor
    loginTextField.layer.cornerRadius = loginTextField.frame.height / 2
    loginTextField.layer.masksToBounds = true
    signInButton.layer.cornerRadius = signInButton.frame.height / 2
    signInButton.layer.masksToBounds = true

    view.backgroundColor = UIColor(red:0.35, green:0.79, blue:0.98, alpha:1.0)

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
    self.view.addGestureRecognizer(tapGesture)
  }


  @IBAction func clickedSignIn(_ sender: Any) {
//    present(MainTabViewController(), animated: true, completion: {})
//    self.navigationController?.pushViewController(MainTabViewController(), animated: true)

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.setRootViewController(MainTabViewController())
  }


  @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
    loginTextField.resignFirstResponder()
  }


  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

//
//  LoginViewController.swift
//  Arkatsu
//
//  Created by Margarita Konnova on 28.01.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var loginTextField: UITextField!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!

  let networkService: NetworkServiceProtocol = NetworkService(requestSender: RequestSender())

  override func viewDidLoad() {
    super.viewDidLoad()

    DispatchQueue.main.async { [weak imageView] in
      let pandaGif = UIImage.gifImageWithName(name: "panda_launch")
      imageView?.image = pandaGif
    }

    loginTextField.textColor = .black
    loginTextField.placeholder = "Your pet name"
    loginTextField.layer.borderColor = UIColor.white.cgColor
    loginTextField.layer.cornerRadius = loginTextField.frame.height * 3 / 7
    loginTextField.layer.masksToBounds = true
    signInButton.layer.cornerRadius = signInButton.frame.height * 3 / 7
    signInButton.layer.masksToBounds = true

    view.backgroundColor = UIColor(red:0.35, green:0.79, blue:0.98, alpha:1.0)

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
    self.view.addGestureRecognizer(tapGesture)
  }


  @IBAction func clickedSignIn(_ sender: Any) {
    guard let petName = loginTextField.text, petName != "" else {
      showEmptyNameAlert()
      return
    }

    networkService.loadUser(withName: petName) { [weak self] userData in
      if let _ = userData {
        DispatchQueue.main.async {
          UserDefaults.standard.set(petName, forKey: "Pet name")

          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          appDelegate.setRootViewController(MainTabViewController())
        }
      } else {
        DispatchQueue.main.async {
          self?.showIncorrectNameAlert()
        }
      }
    }
  }

  func showIncorrectNameAlert() {
      let alertController = UIAlertController(title: "Incorrect name", message:
          "Please clarify your pet's name - pet with given name doesn't exist!", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Try again", style: .default))

      self.present(alertController, animated: true, completion: nil)
  }

  func showEmptyNameAlert() {
      let alertController = UIAlertController(title: "Empty name", message:
          "Please clarify your pet's name - it cannot be empty!", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Try again", style: .default))

      self.present(alertController, animated: true, completion: nil)
  }

  @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
    loginTextField.resignFirstResponder()
  }


  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
}

//
//  ViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 14.03.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passShowImageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var showPassButton: UIButton!
    
    @IBOutlet weak var kayitButton: UIButton!
    @IBOutlet weak var girisButton: UIButton!
    
    let showPass = UIImage.init(named: "showPass")
    let hidePass = UIImage.init(named: "hidePass")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        kayitButton.layer.cornerRadius = 10.0
        girisButton.layer.cornerRadius = 10.0
        
        passShowImageView.image = hidePass
        
        let dokun:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeGizle))

        view.addGestureRecognizer(dokun)
        
    }
    
    @objc func klavyeGizle(){
        view.endEditing(true)
    }
    
    var passStatus = true

    @IBAction func bitti(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func girisButtonTiklandi(_ sender: Any) {
        if (usernameTextField.text != "" && passwordTextField.text != "") {
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { [self] AuthDataResult, Error in
                if Error != nil{
                    self.createAlert(titleInput: "Hata!", messageInput: Error?.localizedDescription ?? "Hata aldınız, Tekrar Deneyin..")
                } else {
                    self.performSegue(withIdentifier: "anaSayfayaGecis", sender: nil)
                    
                    print("\nGiriş yapıldı. \n")
                }
            }
        }else {
            self.createAlert(titleInput: "Hata!", messageInput: "E-mail ve şifrenizi kontrol ediniz..")
        }
        
    }
    
    func createAlert(titleInput: String, messageInput: String) {
        let invalidMessage = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okAlert = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            //ok butonuna tıklayınca olacaklar
            print("ok button clicked")
            }
        invalidMessage.addAction(okAlert)
        self.present(invalidMessage, animated: true, completion: nil)
    }
    
    @IBAction func showPassButtonClick(_ sender: UIButton) {
        if passStatus == true {
            passShowImageView.image = showPass
            passwordTextField.isSecureTextEntry = false
            passStatus = false
        } else {
            passShowImageView.image = hidePass
            passwordTextField.isSecureTextEntry = true
            passStatus = true
        }
        
    }
    
}


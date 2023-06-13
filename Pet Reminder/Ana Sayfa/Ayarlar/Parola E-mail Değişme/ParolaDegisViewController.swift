//
//  ParolaDegisViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 19.05.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class ParolaDegisViewController: UIViewController {

    @IBOutlet weak var parolaTextField: UITextField!
    @IBOutlet weak var yeniParolaTextField: UITextField!
    @IBOutlet weak var yeniParolaTekrarTextField: UITextField!
    @IBOutlet weak var passShowImage: UIImageView!
    
    @IBOutlet weak var onaylaButton: UIButton!
    
    let showPass = UIImage.init(named: "showPass")
    let hidePass = UIImage.init(named: "hidePass")
    
    var passStatus = true
    
    var sifre = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark  
        
        onaylaButton.layer.cornerRadius = 10.0
        
        passShowImage.image = hidePass
        parolaTextField.isSecureTextEntry = true
        yeniParolaTextField.isSecureTextEntry = true
        yeniParolaTekrarTextField.isSecureTextEntry = true
        
        let dokun:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeGizle))

        view.addGestureRecognizer(dokun)

    }
    
    @objc func klavyeGizle(){
        view.endEditing(true)
    }
    
    @IBAction func onaylaButtonTiklandi(_ sender: Any) {
        
        if parolaTextField.text != "" && yeniParolaTextField.text != "" && yeniParolaTekrarTextField.text != "" {
            if parolaTextField.text == sifre && yeniParolaTextField.text == yeniParolaTekrarTextField.text{
                Auth.auth().currentUser!.updatePassword(to: yeniParolaTextField.text!) { error in
                    if error != nil{
                        self.createAlert(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata aldınız, Tekrar Deneyin..")
                    } else {
                        print("Başarıyla şifre değiştirildi.")
                        
                        guard let userID = Auth.auth().currentUser?.uid as? String else { return }
                        let docRef = self.db.collection("Kullanici").document(userID)
                        
                        docRef.parent.whereField("sifre", isEqualTo: self.sifre).getDocuments() { querySnapshot, err in
                            if err != nil {
                                self.createAlert(titleInput: "Hata!", messageInput: err?.localizedDescription ?? "Hata aldınız, Tekrar Deneyin..")
                            } else {
                                let document = querySnapshot!.documents.first
                                document?.reference.updateData(["sifre": self.yeniParolaTextField.text!])
                            }
                        }
                        
                        self.dismiss(animated: true)
                        
                        
                    }
                }
            } else {
              createAlert(titleInput: "Hata!", messageInput: "Bilgilerinizin doğru olup olmadığından emin olun.")
            }
        } else {
            createAlert(titleInput: "Hata!", messageInput: "Boş olan alanları doldurun.")
        }
        
    }
    
    @IBAction func passShowButtonTiklandi(_ sender: Any) {
        if passStatus == true {
            passShowImage.image = showPass
            passStatus = false
            parolaTextField.isSecureTextEntry = false
            yeniParolaTextField.isSecureTextEntry = false
            yeniParolaTekrarTextField.isSecureTextEntry = false
        } else {
            passShowImage.image = hidePass
            passStatus = true
            parolaTextField.isSecureTextEntry = true
            yeniParolaTextField.isSecureTextEntry = true
            yeniParolaTekrarTextField.isSecureTextEntry = true
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
    
}

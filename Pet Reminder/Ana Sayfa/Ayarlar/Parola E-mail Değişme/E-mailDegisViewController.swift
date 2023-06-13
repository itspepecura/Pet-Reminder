//
//  E-mailDegisViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 19.05.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class E_mailDegisViewController: UIViewController {
    
    @IBOutlet weak var mevcutEmailTextfield: UITextField!
    @IBOutlet weak var yeniEmailTextField: UITextField!
    @IBOutlet weak var yeniEmailTekrarTextField: UITextField!
    @IBOutlet weak var onaylaButton: UIButton!
    
    var email = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark  
        
        onaylaButton.layer.cornerRadius = 10.0
        
        let dokun:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeGizle))

        view.addGestureRecognizer(dokun)
    }
    
    @objc func klavyeGizle(){
        view.endEditing(true)
    }

    @IBAction func onaylaButtonTiklandi(_ sender: Any){
        
        if mevcutEmailTextfield.text != "" && yeniEmailTextField.text != "" && yeniEmailTekrarTextField.text != "" {
            if mevcutEmailTextfield.text == email && yeniEmailTextField.text == yeniEmailTekrarTextField.text{
                Auth.auth().currentUser!.updateEmail(to: yeniEmailTextField.text!) { error in
                    if error != nil{
                        self.createAlert(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata aldınız, Tekrar Deneyin..")
                    } else {
                        print("Başarıyla email değiştirildi.")
                        
                        guard let userID = Auth.auth().currentUser?.uid as? String else { return }
                        let docRef = self.db.collection("Kullanici").document(userID)
                        
                        docRef.parent.whereField("e-mail", isEqualTo: self.email).getDocuments() { querySnapshot, err in
                            if err != nil {
                                self.createAlert(titleInput: "Hata!", messageInput: err?.localizedDescription ?? "Hata aldınız, Tekrar Deneyin..")
                            } else {
                                let document = querySnapshot!.documents.first
                                document?.reference.updateData(["e-mail": self.yeniEmailTextField.text!])
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




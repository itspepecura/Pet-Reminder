//
//  SignUpViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 21.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var adTextField: UITextField!
    @IBOutlet weak var soyadTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var sifreTekrarTextField: UITextField!
    @IBOutlet weak var showPassImageView: UIImageView!
    
    @IBOutlet weak var kayitOlButton: UIButton!
    
    
    let showPass = UIImage.init(named: "showPass")
    let hidePass = UIImage.init(named: "hidePass")
    
    var kullaniciSifre = ""
    var sifreUzunluk = 0
    
    var ad = ""
    var soyad = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        kayitOlButton.layer.cornerRadius = 10.0
        
        showPassImageView.image = hidePass
        sifreTextField.isSecureTextEntry = true
        sifreTekrarTextField.isSecureTextEntry = true
        
        let dokun:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeGizle))

        view.addGestureRecognizer(dokun)
    }
    
    @objc func klavyeGizle(){
        view.endEditing(true)
    }
    
    let db = Firestore.firestore()
    
    @IBAction func kayitOlButtonClick(_ sender: Any) {
        
        if (sifreTextField.text == sifreTekrarTextField.text) {
            kullaniciSifre = sifreTextField.text!
            sifreUzunluk = sifreTextField.text!.count
        }
        
        let kullaniciVeri: [String: Any] = [
            "isim": adTextField.text!,
            "soyisim": soyadTextField.text!,
            "e-mail": emailTextField.text!,
            "sifre": kullaniciSifre
        ]
        
        if (adTextField.text == ""){
            createAlert(titleInput: "Ad alanı boş!", messageInput: "Lütfen adınızı giriniz.")
        } else if (soyadTextField.text == ""){
            createAlert(titleInput: "Soyad alanı boş!", messageInput: "Lütfen soyadınızı giriniz.")
        } else if (emailTextField.text == ""){
            createAlert(titleInput: "E-mail alanı boş!", messageInput: "Lütfen e-mailinizi giriniz.")
        } else if (sifreTextField.text == ""){
            createAlert(titleInput: "Şifre alanı boş!", messageInput: "Lütfen şifrenizi giriniz.")
        } else if (sifreTekrarTextField.text == "") {
            createAlert(titleInput: "Şifre tekrar alanı boş!", messageInput: "Lütfen şifrenizi tekrar giriniz.")
        } else if (sifreTextField.text != sifreTekrarTextField.text){
            createAlert(titleInput: "Şifreler uyuşmuyor!", messageInput: "Şifreleri tekrar gözden geçirin.")
        } else if (sifreUzunluk < 6) {
            createAlert(titleInput: "Şifre kısa!", messageInput: "Lütfen en az 6 karakterli şifre giriniz.")
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: kullaniciSifre) { [self] AuthDataResult, Error in
                if Error != nil{
                    self.createAlert(titleInput: "Hata!", messageInput: Error!.localizedDescription)
                } else {
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    self.db.collection("Kullanici").document(userID).setData(kullaniciVeri){ err in
                        if let err = err {
                            print("Döküman yazım hatası \(err)")
                        } else {
                            print("Döküman başarılı bir şekilde yazıldı")
                        }
                    }
                    self.createCorrectAlert(titleInput: "Kaydolundu!", messageInput: "Kaydınız başarıyla alınmıştır.")
                    print("\n Kayıt olundu \n")
                }
            }
        }
    }
    
    @IBAction func bitti(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    var sifreDurum = true
    
    @IBAction func showPassButtonClicked(_ sender: Any) {
        
        if sifreDurum == true {
            showPassImageView.image = showPass
            sifreTextField.isSecureTextEntry = false
            sifreTekrarTextField.isSecureTextEntry = false
            sifreDurum = false
        } else {
            showPassImageView.image = hidePass
            sifreTextField.isSecureTextEntry = true
            sifreTekrarTextField.isSecureTextEntry = true
            sifreDurum = true
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
    
    func createCorrectAlert(titleInput: String, messageInput: String) {
        let correct = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.actionSheet)
        let thanksAlert = UIAlertAction(title: "Teşekkürler", style: UIAlertAction.Style.cancel /*görünüş için cancel kullandım*/) { (UIAlertAction) in
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "LoginVCStoryboard") as UIViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            print("thanks button clicked")
        }
        correct.addAction(thanksAlert)
        self.present(correct, animated: true, completion: nil)
    }
}

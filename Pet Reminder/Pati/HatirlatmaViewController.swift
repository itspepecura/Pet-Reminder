//
//  HatirlatmaViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 16.04.2023.
//

import UIKit

class HatirlatmaViewController: UIViewController {
    
    @IBOutlet weak var baslikTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var aciklamaTextField: UITextField!
    
    public var hatirlaticiDegerler: ((String, String, Date) -> Void)?
    public var labelDegerler: ((String, String) -> Void)?
    
    var aciklama = ""
    var tarihString = ""
    
    var identifierHatirlatici = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Bitti", style: .done, target: self, action: #selector(buttonBitti))

    }
    
    @objc func buttonBitti() {
        
        if (aciklamaTextField.text == "" || baslikTextField.text == ""){
            createAlert(titleInput: "Hata", messageInput: "Başlık ve açıklama giriniz!")
        } else if(aciklamaTextField.text != "" || baslikTextField.text != ""){
            aciklama = aciklamaTextField.text!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, hh:mm"
            tarihString = dateFormatter.string(from: datePicker.date)
        } else if datePicker.date <= Date(){
            createAlert(titleInput: "Hata", messageInput: "Geçmiş zamana hatırlatıcı kuramazsınız!")
        } else if identifierHatirlatici == "" {
            createAlert(titleInput: "Hata", messageInput: "Veri geçerken hata oluştu")
        }
        
        labelDegerler?(aciklama, tarihString)
        
        if let aciklama = aciklamaTextField.text, !aciklama.isEmpty,
        let baslik = baslikTextField.text, !baslik.isEmpty{
            
            let tarih = datePicker.date
            
            hatirlaticiDegerler?(baslik, aciklama, tarih)
         
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
                
                if (success) {

                    let icerik = UNMutableNotificationContent()
                    icerik.title = baslik
                    icerik.sound = .default
                    icerik.body = aciklama
                    
                    let hedefTarih = tarih
                    
                    let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: hedefTarih), repeats: false)
                    
                    let request = UNNotificationRequest(identifier: self.identifierHatirlatici, content: icerik, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                        
                        if error != nil {
                            self.createAlert(titleInput: "Hata", messageInput: error!.localizedDescription)
                            print("Hata")
                        }
                    })
                } else if (error != nil){
                    self.createAlert(titleInput: "Hata", messageInput: error!.localizedDescription)
                }
            })
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

            print("thanks button clicked")
        }
        correct.addAction(thanksAlert)
        self.present(correct, animated: true, completion: nil)
    }
}


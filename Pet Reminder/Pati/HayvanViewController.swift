//
//  HayvanViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 29.03.2023.
//

import UIKit

class HayvanViewController: UIViewController{
    
    @IBOutlet weak var lblMamaAciklama:UILabel!
    @IBOutlet weak var lblMamaZaman:UILabel!
    @IBOutlet weak var lblSuAciklama:UILabel!
    @IBOutlet weak var lblSuZaman:UILabel!
    @IBOutlet weak var lblYuruyusAciklama:UILabel!
    @IBOutlet weak var lblYuruyusZaman:UILabel!
    @IBOutlet weak var lblVeterinerAciklama:UILabel!
    @IBOutlet weak var lblVeterinerZaman:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        lblMamaZaman.text = ""
        lblMamaAciklama.text = ""
        lblSuZaman.text = ""
        lblSuAciklama.text = ""
        lblYuruyusZaman.text = ""
        lblYuruyusAciklama.text = ""
        lblVeterinerZaman.text = ""
        lblVeterinerAciklama.text = ""
        
    }
    
    let identifierList = [
        "mama_hatirlatici",
        "su_hatirlatici",
        "yuruyus_hatirlatici",
        "veteriner_hatirlatici"
    ]
    
    // mama alakali buttonlar
    @IBAction func mamaDuzenleButtonTiklandi(_ sender: Any) {
        let identifier = "mama_hatirlatici"
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HatirlatmaViewController") as? HatirlatmaViewController else { return }
        
        vc.title = "Hatırlatıcı Ayarla"
        
        vc.hatirlaticiDegerler = { (baslik, aciklama, tarih) in
            
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                
                let icerik = UNMutableNotificationContent()
                icerik.title = baslik
                icerik.sound = .default
                icerik.body = aciklama
                
                let hedefTarih = tarih
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: hedefTarih), repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: icerik, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    
                    if error != nil {
                        self.createAlert(titleInput: "Hata", messageInput: error!.localizedDescription)
                        print("Hata")
                    }
                })
                
            }
        }
        
        vc.labelDegerler = { (aciklama, tarihString) in
            self.lblMamaAciklama.text = aciklama
            self.lblMamaZaman.text = tarihString
            self.lblMamaAciklama.isHidden = false
            self.lblMamaZaman.isHidden = false
        }
        vc.identifierHatirlatici = identifier
        navigationController?.pushViewController(vc, animated: true)
        
    } // tıklayınca bildirim geliyor kontrol edilecek
    @IBAction func mamaOnaylaButtonTiklandi(_ sender: Any) {
        
        if (lblMamaZaman.text != "" && lblMamaAciklama.text != ""){
            self.lblMamaAciklama.text = "Tamamlandı!"
            self.lblMamaZaman.text = ""
            self.lblMamaAciklama.isHidden = false
            self.lblMamaZaman.isHidden = false
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[0]])
            
            createCorrectAlert(titleInput: "Tamamlandı!", messageInput: "Mama hatırlatıcınız tamamlandı.")
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
        
    } // tıklayınca bildirim geliyor kontrol edilecek
    @IBAction func mamaSilButtonTiklandi(_ sender: Any) {
        
        if(lblMamaAciklama.text == "Tamamlandı!"){
            self.lblMamaAciklama.text = ""
            self.lblMamaZaman.text = ""
            self.lblMamaAciklama.isHidden = true
            self.lblMamaZaman.isHidden = true
        }
        else if (lblMamaZaman.text != "" && lblMamaAciklama.text != ""){
            
            self.lblMamaAciklama.text = ""
            self.lblMamaZaman.text = ""
            self.lblMamaAciklama.isHidden = true
            self.lblMamaZaman.isHidden = true
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[0]])
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
        
    }
    //
    
    //su alakali buttonlar
    @IBAction func suDuzenleButtonTiklandi(_ sender: Any){
        let identifier = "su_hatirlatici"
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HatirlatmaViewController") as? HatirlatmaViewController else { return }
        
        vc.title = "Hatırlatıcı Ayarla"
        
        vc.hatirlaticiDegerler = { (baslik, aciklama, tarih) in
            
            // istenilen yapıyı sıraya alma ve bildirim ana çekirdekte çalıştığı için yapmak zorundayız async olmasının nedeni de uygulama kullanırken
            // dahi istenilen yapı çalışmasını istediğimiz için async kullanılır
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                
                let icerik = UNMutableNotificationContent()
                icerik.title = baslik
                icerik.sound = .default
                icerik.body = aciklama
                
                let hedefTarih = tarih
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: hedefTarih), repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: icerik, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    
                    if error != nil {
                        self.createAlert(titleInput: "Hata", messageInput: error!.localizedDescription)
                        print("Hata")
                    }
                })
                
            }
        }
        
        vc.labelDegerler = { (aciklama, tarihString) in
            self.lblSuAciklama.text = aciklama
            self.lblSuZaman.text = tarihString
            self.lblSuAciklama.isHidden = false
            self.lblSuZaman.isHidden = false
        }
        vc.identifierHatirlatici = identifier
        navigationController?.pushViewController(vc, animated: true)

        
    }
    @IBAction func suOnaylaButtonTiklandi(_sender: Any){
        
        if (lblSuZaman.text != "" && lblSuAciklama.text != ""){
            self.lblSuAciklama.text = "Tamamlandı!"
            self.lblSuZaman.text = ""
            self.lblSuAciklama.isHidden = false
            self.lblSuZaman.isHidden = false
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[1]])
            
            createCorrectAlert(titleInput: "Tamamlandı!", messageInput: "Su hatırlatıcınız tamamlandı.")
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
        
    }
    @IBAction func suSilButtonTiklandi(_sender: Any){

        if(lblSuAciklama.text == "Tamamlandı!"){
            self.lblSuAciklama.text = ""
            self.lblSuZaman.text = ""
            self.lblSuAciklama.isHidden = true
            self.lblSuZaman.isHidden = true
        }
        
        else if (lblSuZaman.text != "" && lblSuAciklama.text != ""){
        
            self.lblSuAciklama.text = ""
            self.lblSuZaman.text = ""
            self.lblSuAciklama.isHidden = true
            self.lblSuZaman.isHidden = true
                
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[1]])
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
    }
    
    //yuruyus alakali buttonlar
    @IBAction func yuruyusDuzenleButtonTiklandi(_ sender: Any){
        let identifier = "yuruyus_hatirlatici"
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HatirlatmaViewController") as? HatirlatmaViewController else { return }
        
        vc.title = "Hatırlatıcı Ayarla"
        
        vc.hatirlaticiDegerler = { (baslik, aciklama, tarih) in
            
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                
                let icerik = UNMutableNotificationContent()
                icerik.title = baslik
                icerik.sound = .default
                icerik.body = aciklama
                
                let hedefTarih = tarih
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: hedefTarih), repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: icerik, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    
                    if error != nil {
                        self.createAlert(titleInput: "Hata", messageInput: error!.localizedDescription)
                        print("Hata")
                    }
                })
                
            }
        }
        
        vc.labelDegerler = { (aciklama, tarihString) in
            self.lblYuruyusAciklama.text = aciklama
            self.lblYuruyusZaman.text = tarihString
            self.lblYuruyusAciklama.isHidden = false
            self.lblYuruyusZaman.isHidden = false
        }
        
        vc.identifierHatirlatici = identifier
        navigationController?.pushViewController(vc, animated: true)

        
    }
    @IBAction func yuruyusOnaylaButtonTiklandi(_sender: Any){
        
        if (lblYuruyusZaman.text != "" && lblYuruyusAciklama.text != ""){
            self.lblYuruyusAciklama.text = "Tamamlandı!"
            self.lblYuruyusZaman.text = ""
            self.lblYuruyusAciklama.isHidden = false
            self.lblYuruyusZaman.isHidden = false
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[2]])
            
            createCorrectAlert(titleInput: "Tamamlandı!", messageInput: "Yürüyüş hatırlatıcınız tamamlandı.")
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
        
    }
    @IBAction func yuruyusSilButtonTiklandi(_sender: Any){
        
        if(lblYuruyusAciklama.text == "Tamamlandı!"){
            self.lblYuruyusAciklama.text = ""
            self.lblYuruyusZaman.text = ""
            self.lblYuruyusAciklama.isHidden = true
            self.lblSuZaman.isHidden = true
        }else if (lblYuruyusZaman.text != " " && lblYuruyusAciklama.text != " "){
             
            self.lblYuruyusAciklama.text = ""
            self.lblYuruyusZaman.text = ""
            self.lblYuruyusAciklama.isHidden = true
            self.lblYuruyusZaman.isHidden = true
                
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[2]])
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
    }
    //
    
    //veteriner alakali buttonlar
    @IBAction func veterinerDuzenleButtonTiklandi(_ sender: Any){
        
        let identifier = "veteriner_hatirlatici"
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HatirlatmaViewController") as? HatirlatmaViewController else { return }
        
        vc.title = "Hatırlatıcı Ayarla"
        
        vc.hatirlaticiDegerler = { (baslik, aciklama, tarih) in
            
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                
                let icerik = UNMutableNotificationContent()
                icerik.title = baslik
                icerik.sound = .default
                icerik.body = aciklama
                
                let hedefTarih = tarih
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: hedefTarih), repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: icerik, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    
                    if error != nil {
                        self.createAlert(titleInput: "Hata", messageInput: error!.localizedDescription)
                        print("Hata")
                    }
                })
                
            }
        }
        
        vc.labelDegerler = { (aciklama, tarihString) in
            self.lblVeterinerAciklama.text = aciklama
            self.lblVeterinerZaman.text = tarihString
            self.lblVeterinerAciklama.isHidden = false
            self.lblVeterinerZaman.isHidden = false
        }
        vc.identifierHatirlatici = identifier
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func veterinerOnaylaButtonTiklandi(_sender: Any){
        
        if (lblVeterinerZaman.text != "" && lblVeterinerAciklama.text != ""){
            self.lblVeterinerAciklama.text = "Tamamlandı!"
            self.lblVeterinerZaman.text = ""
            self.lblVeterinerAciklama.isHidden = false
            self.lblVeterinerZaman.isHidden = false
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[3]])
            
            createCorrectAlert(titleInput: "Tamamlandı!", messageInput: "Veteriner hatırlatıcınız tamamlandı.")
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
        
        
    }
    @IBAction func veterinerSilButtonTiklandi(_sender: Any){
        
        if(lblVeterinerAciklama.text == "Tamamlandı!"){
            self.lblVeterinerAciklama.text = ""
            self.lblYuruyusZaman.text = ""
            self.lblYuruyusAciklama.isHidden = true
            self.lblYuruyusZaman.isHidden = true
        }
        
        else if (lblVeterinerZaman.text != "" && lblVeterinerAciklama.text != ""){
    
            self.lblYuruyusAciklama.text = ""
            self.lblYuruyusZaman.text = ""
            self.lblYuruyusAciklama.isHidden = true
            self.lblYuruyusZaman.isHidden = true
                
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierList[3]])
        } else {
            createAlert(titleInput: "Hata", messageInput: "Önce hatırlatıcı oluşturmanız gerekiyor!")
        }
    }
    //
    
    /* bildirim oluşturma fonksiyonu
    func zamanlayiciFunc(baslik:String, aciklama:String, tarih:Date){
        
        let icerik = UNMutableNotificationContent()
        icerik.title = baslik
        icerik.sound = .default
        icerik.body = aciklama
        
        let hedefTarih = tarih
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: hedefTarih), repeats: false)
        
        let request = UNNotificationRequest(identifier: "uzun_bir_id", content: icerik, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if error != nil {
                self.createAlert(titleInput: "Hata", messageInput: error!.localizedDescription)
                print("Hata")
            }
        })
    }*/
    
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

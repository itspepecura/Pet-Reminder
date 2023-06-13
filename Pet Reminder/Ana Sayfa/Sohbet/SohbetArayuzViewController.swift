//
//  SohbetArayuzViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 9.04.2023.
//

import UIKit
import MessageKit

struct Sender:SenderType{
    
    var senderId: String
    var displayName: String
    
}

struct Message: MessageType{
    
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
    
}

class SohbetArayuzViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    // sender(yollayan) ile bir değişken oluşumu senderID!!
    let mevcutKullanici = Sender(senderId: "self", displayName: "Ahmet")
    
    let digerKullanici = Sender(senderId: "other", displayName: "Veteriner Murat")
    
    // bu datayı backendden alıcaz
    var mesajlar = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark  
        
        mesajlar.append(Message(sender: mevcutKullanici,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Selamlar.")))
        
        mesajlar.append(Message(sender: digerKullanici,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-70000),
                                kind: .text("Selamlar, nasıl gidiyor?")))
        
        mesajlar.append(Message(sender: mevcutKullanici,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(-66400),
                                kind: .text("İyidir, sizden?")))
        
        mesajlar.append(Message(sender: digerKullanici,
                                messageId: "4",
                                sentDate: Date().addingTimeInterval(-56400),
                                kind: .text("İyi ne olsun. Nasıl sizin kerata?")))
        
        mesajlar.append(Message(sender: mevcutKullanici,
                                messageId: "5",
                                sentDate: Date().addingTimeInterval(-46400),
                                kind: .text("Eskisinden daha mutlu teşekkürler.")))
        
        mesajlar.append(Message(sender: digerKullanici,
                                messageId: "6",
                                sentDate: Date().addingTimeInterval(-26400),
                                kind: .text("Ne demek efendim, görevimiz.")))
        //mesajların kaynak verisi
        messagesCollectionView.messagesDataSource = self
        
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    func currentSender() -> MessageKit.SenderType {
        return mevcutKullanici
    }
    
    //yollanılan mesajlar için mesaj kutusu(item)
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return mesajlar[indexPath.section]
    }
    
    //mesaj sayısı
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return mesajlar.count
    }

}

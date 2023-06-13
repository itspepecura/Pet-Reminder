//
//  Webservice.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 24.05.2023.
//

import Foundation

class Webservice {
    
    func haberleriIndir(url: URL, completion: @escaping ([Haberler]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                
                print(error.localizedDescription) // alert oluşturabiliriz
                completion(nil)
                
            } else if let data = data {
                
                let haberlerDizisi = try? JSONDecoder().decode([Haberler].self, from: data)
                
                if let haberlerDizisi = haberlerDizisi {
                    completion(haberlerDizisi)
                }
            }
        }.resume()
        
        
        
    }
    
}

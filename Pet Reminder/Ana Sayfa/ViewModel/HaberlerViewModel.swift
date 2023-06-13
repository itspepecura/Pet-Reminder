//
//  HaberlerViewModel.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 24.05.2023.
//

import Foundation

struct HaberlerTableViewModel {
    
    let haberlerListesi: [Haberler]
    
}

extension HaberlerTableViewModel {
    
    func numberOfRowsInSection() -> Int {
        return self.haberlerListesi.count
    }
    
    func haberlerAtIndexPath(_ index: Int) -> HaberlerViewModel {
        let haberler = self.haberlerListesi[index]
        return HaberlerViewModel(haberler: haberler)
    }
    
}

struct HaberlerViewModel{
    
    let haberler: Haberler
    
    var baslik: String{
        return self.haberler.baslik
    }
    
    var icerik: String {
        return self.haberler.icerik
    }
    
}

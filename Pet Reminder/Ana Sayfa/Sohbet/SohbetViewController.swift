//
//  SohbetViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 29.03.2023.
//

import UIKit

class SohbetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var sohbetArayuz: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        sohbetArayuz.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        sohbetArayuz.delegate = self
        //veri kaynağı
        sohbetArayuz.dataSource = self
        
    }
    
    // satır sayısı
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // satıra düşen hücre
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Veteriner"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //sohbet mesajlarını göster
        let vc = SohbetArayuzViewController()
        vc.title = "Sohbet"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    

    

}

//
//  AnasayfaViewController.swift
//  Pet Reminder
//
//  Created by Ahmet Erkut on 29.03.2023.
//

import UIKit

class AnasayfaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var haberlerTableViewModel: HaberlerTableViewModel!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark  
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        veriAl()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        view.addSubview(tableView)
        
        
        
        
    }
    
    @objc private func refresh(refreshControl: UIRefreshControl) {
        
        veriAl()
        
    }
    
    func veriAl(){
        
        if tableView.refreshControl?.isRefreshing == true {
            print("Veri yenileniyor")
        } else {
            print("Veriler alındı")
        }
         
        let url = URL(string: "https://raw.githubusercontent.com/itspepecura/evcil-hayvan-veriler/main/veriler.json")
        
        Webservice().haberleriIndir(url: url!) { (haberler) in
            if let haberler = haberler {
                self.haberlerTableViewModel = HaberlerTableViewModel(haberlerListesi: haberler)
                
                DispatchQueue.main.async {
                    self.tableView.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return haberlerTableViewModel == nil ? 0: self.haberlerTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HaberCell
        let haberlerViewModel = self.haberlerTableViewModel.haberlerAtIndexPath(indexPath.row)
        cell.baslikLabel.text = haberlerViewModel.baslik
        cell.icerikLabel.text = haberlerViewModel.icerik
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //sohbet mesajlarını göster
        let vc = HaberIcerikViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

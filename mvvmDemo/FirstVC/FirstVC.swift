//
//  FirstVC.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import UIKit

class FirstVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    private var placesViewModel : PlacesViewModel!
    
    private var tableDelegate: TableViewDelegate<CustomView, Source>!
    private var tableDataSource : TableViewDataSource<TableCell, Datum,Source >!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        placesViewModel = PlacesViewModel()
        
        placesViewModel.bindPlacesViewModelViewModelToController = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    @IBAction func moveToNextAction(_ sender: Any) {
        let vc: SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension FirstVC {
    
    func updateDataSource() {
        let cellIdentifier = "TableCell"
        
        self.tableDelegate = TableViewDelegate(cellIdentifier: cellIdentifier, heightForCell: nil, sectionItems: self.placesViewModel.placesData?.source, heightForSection: 76.0 , configureHeader: { viewX, data in
            
            if let topic = data.annotations?.topic {
                if let subTopic = data.annotations?.subtopic {
                    viewX.myLabel?.text = "\("Topic".uppercased()): \(topic) \n\("SubTopic".uppercased()): \(subTopic)"
                }
            }
            
        })
        
        self.tableDataSource = TableViewDataSource(cellIdentifier: cellIdentifier, cellItems: self.placesViewModel.placesData?.data, sectionItems: self.placesViewModel.placesData?.source ,configureCell: { (tblCell, viewModelData) in
            
            if let pop = viewModelData.population {
                if let nation = viewModelData.nation {
                    if let year = viewModelData.year {
                        tblCell.txtLbl.text = "\(nation) has population of \(pop) in year \(year)."
                    }
                }
            }
        })
        
        DispatchQueue.main.async {
            self.tblVw.dataSource = self.tableDataSource
            self.tblVw.delegate = self.tableDelegate
            self.tblVw.reloadData()
        }
    }
}


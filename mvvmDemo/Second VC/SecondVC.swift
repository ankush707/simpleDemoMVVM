//
//  SecondVC.swift
//  mvvmDemo
//
//  Created by Ankush on 11/01/23.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    private var newPlacesViewModel : NewPlacesViewModel!
    
    private var tableDelegate: TableViewDelegate<CustomView, NewPlacesModel>!
    private var tableDataSource : TableViewDataSource<TableCell, Place, NewPlacesModel >!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newPlacesViewModel = NewPlacesViewModel()
        
        newPlacesViewModel.bindNewPlacesViewModelViewModelToController = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    func updateDataSource() {
        let cellIdentifier = "TableCell"
        
        var arrSections : [NewPlacesModel] = []
        arrSections.append(self.newPlacesViewModel.placesData!)
        
        self.tableDelegate = TableViewDelegate(cellIdentifier: cellIdentifier, heightForCell: nil, sectionItems: arrSections, heightForSection: 56.0 , configureHeader: { viewX, data in
            
            if let country = data.country {
                viewX.myLabel?.text = "\("Country".uppercased()) : \(country)"
            }
            
        })
        
        self.tableDataSource = TableViewDataSource(cellIdentifier: cellIdentifier, cellItems: self.newPlacesViewModel.placesData?.places, sectionItems: arrSections ,configureCell: { (tblCell, viewModelData) in
            
            if let state = viewModelData.state {
                if let place = viewModelData.placeName {
                    if let long = viewModelData.longitude {
                        if let lat = viewModelData.latitude {
                            tblCell.txtLbl.text = "\(place) of state(\(state)) has longitude of : \(long) and latitude of \(lat)"
                        }
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



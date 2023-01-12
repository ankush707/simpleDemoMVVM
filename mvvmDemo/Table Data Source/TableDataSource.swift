//
//  TableDataSource.swift
//  mvvmDemo
//
//  Created by Ankush on 12/01/23.
//

import Foundation
import UIKit

class TableViewDataSource<CELL: UITableViewCell, T, U>: NSObject, UITableViewDataSource {
    
    private var cellIdentifier: String!
    private var cellItems: [T]!
    private var sectionItems: [U]!
    var configureCell: (CELL, T) -> () = {_, _ in}
    
    init(cellIdentifier: String!, cellItems: [T]!, sectionItems: [U]!, configureCell: @escaping (CELL, T) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.cellItems = cellItems
        self.sectionItems = sectionItems
        self.configureCell = configureCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CELL
        let cellItem = self.cellItems[indexPath.row]
        self.configureCell(cell, cellItem)
        return cell
    }
    
    
}

class TableViewDelegate<view: UIView, U>: NSObject, UITableViewDelegate {
    
    private var heightForCell: CGFloat?
    private var heightForSection: CGFloat?
    
    private var sectionItems: [U]!
    
    var configureHeader: (view, U) -> () = {_, _ in}
    
    init(cellIdentifier: String!, heightForCell: CGFloat?, sectionItems: [U]!, heightForSection: CGFloat? , configureHeader: @escaping (view, U) -> Void) {
        self.heightForCell = heightForCell
        self.heightForSection = heightForSection
        self.sectionItems = sectionItems
        self.configureHeader = configureHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightForCell ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.heightForSection  ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let dataHeader = self.sectionItems[section]
        self.configureHeader(headerView as! view, dataHeader)
        
        return headerView
    }
}


class CustomView: UIView {

    public var myLabel: UILabel?
    override init(frame: CGRect) {

        super.init(frame:frame)

        myLabel = UILabel()
        myLabel?.frame = CGRect.init(x: 20, y: 5, width: self.frame.width-10, height: 60)
        myLabel?.text = "Notification Times"
        myLabel?.font = UIFont(name: "Impact", size: 20.0)
        myLabel?.textColor = .black
        myLabel?.numberOfLines = 2
        addSubview(myLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TableCell : UITableViewCell {
    @IBOutlet var txtLbl: UILabel!
}

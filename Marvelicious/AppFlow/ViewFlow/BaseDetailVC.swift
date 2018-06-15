//
//  BaseDetailVC.swift
//  Marvelicious
//
//  Created by ANUJ NIGAM on 14/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

import UIKit

class BaseDetailVC: UIViewController {
    
    var modelSelected : Results?
    var imgSaved : UIImage?
    @IBOutlet weak var tblDetails: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblDetails.dataSource = self
        tblDetails.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension BaseDetailVC: TableViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomDetailCell", for: indexPath) as! CustomDetailCell
        cell.imgItem.image = imgSaved
        cell.lblTitle.text = modelSelected?.name ?? "Title Not Available."
        
        cell.lblDescription.text = modelSelected?.description 
        cell.lblSeriesComics.text = "Total : \(modelSelected?.comics?.items?.count ?? 0)"
        
        if ((modelSelected?.comics?.items?.count)! > 0) {
            var str = ""
            for item in (modelSelected?.comics?.items)! {
                str.append("■ \(item.name ?? "")\n")
            }
            cell.lblPrice.text = str
        }
        else {
            cell.lblPrice.text = "No series data available."
        }
        return cell
    }

}

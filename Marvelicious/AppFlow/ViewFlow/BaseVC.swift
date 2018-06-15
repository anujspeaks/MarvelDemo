//
//  BaseVC.swift
//  Marvelicious
//
//  Created by ANUJ NIGAM on 13/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var tblMarvel: UITableView!
    @IBOutlet weak var btnTryAgain: UIButton!
    var imgToSend : UIImage?
    lazy var imgLazyLoader : LazyImageLoader = LazyImageLoader()
    var isdataLoaded = false
    var arrMarvelModel  : [Results] = []

    //MARK: RefreshControl
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(BaseVC.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.blue
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMarvelData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDetails" {
            let destinationVC = segue.destination as? BaseDetailVC
            destinationVC?.modelSelected = sender as? Results
            destinationVC?.imgSaved = self.imgToSend
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Custom Methods
    func configureUserInterface() {
        self.tblMarvel.estimatedRowHeight = 300
        self.tblMarvel.keyboardDismissMode = .interactive
        self.tblMarvel.rowHeight = UITableViewAutomaticDimension
        if self.isdataLoaded {
            if !arrMarvelModel.isEmpty {
                tblMarvel.addSubview(self.refreshControl)
                tblMarvel.delegate = self
                tblMarvel.dataSource = self
                lblStatus.isHidden = true
                btnTryAgain.isHidden = true
                tblMarvel.isHidden = false
                tblMarvel.reloadData()
                self.tblMarvel.scrollsToTop = true
            }
            else {
                self.isdataLoaded = false
                tblMarvel.isHidden = true
                btnTryAgain.isHidden = false
                lblStatus.isHidden = false
                lblStatus.text = "No Data Available"
            }
        }
    }
    //MARK: API Call
    func fetchMarvelData() {
        sharedAppdelegate.showLoader(withText: "Loading Marvel Comics...", onView: self.view)
        MervelService().fetchMarvelData(sucess: {[weak self] (arrData) in
            sharedAppdelegate.hideLoader()
            guard let `self` = self else {return}
            self.arrMarvelModel = arrData
            DispatchQueue.main.async {
                sharedAppdelegate.hideLoader()
                self.isdataLoaded = true
                self.configureUserInterface()
            }
            }, failure: {[weak self](error) in
                sharedAppdelegate.hideLoader()
                guard let `self` = self else {return}
                let actionRetry = self.getAlertAction(for: "Retry", selector: { (actions) in
                    self.fetchMarvelData()
                }, style: .default)
                let actionCancel = self.getAlertAction(for: "Cancel", selector: { (actions) in
                    
                    if !self.arrMarvelModel.isEmpty && self.isdataLoaded {
                        self.configureUserInterface()
                    }
                    else {
                        self.tblMarvel.isHidden = true
                        self.lblStatus.isHidden = false
                        self.btnTryAgain.isHidden = false
                        self.lblStatus.text = error
                    }

                }, style: .cancel)
                self.showAlert(withtitle: "Message", message: error, style: .alert, actions: [actionCancel,actionRetry])
        })
    }
    
    //MARK: Action Methods
    @IBAction func isClickedTryAgain(_ sender: Any) {
        self.fetchMarvelData()
    }
    //MARK: Refresh Control
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchMarvelData()
        refreshControl.endRefreshing()
    }
    //MARK: Orientation Methods
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.tblMarvel.reloadData()
        self.tblMarvel.updateConstraints()
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .allButUpsideDown
    }
}
extension BaseVC: TableViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMarvelModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let model = self.arrMarvelModel[indexPath.row]
        let strImageLink  = (model.thumbnail?.path)!+"."+(model.thumbnail?.ext)!
        self.imgLazyLoader.show(imageView: cell.imgItem, url: strImageLink, defaultImage: "") {
           cell.spinnerItem.stopAnimating()
        }
        cell.lblItem.text = model.name //model.title
        cell.viewContent.dropShadow(color: colorRed, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 4, scale: true)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        imgToSend = cell.imgItem.image
        let modelSelected = self.arrMarvelModel[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "openDetails", sender: modelSelected)
    }
}

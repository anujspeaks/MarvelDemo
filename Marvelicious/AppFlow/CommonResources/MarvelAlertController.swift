//
//  MarvelAlertController.swift
//  Marvelicious
//
//  Created by ANUJ NIGAM on 14/06/18.
//  Copyright © 2018 ANUJ NIGAM. All rights reserved.
//

import UIKit

class MarvelAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var shouldAutorotate: Bool {return false}
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {return .portrait}
}

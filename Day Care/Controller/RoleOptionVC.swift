//
//  RoleOptionVC.swift
//  Day Care
//
//  Created by Zaman Meraj on 26/09/20.
//

import UIKit

class RoleOptionVC: UIViewController {

    @IBOutlet weak var parentBtn: UIButton!
    @IBOutlet weak var employeeInDayCare: UIButton!
    @IBOutlet weak var ownerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCorenerRadius(btn: self.parentBtn)
        self.setCorenerRadius(btn: self.employeeInDayCare)
        self.setCorenerRadius(btn: self.ownerBtn)
        
    }
    
    func setCorenerRadius(btn: UIButton) {
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
    }
    
    
    
}

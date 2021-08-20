//
//  AlertWithoutClickVC.swift
//  Bam
//
//  Created by ADS N URL on 05/04/21.
//

import UIKit

protocol View1Delegate: class {
    func dismissViewController(controller: UIViewController)
}

class AlertWithoutClickVC: UIViewController {

    //MARK:- Variables
    var selectedPop = ""
    var delegate : View1Delegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var headingLbl: UILabel!

    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedPop == "Invoice" {
            messageLbl.text = "Invoice will be sent to your registered Email ID"
        } else if selectedPop == "Appointment" {
            messageLbl.text = "Your thobe is added to the cart"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.selectedPop == "Appointment" {
//                delegate?.dismissViewController(controller: MyThodeVC)
                self.dismiss(animated: false, completion: { () -> Void   in

                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyThodeVC") as! MyThodeVC
                    self.delegate?.dismissViewController(controller: vc)
                })
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK: - IBActions
    @IBAction func btnTap_Submit(_ sender :UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



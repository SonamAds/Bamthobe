//
//  TrackOrderVC.swift
//  Bam
//
//  Created by ADS N URL on 23/03/21.
//

import UIKit
import ISTimeline


class TrackOrderVC: UIViewController {
    
    //MARK: - Variables
    var orderModel: TrackOrderModel?

    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var scanQrBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var placedOnLbl: UILabel!
    @IBOutlet weak var deliveryLbl: UILabel!
    @IBOutlet weak var timeline: ISTimeline!

    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scanQrBtn.isHidden = true
        orderIdLbl.text = "Order ID: \(orderModel?.data?.order_id ?? "")"
        placedOnLbl.text = "Placed On: \(orderModel?.data?.placed_on ?? "")"
        deliveryLbl.text = orderModel?.data?.delivery_time ?? ""
        
        let orderMod = orderModel?.data?.status_message
        var myPoints = [ISPoint]()
        var green = AppUsedColors.appBackgroundColor
        
        let touchAction = { (point:ISPoint) in
            print("point \(point.title)")
        }
        for i in 0..<(orderMod?.count ?? 0) {
            
            if i < orderModel?.data?.delivery_status ?? 0 {
                green = AppUsedColors.appBackgroundColor
            } else {
//                green =
                green = UIColor.lightGray//UIColor.init(red: 1/255, green: 137/255, blue: 1/255, alpha: 1)
            }

            myPoints.append(ISPoint(title: orderMod?[i] ?? "", description: "", pointColor: green, lineColor: green, touchUpInside: touchAction, fill: false))
        }
         
        timeline.contentInset = UIEdgeInsets(top: 10.0, left: 40.0, bottom: 40.0, right: 40.0)
        timeline.points = myPoints
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_ScanQRCode(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateGiftVC") as! CreateGiftVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
}

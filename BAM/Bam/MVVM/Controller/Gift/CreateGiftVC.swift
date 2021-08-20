//
//  CreateGiftVC.swift
//  Bam
//
//  Created by ADS N URL on 19/03/21.
//

import UIKit

class CreateGiftVC: UIViewController {

    //MARK: - Variables
    var giftId = 0
    let datePicker = DatePickerDialog()
    
    
    // MARK:- IBOutlet Properties
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var dateTF:UITextField!
    @IBOutlet weak var timeTF:UITextField!
    @IBOutlet weak var dateView:UIView!
    @IBOutlet weak var timeView:UIView!
    @IBOutlet weak var dateSV:UIStackView!
    @IBOutlet weak var timeSV:UIStackView!
    @IBOutlet weak var backBtn:UIButton!
    @IBOutlet weak var confirmBtn:UIButton!


    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTF.delegate = self
        timeTF.delegate = self
        dateView.layer.borderWidth = 1
        dateView.layer.borderColor = UIColor.lightGray.cgColor
        timeView.layer.borderWidth = 1
        timeView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Helping Methods
    func datePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = 3
        let threeYearLater = Calendar.current.date(byAdding: dateComponents, to: currentDate)

        datePicker.show("Select Date",
                        doneButtonTitle: "Save",
                        cancelButtonTitle: "Cancel",
                        minimumDate: currentDate,
                        maximumDate: threeYearLater,
                        datePickerMode: .date) { (date) in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.dateTF.text = formatter.string(from: dt)
            }
        }
    }
    
    func timePickerTapped() {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = 3
        let threeYearLater = Calendar.current.date(byAdding: dateComponents, to: currentDate)

        datePicker.show("Select Time",
                        doneButtonTitle: "Save",
                        cancelButtonTitle: "Cancel",
                        minimumDate: currentDate,
                        maximumDate: threeYearLater,
                        datePickerMode: .time) { (date) in
            if let dt = date {
//                self.timeTF.text = formatter.string(from: dt)
                let formatter = DateFormatter()
                formatter.dateFormat = "hh:mm a"
                //for weekday name "EEEE HH:mm"
                //for 24 hour "HH:mm"
                self.timeTF.text = formatter.string(from: dt)
            }
        }
    }

    
    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_Continue(_ sender: UIButton) {
        if dateTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Date", interval: 4)
        } else if timeTF.text == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Time", interval: 4)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SecondCreateGiftDetailVC") as! SecondCreateGiftDetailVC
            vc.dateStr = dateTF.text!
            vc.timeStr = timeTF.text!
            vc.giftId = giftId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


//MARK: - UITextField Delegate
extension CreateGiftVC: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == mobileTF {
//            let cs = NSCharacterSet(charactersIn: "0123456789").inverted
//            let filtered: String = string.components(separatedBy: cs).joined(separator: "")
//            let stringLength: String? = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//            if (stringLength?.count ?? 0) > 10 {
//                return false
//            } else {
//                return string == filtered
//            }
//        }
//        return false
//    }
//
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateTF {
            datePickerTapped()
            return false
        } else if textField == timeTF {
            timePickerTapped()
            return false
        }
        return true
    }
}

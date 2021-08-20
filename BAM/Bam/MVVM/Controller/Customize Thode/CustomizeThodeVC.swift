//
//  CustomizeThodeVC.swift
//  Bam
//
//  Created by ADS N URL on 07/04/21.
//

import UIKit
import Alamofire
import SDWebImage
//import SDWebImageSVGCoder

class CustomizeThodeVC: UIViewController {
    
    //MARK: - Variables
    var thobeDict = [String: String]()
    var imageStr : String?
    var imageCode : String?
    var isImageTap = 0
    var thodeArr = ["Fabric", "Collar", "Cuffs", "Pocket", "Placket", "Button", "Side Pocket"]
    var presentValue = 0
    var fabricSelected = 0
    var selectedThodeArr = [String]()
    var thobeArr = [[String: String]]()
    var summerCollection = [FabricModelData]()
    var winterCollection = [FabricModelData]()
    var sidePocket = ""
    var sidePocket1 = ""
    var sidePocket2 = ""
//    var fabricModel: FabricModel?
    var cuffsModel: CuffsModel?
    var collarModel: CollarModel?
    var placketModel: PlacketModel?
    var pocketModel: PocketModel?
    var buttonModel: ButtonModel?
    var apiHelper = ApiHelper()
    var FABRIC = "0"
    var CUFFS = "1"
    var COLLAR = "2"
    var POCKET = "3"
    var PLACKET = "4"
    var BUTTON = "5"
    var THOBEIMAGE = "-1"
    var userManager = UserManager.userManager
    
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var headingLbl: UILabel!
    
    @IBOutlet weak var summerLbl: UILabel!
    @IBOutlet weak var summerLine: UILabel!
    @IBOutlet weak var summerTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var winterLbl: UILabel!
    @IBOutlet weak var winterLine: UILabel!
    @IBOutlet weak var fabricView: UIView!
    @IBOutlet weak var winterTapGesture: UITapGestureRecognizer!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var priceLbl: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var thodeSV: UIStackView!
    @IBOutlet weak var imageSV: UIImageView!
    
    @IBOutlet weak var collarIV: UIImageView!
    @IBOutlet weak var cuffIV: UIImageView!
    @IBOutlet weak var placketIV: UIImageView!
    @IBOutlet weak var pocketIV: UIImageView!
    @IBOutlet weak var buttonIV: UIImageView!
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var sidePocketSV: UIView!
    @IBOutlet weak var wantCoinSV: UIStackView!
    @IBOutlet weak var SideCoinSV: UIStackView!
    @IBOutlet weak var WhichSideSV: UIStackView!
    
    @IBOutlet weak var bothSidePriceLbl: UILabel!
    @IBOutlet weak var oneSidePriceLbl: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var bothSideBtn: UIButton!
    @IBOutlet weak var oneSideBtn: UIButton!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var backCustomizeBtn: UIButton!
    @IBOutlet weak var nextCustomizeSV: UIStackView!
    @IBOutlet weak var nextCustomizeLbl: UIButton!
    @IBOutlet weak var backCustomizeSV: UIStackView!
    @IBOutlet weak var backCustomizeLbl: UIButton!
    @IBOutlet weak var nextCustomizeBtn: UIButton!

    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noBtn.setImage(#imageLiteral(resourceName: "circle_tick"), for: .normal)
        tableView.rowHeight = UITableView.automaticDimension
        let imageTap1 = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_Image))
        imageSV.addGestureRecognizer(imageTap1)
        bottomHeightConstraint.constant = 0
        collarIV.isHidden = true
        cuffIV.isHidden = true
        placketIV.isHidden = true
        pocketIV.isHidden = true
        buttonIV.isHidden = true
        thobeDict["fabric"] = ""
        thobeDict["collar"] = ""
        thobeDict["cuffs"] = ""
        thobeDict["pocket"] = ""
        thobeDict["placket"] = ""
        thobeDict["button"] = ""
        thobeDict["side_pocket"] = ""
        thobeDict["side_pocket_2"] = ""
        thobeDict["measurement"] = ""
        thobeDict["measurement_type"] = ""
        thobeDict["name"] = ""
        thobeDict["mobile"] = ""
        thobeDict["date"] = ""
        thobeDict["branch"] = ""
        thobeDict["address_id"] = ""
        thobeDict["time"] = ""
        thobeDict["product_id"] = ""
        print("", presentValue)
        apiHelper.responseDelegate = self
        thobeApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fabricApi()
        cuffsApi()
        collarApi()
        pocketApi()
        placketApi()
        buttonApi()
    }
    
    
    //MARK: - API Method
    func thobeApi() {
        apiHelper.GetData(urlString: kThobeImage, tag: THOBEIMAGE)
    }
    
    func fabricApi() {
        apiHelper.GetData(urlString: kFabric, tag: FABRIC)
    }
    
    func cuffsApi() {
        apiHelper.GetData(urlString: kCuffs, tag: CUFFS)
    }
    
    func collarApi() {
        apiHelper.GetData(urlString: kCollar, tag: COLLAR)
    }
    
    func pocketApi() {
        apiHelper.GetData(urlString: kPocket, tag: POCKET)
    }
    
    func placketApi() {
        apiHelper.GetData(urlString: kPlacket, tag: PLACKET)
    }
    
    func buttonApi() {
        apiHelper.GetData(urlString: kButton, tag: BUTTON)
    }
    

    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func gestureTap_Summer(_ sender: UIButton) {
        fabricSelected = 0
        summerLbl.textColor = AppUsedColors.appColor
        summerLbl.backgroundColor = UIColor.clear
        summerLine.isHidden = false
        
        winterLbl.textColor = UIColor.black
        winterLbl.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        winterLine.isHidden = true
        collectionView.reloadData()
    }
    
    @IBAction func gestureTap_Winter(_ sender: UIButton) {
        fabricSelected = 1
        winterLbl.textColor = AppUsedColors.appColor
        winterLbl.backgroundColor = UIColor.clear
        winterLine.isHidden = false
        
        summerLbl.textColor = UIColor.black
        summerLbl.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        summerLine.isHidden = true
        collectionView.reloadData()
    }
    
    @IBAction func btnTap_Yes(_ sender: Any) {
        //delegate.didTap(name: "", tag: sender.tag, row: rowtag)
        if sidePocket == "" || sidePocket == "no" {
            yesBtn.setImage(#imageLiteral(resourceName: "circle_tick"), for: .normal)
            noBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            sidePocket = "yes"
            SideCoinSV.isHidden = false
        } else {
            yesBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            noBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            sidePocket = ""
            SideCoinSV.isHidden = true
        }
    }
    
    
    @IBAction func btnTap_No(_ sender: Any) {
        SideCoinSV.isHidden = true
        WhichSideSV.isHidden = true
        if sidePocket == "" || sidePocket == "yes" {
            yesBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            noBtn.setImage(#imageLiteral(resourceName: "circle_tick"), for: .normal)
            sidePocket = "no"
//            SideCoinSV.isHidden = true
        } else {
            yesBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            noBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            sidePocket = "no"
//            SideCoinSV.isHidden = true
        }
      
    }
    
    @IBAction func btnTap_BothSide(_ sender: Any) {
        if sidePocket1 == "both" {
            bothSideBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            thobeDict["side_pocket"] = ""
            sidePocket1 = ""

//            WhichSideSV.isHidden = false
        } else {
            bothSideBtn.setImage(#imageLiteral(resourceName: "circle_tick"), for: .normal)
            oneSideBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            thobeDict["side_pocket"] = "1"
            sidePocket1 = "both"
            WhichSideSV.isHidden = true
        }
    }
    
    @IBAction func btnTap_OneSide(_ sender: Any) {

        if sidePocket1 == "one" {
            oneSideBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            thobeDict["side_pocket"] = ""
            sidePocket1 = ""
            WhichSideSV.isHidden = true
        } else {
            oneSideBtn.setImage(#imageLiteral(resourceName: "circle_tick"), for: .normal)
            bothSideBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            thobeDict["side_pocket"] = "0"
            sidePocket1 = "one"
            WhichSideSV.isHidden = false
        }
    }
    
    @IBAction func btnTap_Left(_ sender: Any) {
        if sidePocket2 == "left" {
            leftBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            sidePocket2 = ""
            thobeDict["side_pocket_2"] = ""
        } else {
            leftBtn.setImage(#imageLiteral(resourceName: "circle_tick"), for: .normal)
            rightBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            thobeDict["side_pocket_2"] = "0"
            sidePocket2 = "left"
        }
    }
    
    @IBAction func btnTap_Right(_ sender: Any) {
        if sidePocket2 == "right" {
            rightBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            thobeDict["side_pocket_2"] = ""
            sidePocket2 = ""

        } else {
            rightBtn.setImage(#imageLiteral(resourceName: "circle_tick"), for: .normal)
            leftBtn.setImage(#imageLiteral(resourceName: "oval"), for: .normal)
            thobeDict["side_pocket_2"] = "1"
            sidePocket2 = "right"

        }
    }
    
    @IBAction func btnTap_NextCustomize(_ sender: UIButton) {

        selectedThodeArr.insert("Thobe\(presentValue)", at: presentValue)
        print("selectedThodeArr", selectedThodeArr)
        print("presentValue", presentValue)
        print("thobeDict", thobeDict)

        if presentValue == 0 && thobeDict["fabric"] == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Fabric", interval: 2)
        } else if presentValue == 1 && thobeDict["collar"] == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Collar", interval: 2)
        } else if presentValue == 2 && thobeDict["cuffs"] == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Cuffs", interval: 2)
        } else if presentValue == 3 && thobeDict["pocket"] == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Pocket", interval: 2)
        } else if presentValue == 4 && thobeDict["placket"] == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Placket", interval: 2)
        } else if presentValue == 5 && thobeDict["button"] == "" {
            SnackBar().showSnackBar(view: self.view, text: "Select Button", interval: 2)
        } else if presentValue == 6 && sidePocket == "yes" && thobeDict["side_pocket"] == "" {
                SnackBar().showSnackBar(view: self.view, text: "Choose Side Pocket", interval: 2)
            
        } else if presentValue == 6 && sidePocket == "yes" && thobeDict["side_pocket"] == "" && thobeDict["side_pocket_2"] == "" && sidePocket2 == "" {
                SnackBar().showSnackBar(view: self.view, text: "Choose Side Pocket", interval: 2)
            
//        } else if presentValue == 6 && sidePocket == "yes" {
//            if thobeDict["side_pocket"] == "" {
//                SnackBar().showSnackBar(view: self.view, text: "Choose Side Pocket", interval: 2)
//            } else if thobeDict["side_pocket_2"] == "" && sidePocket2 == "" {
//                SnackBar().showSnackBar(view: self.view, text: "Choose Side Pocket", interval: 2)
//            }
        } else {
        if selectedThodeArr[presentValue] != "" {
            presentValue = presentValue + 1
            if presentValue < 7 {
                if presentValue == 6 {
                    fabricView.isHidden = true
                    collectionView.isHidden = true
                    sidePocketSV.isHidden = false
                    nextCustomizeLbl.setTitle("Button", for: .normal)
                    nextCustomizeLbl.setTitle("My Thobe", for: .normal)
                   // nextCustomizeLbl.text = "Measurement"
                } else {
                    if presentValue == 0 {
                    fabricView.isHidden = false
                } else {
                    fabricView.isHidden = true
                }
                    collectionView.isHidden = false
                    collectionView.reloadData()
                    sidePocketSV.isHidden = true
                    showBottomUI()
                }
                tableView.reloadData()
                collectionView.reloadData()
            } else {
                let data = ["id":"0", "thobe":thobeDict["side_pocket"] == "" ? "No" : thobeDict["side_pocket"] == "0" ? "One" : thobeDict["side_pocket"] == "1" ? "Both" : thobeDict["side_pocket_2"] == "0" ? "left" : "right", "price":thobeDict["side_pocket"] == "" ? "0.00" : thobeDict["side_pocket"] == "0" ? "35.00" : thobeDict["side_pocket"] == "1" ? "40.00" : "20.00", "description":"", "image":""]
                thobeArr.insert(data, at: 6)
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyThodeVC") as! MyThodeVC
//                let vc = storyboard?.instantiateViewController(withIdentifier: "SavedMeasurementsVC") as! SavedMeasurementsVC
                vc.thobeDict = thobeDict
                vc.thobeArr = thobeArr
                self.navigationController?.pushViewController(vc, animated: false)
            }
        } else {}
        }
    }
    
    
    @IBAction func btnTap_BackCustomize(_ sender: UIButton) {
//        selectedThodeArr.remove(at: presentValue + 1)
        presentValue = presentValue - 1
        if presentValue == 6 {
            fabricView.isHidden = true
            collectionView.isHidden = true
            sidePocketSV.isHidden = false
        } else {
            if presentValue == 0 {
                fabricView.isHidden = false
            } else {
                fabricView.isHidden = true
            }
            collectionView.isHidden = false
            collectionView.reloadData()
            sidePocketSV.isHidden = true
        }
        showBottomUI()
        collectionView.reloadData()
    }
    
    @objc func gestureTap_Image() {
        if isImageTap == 1 {
            fabricView.isHidden = true
            collectionView.isHidden = true
            priceLbl.isHidden = true
//            bottomView.isHidden = true
            imageHeightConstraint.constant = (UIScreen.main.bounds.height - 120)
            bottomHeightConstraint.constant = 0
            isImageTap = 0
        } else {
            fabricView.isHidden = false
//            bottomView.isHidden = false
            collectionView.isHidden = false
            priceLbl.isHidden = false
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
            imageHeightConstraint.constant = (UIScreen.main.bounds.height - 120) / 2
            bottomHeightConstraint.constant = 80
//            showBottomUI()
            isImageTap = 1
        }
        showBottomUI()
    }
    
    
    //MARK: - Helping Methods
    func showBottomUI() {
        if presentValue == 0 {
            backCustomizeSV.isHidden = true
            nextCustomizeLbl.setTitle(thodeArr[presentValue + 1], for: .normal)
//            nextCustomizeLbl.text = thodeArr[presentValue + 1]
        } else {
            nextCustomizeLbl.setTitle(thodeArr[presentValue + 1], for: .normal)
            backCustomizeLbl.setTitle(thodeArr[presentValue - 1], for: .normal)

//            nextCustomizeLbl.text = thodeArr[presentValue + 1]
//            backCustomizeLbl.text = thodeArr[presentValue - 1]
            backCustomizeSV.isHidden = false
//            nextCustomizeSV.isHidden = false
        }
    }
    
}


//MARK: - Custom Delegates
extension CustomizeThodeVC: ThodeDetailDelegate {
    func didTap(row: Int, selectedThobe: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailPopupVC") as! DetailPopupVC
        if selectedThobe == 0 {
            if fabricSelected == 0 {
                vc.pushDict = summerCollection[row - 1]
            } else {
                vc.pushDict = winterCollection[row - 1]
            }
        } else if selectedThobe == 1 {
            vc.pushDict1 = collarModel?.data?[row - 1]

        } else if selectedThobe == 2 {
            vc.pushDict2 = cuffsModel?.data?[row - 1]

        } else if selectedThobe == 3 {
            vc.pushDict3 = pocketModel?.data?[row - 1]

        } else if selectedThobe == 4 {
            vc.pushDict4 = placketModel?.data?[row - 1]

        } else if selectedThobe == 5 {
            vc.pushDict5 = buttonModel?.data?[row - 1]
        }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
        print("Tetdknd")
    }

}

//MARK: - UITableView Delegate and DataSource
extension CustomizeThodeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thodeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CutomizeThobeTVCell")
        cell?.textLabel?.text = thodeArr[indexPath.row]
        cell?.textLabel?.transform = CGAffineTransform(rotationAngle: .pi/2)
        if indexPath.row == presentValue {
            cell?.textLabel?.textColor = UIColor.black
        } else {
            cell?.textLabel?.textColor = UIColor.lightGray
        }
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if thodeArr[indexPath.row] == "Side Pocket" || thodeArr[indexPath.row] == "My Thobe" {
            return 120
        }
        return 80
    }
}

//MARK: - UICollectionView Delegate and DataSource
extension CustomizeThodeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presentValue == 0 {
            if fabricSelected == 0 {
                return summerCollection.count
            } else {
                return winterCollection.count
            }
        } else if presentValue == 1 {
            return collarModel?.data?.count ?? 0
        } else if presentValue == 2 {
            return cuffsModel?.data?.count ?? 0
        } else if presentValue == 3 {
            return pocketModel?.data?.count ?? 0
        } else if presentValue == 4 {
            return placketModel?.data?.count ?? 0
        } else if presentValue == 5 {
            return buttonModel?.data?.count ?? 0
//        } else if presentValue == 6 {
//            return fabricModel?.data?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThodeCell", for: indexPath) as! ThodeCell
        
        if presentValue == 0 {
            
            if fabricSelected == 0 {
                cell.colorLbl.tag = presentValue
                let data = summerCollection[indexPath.row]
                let url = "\(data.image ?? "")"
                cell.customizeThodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    cell.customizeThodeIV.image = image
                    cell.customizeThodeIV.contentMode = .scaleToFill
                }
                cell.colorLbl.setTitle(data.fabrics, for: .normal)
                cell.priceLbl.setTitle("SAR \(data.price ?? "0")", for: .normal)
                cell.viewFabricBtn.setTitle("View Fabric", for: .normal)
                if thobeDict["fabric"] == "" || thobeDict["fabric"] != "\(data.id ?? 0)" {
                    cell.tickIV.isHidden = true
                } else {
                    cell.tickIV.isHidden = false
                }
            } else {
                cell.colorLbl.tag = presentValue
                let data = winterCollection[indexPath.row]
                let url = "\(data.image ?? "")"
                cell.customizeThodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    cell.customizeThodeIV.image = image
                    cell.customizeThodeIV.contentMode = .scaleToFill
                }
                cell.colorLbl.setTitle(data.fabrics, for: .normal)
                cell.priceLbl.setTitle("SAR \(data.price ?? "0")", for: .normal)
                cell.viewFabricBtn.setTitle("View Fabric", for: .normal)
                if thobeDict["fabric"] == "" || thobeDict["fabric"] != "\(data.id ?? 0)" {
                    cell.tickIV.isHidden = true
                } else {
                    cell.tickIV.isHidden = false
                }
            }

        } else if presentValue == 1 {
            cell.colorLbl.tag = presentValue
            let data = collarModel?.data?[indexPath.row]
            let url = "\(data?.image ?? "")"
            cell.customizeThodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.customizeThodeIV.image = image
                cell.customizeThodeIV.contentMode = .scaleAspectFit
            }
            cell.colorLbl.setTitle(data?.collar_style, for: .normal)
            cell.priceLbl.setTitle("SAR \(data?.price ?? "0")", for: .normal)
            cell.viewFabricBtn.setTitle("Details", for: .normal)
            if thobeDict["collar"] == "" || thobeDict["collar"] != "\(collarModel?.data?[indexPath.row].id ?? 0)"{
                cell.tickIV.isHidden = true
            } else {
                cell.tickIV.isHidden = false
            }
   
        } else if presentValue == 2 {
            cell.colorLbl.tag = presentValue
            let data = cuffsModel?.data?[indexPath.row]
            let url = "\(data?.image ?? "")"
            cell.customizeThodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.customizeThodeIV.image = image
                cell.customizeThodeIV.contentMode = .scaleAspectFit
            }
            cell.colorLbl.setTitle(data?.cuff, for: .normal)
            cell.priceLbl.setTitle("SAR \(data?.price ?? "0")", for: .normal)
            cell.viewFabricBtn.setTitle("Details", for: .normal)
            if thobeDict["cuffs"] == "" || thobeDict["cuffs"] != "\(cuffsModel?.data?[indexPath.row].id ?? 0)" {
                cell.tickIV.isHidden = true
            } else {
                cell.tickIV.isHidden = false
            }
       
        } else if presentValue == 3 {
            cell.colorLbl.tag = presentValue
            let data = pocketModel?.data?[indexPath.row]
            let url = "\(data?.image ?? "")"
            cell.customizeThodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.customizeThodeIV.image = image
                cell.customizeThodeIV.contentMode = .scaleAspectFit
            }
            cell.colorLbl.setTitle(data?.pocket, for: .normal)
            cell.priceLbl.setTitle("SAR \(data?.price ?? "0")", for: .normal)
            cell.viewFabricBtn.setTitle("Details", for: .normal)
            if thobeDict["pocket"] == "" || thobeDict["pocket"] != "\(pocketModel?.data?[indexPath.row].id ?? 0)" {
                cell.tickIV.isHidden = true
            } else {
                cell.tickIV.isHidden = false
            }
       
        } else if presentValue == 4 {
            cell.colorLbl.tag = presentValue
            let data = placketModel?.data?[indexPath.row]
            let url = "\(data?.image ?? "")"
            cell.customizeThodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.customizeThodeIV.image = image
                cell.customizeThodeIV.contentMode = .scaleAspectFit
            }
            cell.colorLbl.setTitle(data?.style, for: .normal)
            cell.priceLbl.setTitle("SAR \(data?.price ?? "0")", for: .normal)
            cell.viewFabricBtn.setTitle("Details", for: .normal)
            if thobeDict["placket"] == "" || thobeDict["placket"] != "\(placketModel?.data?[indexPath.row].id ?? 0)" {
                cell.tickIV.isHidden = true
            } else {
                cell.tickIV.isHidden = false
            }
      
        } else if presentValue == 5 {
            cell.colorLbl.tag = presentValue
            let data = buttonModel?.data?[indexPath.row]
            let url = "\(data?.image ?? "")"
            cell.customizeThodeIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.customizeThodeIV.image = image
                cell.customizeThodeIV.contentMode = .scaleAspectFit
            }
            cell.colorLbl.setTitle(data?.buttons, for: .normal)
            cell.priceLbl.setTitle("SAR \(data?.price ?? "0")", for: .normal)
            cell.viewFabricBtn.setTitle("Details", for: .normal)
            if thobeDict["button"] == "" || thobeDict["button"] != "\(buttonModel?.data?[indexPath.row].id ?? 0)" {
                cell.tickIV.isHidden = true
            } else {
                cell.tickIV.isHidden = false
            }
        }
        cell.viewFabricBtn.tag = indexPath.row + 1
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("test comes")
        if presentValue == 0 {
            if fabricSelected == 0 {
                if thobeDict["fabric"] != "" {
                    thobeDict["fabric"] = ""
                    thobeArr.remove(at: presentValue)

                }/* else {*/
                let data = ["id":"\(summerCollection[indexPath.row].id ?? 0)", "thobe":"\(summerCollection[indexPath.row].fabrics ?? "")", "price":"\(summerCollection[indexPath.row].price ?? "0")", "description":"\(summerCollection[indexPath.row].description ?? "")", "image":"\(summerCollection[indexPath.row].image ?? "")"]
                thobeArr.insert(data, at: presentValue)
                thobeDict["fabric"] = "\(summerCollection[indexPath.row].id ?? 0)"
                imageSV.tintColor = hexStringToUIColor(hex: summerCollection[indexPath.row].color_code ?? "")
                priceLbl.setTitle("SAR \(summerCollection[indexPath.row].price ?? "0")", for: .normal)
               /* }*/
            } else {
                if thobeDict["fabric"] != "" || thobeDict["fabric"] == "\(winterCollection[indexPath.row].id ?? 0)"{
                    thobeDict["fabric"] = ""
                    thobeArr.remove(at: presentValue)
                   
    //                }
                } /*else {*/
                let data = ["id":"\(winterCollection[indexPath.row].id ?? 0)", "thobe":"\(winterCollection[indexPath.row].fabrics ?? "")", "price":"\(winterCollection[indexPath.row].price ?? "0")", "description":"\(winterCollection[indexPath.row].description ?? "")", "image":"\(winterCollection[indexPath.row].image ?? "")"]
                thobeArr.insert(data, at: presentValue)
                thobeDict["fabric"] = "\(winterCollection[indexPath.row].id ?? 0)"
                imageSV.tintColor = hexStringToUIColor(hex: winterCollection[indexPath.row].color_code ?? "")
                priceLbl.setTitle("SAR \(winterCollection[indexPath.row].price ?? "0")", for: .normal)
                /*}*/
            }
        } else if presentValue == 1 {
            if thobeDict["collar"] != "" {
                thobeArr.remove(at: presentValue)
                thobeDict["collar"] = ""
                collarIV.isHidden = true
            } /*else {*/
                let data = ["id":"\(collarModel?.data?[indexPath.row].id ?? 0)", "thobe":"\(collarModel?.data?[indexPath.row].collar_style ?? "")", "price":"\(collarModel?.data?[indexPath.row].price ?? "0")", "description":"\(collarModel?.data?[indexPath.row].description ?? "")", "image":"\(collarModel?.data?[indexPath.row].image ?? "")"]
                thobeArr.insert(data, at: presentValue)
                thobeDict["collar"] = "\(collarModel?.data?[indexPath.row].id ?? 0)"
                collarIV.sd_setImage(with: URL(string: collarModel?.data?[indexPath.row].visible_image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    self.collarIV.image = image
                }
            priceLbl.setTitle("SAR \(collarModel?.data?[indexPath.row].price ?? "0")", for: .normal)
                collarIV.alpha = 0.5
                collarIV.isHidden = false
            /*}*/
        } else if presentValue == 2 {
            if thobeDict["cuffs"] != "" {
                thobeArr.remove(at: presentValue)
                thobeDict["cuffs"] = ""
                cuffIV.isHidden = true
            }/* else {*/
                let data = ["id":"\(cuffsModel?.data?[indexPath.row].id ?? 0)", "thobe":"\(cuffsModel?.data?[indexPath.row].cuff ?? "")", "price":"\(cuffsModel?.data?[indexPath.row].price ?? "0")", "description":"\(cuffsModel?.data?[indexPath.row].description ?? "")", "image":"\(cuffsModel?.data?[indexPath.row].image ?? "")"]
                thobeArr.insert(data, at: presentValue)
                thobeDict["cuffs"] = "\(cuffsModel?.data?[indexPath.row].id ?? 0)"
                cuffIV.sd_setImage(with: URL(string: cuffsModel?.data?[indexPath.row].visible_image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    self.cuffIV.image = image
                }
            priceLbl.setTitle("SAR \(cuffsModel?.data?[indexPath.row].price ?? "0")", for: .normal)

                cuffIV.alpha = 0.5
                cuffIV.isHidden = false
            /*}*/
        } else if presentValue == 3 {
            if thobeDict["pocket"] != "" {
                thobeArr.remove(at: presentValue)
                thobeDict["pocket"] = ""
                pocketIV.isHidden = true
            } /* else {*/
                let data = ["id":"\(pocketModel?.data?[indexPath.row].id ?? 0)", "thobe":"\(pocketModel?.data?[indexPath.row].pocket ?? "")", "price":"\(pocketModel?.data?[indexPath.row].price ?? "0")", "description":"\(pocketModel?.data?[indexPath.row].description ?? "")", "image":"\(pocketModel?.data?[indexPath.row].image ?? "")"]
                thobeArr.insert(data, at: presentValue)
                thobeDict["pocket"] = "\(pocketModel?.data?[indexPath.row].id ?? 0)"
                pocketIV.sd_setImage(with: URL(string: pocketModel?.data?[indexPath.row].visible_image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    self.pocketIV.image = image
                }
            priceLbl.setTitle("SAR \(pocketModel?.data?[indexPath.row].price ?? "0")", for: .normal)

                pocketIV.alpha = 0.5
                pocketIV.isHidden = false
           /* }*/
        } else if presentValue == 4 {
            if thobeDict["placket"] != "" {
                thobeArr.remove(at: presentValue)
                thobeDict["placket"] = ""
                placketIV.isHidden = true
            } /* else {*/
                let data = ["id":"\(placketModel?.data?[indexPath.row].id ?? 0)", "thobe":"\(placketModel?.data?[indexPath.row].style ?? "")", "price":"\(placketModel?.data?[indexPath.row].price ?? "0")", "description":"\(placketModel?.data?[indexPath.row].description ?? "")", "image":"\(placketModel?.data?[indexPath.row].image ?? "")"]
                thobeArr.insert(data, at: presentValue)
                thobeDict["placket"] = "\(placketModel?.data?[indexPath.row].id ?? 0)"
                placketIV.sd_setImage(with: URL(string: placketModel?.data?[indexPath.row].visible_image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    self.placketIV.image = image
                }
            priceLbl.setTitle("SAR \(placketModel?.data?[indexPath.row].price ?? "0")", for: .normal)

                placketIV.alpha = 0.5
                placketIV.isHidden = false
            /*}*/
        } else if presentValue == 5 {
            if thobeDict["button"] != "" {
                thobeArr.remove(at: presentValue)
                thobeDict["button"] = ""
                buttonIV.isHidden = true
            } /* else {*/
                let data = ["id":"\(buttonModel?.data?[indexPath.row].id ?? 0)", "thobe":"\(buttonModel?.data?[indexPath.row].buttons ?? "")", "price":"\(buttonModel?.data?[indexPath.row].price ?? "0")", "description":"\(buttonModel?.data?[indexPath.row].description ?? "")", "image":"\(buttonModel?.data?[indexPath.row].image ?? "")"]
                thobeArr.insert(data, at: presentValue)
                thobeDict["button"] = "\(buttonModel?.data?[indexPath.row].id ?? 0)"
                buttonIV.sd_setImage(with: URL(string: buttonModel?.data?[indexPath.row].visible_image ?? "")!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    self.buttonIV.image = image
                }
                buttonIV.alpha = 0.3
            priceLbl.setTitle("SAR \(buttonModel?.data?[indexPath.row].price ?? "0")", for: .normal)

//                buttonIV.isHidden = false
            /*}*/
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if fabricView.isHidden == true {
            return CGSize(width: (UIScreen.main.bounds.width - 75.0) / 3, height: 140)
        } else {
            return CGSize(width: (UIScreen.main.bounds.width - 75.0) / 2, height: 120)
        }
    }
    
}


//MARk: - API Success
extension CustomizeThodeVC: ApiResponseDelegate {
    func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
    let jsonDecoder = JSONDecoder()
    LoadingIndicatorView.hide()
    switch tag {
        case THOBEIMAGE:
//            do{
                let resultJson = try? JSONSerialization.jsonObject(with: responseData.data!, options: []) as? [String:AnyObject]
                print("resultJson", resultJson)
//            let json_value = resultJson as? JSON
//                if let dictionary = resultJson as? [String: String] {
//                 print("dictionary", dictionary)
                    if let status = resultJson?["status"] as? Bool {
                     print("status", status)
                        if status == true {
                            let data = resultJson?["data"] as? [[String: Any]]
                            imageCode = data?[0]["color_code"] as? String
                            imageStr = data?[0]["image"] as? String
                            imageSV.sd_setImage(with: URL(string: imageStr ?? ""), placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                                self.imageSV.image = image?.withRenderingMode(.alwaysTemplate)
                                self.imageSV.tintColor = hexStringToUIColor(hex: "#fefefe")
                            }
                        }else {
                         print("status 400")
                            if let nestedDictionary = resultJson?["message"] as? String {
                             SnackBar().showSnackBar(view: self.view, text: "\(nestedDictionary)", interval: 4)
                          }
                        }
                    }
//                }
//            }catch let error as NSError{
//                LoadingIndicatorView.hide()
//                print(error.localizedDescription)
//                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
//            }
            break
        case FABRIC:
            do{
                print(responseData)
                let response = try jsonDecoder.decode(FabricModel.self, from: responseData.data!)
                if response.status == true/*200*/{
                    // create session here
                    for i in 0..<(response.data!.count) {
                        if (response.data![i].type) == "Winter" {
                            winterCollection.append(response.data![i])
                        } else {
                            summerCollection.append(response.data![i])
                        }
                    }
                    
                } else if response.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(response.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
        case CUFFS:
            do{
                print(responseData)
                cuffsModel = try jsonDecoder.decode(CuffsModel.self, from: responseData.data!)
                if cuffsModel?.status == true/*200*/{
                // create session here
                
                } else if cuffsModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(cuffsModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
        case COLLAR:
            do{
                print(responseData)
                collarModel = try jsonDecoder.decode(CollarModel.self, from: responseData.data!)
                if collarModel?.status == true/*200*/{
                // create session here
                
                } else if collarModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(collarModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
      
        case POCKET:
            do{
                print(responseData)
                pocketModel = try jsonDecoder.decode(PocketModel.self, from: responseData.data!)
                if pocketModel?.status == true/*200*/{
                // create session here
                } else if pocketModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(pocketModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
        
        case PLACKET:
            do{
                print(responseData)
                placketModel = try jsonDecoder.decode(PlacketModel.self, from: responseData.data!)
                if placketModel?.status == true/*200*/{
                // create session here
                
                } else if placketModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(placketModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
        
        case BUTTON:
            do{
                print(responseData)
                buttonModel = try jsonDecoder.decode(ButtonModel.self, from: responseData.data!)
                if buttonModel?.status == true/*200*/{
                // create session here
                
                } else if buttonModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(buttonModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
        
        default:
            break
        }
    }


    func onFailure(msg: String) {
        LoadingIndicatorView.hide()
        SnackBar().showSnackBar(view: self.view, text: "\(msg)", interval: 4)
    }

    func onError(error: AFError) {
        LoadingIndicatorView.hide()
        SnackBar().showSnackBar(view: self.view, text: "\(error)", interval: 4)
    }


}


//extension UIImageView {
//func downloadedsvg(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//    contentMode = mode
//    URLSession.shared.dataTask(with: url) { data, response, error in
//        guard
//            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//            let data = data, error == nil,
//            let receivedicon: SVGKImage = SVGKImage(data: data),
//            let image = receivedicon.uiImage
//            else { return }
//        DispatchQueue.main.async() {
//            self.image = image
//        }
//    }.resume()
//}
//}

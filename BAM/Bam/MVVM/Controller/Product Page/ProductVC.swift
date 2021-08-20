//
//  ProductVC.swift
//  Bam
//
//  Created by ADS N URL on 13/04/21.
//

import UIKit
import Alamofire


class ProductVC: UIViewController {
        
    //MARK: - Variables
    var headingStr = ""
    var categoryId = ""
    
    var productModel: ProductModel?
//    var pushModel: AddressDataModel?
    var apiHelper = ApiHelper()
    var GETPRODUCT = "-1"
    var userManager = UserManager.userManager
    
    //MARK:- IBOutlet Properties
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    
    
    //MARK:-  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLbl.text = headingStr
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }
    
    //MARK: - Helper Method
    func apiHit() {
        apiHelper.GetData(urlString: "\(kGetProducts)\(categoryId)", tag: GETPRODUCT)
    }
    
    //MARK: - IBAction
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
}

//MARK: Collectionview Methods
extension ProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.collectionView.bounds.size.width, height: self.collectionView.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()
        self.collectionView.backgroundView = messageLabel
        if productModel?.data?.count == 0 {
            messageLabel.text = "NO DATA FOUND"
        } else {
            messageLabel.text = ""
        }
        return productModel?.data?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
//        cell.cell_view.layer.borderColor = UIColor.lightGray.cgColor
//        cell.cell_view.layer.borderWidth = 0.3
        
        cornerRadius(viewName: cell.img_food, radius: 6.0)
        cornerRadius(viewName: cell.lbl_Price, radius: 6.0)
        cornerRadius(viewName: cell.btn_Favorites, radius: 6.0)
//            cornerRadius(viewName: cell.btn_Addtocart, radius: 6.0)
//            cornerRadius(viewName: cell.lbl_outofStock, radius: 10.0)
        let data = productModel?.data?[indexPath.row]
        let url = "\(data?.image ?? "")"
        cell.img_food.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.img_food.image = image
        }
        cell.lbl_Name.text = data?.title
        cell.lbl_Price.text = "SAR \(data?.cost ?? "0")"
//        \(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))
//            cell.btn_Favorites.tag = indexPath.row
//            cell.btn_Favorites.addTarget(self, action:#selector(btnTap_Favorites_Latest), for: .touchUpInside)
//            cell.btn_Addtocart.tag = indexPath.row
//            cell.btn_Addtocart.addTarget(self, action:#selector(btnTap_AddtoCart_Latest), for: .touchUpInside)
////            if data["isFavorite"]! == "0" {
////                cell.btn_Favorites.setImage(UIImage(systemName: "heart"), for: .normal)
////            }
////            else {
////                cell.btn_Favorites.setImage(UIImage(systemName: "heart.fill"), for: .normal)
////            }
//            print("", data["item_status"]!)
//            if (data["item_status"]! as NSString).integerValue > 0 {
//                cell.lbl_outofStock.isHidden = true
//                cell.btn_Addtocart.isEnabled = true
//                cell.btn_Favorites.isEnabled = true
//                cell.btn_Addtocart.backgroundColor = GREEN_COLOR
//            }
//            else {
//                cell.lbl_outofStock.isHidden = false
//                cell.btn_Addtocart.isEnabled = false
//                cell.btn_Addtocart.backgroundColor = UIColor.lightGray
//            }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 45.0) / 2, height: 215)
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
        vc.productId = productModel?.data?[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARk: - API Success
extension ProductVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case GETPRODUCT:
                do{
                    print(responseData)
                    productModel = try jsonDecoder.decode(ProductModel.self, from: responseData.data!)
                    if productModel?.status == true/*200*/{
                    // create session here
                        collectionView.delegate = self
                        collectionView.dataSource = self
                        collectionView.reloadData()
                    } else if productModel?.status == false {
                        LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(productModel?.message ?? "")", interval: 4)
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


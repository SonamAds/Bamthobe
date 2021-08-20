//
//  ProductDetailVC.swift
//  Bam
//
//  Created by ADS N URL on 22/03/21.
//

import UIKit
import ImageSlideshow
import Alamofire


class ProductDetailVC: UIViewController {
    
    //MARK: - Variables
    var cartAddValue = 0
    var productId = 0
    var productDetailModel: ProductDetailModelData?
    var apiHelper = ApiHelper()
    var GETPRODUCTDETAIL = "-1"
    var ADDTOCART = "0"
    var userManager = UserManager.userManager
    
    
    // MARK:- IBOutlets
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var image_Slider: ImageSlideshow!

    @IBOutlet weak var bottomView:UIView!
    @IBOutlet weak var cartValue:UILabel!
    @IBOutlet weak var cartPriceLbl:UILabel!
    @IBOutlet weak var cartBtn:UIButton!
    
    @IBOutlet weak var productBtn:UIButton!
    @IBOutlet weak var addCartValueTF:UITextField!
    @IBOutlet weak var plusBtn:UIButton!
    @IBOutlet weak var minusBtn:UIButton!
    @IBOutlet weak var customerReviewBtn:UIButton!
    @IBOutlet weak var productView:UIView!
    @IBOutlet weak var productNameLbl:UILabel!
    @IBOutlet weak var productPriceLbl:UILabel!
    @IBOutlet weak var productDescLbl:UILabel!
    @IBOutlet weak var productCustomerReviewLbl:UILabel!
    @IBOutlet weak var productCustomerRatingLbl:UILabel!
    
    @IBOutlet weak var brandSV:UIStackView!
    @IBOutlet weak var materialSV:UIStackView!
    @IBOutlet weak var categorySV:UIStackView!
    @IBOutlet weak var sizeSV:UIStackView!
    @IBOutlet weak var addView:UIView!
    
    @IBOutlet weak var detailBtn:UIButton!
    @IBOutlet weak var detailView:UIView!
    @IBOutlet weak var brandNameLbl:UILabel!
    @IBOutlet weak var categoryNameLbl:UILabel!
    @IBOutlet weak var detailDescLbl:UILabel!
    @IBOutlet weak var sizeLbl:UILabel!
    @IBOutlet weak var materialLbl:UILabel!
    
    @IBOutlet weak var reviewBtn:UIButton!
    @IBOutlet weak var reviewView:UIView!
    @IBOutlet weak var viewAllBtn:UIButton!
    @IBOutlet weak var tableView:UITableView!
        

    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.isHidden = true
        addView.layer.borderWidth = 1
        addView.layer.borderColor = AppUsedColors.appColor.cgColor
        apiHelper.responseDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiHit()
    }
    
    
    //MARK: - Helping Methods
    func imageSliderData() {
        var imageSource: [ImageSource] = []
        for i in 0..<(self.productDetailModel?.image!.count)! {
            let url = URL(string:(self.productDetailModel?.image?[i])!)
            if url != nil {
                let imV = UIImageView()
//                imV.downloaded(from: data)
//                let image = UIImage()
//                imV.downloaded(from: url!)// self.productDetailModel?.image?[i] ?? "")
                imV.sd_setImage(with: url/*URL(string: url)!*/, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    imV.image = image
                }
                imageSource.append(ImageSource(image: imV.image ?? #imageLiteral(resourceName: "header_bkg")))
            }
//               if let data = try? Data(contentsOf: url!) {
//                let image: UIImage = UIImage(data: data)!
//                imageSource.append(ImageSource(image:  image))
//               }
        }
        self.image_Slider.slideshowInterval = 3.0
        self.image_Slider.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: 10.0))
        self.image_Slider.contentScaleMode = UIView.ContentMode.scaleAspectFit
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.image_Slider.pageIndicator = pageControl
        self.image_Slider.setImageInputs(imageSource)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapImage))
        self.image_Slider.addGestureRecognizer(recognizer)
    }
    
    @objc func didTapImage() {
        self.image_Slider.presentFullScreenController(from: self)
    }
    
    //MARK: - API Method
    func apiHit() {
        apiHelper.GetData(urlString: "\(kProductDetails)\(productId)", tag: GETPRODUCTDETAIL)
    }
    
    func addToCartApiHit() {
        apiHelper.PostData(urlString: kAddCart, tag: ADDTOCART, params: ["product_id":"\(productId)", "quantity":addCartValueTF.text == "Add" ? 0 : addCartValueTF.text!, "type": "normal", "measurement": "", "measurement_type": "", "name": "", "mobile": "", "date": "", "branch": "", "address": "", "time": ""])
    }

    //MARK: Actions
    @IBAction func btnTap_back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTap_Product(_ sender: UIButton) {
        productBtn.backgroundColor = AppUsedColors.appColor
        productBtn.setTitleColor(UIColor.white, for: .normal)
        detailBtn.backgroundColor = UIColor.clear
        detailBtn.setTitleColor(UIColor.black, for: .normal)
        reviewBtn.backgroundColor = UIColor.clear
        reviewBtn.setTitleColor(UIColor.black, for: .normal)
        detailView.isHidden = true
        reviewView.isHidden = true
        productView.isHidden = false
    }
    
    @IBAction func btnTap_Details(_ sender: UIButton) {
        detailBtn.backgroundColor = AppUsedColors.appColor
        detailBtn.setTitleColor(UIColor.white, for: .normal)
        productBtn.backgroundColor = UIColor.clear
        productBtn.setTitleColor(UIColor.black, for: .normal)
        reviewBtn.backgroundColor = UIColor.clear
        reviewBtn.setTitleColor(UIColor.black, for: .normal)
        detailView.isHidden = false
        reviewView.isHidden = true
        productView.isHidden = true
    }
    
    @IBAction func btnTap_Review(_ sender: UIButton) {
        reviewBtn.backgroundColor = AppUsedColors.appColor
        reviewBtn.setTitleColor(UIColor.white, for: .normal)
        detailBtn.backgroundColor = UIColor.clear
        detailBtn.setTitleColor(UIColor.black, for: .normal)
        productBtn.backgroundColor = UIColor.clear
        productBtn.setTitleColor(UIColor.black, for: .normal)
        detailView.isHidden = true
        reviewView.isHidden = false
        productView.isHidden = true
    }
    
    @IBAction func btnTap_ViewAllReview(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        vc.productId = productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_CustomerReview(_ sender: UIButton) {
    }
        
    @IBAction func btnTap_AddCartValue(_ sender: UIButton) {
        if userManager.getApiToken() != "" {
            if productDetailModel?.is_measurement_required == "1" {
                var thobeDict = [String: String]()

                thobeDict["product_id"] = ""
                thobeDict["measurement_type"] = ""
                thobeDict["measurement"] = ""
                thobeDict["name"] = ""
                thobeDict["mobile"] = ""
                thobeDict["date"] = ""
                thobeDict["branch"] = ""
                thobeDict["address_id"] = ""
                thobeDict["time"] = ""
                thobeDict["product_id"] = "\(productId)"
                let vc = storyboard?.instantiateViewController(withIdentifier: "SavedMeasurementsVC") as! SavedMeasurementsVC
                vc.thobeDict = thobeDict
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
            if plusBtn.currentTitle == "Add" {
                plusBtn.setTitle("+", for: .normal)
                addCartValueTF.isHidden = false
                minusBtn.isHidden = false                
            }
            cartAddValue = cartAddValue + 1
            addCartValueTF.text = "\(cartAddValue)"
            addToCartApiHit()
            if cartAddValue != 0 {
                bottomView.isHidden = false
                let total = Int(productDetailModel?.cost ?? "")
                cartPriceLbl.text = "SAR \(total ?? 0 * cartAddValue)"
                cartValue.text = "\(cartAddValue)"
            } else {
                bottomView.isHidden = true
                cartPriceLbl.text = "SAR 00.00"
                cartValue.text = "0"
            }
            }
        } else {
            navigateToLogin()
        }

    }
    
    @IBAction func btnTap_MinusCartValue(_ sender: UIButton) {
        if userManager.getApiToken() != "" {
            cartAddValue = cartAddValue - 1
            if cartAddValue != 0 {
                addCartValueTF.text = "\(cartAddValue)"
                bottomView.isHidden = false
                let total = Int((productDetailModel?.cost)!)
                cartPriceLbl.text = "SAR \(total ?? 0 * cartAddValue)"
                cartValue.text = "\(cartAddValue)"
            } else {
                addCartValueTF.isHidden = true
                minusBtn.isHidden = true
                plusBtn.setTitle("Add", for: .normal)
                cartAddValue = 0
                bottomView.isHidden = true
                cartPriceLbl.text = "SAR 00.00"
                cartValue.text = "0"
            }
            addToCartApiHit()
            
        } else {
            navigateToLogin()
        }
        
    }
    
    @IBAction func btnTap_AddToCart(_ sender: UIButton) {
        if userManager.getApiToken() != "" {
        
//        let currentIndex : Int? = self.tabBarController?.selectedIndex
//
//        self.tabBarController?.selectedIndex = 2
//
//        if let ramTBC =  self.tabBarController,
//            let current = currentIndex {
//            ramTBC.selectedIndex = 1
////            ramTBC.setSelectIndex(from: current, to: 2)
//        }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            mainTabBarController.selectedIndex = 1
            mainTabBarController.modalPresentationStyle = .fullScreen

            self.present(mainTabBarController, animated: true, completion: nil)
        } else {
            navigateToLogin()
        }
        
    }
}


//MARK: - UITableView Delegate and DataSource
extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
//        let messageLabel = UILabel(frame: rect)
//        messageLabel.textColor = UIColor.lightGray
//        messageLabel.numberOfLines = 0
//        messageLabel.textAlignment = .center
//        messageLabel.sizeToFit()
//        self.tableView.backgroundView = messageLabel;
//        if ongoingAppointmentModel?.data?.count == 0 || olderAppointmentModel?.data?.count == 0 {
//            messageLabel.text = "NO DATA FOUND"
//        } else {
//            messageLabel.text = ""
//        }
        if productDetailModel?.review?.count ?? 0 > 2 {
            return 2
        }
        return productDetailModel?.review?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTVCell", for: indexPath) as! ReviewTVCell
        let data = productDetailModel?.review?[indexPath.row]
//            let imgUrl = image_base_url + data["product_image"]! //["product_image"]!
        let url = "\(data?.image ?? "")"
        cell.userIV.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
            cell.userIV.image = image
        }
        cell.nameLbl.text = data?.name
        cell.dateLbl.text = data?.updated_at
        if Int(data?.star ?? "") == 5 {
            cell.ratingIV5.setTitleColor(UIColor.gray, for: .normal) //= UIColor.gray
            cell.ratingIV4.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 4 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 3 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 2 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.gray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else if Int(data?.star ?? "") == 1 {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.gray, for: .normal)
        } else {
            cell.ratingIV5.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV4.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV3.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV2.setTitleColor(UIColor.lightGray, for: .normal)
            cell.ratingIV1.setTitleColor(UIColor.lightGray, for: .normal)
        }
        return cell
    }
    
}


//MARk: - API Success
extension ProductDetailVC: ApiResponseDelegate {
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        LoadingIndicatorView.hide()
        switch tag {
            case GETPRODUCTDETAIL:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(ProductDetailModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                    // create session here
                        productDetailModel = response.data
//                        if productDetailModel?.is_measurement_required == "1" {
//
//                        }
                        imageSliderData()
                        productNameLbl.text = productDetailModel?.title
                        productDescLbl.text = productDetailModel?.description
                        productPriceLbl.text = "SAR \(productDetailModel?.cost ?? "0")"
                        detailDescLbl.text = productDetailModel?.description
                        sizeLbl.text = productDetailModel?.category_name
                        categoryNameLbl.text = productDetailModel?.category_name
//                        brandNameLbl.text = productDetailModel?.brand
//                        materialLbl.text = productDetailModel?.brand
                        tableView.delegate = self
                        tableView.dataSource = self
                        tableView.reloadData()
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
            case ADDTOCART:
                do{
                    print(responseData)
                    let response = try jsonDecoder.decode(AddtoCartModel.self, from: responseData.data!)
                    if response.status == true/*200*/{
                        // create session here
                        print("", response.message)
                    
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


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

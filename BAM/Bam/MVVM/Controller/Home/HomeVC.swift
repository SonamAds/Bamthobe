//
//  HomeVC.swift
//  Bam
//
//  Created by ADS N URL on 17/03/21.
//

import UIKit
import Alamofire
import SDWebImage

class HomeVC: UIViewController {
   
    // MARK:- Variables
    var catIdArr = [[String: String]]()
    var shawls = "0"
    var attars = "0"
    var cufflinks = "0"
    var modelsArray = [[ProductModelData]]()
    var categoryModel: CategoryModel?
    var bannerModel: BannerModel?
    var sliderModel: SliderModel?
    var apiHelper = ApiHelper()
    var GETPRODUCT = "-4"
    var GETCATEGORY = "-1"
    var GETSLIDER = "-3"
    var BANNER = "-2"
    var userManager = UserManager.userManager
    
    
    //MARK: Outlets
    @IBOutlet weak var page_control: UIPageControl!

    @IBOutlet weak var CollectioView_categoriesList: UICollectionView!
    @IBOutlet weak var collectionView_Banner: UICollectionView!
    @IBOutlet weak var collectioView_CustomizeThodeList: UICollectionView!
    @IBOutlet weak var collectioView_TrendingList: UICollectionView!
    @IBOutlet weak var collectioView_AccessoriesList: UICollectionView!
    @IBOutlet weak var collectioView_FeaturedProductList: UICollectionView!
    @IBOutlet weak var collectioView_AccessoriesFeaturedProductList: UICollectionView!
    @IBOutlet weak var collectioView_AttarsList: UICollectionView!
    
    @IBOutlet weak var customizethode_stack_Name: UIStackView!
    @IBOutlet weak var trendingproduct_stack_Name: UIStackView!
    @IBOutlet weak var accessories_stack_Name: UIStackView!
    @IBOutlet weak var featuredproduct_stack_Name: UIStackView!
    @IBOutlet weak var accessoriesfeaturedproduct_stack_Name: UIStackView!
    @IBOutlet weak var attars_stack_Name: UIStackView!

    @IBOutlet weak var lbl_Featured: UILabel!
    @IBOutlet weak var lbl_Trending: UILabel!
    @IBOutlet weak var lbl_FeaturedAccessories: UILabel!
    @IBOutlet weak var lbl_Attars: UILabel!

    @IBOutlet weak var customizethode_view_Btn: UIButton!
    @IBOutlet weak var trendingproduct_view_Btn: UIButton!
    @IBOutlet weak var accessories_view_Btn: UIButton!
    @IBOutlet weak var featuredproduct_view_Btn: UIButton!
    @IBOutlet weak var accessoriesfeaturedproduct_view_Btn: UIButton!
    @IBOutlet weak var attars_view_Btn: UIButton!
    @IBOutlet weak var categories_view_Btn: UIButton!
    
    @IBOutlet weak var btn_sideMenu: UIButton!
    @IBOutlet weak var btn_notification: UIButton!
    @IBOutlet weak var btn_search: UIButton!
    
    @IBOutlet weak var btn_Cart: UIButton!
//    @IBOutlet weak var lbl_titleName: UILabel!
//    @IBOutlet weak var lbl_CartCount: UILabel!
    @IBOutlet weak var banner_Height: NSLayoutConstraint!
//    @IBOutlet weak var lbl_TotalCartPrice: UILabel!
//    @IBOutlet weak var lbl_Cartcount: UILabel!
//    @IBOutlet weak var gotoCart_View: UIView!
//    @IBOutlet weak var goToCart_ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btn_Locations: UIButton!


    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        apiHelper.responseDelegate = self

//        self.banner_Height.constant = 0.0
//        self.gotoCart_View.isHidden = true
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            self.gotoCart_View.isHidden = true
//            self.goToCart_ViewHeight.constant = 0.0
//            self.lbl_titleName.text = "Welcome to,\n\("Hii5 Grocer App")."
//        }
//        else {
//            self.lbl_titleName.text = "Hello,\n\(UserDefaultManager.getStringFromUserDefaults(key: UD_userName))"
//        }
//        self.collectioView_GirdList.refreshControl = self.refreshControl
//        self.refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
//        cornerRadius(viewName: self.lbl_CartCount, radius: self.lbl_CartCount.frame.height / 2)
//        cornerRadius(viewName: self.lbl_Cartcount, radius: self.lbl_Cartcount.frame.height / 2)
//        cornerRadius(viewName: self.btn_Cart, radius: 6.0)
//        cornerRadius(viewName: self.btn_Locations, radius: 6.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        apiCategoryHit()
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            appDelegate.makeRootViewController()
//        }
    }
  
    
    //MARK: - Helper Method
    func apiCategoryHit() {
        apiHelper.GetData(urlString: kGetCategory, tag: GETCATEGORY)
    }
    
    func apiSliderHit() {
        apiHelper.GetData(urlString: KGetSlider, tag: GETSLIDER)
    }
    
    func apiBannerHit() {
        apiHelper.GetData(urlString: kGetBanner, tag: BANNER)
    }

}


//MARK: Actions
extension HomeVC {
    @IBAction func btnTap_Search(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductSearchVC") as! ProductSearchVC
        self.navigationController?.pushViewController(vc, animated:false)
    }
    
    @IBAction func btnTap_Notification(_ sender: UIButton) {
        if userManager.getApiToken() == "" {
            navigateToLogin()
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated:true)
        }
    }
   
    @IBAction func btnTap_CustomizeThodeViewAll(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CustomizeThodeVC") as! CustomizeThodeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnTap_TrendingViewAll(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        vc.categoryId = catIdArr[1]["id"] ?? ""
        vc.headingStr = catIdArr[1]["name"] ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnTap_AccessoriesViewAll(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewAllVC") as! ViewAllVC
//        vc.isSelected = "2"
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnTap_FeaturedViewAll(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        vc.categoryId = catIdArr[0]["id"] ?? ""
        vc.headingStr = catIdArr[0]["name"] ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnTap_AccessoriesFeaturedViewAll(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        vc.categoryId = catIdArr[2]["id"] ?? ""
        vc.headingStr = catIdArr[2]["name"] ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTap_AttarsViewAll(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        vc.categoryId = catIdArr[3]["id"] ?? ""
        vc.headingStr = catIdArr[3]["name"] ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func btnTap_CategoriesViewAll(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(identifier: "CategoriesVC") as! CategoriesVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }

//    @IBAction func btnTap_Cart(_ sender: UIButton) {
////        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
////            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
////            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
////            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
////            appNavigation.setNavigationBarHidden(true, animated: true)
////            UIApplication.shared.windows[0].rootViewController = appNavigation
////        }
////        else {
////            let vc = self.storyboard?.instantiateViewController(identifier: "AddtoCartVC") as! AddtoCartVC
////            self.navigationController?.pushViewController(vc, animated:true)
////        }
//    }
//
//    @IBAction func btnTap_GotoCart(_ sender: UIButton) {
////        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
////            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
////            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
////            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
////            appNavigation.setNavigationBarHidden(true, animated: true)
////            UIApplication.shared.windows[0].rootViewController = appNavigation
////        }
////        else {
////            let vc = self.storyboard?.instantiateViewController(identifier: "AddtoCartVC") as! AddtoCartVC
////            self.navigationController?.pushViewController(vc, animated:true)
////        }
//    }

}

//MARK: Collectionview Methods
extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.CollectioView_categoriesList {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.CollectioView_categoriesList.bounds.size.width, height: self.CollectioView_categoriesList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.CollectioView_categoriesList.backgroundView = messageLabel;
            if categoryModel?.data?.count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            }
            else {
                messageLabel.text = ""
            }
            return categoryModel?.data?.count ?? 0
      
        } else if collectionView == self.collectioView_FeaturedProductList {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.collectioView_FeaturedProductList.bounds.size.width, height: self.collectioView_FeaturedProductList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.collectioView_FeaturedProductList.backgroundView = messageLabel;
            if self.modelsArray[0].count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            }
            else {
                messageLabel.text = ""
            }
            return modelsArray[0].count

        } else if collectionView == self.collectioView_TrendingList{
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.collectioView_TrendingList.bounds.size.width, height: self.collectioView_TrendingList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.collectioView_TrendingList.backgroundView = messageLabel;
            if self.modelsArray[1].count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            }
            else {
                    messageLabel.text = ""
            }
            return modelsArray[1].count
            
        } else if collectionView == self.collectioView_AccessoriesFeaturedProductList {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.collectioView_AccessoriesFeaturedProductList.bounds.size.width, height: self.collectioView_AccessoriesFeaturedProductList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.collectioView_AccessoriesFeaturedProductList.backgroundView = messageLabel;
            if self.modelsArray[2]/*modelsArray[2]*/.count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            }
            else {
                messageLabel.text = ""
            }
            return modelsArray[2].count// ?? 0
            
        } else if collectionView == self.collectioView_AttarsList {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.collectioView_AttarsList.bounds.size.width, height: self.collectioView_AttarsList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.collectioView_AttarsList.backgroundView = messageLabel;
            if self.modelsArray[3]/*modelsArray[3]*/.count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            }
            else {
                messageLabel.text = ""
            }
            return modelsArray[3].count

        } else if collectionView == self.collectioView_CustomizeThodeList {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.collectioView_CustomizeThodeList.bounds.size.width, height: self.collectioView_CustomizeThodeList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.collectioView_CustomizeThodeList.backgroundView = messageLabel;
            if self.bannerModel?.data?.count == 0 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            }
            else {
                messageLabel.text = ""
            }
            return 1
            
        } else if collectionView == self.collectioView_AccessoriesList {
            let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.collectioView_AccessoriesList.bounds.size.width, height: self.collectioView_AccessoriesList.bounds.size.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.textColor = UIColor.lightGray
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            self.collectioView_AccessoriesList.backgroundView = messageLabel;
            if self.bannerModel?.data?.count ?? 0 < 3 {
                messageLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NO DATA FOUND", comment: "")
            }
            else {
                messageLabel.text = ""
            }
            return 1
        }
        else {
            self.page_control.numberOfPages = sliderModel?.data?.count ?? 0
            return sliderModel?.data?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.CollectioView_categoriesList {
            let cell = self.CollectioView_categoriesList.dequeueReusableCell(withReuseIdentifier: "Categoriescell", for: indexPath) as! Categoriescell
            cell.lbl_CategoriesName.text = categoryModel?.data?[indexPath.row].category_name
            cornerRadius(viewName: cell.cell_view, radius: 6.0)
            cornerRadius(viewName: cell.img_categories, radius: 4.0)
            let url = "\(categoryModel?.data?[indexPath.row].image ?? "")"
            cell.img_categories.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.img_categories.image = image
            }
            return cell
        
        } else if collectionView == self.collectioView_FeaturedProductList || collectionView == self.collectioView_TrendingList || collectionView == self.collectioView_AccessoriesFeaturedProductList || collectionView == self.collectioView_AttarsList {
            let cell = self.collectioView_FeaturedProductList.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as! GridCell
            cornerRadius(viewName: cell.img_food, radius: 6.0)
            cornerRadius(viewName: cell.lbl_Price, radius: 6.0)
            cornerRadius(viewName: cell.btn_Favorites, radius: 6.0)
            cornerRadius(viewName: cell.btn_Addtocart, radius: 6.0)
            cornerRadius(viewName: cell.lbl_outofStock, radius: 10.0)
            
            if collectionView == self.collectioView_FeaturedProductList {
                let data = modelsArray[0][indexPath.row]
                let imgUrl = data.image ?? ""
                cell.img_food.sd_setImage(with: URL(string: imgUrl)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    cell.img_food.image = image
                    cell.img_food.contentMode = .scaleToFill
                }
                cell.lbl_weight.text = data.description
                cell.lbl_Name.text = data.title
                cell.lbl_Price.text = "SAR \(data.cost ?? "0")"

            } else if collectionView == self.collectioView_TrendingList {
                let data = modelsArray[1][indexPath.row]
                let imgUrl = data.image ?? ""
                cell.img_food.sd_setImage(with: URL(string: imgUrl)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    cell.img_food.image = image
                    cell.img_food.contentMode = .scaleToFill
                }
                cell.lbl_weight.text = data.description
                cell.lbl_Name.text = data.title
                cell.lbl_Price.text = "SAR \(data.cost ?? "0")"

            } else if collectionView == self.collectioView_AccessoriesFeaturedProductList {
                let data = modelsArray[2][indexPath.row]
                let imgUrl = data.image ?? ""
                cell.img_food.sd_setImage(with: URL(string: imgUrl)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    cell.img_food.image = image
                    cell.img_food.contentMode = .scaleToFill
                }
                cell.lbl_weight.text = data.description
                cell.lbl_Name.text = data.title
                cell.lbl_Price.text = "SAR \(data.cost ?? "0")"
           
            } else {
                let data = modelsArray[3][indexPath.row]
                let imgUrl = data.image ?? ""
                cell.img_food.sd_setImage(with: URL(string: imgUrl)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                    cell.img_food.image = image
                    cell.img_food.contentMode = .scaleToFill
                }
                cell.lbl_weight.text = data.description
                cell.lbl_Name.text = data.title
                cell.lbl_Price.text = "SAR \(data.cost ?? "0")"

            }
            
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
      
        } else if collectionView == self.collectioView_CustomizeThodeList {
            let cell = self.collectioView_CustomizeThodeList.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            let url = "\(bannerModel?.data?[0].image ?? "")"
            cell.img_Banner.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.img_Banner.image = image
            }
            cornerRadius(viewName: cell.img_Banner, radius: 6.0)
            return cell
            
        } else if collectionView == self.collectioView_AccessoriesList {
            let cell = self.collectioView_AccessoriesList.dequeueReusableCell(withReuseIdentifier: "AccessoriesCell", for: indexPath) as! AccessoriesCell
            let url = "\(bannerModel?.data?[2].image ?? "")"
            cell.img_Banner.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.img_Banner.image = image
            }
            cornerRadius(viewName: cell.img_Banner, radius: 6.0)
            return cell
        }
        else {
            let cell = self.collectionView_Banner.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
            let url = "\(sliderModel?.data?[indexPath.row].mobile_image ?? sliderModel?.data?[indexPath.row].image ?? "")"
            if url != "" {
            cell.img_Banner.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.img_Banner.image = image
            }
            }
//            cell.lbl_Name.text = sliderModel?.data?[indexPath.row].main_title
//            cell.lbl_Descrptn.text = sliderModel?.data?[indexPath.row].sub_title
            cornerRadius(viewName: cell.img_Banner, radius: 6.0)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if collectionView == self.CollectioView_categoriesList{
            return CGSize(width: 80, height: 80)
        }
        else if collectionView == self.collectioView_FeaturedProductList || collectionView == self.collectioView_AccessoriesFeaturedProductList || collectionView == self.collectioView_TrendingList || collectionView == self.collectioView_AttarsList {
            return CGSize(width: (UIScreen.main.bounds.width - 30.0) / 2, height: 215)
        }
        else {
            if collectionView == collectionView_Banner {
                if sliderModel?.data?.count == 1 {
                return CGSize(width: (UIScreen.main.bounds.width - 30.0), height: 160)
                } else {
                    return CGSize(width: (UIScreen.main.bounds.width - 16) / 1.1, height: 160)
                }
            }
            return CGSize(width: (UIScreen.main.bounds.width - 30.0), height: 160)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt
        indexPath: IndexPath) {
        if collectionView == collectionView_Banner {
            page_control.currentPage = indexPath.row
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.CollectioView_categoriesList {
            if categoryModel?.data?[indexPath.row].type == "special" {
                if userManager.getApiToken() != nil {
                let vc = storyboard?.instantiateViewController(withIdentifier: "CustomizeThodeVC") as! CustomizeThodeVC
                self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    navigateToLogin()
                }
//            } else if categoryModel?.data?[indexPath.row].type == "Design Your Thobe" {
                
            } else if categoryModel?.data?[indexPath.row].type == "gift" {
                if userManager.getApiToken() != nil {
                let vc = storyboard?.instantiateViewController(withIdentifier: "GiftListVC") as! GiftListVC
                self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    navigateToLogin()
                }
            } else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
                vc.categoryId = "\(categoryModel?.data?[indexPath.row].id ?? 0)"
                vc.headingStr = categoryModel?.data?[indexPath.row].category_name ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } else if collectionView == self.collectioView_FeaturedProductList || collectionView == self.collectioView_TrendingList || collectionView == self.collectioView_AccessoriesFeaturedProductList || collectionView == self.collectioView_AttarsList {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
            if collectionView == self.collectioView_FeaturedProductList {
                vc.categoryId = catIdArr[0]["id"] ?? ""
                vc.headingStr = catIdArr[0]["name"] ?? ""
            } else if collectionView == self.collectioView_TrendingList {
                vc.categoryId = catIdArr[1]["id"] ?? ""
                vc.headingStr = catIdArr[1]["name"] ?? ""
            } else if collectionView == self.collectioView_AccessoriesFeaturedProductList{
                vc.categoryId = catIdArr[2]["id"] ?? ""
                vc.headingStr = catIdArr[2]["name"] ?? ""
            } else {
                vc.categoryId = catIdArr[3]["id"] ?? ""
                vc.headingStr = catIdArr[3]["name"] ?? ""
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == collectioView_CustomizeThodeList {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CustomizeThodeVC") as! CustomizeThodeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
            
    }
}


//MARk: - API Success
extension HomeVC: ApiResponseDelegate{
     func onSuccess(responseData: AFDataResponse<Any>, tag: String) {
        let jsonDecoder = JSONDecoder()
        
        switch tag {
            case GETCATEGORY:
                do{
                    print(responseData)
                    categoryModel = try jsonDecoder.decode(CategoryModel.self, from: responseData.data!)
                    apiSliderHit()
                    if categoryModel?.status == true/*200*/{
                    // create session here
                        if categoryModel?.data?.count != 0 {
                            for model in categoryModel?.data ?? [] {
                                if model.type == "normal" || model.type == "model" {
                                    let data = ["id": "\(model.id ?? 0)", "name": model.category_name ?? ""] as [String : String]
                                    catIdArr.append(data)
                                }
                            }
                        }
                        CollectioView_categoriesList.delegate = self
                        CollectioView_categoriesList.dataSource = self
                        CollectioView_categoriesList.reloadData()
                    } else if categoryModel?.status == false {
                        LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(categoryModel?.message ?? "")", interval: 4)
                    }
                }catch let error as NSError{
                    LoadingIndicatorView.hide()
                    print(error.localizedDescription)
                    SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
                }
                break
                
        case GETSLIDER:
            do{
                print(responseData)
                sliderModel = try jsonDecoder.decode(SliderModel.self, from: responseData.data!)
                apiBannerHit()
                if sliderModel?.status == true/*200*/{
                // create session here
                    collectionView_Banner.delegate = self
                    collectionView_Banner.dataSource = self
                    collectionView_Banner.reloadData()
                } else if sliderModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(sliderModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
        case BANNER:
            do{
                print(responseData)
                bannerModel = try jsonDecoder.decode(BannerModel.self, from: responseData.data!)
                if bannerModel?.status == true/*200*/{
                // create session here
                    LoadingIndicatorView.hide()
                    collectioView_CustomizeThodeList.delegate = self
                    collectioView_AccessoriesList.delegate = self
                    collectioView_AccessoriesList.dataSource = self
                    collectioView_CustomizeThodeList.dataSource = self
                    collectioView_CustomizeThodeList.reloadData()
                    collectioView_AccessoriesList.reloadData()
//                    catId = 6
//                    apiCufflinksHit()
                    for i in 0..<catIdArr.count {

                        if i == 0 {
                            lbl_Featured.text = catIdArr[i]["name"]
                            
                        } else if i == 1 {
                            lbl_Trending.text = catIdArr[i]["name"]
                            cufflinks = catIdArr[i]["id"] ?? "0"
                        } else if i == 3 {
                            lbl_Attars.text = catIdArr[i]["name"]
                            attars = catIdArr[i]["id"] ?? "0"
                        } else if i == 2 {
                            lbl_FeaturedAccessories.text = catIdArr[i]["name"]
                            shawls = catIdArr[i]["id"] ?? "0"
                        }
                        apiHelper.GetData(urlString: "\(kGetProducts)\(catIdArr[i]["id"] ?? "")", tag: GETPRODUCT)
                    }
                    
                } else if bannerModel?.status == false {
                    LoadingIndicatorView.hide()
                    SnackBar().showSnackBar(view: self.view, text: "\(bannerModel?.message ?? "")", interval: 4)
                }
            }catch let error as NSError{
                LoadingIndicatorView.hide()
                print(error.localizedDescription)
                SnackBar().showSnackBar(view: self.view, text: "\(error.localizedDescription)", interval: 4)
            }
            break
            
        case GETPRODUCT:
            do{
//                print(responseData)
                let response = try jsonDecoder.decode(ProductModel.self, from: responseData.data!)
                LoadingIndicatorView.hide()
                if response.status == true/*200*/{
                    // create session here
                    let res = response.data
                    modelsArray.append(res!)
                    if catIdArr[1]["id"] == cufflinks && modelsArray.count == 2 { //String((res?[0].category_id)!) {

//                        modelsArray.insert(res!, at: 1)

                        collectioView_TrendingList.delegate = self
                        collectioView_TrendingList.dataSource = self
                        collectioView_TrendingList.reloadData()
                    } else if catIdArr[3]["id"] == attars && modelsArray.count == 4 { //String((res?[0].category_id)!) {
//                        modelsArray.insert(res!, at: 2)

                        collectioView_AttarsList.delegate = self
                        collectioView_AttarsList.dataSource = self
                        collectioView_AttarsList.reloadData()
                    } else if catIdArr[2]["id"] == shawls && modelsArray.count == 3 {
//                        modelsArray.insert(res!, at: 3)

                        collectioView_AccessoriesFeaturedProductList.delegate = self
                        collectioView_AccessoriesFeaturedProductList.dataSource = self
                        collectioView_AccessoriesFeaturedProductList.reloadData()
                    } else { //String((res?[0].category_id)!) {
                        //                    if lbl_Featured.text == catIdArr[0]["name"] {
                        //                        modelsArray.insert(res!, at: 0)
                                                collectioView_FeaturedProductList.delegate = self
                                                collectioView_FeaturedProductList.dataSource = self
                                                collectioView_FeaturedProductList.reloadData()
                        //                    } else if catIdArr[1]["id"] == String((res?[0].category_id)!) {
                                            }
                    print(modelsArray)

                
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
//        userManager.setlogin(login: false)
//        userManager.setApiToken(apiToken: "")
//        userManager.setImage(image: "")
//        userManager.setMobile(mobile: "")
//        userManager.setUserName(name: "")
//        userManager.setUserEmail(email: "")
//        navigateToLogin()
    }


}




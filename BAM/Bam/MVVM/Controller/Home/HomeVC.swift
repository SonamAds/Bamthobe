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
                messageLabel.text = "NO DATA FOUND"
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
                messageLabel.text = "NO DATA FOUND"
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
                    messageLabel.text = "NO DATA FOUND"
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
                messageLabel.text = "NO DATA FOUND"
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
                messageLabel.text = "NO DATA FOUND"
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
                messageLabel.text = "NO DATA FOUND"
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
                messageLabel.text = "NO DATA FOUND"
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
                let data = modelsArray[3][indexPath.row]// modelsArray[3][indexPath.row]
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
            let url = "\(sliderModel?.data?[indexPath.row].image ?? "")"
            cell.img_Banner.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (image, error, cacheType, url) in
                cell.img_Banner.image = image
            }
            cell.lbl_Name.text = sliderModel?.data?[indexPath.row].main_title
            cell.lbl_Descrptn.text = sliderModel?.data?[indexPath.row].sub_title
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
                                if model.type == "normal" {
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
                            
                        } else if i == 3 {
                            lbl_Attars.text = catIdArr[i]["name"]
                        } else if i == 2 {
                            lbl_FeaturedAccessories.text = catIdArr[i]["name"]
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
                    if catIdArr[0]["name"] == lbl_Featured.text { //String((res?[0].category_id)!) {
//                    if lbl_Featured.text == catIdArr[0]["name"] {
//                        modelsArray.insert(res!, at: 0)
                        collectioView_FeaturedProductList.delegate = self
                        collectioView_FeaturedProductList.dataSource = self
                        collectioView_FeaturedProductList.reloadData()
//                    } else if catIdArr[1]["id"] == String((res?[0].category_id)!) {
                    } else if catIdArr[1]["name"] == lbl_Trending.text { //String((res?[0].category_id)!) {

//                        modelsArray.insert(res!, at: 1)

                        collectioView_TrendingList.delegate = self
                        collectioView_TrendingList.dataSource = self
                        collectioView_TrendingList.reloadData()
                    } else if catIdArr[3]["name"] == lbl_Attars.text { //String((res?[0].category_id)!) {
//                        modelsArray.insert(res!, at: 2)

                        collectioView_AttarsList.delegate = self
                        collectioView_AttarsList.dataSource = self
                        collectioView_AttarsList.reloadData()
                    } else {
//                        modelsArray.insert(res!, at: 3)

                        collectioView_AccessoriesFeaturedProductList.delegate = self
                        collectioView_AccessoriesFeaturedProductList.dataSource = self
                        collectioView_AccessoriesFeaturedProductList.reloadData()
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



//
////MARK: Webservices
//extension HomeVC {
//    func Webservice_AddtoCart(url:String, params:NSDictionary,sender:UIButton!) -> Void {
//        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
//
//            if strErrorMessage.count != 0 {
//                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
//            }
//            else {
//                let responseCode = jsonResponse!["status"]//.stringValue
//                if responseCode == true/*"1"*/ {
//                    if self.isAddtoCartSelect == "1" {
//                        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.collectioView_GirdList)
//                        let indexPath = self.collectioView_GirdList.indexPathForItem(at: buttonPosition)
//                        let cell = self.collectioView_GirdList.cellForItem(at: indexPath!) as! GridCell
//                        let imageViewPosition : CGPoint = cell.img_food.convert(cell.img_food.bounds.origin, to: self.view)
//                        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.img_food.frame.size.width, height: cell.img_food.frame.size.height))
//                        imgViewTemp.image = cell.img_food.image
//                        self.animation(tempView: imgViewTemp)
//                    }
//                    else {
//                        let buttonPosition : CGPoint = sender.convert(sender.bounds.origin, to: self.collectioView_ExpolerList)
//                        let indexPath = self.collectioView_ExpolerList.indexPathForItem(at: buttonPosition)
//                        let cell = self.collectioView_ExpolerList.cellForItem(at: indexPath!) as! GridCell
//                        let imageViewPosition : CGPoint = cell.img_food.convert(cell.img_food.bounds.origin, to: self.view)
//                        let imgViewTemp = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.img_food.frame.size.width, height: cell.img_food.frame.size.height))
//                        imgViewTemp.image = cell.img_food.image
//                        self.animation(tempView: imgViewTemp)
//                    }
//                }
//                else {
//                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
//                }
//            }
//        }
//    }
//
//    func Webservice_cartcount(url:String, params:NSDictionary) -> Void {
//        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "POST", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
//
//            if strErrorMessage.count != 0 {
//                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
//            }
//            else {
//                let responseCode = jsonResponse!["status"]//.stringValue
//                if responseCode == true/*"1"*/ {
//                    self.lbl_CartCount.isHidden = false
//                    let responceCart = jsonResponse!//["catlist"].dictionaryValue
//                    self.lbl_Cartcount.text = responceCart["quty"/*"cartcount"*/].stringValue
//                    self.lbl_CartCount.text = responceCart["quty"/*"cartcount"*/].stringValue
//                    let ItemPrice = formatter.string(for: responceCart["price"].stringValue.toDouble)
//                    self.lbl_TotalCartPrice.text = "\(rupee)\(ItemPrice!)"//(UserDefaultManager.getStringFromUserDefaults(key: UD_currency))
//                    if responceCart["quty"/*"cartcount"*/].stringValue == "0" || responceCart["quty"/*"cartcount"*/].stringValue == "" {
//                        self.gotoCart_View.isHidden = true
//                        self.goToCart_ViewHeight.constant = 0.0
//                    }
//                    else {
//                        self.gotoCart_View.isHidden = false
//                        self.goToCart_ViewHeight.constant = 50.0
//                    }
//                }
//                else {
//                    self.lbl_CartCount.isHidden = false
//                    self.lbl_CartCount.text = "0"
//                }
//            }
//        }
//    }
//
//
//    func Webservice_getrestaurantslocation(url:String, params:NSDictionary) -> Void {
////        WebServices().CallGlobalAPI(url: url, headers: [:], parameters:params, httpMethod: "GET", progressView:true, uiView:self.view, networkAlert: true) {(_ jsonResponse:JSON? , _ strErrorMessage:String) in
////            if strErrorMessage.count != 0 {
////                showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: strErrorMessage)
////            }
////            else {
////                let responseCode = jsonResponse!["status"].stringValue
////                if responseCode == "1" {
////                    let responseData = jsonResponse!["data"].dictionaryValue
////                    self.latitued = responseData["lat"]!.stringValue
////                    self.longitude = responseData["lang"]!.stringValue
////                    self.openMapForPlace()
////                }
////                else {
////                    showAlertMessage(titleStr: Bundle.main.displayName!, messageStr: jsonResponse!["message"].stringValue)
////                }
////            }
////        }
//    }
//}


//MARK: Functions
//extension HomeVC {
//    func openMapForPlace() {
//        let latitude: CLLocationDegrees = Double(self.latitued)!
//        let longitude: CLLocationDegrees = Double(self.longitude)!
//        let regionDistance:CLLocationDistance = 5000
//        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
//        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//                       MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
//        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "Store Location"
//        mapItem.openInMaps(launchOptions: options)
//    }
//
//    @objc private func refreshData(_ sender: Any) {
//        self.refreshControl.endRefreshing()
//        self.pageIndex = 1
//        self.lastIndex = 0
//        let urlString = API_URL + "catlist"
//        self.Webservice_getCategory(url: urlString, params: [:])
//    }
//
//    @objc func btnTap_Favorites_Latest(sender:UIButton!) {
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
//            appNavigation.setNavigationBarHidden(true, animated: true)
//            UIApplication.shared.windows[0].rootViewController = appNavigation
//        }
//        else {
//            if self.LatestitemArray[sender.tag]["isFavorite"]! == "0" {
//                self.isFavoriteSelect = "1"
//                let urlString = API_URL + "addfavorite"
//                let params: NSDictionary = ["user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),"token":UserDefaultManager.getStringFromUserDefaults(key: UD_token),"item_id":self.LatestitemArray[sender.tag]["id"]!]
//                self.Webservice_FavoriteItems(url: urlString, params: params, productIndex: sender.tag)
//            }
//        }
//    }
//
//    @objc func btnTap_Favorites_Exploer(sender:UIButton!) {
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
//            appNavigation.setNavigationBarHidden(true, animated: true)
//            UIApplication.shared.windows[0].rootViewController = appNavigation
//        }
//        else {
//            if self.exploreItemArray[sender.tag]["isFavorite"]! == "0" {
//                self.isFavoriteSelect = "2"
//                let urlString = API_URL + "addfavorite"
//                let params: NSDictionary = ["user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),"token":UserDefaultManager.getStringFromUserDefaults(key: UD_token),"item_id":self.exploreItemArray[sender.tag]["id"]!]
//                self.Webservice_FavoriteItems(url: urlString, params: params, productIndex: sender.tag)
//            }
//        }
//    }
//
//    @objc func btnTap_AddtoCart_Latest(sender:UIButton!) {
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
//            appNavigation.setNavigationBarHidden(true, animated: true)
//            UIApplication.shared.windows[0].rootViewController = appNavigation
//        }
//        else {
//            self.isAddtoCartSelect = "1"
//            let data = self.LatestitemArray[sender.tag]
//            let urlString = API_URL + "add_cart"//"cart"
//            let params: NSDictionary = ["product_id":data["id"]!,
//                                        "quty":"1",
//                                        "price":data["item_price"]!.replacingOccurrences(of: ",", with: ""),
//                                        "user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),
//                                        "token":UserDefaultManager.getStringFromUserDefaults(key: UD_token)]
//            self.Webservice_AddtoCart(url: urlString, params:params, sender: sender)
//        }
//    }
//
//    @objc func btnTap_AddtoCart_Exploer(sender:UIButton!) {
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
//            appNavigation.setNavigationBarHidden(true, animated: true)
//            UIApplication.shared.windows[0].rootViewController = appNavigation
//        }
//        else {
//            self.isAddtoCartSelect = "2"
//            let data = self.exploreItemArray[sender.tag]
//            let urlString = API_URL + "add_cart"//"cart"
//            let params: NSDictionary = ["product_id":data["id"]!,
//                                        "quty":"1",
//                                        "price":data["item_price"]!.replacingOccurrences(of: ",", with: ""),
//                                        "user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),
//                                        "token":UserDefaultManager.getStringFromUserDefaults(key: UD_token)]
//            self.Webservice_AddtoCart(url: urlString, params:params, sender: sender)
//        }
//    }
//
//    @objc func btnTap_AddtoCart_BestSelling(sender:UIButton!) {
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
//            appNavigation.setNavigationBarHidden(true, animated: true)
//            UIApplication.shared.windows[0].rootViewController = appNavigation
//        }
//        else {
//            self.isAddtoCartSelect = "2"
//            let data = self.bestSellingItemArray[sender.tag]
//            let urlString = API_URL + "add_cart"//"cart"
//            let params: NSDictionary = ["product_id":data["id"]!,
//                                        "quty":"1",
//                                        "price":data["item_price"]!.replacingOccurrences(of: ",", with: ""),
//                                        "user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),
//                                        "token":UserDefaultManager.getStringFromUserDefaults(key: UD_token)]
//            self.Webservice_AddtoCart(url: urlString, params:params, sender: sender)
//        }
//    }
//
//    @objc func btnTap_AddtoCart_TopProduct(sender:UIButton!) {
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
//            appNavigation.setNavigationBarHidden(true, animated: true)
//            UIApplication.shared.windows[0].rootViewController = appNavigation
//        }
//        else {
//            self.isAddtoCartSelect = "2"
//            let data = self.topItemArray[sender.tag]
//            let urlString = API_URL + "add_cart"//"cart"
//            let params: NSDictionary = ["product_id":data["id"]!,
//                                        "quty":"1",
//                                        "price":data["item_price"]!.replacingOccurrences(of: ",", with: ""),
//                                        "user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),
//                                        "token":UserDefaultManager.getStringFromUserDefaults(key: UD_token)]
//            self.Webservice_AddtoCart(url: urlString, params:params, sender: sender)
//        }
//    }
//
//    @objc func btnTap_AddtoCart_Previous(sender:UIButton!) {
//        if UserDefaultManager.getStringFromUserDefaults(key: UD_userId) == "" {
//            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//            let objVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
//            let appNavigation: UINavigationController = UINavigationController(rootViewController: objVC)
//            appNavigation.setNavigationBarHidden(true, animated: true)
//            UIApplication.shared.windows[0].rootViewController = appNavigation
//        }
//        else {
//            self.isAddtoCartSelect = "2"
//            let data = self.previousItemArray[sender.tag]
//            let urlString = API_URL + "add_cart"//"cart"
//            let params: NSDictionary = ["product_id":data["id"]!,
//                                        "quty":"1",
//                                        "price":data["item_price"]!.replacingOccurrences(of: ",", with: ""),
//                                        "user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId),
//                                        "token":UserDefaultManager.getStringFromUserDefaults(key: UD_token)]
//            self.Webservice_AddtoCart(url: urlString, params:params, sender: sender)
//        }
//    }
//
//    func animation(tempView : UIView)  {
//        self.view.addSubview(tempView)
//        UIView.animate(withDuration: 1.0,
//                       animations: {
//                        tempView.animationZoom(scaleX: 1.3, y: 1.3)
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.5, animations: {
//                tempView.animationZoom(scaleX: 0.2, y: 0.2)
//                tempView.animationRoted(angle: CGFloat(Double.pi))
//                tempView.frame.origin.x = self.btn_Cart.frame.origin.x
//                tempView.frame.origin.y = self.btn_Cart.frame.origin.y
//            }, completion: { _ in
//                tempView.removeFromSuperview()
//                UIView.animate(withDuration: 1.0, animations: {
//                    let urlString = API_URL + "cart_count"//"cartcount"
//                    let params: NSDictionary = ["user_id":UserDefaultManager.getStringFromUserDefaults(key: UD_userId), "token":UserDefaultManager.getStringFromUserDefaults(key: UD_token)]
//                    self.Webservice_cartcount(url: urlString, params:params)
//                    self.btn_Cart.animationZoom(scaleX: 1.1, y: 1.1)
//                }, completion: {_ in
//                    self.btn_Cart.animationZoom(scaleX: 1.0, y: 1.0)
//                })
//            })
//        })
//    }
//}

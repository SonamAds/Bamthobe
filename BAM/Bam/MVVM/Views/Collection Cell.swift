//
//  Collection Cell.swift
//  Bam
//
//  Created by ADS N URL on 17/03/21.
//

import UIKit


@objc protocol ThodeDetailDelegate {
    func didTap(row: Int, selectedThobe: Int)
}

//MARK: Banner Collection cell
class BannerCell: UICollectionViewCell {
    //MARK: - IBOutlet Properties
    @IBOutlet weak var img_Banner: UIImageView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Descrptn: UILabel!
    @IBOutlet weak var designOwn: UIButton!

}

class CustomizeThobeCell: UICollectionViewCell {
    //MARK: - IBOutlet Properties
    @IBOutlet weak var img_Banner: UIImageView!
//    @IBOutlet weak var lbl_Name: UILabel!
//    @IBOutlet weak var lbl_Descrptn: UILabel!
    @IBOutlet weak var designOwn: UIButton!
}

class AccessoriesCell: UICollectionViewCell {
    //MARK: - IBOutlet Properties
    @IBOutlet weak var img_Banner: UIImageView!
//    @IBOutlet weak var lbl_Name: UILabel!
//    @IBOutlet weak var lbl_Descrptn: UILabel!
//    @IBOutlet weak var designOwn: UIButton!
    @IBOutlet weak var accessoriesLbl: UILabel!

}

//MARK: Category Collection cell
class Categoriescell: UICollectionViewCell {
    //MARK: - IBOutlet Properties
//    @IBOutlet weak var cell_image_view: CardViewMaster!
    @IBOutlet weak var cell_view: UIView!
    @IBOutlet weak var img_categories: UIImageView!
    @IBOutlet weak var lbl_CategoriesName: UILabel!
}



//MARK: Product Collection cell
class GridCell: UICollectionViewCell {
    //MARK: - IBOutlet Properties
    @IBOutlet weak var lbl_outofStock: UILabel!
    @IBOutlet weak var lbl_weight: UILabel!
    @IBOutlet weak var cell_imge_view: CornerView!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var img_food: UIImageView!
    @IBOutlet weak var cell_view: CardViewMaster!
    @IBOutlet weak var btn_Favorites: UIButton!
    @IBOutlet weak var btn_Addtocart: UIButton!
}


//MARK: Thode Collection cell
class ThodeCell: UICollectionViewCell {
    
    var delegate: ThodeDetailDelegate?
    
    //MARK: - IBOutlet Properties
    @IBOutlet weak var customizeThodeIV: UIImageView!
    @IBOutlet weak var tickIV: UIImageView!
    @IBOutlet weak var priceLbl: UIButton!
    @IBOutlet weak var viewFabricBtn: UIButton!
    @IBOutlet weak var colorLbl: UIButton!
    
    
    //MARK: - Intialization 
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.addViews()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.addViews()
    }


    func addViews(){
        let imageTap1 = UITapGestureRecognizer(target: self, action: #selector(self.gestureTap_Check))
        customizeThodeIV.addGestureRecognizer(imageTap1)
    }


    //MARK: - Actions
    @IBAction func btnTap_ViewDetail(_ sender: Any) {
        delegate?.didTap(row: viewFabricBtn.tag, selectedThobe: colorLbl.tag)
    }
    
    @objc func gestureTap_Check() {
        if tickIV.isHidden == true {
            tickIV.image = #imageLiteral(resourceName: "circle_tick")
            tickIV.isHidden = false
        } else {
            tickIV.image = nil
            tickIV.isHidden = true
        }
    }
    
}


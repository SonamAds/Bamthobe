//
//  Table Cell.swift
//  Bam
//
//  Created by ADS N URL on 18/03/21.
//

import UIKit

protocol CartProductDeleteDelegate {
    func deleteProduct(row: Int, section: Int)
    func changeQuantity(rows: Int, quantity: String, section: Int)
    func showDetails(rows: Int, section: Int)

}

//MARK: - Menu  Cell
class SideMenuCell: UITableViewCell {
    @IBOutlet weak var menuImg:UIImageView!
    @IBOutlet weak var menyTitleLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
          self.selectionStyle = .none
     }

}

//MARK: - Notification Cell
class NotificationTVCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var usrIV:UIImageView!
    @IBOutlet weak var descriptionLbl:UILabel!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var unreadBtn:UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
          self.selectionStyle = .none
     }

}

//MARK: - Address Cell
class AddressBookTVCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tickIV:UIImageView!
    @IBOutlet weak var descriptionLbl:UILabel!
    @IBOutlet weak var headingLbl:UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

}

//MARK: - Gift Cell
class GiftTVCell: UITableViewCell {
    
    //MARK: - Variables
    var delegate : CartProductDeleteDelegate?

    
    //MARK: - IBOutlets
    @IBOutlet weak var giftIV:UIImageView!
    @IBOutlet weak var descriptionLbl:UILabel!
    @IBOutlet weak var priceLbl:UILabel!
    @IBOutlet weak var createGiftBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

    //MARK: - Actions
    @IBAction func btnTap_CreatGift(_ sender: Any) {
        delegate?.showDetails(rows: createGiftBtn.tag, section: 0)
    }
    
}


//MARK: - Appointments Cell
class MyAppointmentsTVCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var bookingIdLbl:UILabel!
    @IBOutlet weak var storeNameLbl:UILabel!
    @IBOutlet weak var storeAddressLbl:UILabel!
    @IBOutlet weak var dateLbl:UILabel!
    @IBOutlet weak var visitLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
     }

    //MARK: - Actions
    @IBAction func btnTap_CreatGift(_ sender: Any) {
    }
    
}


//MARK: - Loyalty Points Cell
class LoyaltyPointsTVCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var bookingIdLbl:UILabel!
    @IBOutlet weak var pontsEarnedlbl:UILabel!
    @IBOutlet weak var dateLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }
    
}


//MARK: - Review Cell
class ReviewTVCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var userIV:UIImageView!
    @IBOutlet weak var ratingIV1:UIButton!
    @IBOutlet weak var ratingIV2:UIButton!
    @IBOutlet weak var ratingIV3:UIButton!
    @IBOutlet weak var ratingIV4:UIButton!
    @IBOutlet weak var ratingIV5:UIButton!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var descriptionLbl:UILabel!
    @IBOutlet weak var dateLbl:UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}


//MARK: - Review Cell
class MyOrderTVCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var userIV:UIImageView!
    @IBOutlet weak var orderIdSV:UIStackView!
    @IBOutlet weak var totalItemSV:UIStackView!
    @IBOutlet weak var priceSV:UIStackView!
    @IBOutlet weak var orderIdLbl:UIButton!
    @IBOutlet weak var totalItem:UILabel!
    @IBOutlet weak var totalItemLbl:UILabel!
    @IBOutlet weak var priceLbl:UILabel!
    @IBOutlet weak var descriptionLbl:UILabel!
    @IBOutlet weak var viewBtn:UIButton!
    @IBOutlet weak var View_Cell:UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    //MARK: - Actions
    @IBAction func btnTap_ViewDetail(_ sender: Any) {
    }
    
}


//MARK: - Measurement Cell
class SavedMeasurementTVCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var usrIV:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var tickIV:UIImageView!
    @IBOutlet weak var backgView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
          self.selectionStyle = .none
     }

}


//MARK: - Cart Cell
class CartTVCell: UITableViewCell {
    
    var deleteDelegate: CartProductDeleteDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var thodeView:UIView!
    @IBOutlet weak var thodeIV:UIImageView!
    @IBOutlet weak var thodeLbl:UILabel!
    @IBOutlet weak var thodeDescriptionLbl:UILabel!
    @IBOutlet weak var thodeQtyLbl:UILabel!
    @IBOutlet weak var thodeDeleteBtn:UIButton!
    @IBOutlet weak var thodePriceLbl:UILabel!
    @IBOutlet weak var thodeLessDetailBtn:UIButton!

    @IBOutlet weak var giftView:UIView!
    @IBOutlet weak var giftIV:UIImageView!
    @IBOutlet weak var giftLbl:UILabel!
    @IBOutlet weak var giftDescriptionLbl:UILabel!
    @IBOutlet weak var giftQtyLbl:UILabel!
    @IBOutlet weak var giftDeleteBtn:UIButton!
    @IBOutlet weak var giftPriceLbl:UILabel!
    
    @IBOutlet weak var priceView:UIView!
    @IBOutlet weak var customizedPriceLbl:UILabel!
    @IBOutlet weak var visitingChargePriceLbl:UILabel!
    @IBOutlet weak var advancePriceLbl:UILabel!
    @IBOutlet weak var remPriceLbl:UILabel!

    @IBOutlet weak var fabricPriceLbl:UILabel!
    @IBOutlet weak var collarPriceLbl:UILabel!
    @IBOutlet weak var cuffPriceLbl:UILabel!
    @IBOutlet weak var pocketPriceLbl:UILabel!
    @IBOutlet weak var placketPriceLbl:UILabel!
    @IBOutlet weak var buttonPriceLbl:UILabel!
    @IBOutlet weak var sidePocketPriceLbl:UILabel!
    @IBOutlet weak var fabricSV:UIStackView!
    @IBOutlet weak var collarSV:UIStackView!
    @IBOutlet weak var cuffSV:UIStackView!
    @IBOutlet weak var pocketSV:UIStackView!
    @IBOutlet weak var placketSV:UIStackView!
    @IBOutlet weak var buttonSV:UIStackView!
    @IBOutlet weak var sidePocketSV:UIStackView!
    
    @IBOutlet weak var subTotalPriceLbl:UILabel!

    @IBOutlet weak var addCartValueTF:UITextField!
    @IBOutlet weak var plusBtn:UIButton!
    @IBOutlet weak var minusBtn:UIButton!
    @IBOutlet weak var addView:UIView!
    @IBOutlet var View_Cell:[UIView]!
    
    
    @IBOutlet weak var lessDetailHeightConstraint:NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        plusBtn.layer.borderWidth = 1
        plusBtn.layer.borderColor = AppUsedColors.appColor.cgColor
        minusBtn.layer.borderWidth = 1
        minusBtn.layer.borderColor = AppUsedColors.appColor.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

    //MARK: - Actions
    @IBAction func btnTap_ThodeDelete(_ sender: Any) {
        deleteDelegate?.deleteProduct(row: thodeDeleteBtn.tag, section: thodeLbl.tag)
    }
    
    @IBAction func btnTap_GiftDelete(_ sender: Any) {
        deleteDelegate?.deleteProduct(row: giftDeleteBtn.tag, section: giftPriceLbl.tag)
    }
    
    @IBAction func btnTap_LessDetail(_ sender: Any) {
        deleteDelegate?.showDetails(rows: giftDeleteBtn.tag, section: giftPriceLbl.tag)
    }
    
    
    @IBAction func btnTap_AddCartValue(_ sender: UIButton) {
        let qty = Int(addCartValueTF.text!)
        minusBtn.isHidden = false
        
        if addCartValueTF.text == "Add" {
            addCartValueTF.text = "1"
        } else {
            addCartValueTF.text = "\(qty! + 1)"
        }
        
        deleteDelegate?.changeQuantity(rows: giftDeleteBtn.tag, quantity: addCartValueTF.text!, section: giftPriceLbl.tag)
    }
    
    @IBAction func btnTap_MinusCartValue(_ sender: UIButton) {
        let qty = Int(addCartValueTF.text!)
        if addCartValueTF.text == "1" {
            deleteDelegate?.deleteProduct(row: thodeDeleteBtn.tag, section: thodeLbl.tag)
//            addCartValueTF.text = "Add"
//            minusBtn.isHidden = true
        } else {
            addCartValueTF.text = "\(qty! - 1)"
            deleteDelegate?.changeQuantity(rows: giftDeleteBtn.tag, quantity: addCartValueTF.text!, section: giftPriceLbl.tag)
        }
    }
}



//MARK: - My Thode Cell
class MyThodeTVCell: UITableViewCell {
    
    //MARK: - Variables
    var delegate: ThodeDetailDelegate?
    
    //MARK: - IBOutlets
    @IBOutlet weak var thodeView:UIView!
    @IBOutlet weak var thodeIV:UIImageView!
    @IBOutlet weak var thodeLbl:UILabel!
    @IBOutlet weak var thodeDescriptionLbl:UILabel!
    @IBOutlet weak var thodeQtyLbl:UILabel!
    @IBOutlet weak var thodeDeleteBtn:UIButton!
    @IBOutlet weak var thodePriceLbl:UILabel!
    @IBOutlet weak var thodeLessDetailBtn:UIButton!

    @IBOutlet weak var fabricView:UIView!
    @IBOutlet weak var fabricIV:UIImageView!
    @IBOutlet weak var fabricLbl:UILabel!
    @IBOutlet weak var fabricPriceLbl:UILabel!
    @IBOutlet weak var fabricEditBtn:UIButton!
    
    @IBOutlet weak var cuffsView:UIView!
    @IBOutlet weak var cuffsIV:UIImageView!
    @IBOutlet weak var cuffsLbl:UILabel!
    @IBOutlet weak var cuffsPriceLbl:UILabel!
    @IBOutlet weak var cuffsEditBtn:UIButton!
    
    @IBOutlet weak var collarView:UIView!
    @IBOutlet weak var collarIV:UIImageView!
    @IBOutlet weak var collarLbl:UILabel!
    @IBOutlet weak var collarPriceLbl:UILabel!
    @IBOutlet weak var collarEditBtn:UIButton!
    
    @IBOutlet weak var buttonView:UIView!
    @IBOutlet weak var buttonIV:UIImageView!
    @IBOutlet weak var buttonLbl:UILabel!
    @IBOutlet weak var buttonPriceLbl:UILabel!
    @IBOutlet weak var buttonEditBtn:UIButton!
    
    @IBOutlet weak var pocketView:UIView!
    @IBOutlet weak var pocketIV:UIImageView!
    @IBOutlet weak var pocketLbl:UILabel!
    @IBOutlet weak var pocketPriceLbl:UILabel!
    @IBOutlet weak var pocketEditBtn:UIButton!
    
    @IBOutlet weak var placketView:UIView!
    @IBOutlet weak var placketIV:UIImageView!
    @IBOutlet weak var placketLbl:UILabel!
    @IBOutlet weak var placketPriceLbl:UILabel!
    @IBOutlet weak var placketEditBtn:UIButton!
    
    @IBOutlet weak var sidePocketView:UIView!
    @IBOutlet weak var sidePocketIV:UIImageView!
    @IBOutlet weak var sidePocketLbl:UILabel!
    @IBOutlet weak var sidePocketPriceLbl:UILabel!
    @IBOutlet weak var sidePocketEditBtn:UIButton!
    @IBOutlet weak var allSV:UIStackView!
    @IBOutlet weak var lessDetailHeightConstraint:NSLayoutConstraint!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
     }

    //MARK: - Actions
    @IBAction func btnTap_ThodeDelete(_ sender: Any) {
    }
        
    @IBAction func btnTap_LessDetail(_ sender: Any) {
        if allSV.isHidden == true {
            allSV.isHidden = false
        } else {
            allSV.isHidden = true
        }
    }
    
    @IBAction func btnTap_FabricEdit(_ sender: Any) {
        delegate?.didTap(row: 0, selectedThobe: 0)
    }
    
    @IBAction func btnTap_CuffsEdit(_ sender: Any) {
        delegate?.didTap(row: 2, selectedThobe: 2)
    }
    
    @IBAction func btnTap_CollarEdit(_ sender: Any) {
        delegate?.didTap(row: 1, selectedThobe: 1)
    }
    
    @IBAction func btnTap_ButtonEdit(_ sender: Any) {
        delegate?.didTap(row: 5, selectedThobe: 5)
    }
    
    @IBAction func btnTap_PocketEdit(_ sender: Any) {
        delegate?.didTap(row: 3, selectedThobe: 3)
    }
    
    @IBAction func btnTap_PlacketEdit(_ sender: Any) {
        delegate?.didTap(row: 4, selectedThobe: 4)
    }
    
    @IBAction func btnTap_SidePocketEdit(_ sender: Any) {
        delegate?.didTap(row: 6, selectedThobe: 6)
    }
    
}



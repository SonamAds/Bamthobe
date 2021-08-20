//
//  DetailPopupVC.swift
//  Bam
//
//  Created by ADS N URL on 08/04/21.
//

import UIKit

class DetailPopupVC: UIViewController {
    
    //MARK:- Variables
    var pushDict: FabricModelData?
    var pushDict1: CollarModelData?
    var pushDict2: CuffsModelData?
    var pushDict3: PocketModelData?
    var pushDict4: PlacketModelData?
    var pushDict5: ButtonModelData?
    
    
    //MARK: - IBOutlets Properties
    @IBOutlet weak var descriptionLbl: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if pushDict != nil {
            descriptionLbl.text = pushDict?.description
            priceLbl.text = "SAR \(pushDict?.price ?? "0")"
            titleLbl.text = pushDict?.fabrics
            let url = "\(pushDict?.image ?? "")"
            image.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (imge, error, cacheType, url) in
                self.image.image = imge
            }
        } else if pushDict1 != nil {
            descriptionLbl.text = pushDict1?.description
            priceLbl.text = "SAR \(pushDict1?.price ?? "0")"
            titleLbl.text = pushDict1?.collar_style
            let url = "\(pushDict1?.image ?? "")"
            image.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (imge, error, cacheType, url) in
                self.image.image = imge
            }
        } else if pushDict2 != nil {
            descriptionLbl.text = pushDict2?.description
            priceLbl.text = "SAR \(pushDict2?.price ?? "0")"
            titleLbl.text = pushDict2?.cuff
            let url = "\(pushDict2?.image ?? "")"
            image.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (imge, error, cacheType, url) in
                self.image.image = imge
            }
        } else if pushDict3 != nil {
            descriptionLbl.text = pushDict3?.description
            priceLbl.text = "SAR \(pushDict3?.price ?? "0")"
            titleLbl.text = pushDict3?.pocket
            let url = "\(pushDict3?.image ?? "")"
            image.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (imge, error, cacheType, url) in
                self.image.image = imge
            }
        } else if pushDict4 != nil {
            descriptionLbl.text = pushDict4?.description
            priceLbl.text = "SAR \(pushDict4?.price ?? "0")"
            titleLbl.text = pushDict4?.style
            let url = "\(pushDict4?.image ?? "")"
            image.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (imge, error, cacheType, url) in
                self.image.image = imge
            }
        } else if pushDict5 != nil {
            descriptionLbl.text = pushDict5?.description
            priceLbl.text = "SAR \(pushDict5?.price ?? "0")"
            titleLbl.text = pushDict5?.buttons
            let url = "\(pushDict5?.image ?? "")"
            image.sd_setImage(with: URL(string: url)!, placeholderImage: nil, options: .refreshCached) { (imge, error, cacheType, url) in
                self.image.image = imge
            }
        }
    }
    
    
    //MARK: - IBActions
    @IBAction func btnTap_Close(_ sender :UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

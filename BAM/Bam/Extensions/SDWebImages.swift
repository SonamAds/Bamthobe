//
//  SDWebImages.swift
//  Bam
//
//  Created by ADS N URL on 22/04/21.
//


import Foundation
import SDWebImage

//InputSource to image using SDWebImage
@objcMembers
public class SDWebImageSource: NSObject/*, InputSource*/ {
    ////url to load
    public var url : URL

    ////placeholder used before image is loaded
    public var placeholder: UIImage?


    ////Intializes a new source with a URL
    //// - parameter urlString: a string url to load
    //// - parameter placeholder: a placeholder used before image is loaded
    public init?(urlString: String, placeholder: UIImage? = nil) {
        if let validUrl = URL(string: urlString) {
            self.url = validUrl
            self.placeholder = placeholder
            super.init()
        } else {
            return nil
        }
    }
    
    public func load(to imageView: UIImageView, with callback: @escaping(UIImage?) -> Void) {
        imageView.sd_setImage(with: self.url, placeholderImage: self.placeholder, options: [], completed: { (image, _, _, _) in
            callback(image)
        })
    }
    
    public func cancelled(on imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }
}

//
//  SnackBar.swift
//  Bam
//
//  Created by ADS N URL on 23/04/21.
//

import Foundation
import UIKit


public class SnackBar: UIView {
    
    private let textView = PaddingLabel()
    private var bottomPadding = CGFloat()
    private var textViewHeight: CGFloat = 45.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.zero
        textView.frame = CGRect.zero
        self.addSubview(self.textView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func showSnackBar(view:UIView/*,bgColor:UIColor*/,text:String,/*textColor:UIColor,*/interval:Int){
        
        //Bottom Pading for iPhone X.
        if #available(iOS 11.0, *) {
            bottomPadding = view.safeAreaInsets.bottom
            
        }
        
        //Calcute height & set frame.
        self.frame = CGRect(x:5, y: UIScreen.main.bounds.height - 5, width: UIScreen.main.bounds.width - 10, height: textViewHeight)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.textViewHeight = calculateHeight(text: text)
        textView.frame = CGRect(x:0, y:0, width: self.frame.width ,height: textViewHeight)
      
        textView.text = text
        textView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textAlignment = NSTextAlignment.left
        textView.numberOfLines = 0
        self.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.addSubview(self)
        
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x:5, y: UIScreen.main.bounds.height - (self.textViewHeight + self.bottomPadding + 5), width: UIScreen.main.bounds.width - 10, height: self.textViewHeight + self.bottomPadding)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(interval)) {
            UIView.animate(withDuration: 0.5, animations: {
                  self.frame = CGRect(x:5, y: UIScreen.main.bounds.height - 5, width: UIScreen.main.bounds.width - 10, height: 45)
            }) { (success) in
                self.removeFromSuperview()
            }
        }

    }
    
    private func calculateHeight(text:String) -> CGFloat{
        let rect = text.boundingRect(with: CGSize(width: self.frame.width - 30 , height: 10000000),options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)], context: nil)
        let height = rect.size.height <= 45 ? 45 : rect.size.height + 10
        return height
    }
}

private class PaddingLabel: UILabel {
    
    var topInset: CGFloat = 0.0
    var bottomInset: CGFloat = 0.0
    var leftInset: CGFloat = 15.0
    var rightInset: CGFloat = 15.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}

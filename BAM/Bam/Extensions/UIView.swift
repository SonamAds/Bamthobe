//
//  UIView.swift
//  Bam
//
//  Created by ADS N URL on 17/03/21.
//

import UIKit

@IBDesignable
class CardViewMaster: UIView {

    @IBInspectable var cornerRadius: CGFloat = 2

    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.5

    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }

}

@IBDesignable
class CornerView: UIView {
    
    @IBInspectable var leftTopRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    @IBInspectable var rightTopRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    @IBInspectable var rightBottomRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    
    @IBInspectable var leftBottomRadius : CGFloat = 0{
        didSet{
            self.applyMask()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.applyMask()
    }
    func applyMask()
    {
        let shapeLayer = CAShapeLayer(layer: self.layer)
        shapeLayer.path = self.pathForCornersRounded(rect:self.bounds).cgPath
        shapeLayer.frame = self.bounds
        shapeLayer.masksToBounds = true
        self.layer.mask = shapeLayer
    }
    func pathForCornersRounded(rect:CGRect) ->UIBezierPath
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0 + leftTopRadius , y: 0))
        path.addLine(to: CGPoint(x: rect.size.width - rightTopRadius , y: 0))
        path.addQuadCurve(to: CGPoint(x: rect.size.width , y: rightTopRadius), controlPoint: CGPoint(x: rect.size.width, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width , y: rect.size.height - rightBottomRadius))
        path.addQuadCurve(to: CGPoint(x: rect.size.width - rightBottomRadius , y: rect.size.height), controlPoint: CGPoint(x: rect.size.width, y: rect.size.height))
        path.addLine(to: CGPoint(x: leftBottomRadius , y: rect.size.height))
        path.addQuadCurve(to: CGPoint(x: 0 , y: rect.size.height - leftBottomRadius), controlPoint: CGPoint(x: 0, y: rect.size.height))
        path.addLine(to: CGPoint(x: 0 , y: leftTopRadius))
        path.addQuadCurve(to: CGPoint(x: 0 + leftTopRadius , y: 0), controlPoint: CGPoint(x: 0, y: 0))
        path.close()
        
        return path
    }
}
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

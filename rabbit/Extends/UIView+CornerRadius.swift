//
//  UIView+CornerRadius.swift
//  rabbit
//
//  Created by CYC on 2016/11/19.
//  Copyright © 2016年 yicheng. All rights reserved.
//
//
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0;
        }
    }
    func setCornerRadius()  {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
class ZCBView: UIView {
    var shapeLayer:CAShapeLayer!
    var oneLayer:CAShapeLayer!
    let annimation = CABasicAnimation(keyPath: "transform.rotation.z")
    var oneColor:[CGColor] = [UIColor.init(red: 41.0/255.0, green: 244.0/255.0, blue: 49.0/255.0, alpha: 1).cgColor,UIColor.init(red: 73.0/255.0, green: 133.0/255.0, blue: 130.0/255.0, alpha: 1).cgColor,UIColor.init(red: 117.0/255.0, green: 124.0/255.0, blue: 188.0/255.0, alpha: 1).cgColor,UIColor.white.cgColor]
    var twoColor:[CGColor] = [UIColor.init(red: 41.0/255.0, green: 244.0/255.0, blue: 49.0/255.0, alpha: 1).cgColor,UIColor.init(red: 73.0/255.0, green: 133.0/255.0, blue: 130.0/255.0, alpha: 1).cgColor,UIColor.init(red: 117.0/255.0, green: 124.0/255.0, blue: 188.0/255.0, alpha: 1).cgColor,UIColor.white.cgColor]
    var strokeEndFloat:CGFloat = 0 {
        didSet{
            oneLayer.strokeEnd = strokeEndFloat
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    func setUI() {
        shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        self.layer.addSublayer(shapeLayer)
        
        //创建梯形layer
        let leftLayer = CAGradientLayer()
        leftLayer.frame = CGRect.init(x: 0, y: 0, width: 90, height: 45)
        leftLayer.colors = oneColor
        leftLayer.startPoint = CGPoint(x: 0, y: 0.5)
        leftLayer.endPoint = CGPoint(x: 1, y: 0.5)
        //        shapeLayer.addSublayer(leftLayer)
        
        let rightLaye = CAGradientLayer()
        rightLaye.frame = CGRect.init(x: 45, y: 0, width: 90, height: 90)
        rightLaye.colors = twoColor
        rightLaye.startPoint = CGPoint.init(x: 0, y: 1)
        rightLaye.endPoint = CGPoint.init(x: 0, y: 0)
        shapeLayer.addSublayer(rightLaye)
        //创建一个圆形
        oneLayer = CAShapeLayer()
        oneLayer.frame = self.bounds
        oneLayer.path = UIBezierPath(arcCenter: CGPoint.init(x: 45, y: 45), radius: 42.5, startAngle: 0, endAngle:CGFloat.pi*2, clockwise: true).cgPath
        oneLayer.lineWidth = 3
        oneLayer.lineCap = kCALineCapRound
        oneLayer.lineJoin = kCALineJoinRound
        oneLayer.strokeColor = UIColor.black.cgColor
        oneLayer.fillColor = UIColor.clear.cgColor
        //根据oneLayer的layer形状在shaperlayer中截取出来一个layer
        shapeLayer.mask = oneLayer
        
    }
    func strartLoading()  {
        
        annimation.toValue = 2*CGFloat.pi
        annimation.duration = 1.25
        annimation.repeatCount = HUGE
        self.layer.add(annimation, forKey: "")
        
    }
    
}

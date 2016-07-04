//
//  CouponCenterCell.swift
//  APP
//
//  Created by garfield on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

import UIKit

class CouponCenterCell: UITableViewCell {
    @IBOutlet weak var backGroundImage: QWImageView!
    @IBOutlet weak var leftTopImage: UIImageView!

    @IBOutlet weak var priceLabel: QWLabel!

    @IBOutlet weak var storeName: QWLabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var obtainButton: QWButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var crazyGetLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var isChronicImage: UIImageView!
    @IBOutlet weak var lblRightArrow: UILabel!
    
    @IBOutlet weak var pickUpLabel: UILabel!
    @IBOutlet weak var priceUnitLabel: UILabel!
    @IBOutlet weak var pickImageView: UIImageView!
    
    @IBOutlet weak var imReciveLabel: UILabel!  //立即领取
    @IBOutlet weak var unExpireLabel: UILabel!   //预售券未到期使用
    @IBOutlet weak var couponPickedBGView: UIView!
    @IBOutlet weak var promotionLabel: UILabel! //券备注
    override func awakeFromNib() {
        super.awakeFromNib()
        self.conditionLabel.layer.masksToBounds = true
        self.conditionLabel.layer.cornerRadius = 8.5

    }
    
    func setCell(data: AnyObject!)
    {
        var couponModel:OnlineCouponVoModel! = data as! OnlineCouponVoModel
        print(couponModel)
        startDateLabel.text = couponModel.begin
        endDateLabel.text = couponModel.end
        //判断是否是大于10个字
//        if couponModel.groupName.characters.count > 10 {
//            storeName.text = (couponModel.groupName as NSString).substringToIndex(10)
//        } else {
//            storeName.text = couponModel.groupName
//        }


        if couponModel.couponRemark.characters.count > 16 {
            storeName.text = (couponModel.couponRemark as NSString).substringToIndex(16)
        } else {
            storeName.text = couponModel.couponRemark
        }

        
        priceLabel.text = couponModel.couponValue
        conditionLabel.text = couponModel.couponTag
        print(couponModel.status)
        if(couponModel.status == 0){        //状态：0.待开始，1.待使用，2.快过期，3.已使用，4.已过期
            self.imReciveLabel.text = "预领取"
            self.unExpireLabel.hidden = false
        }else{
            self.imReciveLabel.text = "立即领取"
            self.unExpireLabel.hidden = true
        }
        if(couponModel.chronic){
            //慢病专享logo显示
            self.isChronicImage.hidden = false
        }else{
            //慢病专享logo隐藏
            self.isChronicImage.hidden = true
        }
        self.lblRightArrow.hidden = false
        if let strRemark = couponModel.couponRemark {       // 显示备注
            if strRemark.characters.count > 0 {
                self.promotionLabel.hidden = false;
                self.promotionLabel.text = couponModel.couponRemark
            } else {
                self.promotionLabel.hidden = true;
            }
        }
        self.promotionLabel.hidden = true

        self.pickImageView.hidden = false
        self.couponPickedBGView.hidden = true
        self.pickUpLabel.hidden = false
        var image:UIImage! = nil
        self.lblRightArrow.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        
        if couponModel.pick {
            
        } else {
            
        }
        
        if(couponModel.empty) {
            //已领完
            image = UIImage(named: "img_bg_ticket_gray_big")
            
            self.priceLabel.textColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
            self.conditionLabel.backgroundColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
            self.priceUnitLabel.textColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
            
            self.pickImageView.image = UIImage(named: "img_bg_finish")
            self.lblRightArrow.textColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        } else if(couponModel.pick) {
            //已领取
            if couponModel.limitLeftCounts == 0{
                // 已经没有可领的券了
                self.couponPickedBGView.layer.cornerRadius = 8.0
                self.couponPickedBGView.layer.masksToBounds = true
                self.couponPickedBGView.hidden = false
                self.lblRightArrow.hidden = true
                self.pickUpLabel.hidden = true
                self.pickImageView.image = UIImage(named: "img_bg_receive")
                self.pickImageView.hidden = false
            } else {
                
                self.pickImageView.hidden = true;
                self.lblRightArrow.hidden = false
                self.pickUpLabel.hidden = false
                self.couponPickedBGView.hidden = true
            }
            image = UIImage(named: "img_bg_ticket_big")
            self.priceLabel.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.conditionLabel.backgroundColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.priceUnitLabel.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
        }else {
            image = UIImage(named: "img_bg_ticket_big")
            self.priceLabel.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.conditionLabel.backgroundColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.priceUnitLabel.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.pickImageView.hidden = true
        }
        self.backGroundImage.image = image
        self.promotionLabel.hidden = true
    }
    
    
    
}

//
//  CouponGiftCertificateCell.swift
//  APP
//
//  Created by garfield on 15/9/7.
//  Copyright (c) 2015年 carret. All rights reserved.
//

import UIKit

class CouponGiftCertificateCell: UITableViewCell {

    @IBOutlet weak var backGroundImage: QWImageView!
    @IBOutlet weak var storeName: QWLabel!
    @IBOutlet weak var conditionLabel: QWLabel!
    @IBOutlet weak var obtainButton: QWButton!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!

    @IBOutlet weak var giftImageUrl: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var crazyGetLabel: UILabel!
    @IBOutlet weak var leftTopImage: UIImageView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickImageView: UIImageView!
    
    @IBOutlet weak var imReciveLabel: UILabel! //立即领取label
    @IBOutlet weak var couponPickUPBgView: UIView!
    @IBOutlet weak var unExpireLabel: UILabel! //未到使用期label
    
    @IBOutlet weak var rightArrowLbl: UILabel!  // 向右箭头label
    @IBOutlet weak var remarkLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        conditionLabel.layer.masksToBounds = true
        conditionLabel.layer.cornerRadius = 8.5
        // Initialization code
    }

    func setCellModel(data: AnyObject!)
    {
        var couponModel:OnlineCouponVoModel! = data as! OnlineCouponVoModel
        print(couponModel)
        startDateLabel.text = couponModel.begin
        endDateLabel.text = couponModel.end
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
        
        conditionLabel.text = couponModel.couponTag
        priceLabel.text = NSString(format: "价值%@元", couponModel.couponValue) as String
        self.pickImageView.hidden = false
        var image:UIImage! = nil
        obtainButton.hidden = false
        couponPickUPBgView.hidden = true
        if(Int(couponModel.status) == 0) {   //状态：0.待开始，1.待使用，2.快过期，3.已使用，4.已过期
            self.imReciveLabel.text = "预领取"
            self.unExpireLabel.hidden = false
        }else{
            self.imReciveLabel.text = "立即领取"
            self.unExpireLabel.hidden = true
        }
        if let strRemark = couponModel.couponRemark {
            if strRemark.characters.count > 0 {
                self.remarkLable.hidden = false;
                self.remarkLable.text = couponModel.couponRemark
            } else {
                self.remarkLable.hidden = true;
            }
        }
        self.remarkLable.hidden = true;
        self.imReciveLabel.hidden = false
        self.rightArrowLbl.hidden = false
        self.rightArrowLbl.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)

        if(couponModel.empty) {
            //已领完
            image = UIImage(named: "img_bg_ticket_gray_big")
            self.pickImageView.image = UIImage(named: "img_bg_finish")
            self.priceLabel.textColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
            self.conditionLabel.backgroundColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
            self.rightArrowLbl.textColor = UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        }else if(couponModel.pick) {
            //已领取
            if couponModel.limitLeftCounts == 0 {
                // 已经没有可领的券了
                couponPickUPBgView.hidden = false
                couponPickUPBgView.layer.cornerRadius = 8.0
                couponPickUPBgView.layer.masksToBounds = true
                obtainButton.hidden = true
                self.imReciveLabel.hidden = true
                self.pickImageView.image = UIImage(named: "img_bg_receive")
            } else {
                self.pickImageView.image = UIImage(named: "img_bg_receive")
                self.pickImageView.hidden = false
            }
            image = UIImage(named: "img_bg_ticket_big")
            self.priceLabel.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.conditionLabel.backgroundColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            
        }else {
            image = UIImage(named: "img_bg_ticket_big")
            self.priceLabel.textColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.conditionLabel.backgroundColor = UIColor(red: 112.0/255.0, green: 188.0/255.0, blue: 238.0/255.0, alpha: 1.0)
            self.pickImageView.hidden = true
        }
        self.backGroundImage.image = image
        self.giftImageUrl.setImageWithURL(NSURL(string: couponModel.giftImgUrl), placeholderImage: UIImage(named:  "img_bg_gift_ticket"))
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

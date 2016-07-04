//
//  EvaluateCouponViewController.swift
//  APP
//
//  Created by garfield on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

import UIKit

class EvaluateCouponViewController: QWBaseVC,UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var keyboardConstraint: NSLayoutConstraint!
    var stars:Float = 0.0
    var orderCheckModel:CouponOrderCheckVo! = nil   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.layer.masksToBounds = false
        self.submitButton.layer.cornerRadius = 5.0
        self.title = orderCheckModel.branchName
        self.ratingView.setImagesDeselected("star_none_big.png", partlySelected: "star_half_big.png", fullSelected: "star_full_big", andDelegate: nil)
        self.ratingView.displayRating(stars)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: "confirmClick:")
        (self.navigationController as! QWBaseNavigationController).canDragBack = false
    }

    
    @IBAction func confirmClick(sender: AnyObject)
    {
        if(textView.text.characters.count > 100) {
            SVProgressHUD.showErrorWithStatus("评论长度不得大于100字", duration: 0.8)
            return
        }else if(textView.text.characters.count == 0 ) {
            SVProgressHUD.showErrorWithStatus("评论内容不得为空", duration: 0.8)
            return
        }
        print(floor(self.ratingView.rating() * 2.0));
        var modelR:OrderBaseCommentModelR! = OrderBaseCommentModelR()
        modelR.orderId = orderCheckModel.orderId;
        modelR.star = NSString(format: "%.0f", floor(self.ratingView.rating() * 2.0)) as String
        modelR.content = textView.text
        modelR.token = QWGlobalManager.sharedInstance().configure.userToken
        OrderBase.orderBaseComment(modelR, success: { (orderBasemodel:OrderBaseCommentModel!) -> Void in
            
            if(orderBasemodel.apiStatus.integerValue == 1){
                SVProgressHUD.showErrorWithStatus(orderBasemodel.apiMessage)
                return;
            }
            
            self.popOutViewController(true);
            
            }, failure: nil)
    }
    
    @IBAction func dismissKeyBoard(sender:AnyObject)
    {
        self.textView.resignFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWillShow(noti:NSNotification)
    {
        if(UIScreen.mainScreen().bounds.size.height == 480) {
            keyboardConstraint.constant = -20.0;
        }else{
            keyboardConstraint.constant = 5.0;
        }
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        self.hintLabel.hidden = true
    }
    
    func keyboardWillHide(noti:NSNotification)
    {
        keyboardConstraint.constant = 79.0;
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n"){
            textView.resignFirstResponder()
        }
        var newString:NSString = textView.text as NSString
        newString = newString.stringByReplacingCharactersInRange(range, withString: text)
        if(newString.length > 0) {
            self.hintLabel.hidden = true
        }else{
            self.hintLabel.hidden = false
        }
        return true
    }
    
    @IBAction func cancelClick(sender: AnyObject)
    {
        self.popOutViewController(false);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func popVCAction(sender: AnyObject!) {
        self.popOutViewController(false)
    }
    
    
    func popOutViewController(shouldPush:Bool)
    {
        (self.navigationController as! QWBaseNavigationController).canDragBack = true
        var viewControllers:NSArray! = self.navigationController?.viewControllers
        var popToViewController:UIViewController! = nil
        for viewController in viewControllers {
            if(viewController.isKindOfClass(MyCouponQuanViewController.classForCoder()))
            {
                popToViewController = viewController as! UIViewController
                break;
            }
        }
        if(popToViewController != nil) {
            (popToViewController as! MyCouponQuanViewController).shouldJump = true
            self.navigationController?.popToViewController(popToViewController, animated: true)
        }else{
            var myViewController: MyCouponQuanViewController = MyCouponQuanViewController()
            myViewController.shouldJump = true
            self.navigationController?.pushViewController(myViewController, animated: true)
        }
    }
}

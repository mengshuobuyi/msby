//
//  CouponCenterViewController.swift
//  APP
//
//  Created by garfield on 15/8/17.
//  Copyright (c) 2015年 carret. All rights reserved.
//

import UIKit
class CouponCenterViewController: QWBaseVC,UITableViewDelegate,UITableViewDataSource,XLCycleScrollViewDelegate,XLCycleScrollViewDatasource,ComboxViewDelegate {

    let identifier = "VFourCouponQuanTableViewCell"
    let topIdentifier = "VFourCouponQuanTableViewCell"
    
    
    let MenuIdentifier = "MenuIdentifier"
    let APP_WH = UIScreen.mainScreen().bounds.size.width
    let APP_SH = UIScreen.mainScreen().bounds.size.height
    
    var leftComboxView:ComboxView! = nil
    var rightComboxView:ComboxView! = nil
    var centerComboxView:ComboxView! = nil
    var leftButton:RightAccessButton! = nil
    var rightButton:RightAccessButton! = nil
    var centerButton:RightAccessButton! = nil
    var cycleScrollView:XLCycleScrollView! = nil
    
    var bannerList:NSArray! = NSArray()
    var topCoupons:NSMutableArray! = NSMutableArray()
    var priceRange:NSMutableArray! = NSMutableArray()
    var cityRange :NSMutableArray! = NSMutableArray()
    var normalCoupons:NSMutableArray! = NSMutableArray()
    var leftMenuItems:NSArray! = nil
    var rightMenuItems:NSArray! = nil
    var leftIndex:Int! = nil
    var rightIndex:Int! = nil
    var centerIndex:Int! = nil
    var headerView:UIImageView! = nil
    var currentPage:Int = 1

    @IBOutlet weak var tableView: UITableView!
    var topTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        leftMenuItems = ["默认排序","优惠金额从低到高","优惠金额从高到低"]
        rightMenuItems = ["全部","慢病专享代金券","通用代金券","礼品券","商品券"]
        self.view.backgroundColor = UIColor(red: 242.0/255.0, green: 244.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        leftIndex = 0;
        rightIndex = 0;
        centerIndex = 0;
        priceRange.addObject("满额金额")
        cityRange.addObject("全部药房")
        setupUI()
        
        if(QWGlobalManager.sharedInstance().currentNetWork == NetworkStatus.NotReachable)
        {
            self.topTableView.tableHeaderView = nil
            self.showInfoInView(self.topTableView, offsetSize: 0, text: "网络未连接，请重试", image: "网络信号icon")
        }else{
            queryCouponBanner()
            queryCouponCenterList(true)
            queryCouponCondition()
            queryBanchCondition()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as! QWBaseNavigationController).canDragBack = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        (self.navigationController as! QWBaseNavigationController).canDragBack = true
        if(self.cycleScrollView != nil)
        {
            self.cycleScrollView.stopAutoScroll()
        }
    }
    
    //初始化TableView,上拉下拉以及
    func setupUI() {
        self.title = "领券中心"
        // icon_share   icon_share_click
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: UIBarButtonItemStyle.Plain, target: self, action: "couponShareClick")
        
        let ypDetailBarItems:UIView = UIView.init(frame: CGRectMake(0, 0, 80, 55))
        let zoomButton:UIButton = UIButton.init(type:UIButtonType.RoundedRect)
        zoomButton.frame = CGRectMake(23, 2, 55,55)
        
        zoomButton.addTarget(self, action: "couponShareClick", forControlEvents: UIControlEvents.TouchUpInside)
        var iconImage = UIImage.init(named: "icon_share_click")
        iconImage = iconImage!.imageWithRenderingMode(.AlwaysOriginal)
        
        zoomButton.setImage(iconImage, forState: UIControlState.Normal)
        ypDetailBarItems.addSubview(zoomButton)
        let fixed:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        fixed.width = -15
        
        let rightBarButtons = [fixed,UIBarButtonItem.init(customView: ypDetailBarItems)]
        self.navigationItem.rightBarButtonItems = rightBarButtons
        //初始化TableView,上拉下拉刷新
        
        let nib = UINib(nibName: "VFourCouponQuanTableViewCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: identifier)

        //初始化第一屏UITableView
        self.topTableView = UITableView(frame: CGRect(x: 0, y:0, width: APP_WH, height: APP_SH - 64))
        self.topTableView?.registerNib(nib, forCellReuseIdentifier: topIdentifier)
        self.topTableView.separatorStyle = .None
        self.topTableView.dataSource = self
        self.topTableView.delegate = self
        self.topTableView.backgroundColor = UIColor(red: 242.0/255.0, green: 244.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        self.topTableView.tableFooterView = setupTopFooterView()
        self.view.addSubview(self.topTableView)
        self.topTableView.addFooterWithCallback { 
            self.switchToNextScreen()
        }

        self.enableSimpleRefresh(self.topTableView) { [unowned self] ( sender:SRRefreshView!) -> Void in
            self.queryCouponBanner()
            self.queryCouponCenterList(true)
        }

        hiddenFooterView()
        self.tableView.addHeaderWithCallback { [unowned self] () -> Void in
            self.switchToPrevSceen()
        }
        self.topTableView.footer!.shouldShowPulling = false
        self.tableView.frame = CGRectMake(0, self.topTableView.frame.size.height, APP_WH, APP_SH - 64)
        self.tableView.tableHeaderView = setupStatusChooseBar()
        self.tableView.addFooterWithCallback {
            self.queryCouponCenterList(false)
        }
        self.view.addSubview(self.tableView)

        //初始化滚动Banner
        self.cycleScrollView = XLCycleScrollView(frame: CGRectMake(0, 0, APP_WH, APP_WH / 320.0 * 85.0))
        self.cycleScrollView.delegate = self
        self.cycleScrollView.datasource = self
        self.cycleScrollView.scrollView.scrollEnabled = true
        var rect = self.cycleScrollView.pageControl.frame
        rect.origin.x = (APP_WH - rect.size.width) / 2.0
        self.cycleScrollView.pageControl.frame = rect
        self.cycleScrollView.pageControl.hidesForSinglePage = true
        self.topTableView.tableHeaderView = self.cycleScrollView
    }
    
    func hiddenFooterView()
    {
        self.topTableView.footer!.statusLabel!.hidden = true
        self.topTableView.footer!.arrowImage!.hidden = true
        self.topTableView.footer!.refreshPatternImageView!.hidden = true
        self.topTableView.footer!.activityView!.hidden = true
        self.topTableView.footer!.imgvLoading!.hidden = true
        self.topTableView.footer!.imgBg!.hidden = true
    }
    
    
    func  setupTopFooterView() -> UIView {
        let footerView = UIView(frame: CGRectMake(0, 0, APP_WH, 40))
        let label = UILabel(frame: CGRectMake((APP_WH - 150) / 2 , 0, 150, 40))
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(12.0)
        label.text = "继续拖动，查看所有优惠券"
        
        let sepatorWidth = UIView(frame:CGRectMake(15, 20, (APP_WH - 30.0 - 56.0 - 150) / 2, 0.5))
        sepatorWidth.backgroundColor = UIColor.init(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 228.0/255.0)
        
        let sepatorWidth2 = UIView(frame:CGRectMake(label.frame.origin.x + label.frame.size.width + 28, 20, (APP_WH - 30.0 - 56.0 - 150) / 2, 0.5))
        sepatorWidth2.backgroundColor = UIColor.init(red: 228.0/255.0, green: 228.0/255.0, blue: 228.0/255.0, alpha: 228.0/255.0)
        
        footerView.addSubview(label)
        footerView.addSubview(sepatorWidth)
        footerView.addSubview(sepatorWidth2)
        return footerView
    }
    
    func switchToNextScreen()
    {
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.topTableView.footerEndRefreshing()
            self.topTableView.removeFooter()
            QWGlobalManager.sharedInstance().statisticsEventId("领券中心_全部优惠券", withLable: "领券中心_全部优惠券", withParams: nil)
            var rect = self.topTableView.frame
            rect.origin.y -= (self.APP_SH - 64)
            self.topTableView.frame = rect;
            rect = self.tableView.frame
            rect.origin.y = 0
            self.tableView.frame = rect
            
            }) { (result) in
                
        }
    }
    
    func  switchToPrevSceen()
    {
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.tableView.headerEndRefreshing()
            var rect = self.topTableView.frame
            rect.origin.y += (self.APP_SH - 64)
            self.topTableView.frame = rect
            rect = self.tableView.frame
            rect.origin.y = self.APP_SH - 64
            self.tableView.frame = rect
            
        }) { (result) in
            self.topTableView.addFooterWithCallback {
                self.switchToNextScreen()
            }
            self.topTableView!.footer!.shouldShowPulling = false
            self.hiddenFooterView()
        }
    }
    
    //初始化 领券中心界面的状态选择栏
    func setupStatusChooseBar()->UIImageView!
    {
        if(headerView != nil)
        {
            return headerView;
        }
        headerView = UIImageView(frame: CGRectMake(0, 0, APP_WH, 38))
        headerView.tag = 1008
        headerView.userInteractionEnabled = true
        headerView.backgroundColor = UIColor.whiteColor()
        headerView.image = UIImage(named: "菜单下拉背景two")
        
        leftButton = RightAccessButton(frame: CGRectMake(30, 0, APP_WH / 2.0 - 60, 38))
        //headerView.addSubview(leftButton)
        rightButton = RightAccessButton(frame: CGRectMake(APP_WH / 2.0 + 30,0, APP_WH / 2.0 - 60, 38))
        headerView.addSubview(rightButton)
        centerButton = RightAccessButton(frame: CGRectMake(30, 0, APP_WH / 2.0 - 60, 38))
        headerView.addSubview(centerButton)
        
        let accessView1:UIImageView! = UIImageView(frame: CGRectMake(0, 0, 12, 6))
        let accessView2:UIImageView! = UIImageView(frame: CGRectMake(0, 0, 12, 6))
        let accessView3:UIImageView! = UIImageView(frame: CGRectMake(0, 0, 12, 6))
        
        accessView1.image = UIImage(named: "arrDown.png")
        accessView2.image = UIImage(named: "arrDown.png")
        accessView3.image = UIImage(named: "arrDown.png")
        
        leftButton.accessIndicate = accessView1
        rightButton.accessIndicate = accessView2
        centerButton.accessIndicate = accessView3
        
        leftButton.buttonTitle = "默认排序"
        rightButton.buttonTitle = "按药房查找"
        centerButton.buttonTitle = "满额金额"
        
        leftButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
        rightButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
        centerButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
        
        leftButton.customFont = UIFont.systemFontOfSize(14.0)
        rightButton.customFont = UIFont.systemFontOfSize(14.0)
        centerButton.customFont = UIFont.systemFontOfSize(14.0)
        leftButton.addTarget(self, action: "showLeftTable:", forControlEvents: UIControlEvents.TouchDown)
        centerButton.addTarget(self, action: "showCenterTable:", forControlEvents: UIControlEvents.TouchDown)
        rightButton.addTarget(self, action: "showRightTable:", forControlEvents: UIControlEvents.TouchDown)
        
        var height:CGFloat = CGFloat(leftMenuItems.count * 44)
        leftComboxView = ComboxView(frame: CGRectMake(0, 38, APP_WH, height))
        leftComboxView.delegate = self
        leftComboxView.comboxDeleagte = self
        height = CGFloat(self.cityRange.count * 44)
        rightComboxView = ComboxView(frame: CGRectMake(0, 38, APP_WH, APP_SH))
        rightComboxView.delegate = self
        rightComboxView.comboxDeleagte = self;
        height = CGFloat(3 * 44)
        centerComboxView = ComboxView(frame: CGRectMake(0, 38, APP_WH, height))
        centerComboxView.delegate = self
        centerComboxView.comboxDeleagte = self;
        
        leftComboxView.tableView?.registerClass(ComboxViewCell.classForCoder(), forCellReuseIdentifier: MenuIdentifier)
        rightComboxView.tableView?.registerClass(ComboxViewCell.classForCoder(), forCellReuseIdentifier: MenuIdentifier)
        centerComboxView.tableView?.registerClass(ComboxViewCell.classForCoder(), forCellReuseIdentifier: MenuIdentifier)
        return headerView
    }
    
    
    func showSelectedStatus(left:Bool)
    {
        if(left) {
            centerButton.customColor = UIColor(red: 25.0/255.0, green: 117.0/255.0, blue: 207.0/255.0, alpha: 1.0);
            centerButton.accessIndicate.image = UIImage(named: "arrDown_yellow")
            
            rightButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
            leftButton.customColor =  UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
            
            
            rightButton.accessIndicate!.image = UIImage(named: "arrDown")
            leftButton.accessIndicate!.image = UIImage(named: "arrDown_yellow")
        }else{
            rightButton.customColor = UIColor(red: 25.0/255.0, green: 117.0/255.0, blue: 207.0/255.0, alpha: 1.0);
            rightButton.accessIndicate.image = UIImage(named: "arrDown_yellow")
            
            leftButton.customColor =  UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
            centerButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
            
            leftButton.accessIndicate!.image = UIImage(named: "arrDown")
            centerButton.accessIndicate!.image = UIImage(named: "arrDown")
        }
        
    }
    
    func showUnSelectedStatus()
    {
        leftButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
        rightButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
        centerButton.customColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0);
        
        leftButton.accessIndicate!.image = UIImage(named: "arrDown")
        rightButton.accessIndicate!.image = UIImage(named: "arrDown")
        centerButton.accessIndicate!.image = UIImage(named: "arrDown")
    }
    
    //显示筛选条件列表
    func showLeftTable(sender:AnyObject!)
    {
        rightButton.changeArrowDirectionUp(false)
        rightButton.isToggle = false;
        rightComboxView.dismissView()
        centerButton.changeArrowDirectionUp(false)
        centerButton.isToggle = false;
        centerComboxView.dismissView()
        
        if(leftButton.isToggle) {
            leftComboxView.dismissView()
            leftButton.changeArrowDirectionUp(false)
        }else{
            leftComboxView.showInView(self.view)
            leftButton.changeArrowDirectionUp(true)
            leftButton.isToggle = true;
            leftComboxView.tableView.reloadData()
            
        }
        showSelectedStatus(true)
//        self.tableView.footerHidden = true
    }
    
    //显示筛选条件列表
    @IBAction func showRightTable(sender:AnyObject!)
    {
        QWGlobalManager.sharedInstance().statisticsEventId("领券中心_全部优惠券_按药房查找", withLable: "领券中心_全部优惠券_按药房查找", withParams: nil)
        leftButton.changeArrowDirectionUp(false)
        leftButton.isToggle = false;
        leftComboxView.dismissView()
        centerButton.changeArrowDirectionUp(false)
        centerButton.isToggle = false
        centerComboxView.dismissView()
        
        if(rightButton.isToggle) {
            rightComboxView.dismissView()
            rightButton.changeArrowDirectionUp(false)
        }else{
            let height:CGFloat
            if(self.cityRange.count <= 5){
                height = CGFloat(self.cityRange.count * 44)
            }else{
                height = CGFloat(220)
            }
            rightComboxView.tableView.frame = CGRectMake(0, 0, APP_WH, height)
            rightComboxView.showInView(self.view)
            rightButton.changeArrowDirectionUp(true)
            rightButton.isToggle = true
            rightComboxView.tableView.reloadData()
        }
        showSelectedStatus(false)
//        self.tableView.footerHidden = true
    }
    
    func showCenterTable(sender:AnyObject!)
    {
        leftButton.changeArrowDirectionUp(false)
        leftButton.isToggle = false
        leftComboxView.dismissView()
        QWGlobalManager.sharedInstance().statisticsEventId("领券中心_全部优惠券_满额金额", withLable: "领券中心_全部优惠券_满额金额", withParams: nil)
        rightButton.changeArrowDirectionUp(false)
        centerButton .changeArrowDirectionUp(false)
        rightButton.isToggle = false;
        rightComboxView.dismissView()
        centerComboxView.tableView.reloadData()
        if(centerButton.isToggle) {
            centerComboxView.dismissView()
            centerButton.changeArrowDirectionUp(false)
        }else{
            centerComboxView.showInView(self.view)
            centerButton.changeArrowDirectionUp(true)
            centerButton.isToggle = true;
        }
        showSelectedStatus(true)
//        self.tableView.footerHidden = true
    }
    
    func comboxViewDidDisappear(comboxView:ComboxView!) {
        if(comboxView.isEqual(rightComboxView)){
            rightButton.changeArrowDirectionUp(false)
            rightButton.isToggle = false
        }
        else if(comboxView.isEqual(centerComboxView)){
            centerButton.changeArrowDirectionUp(false)
            centerButton.isToggle = false
        }
        else{
            leftButton.isToggle = false;
            leftButton.changeArrowDirectionUp(false)
        }
        if(!centerButton.isToggle && !leftButton.isToggle && !rightButton.isToggle) {
            showUnSelectedStatus()
        }
    }
    
    //查询领券中心Banner
    func queryCouponBanner()
    {
        QWGlobalManager.sharedInstance().readLocationWhetherReLocation(false, block: { (mapInfoModel:MapInfoModel!) -> Void in
            let modelR:ConfigInfoQueryModelR? = ConfigInfoQueryModelR()
            if((mapInfoModel) != nil) {
                modelR!.province = mapInfoModel.province
                modelR!.city = mapInfoModel.city
            }else{
                modelR!.province = "江苏省"
                modelR!.city = "苏州市"
            }
            modelR!.place = "3"
            
            ConfigInfo.configInfoQueryBanner(modelR, success: { (result:BannerInfoListModel!) -> Void in
                if(result.list.count == 0){
                    self.bannerList = NSArray()
                    self.topTableView.tableHeaderView = nil
                }else{
                    self.bannerList = result.list
                    self.cycleScrollView.reloadData()
                    self.cycleScrollView.startAutoScroll(5.0)
                    self.topTableView.tableHeaderView = self.cycleScrollView
                }
                
                }, failure: { (error:HttpException!) -> Void in
                    if(error.errorCode != -999){
                        if(error.errorCode == -1001)
                        {
                            self.showInfoInView(self.tableView, offsetSize: 0, text: kWarning215N26, image:  "ic_img_fail")
                        }else{
                            if(self.normalCoupons.count == 0 && self.topCoupons.count == 0) {
                                self.showInfoInView(self.tableView, offsetSize: 0, text: kWarning39, image:  "ic_img_fail")
                            }
                        }
                    }
            })
        })
    }
    
    func cacheCouponBannerData(array:[AnyObject]!)
    {
        BannerInfoModel.saveObjToDBWithArray(array)
    }
    
    func loadBannerCacheData() -> [AnyObject]!
    {
        return BannerInfoModel.getArrayFromDBWithWhere(nil)
    }
    
    //查看领券中心列表数据,需要配合对应的筛选条件
    func queryCouponCenterList(refresh:Bool)
    {
        self.removeInfoView()
        
        QWGlobalManager.sharedInstance().readLocationWhetherReLocation(false, block: { (mapInfoModel:MapInfoModel!) -> Void in
            
            let modelR = BranchFournNewModelR()
            modelR.branchId = mapInfoModel.branchId
            modelR.token = QWGlobalManager.sharedInstance().configure.userToken
            modelR.currPage = 1
            modelR.pageSize = 10000
            Coupon.couponQueryBranchFournNew(modelR, success: {[unowned self] (model:BranchCouponListVoModel!) in
                if(model?.coupons?.count > 0) {
                    self.topCoupons.removeAllObjects()
                    self.topCoupons = NSMutableArray(array: model.coupons)
                    self.hidePharmacyTicketEmpty()
                }else{
                    self.topCoupons.removeAllObjects()
                    self.showPharmacyTicketEmpty("此药房暂无优惠券")
                }
                self.topTableView.reloadData()
                
                let modelR:CouponQueryInCityModelR? = CouponQueryInCityModelR()
                if((mapInfoModel) != nil) {
                    modelR!.cityName = mapInfoModel.branchCityName
                }else{
                    modelR!.cityName = "苏州市"
                }
                modelR!.token = QWGlobalManager.sharedInstance().configure.userToken
                let type:String
                //224药房筛选条件
                if(self.rightIndex == 0){
                    modelR!.groupId = "";
                    type = "全部药房"
                    
                }else{
                    let vo:GroupFilterVo = self.cityRange[self.rightIndex] as! GroupFilterVo
                    modelR!.groupId = vo.groupId;
                    type = vo.groupName
                }
                let price:String
                if(self.priceRange.count == 1 || self.centerIndex == 0) {
                    price = ""
                    QWGlobalManager.sharedInstance().statisticsEventId("领券中心_全部优惠券_满额金额", withLable: "领券中心_全部优惠券_满额金额", withParams: nil)
                }else{
                    let conditionModel:ConditionAmountVoModel = self.priceRange[self.centerIndex] as! ConditionAmountVoModel
                    modelR!.amountRange = String(format: "%d%@%d", conditionModel.min,SeparateStr,conditionModel.max)
                    price = modelR!.amountRange
                }
                
                let model = StatisticsModel()
                model.eventId = "e_coupon_list"
                let dic:Dictionary = ["model优惠券类型":type ,"满额金额":price]
                model.params = NSMutableDictionary(dictionary: dic)
                
                if(refresh) {
                    self.currentPage = 1
                    modelR!.page = NSString(format: "%d", self.currentPage++) as String
                }else{
                    
                    modelR!.page = NSString(format: "%d", self.currentPage++) as String
                }
                modelR!.pageSize = "10"
                Coupon.couponQueryInCity(modelR, success: { [unowned self] (result:OnlineCouponVoListModel!) -> Void in
                    if(result.apiStatus.longValue != 0)
                    {
                        self.tableView.footer!.canLoadMore = false
                        self.tableView.footerEndRefreshing()
                        self.showCurrentCityTicketEmpty(result.apiMessage)
                        self.normalCoupons.removeAllObjects()
                        self.reloadAllTableView()
                        return
                    }
                    let list:OnlineCouponVoListModel = result as OnlineCouponVoListModel
                    
                    if(refresh) {
                        self.normalCoupons = NSMutableArray(array: list.coupons)
                        self.tableView.headerEndRefreshing()
                    }else{
                        
                        self.normalCoupons.addObjectsFromArray(list.coupons)
                    }
                    if(list.coupons?.count == 0) {
                        self.tableView.footer!.canLoadMore = false
                        self.tableView.footerEndRefreshing()
                    }else{
                        if(!self.tableView.footer!.canLoadMore) {
                            self.tableView.footer!.canLoadMore = true
                        }
                        self.tableView.footerEndRefreshing()
                        self.hideCurrentCityTicketEmpty()
                    }
                    if(self.normalCoupons?.count == 0) {
                        self.showCurrentCityTicketEmpty(result.apiMessage)
                    }
                    
                    self.reloadAllTableView()
                    }, failure: { (error:HttpException!) -> Void in
                        
                        
                })
                
                }, failure: nil)
            
            
        })
        
    }
    
    func showPharmacyTicketEmpty(text:String)
    {
        let emptyImage:UIImageView = UIImageView.init(frame: CGRectMake((APP_WH - 90.0) / 2.0, 160, 90, 90))
        emptyImage.image = UIImage.init(named: "icon_coupons_default")
        let emptyLabel:UILabel = UILabel.init(frame: CGRectMake((APP_WH - 300.0) / 2.0, 250, 300.0, 90))
        emptyLabel.textAlignment = .Center;
        emptyLabel.text = text
        emptyLabel.font = UIFont.systemFontOfSize(18)
        emptyLabel.textColor = UIColor.init(red: 192.0/255.0, green: 197.0/255.0, blue: 208/255.0, alpha: 1.0)
        emptyImage.tag = 1888
        emptyLabel.tag = 1888
        self.topTableView.addSubview(emptyImage)
        self.topTableView.addSubview(emptyLabel)
    }
    
    func hidePharmacyTicketEmpty()
    {
        for view in self.topTableView.subviews
        {
            if(view.tag == 1888) {
                view.removeFromSuperview()
            }
        }
    }
    
    func showCurrentCityTicketEmpty(text:String)
    {
        let emptyImage:UIImageView = UIImageView.init(frame: CGRectMake((APP_WH - 90.0) / 2.0, 160, 90, 90))
        emptyImage.image = UIImage.init(named: "icon_coupons_default")
        let emptyLabel:UILabel = UILabel.init(frame: CGRectMake((APP_WH - 300.0) / 2.0, 250, 300.0, 90))
        emptyLabel.textAlignment = .Center;
        emptyLabel.text = text
        emptyLabel.font = UIFont.systemFontOfSize(18)
        emptyLabel.textColor = UIColor.init(red: 192.0/255.0, green: 197.0/255.0, blue: 208/255.0, alpha: 1.0)
        emptyImage.tag = 1888
        emptyLabel.tag = 1888
        self.tableView.addSubview(emptyImage)
        self.tableView.addSubview(emptyLabel)
    }
    
    func hideCurrentCityTicketEmpty()
    {
        for view in self.tableView.subviews
        {
            if(view.tag == 1888) {
                view.removeFromSuperview()
            }
        }
    }
    
    override func viewInfoClickAction(sender: AnyObject!)
    {
        if(QWGlobalManager.sharedInstance().currentNetWork != NetworkStatus.NotReachable) {
            self.removeInfoView()
            self.tableView?.delegate = self;
            self.tableView?.dataSource = self;
            queryCouponBanner()
            queryCouponCenterList(true)
            queryCouponCondition()
            queryBanchCondition()
        }
    }
    
    func cacheCouponCenterListData(topArrays:[AnyObject]!,normalArrays:[AnyObject]!)
    {
        OnlineCouponVoModel.saveObjToDBWithArray(topArrays)
        OnlineCouponVoModel.saveObjToDBWithArray(normalArrays)
    }
    
    func loadCouponCenterListData() -> [AnyObject]!
    {
        return BannerInfoModel.getArrayFromDBWithWhere(nil)
    }
    
    //获取满额金额筛选条件
    func queryCouponCondition()
    {
        Coupon.couponConditions(nil, success: {[unowned self] (listModel:ConditionAmountVoListModel!) -> Void in
            self.priceRange.addObjectsFromArray(listModel.conditions)
//            self.rightComboxView.tableView.reloadData()
            }) { (e:HttpException!) -> Void in
            
        }
    }
    //获取药房筛选条件
    func queryBanchCondition()
    {
        QWGlobalManager.sharedInstance().readLocationWhetherReLocation(false) { (mapInfo:MapInfoModel!) -> Void in
            
            let cityModelR:CouponListModelR = CouponListModelR()
            
            cityModelR.city = mapInfo.city;
            
            Coupon.couponCityConditions(cityModelR, success: {[unowned self] (cityList:GroupFilterListVo!) -> Void in
                if(cityList.apiStatus.integerValue == 0) {
                    self.cityRange.addObjectsFromArray(cityList.groups)
//                self.rightComboxView.tableView.reloadData()
                }
                }) { (e:HttpException!) -> Void in
                    
            }
            
        }
        
        
        
    }
    
    func cacheCouponConditionData(array:[AnyObject]!)
    {
        BannerInfoModel.saveObjToDBWithArray(array)
    }
    
    func loadCouponConditionData() -> [AnyObject]!
    {
        return BannerInfoModel.getArrayFromDBWithWhere(nil)
    }
    
    override func popVCAction(sender: AnyObject!) {
        self.cycleScrollView.stopAutoScroll()
        let dictionayMu = NSMutableDictionary.init(capacity: 10)
        QWGlobalManager.sharedInstance().statisticsEventId("x_lqzx_fh", withLable: "领券中心", withParams: dictionayMu)
        super.popVCAction(sender);
    }
    
    func didClickPage(csView: XLCycleScrollView!, atIndex index: Int) {
        self.cycleScrollView.stopAutoScroll()
        
        let model:BannerInfoModel! = self.bannerList[index] as! BannerInfoModel
        QWGlobalManager.sharedInstance().pushIntoDifferentBannerType(model, navigation: self.navigationController, bannerLocation:"领券中心",selectedIndex: index)
    }
    
    func scollerToindex(index: UInt) {
        
    }
    
    func didScrolltoPage(csView: XLCycleScrollView!, atIndex index: UInt) {
        
    }
    
    func numberOfPages() -> Int {
        return self.bannerList.count
    }
    
    func pageAtIndex(index: Int) -> UIView! {
        let imageView = UIImageView(frame: CGRectMake(0, 0, APP_WH, APP_WH / 320.0 * 100))
        let imageModel:BannerInfoModel = self.bannerList[index] as! BannerInfoModel
        imageView .setImageWithURL(NSURL(string: imageModel.imgUrl), placeholderImage: UIImage(named: "img_banner_nomal"))
        return imageView
    }
    
    //点击分享
    func couponShareClick()
    {
        let model:ShareContentModel = ShareContentModel()
        model.typeShare = UMengShareType.ShareTypeGetCouponList
        let modelR:ShareSaveLogModel = ShareSaveLogModel()
        let mapInfoModel:MapInfoModel? = QWUserDefault.getObjectBy(APP_MAPINFOMODEL) as? MapInfoModel
        
        if((mapInfoModel) != nil) {
            modelR.city = mapInfoModel?.city
            modelR.province = mapInfoModel?.province
        }else{
            modelR.city = "苏州市"
            modelR.province = "江苏省"
        }
        modelR.shareObj = "0"
        modelR.shareObjId = ""
        model.modelSavelog = modelR
        let dictionayMu = NSMutableDictionary.init(capacity: 10)
        QWGlobalManager.sharedInstance().statisticsEventId("领券中心_分享", withLable: "领券中心_分享", withParams: dictionayMu)
        self.popUpShareView(model)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(atableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(atableView.isEqual(self.tableView)) {
            return normalCoupons.count
        }else if(atableView.isEqual(self.topTableView)){
            return topCoupons.count + 1
        }else if(atableView.isEqual(leftComboxView.tableView)) {
            return leftMenuItems.count
        }else if(atableView.isEqual(rightComboxView.tableView)) {
            return self.cityRange.count
        }else {
            if(self.priceRange.count > 0){
                return self.priceRange.count
            }else{
                return 1
            }
        }
    }
    
    func tableView(atableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if(atableView.isEqual(self.tableView) || atableView.isEqual(self.topTableView)) {
            if(atableView.isEqual(self.topTableView) && indexPath.row  == self.topCoupons.count) {
                var height:CGFloat = 0.0;
                if(self.bannerList.count > 0) {
                    height += self.cycleScrollView.frame.height;
                }
                height += CGFloat(self.topCoupons.count) * VFourCouponQuanTableViewCell.getCellHeight(nil)
                return max(0,self.topTableView.frame.size.height - height)
            }else{
                return  VFourCouponQuanTableViewCell.getCellHeight(nil)
            }
        }else{
            return 44.0
        }
    }
    
    func tableView(atableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if(atableView.isEqual(self.tableView) || atableView.isEqual(self.topTableView)) {
            if(atableView.isEqual(self.topTableView) && indexPath.row  == self.topCoupons.count)
            {
                let cell:UITableViewCell = UITableViewCell.init()
                cell.backgroundColor = UIColor.clearColor()
                cell.selectionStyle = .None
                cell.contentView.backgroundColor = UIColor.clearColor()
                return cell
            }
            var couponModel:OnlineCouponVoModel! = nil
            if(atableView.isEqual(self.tableView)) {
                couponModel = self.normalCoupons[indexPath.row] as! OnlineCouponVoModel
            }else{
                couponModel = self.topCoupons[indexPath.row] as! OnlineCouponVoModel
            }
            let cell = atableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? VFourCouponQuanTableViewCell
            cell!.setCouponCenterQuan(couponModel);
            return cell!
        }
        else{
            let cell:ComboxViewCell! = atableView.dequeueReusableCellWithIdentifier(MenuIdentifier,forIndexPath:indexPath) as! ComboxViewCell
            
            var content:String! = nil
            var showImage:Bool! = false

            if(atableView.isEqual(leftComboxView.tableView))
            {
                content = leftMenuItems[indexPath.row] as! String;
                if(indexPath.row == leftIndex) {
                    showImage = true;
                }
                cell.setCellWithContent(content, showImage: showImage)
            }else if (atableView.isEqual(centerComboxView.tableView)){
                if(indexPath.row == 0) {
                    content = "满额金额"
                }else{
                    let conditionModel:ConditionAmountVoModel = self.priceRange[indexPath.row] as! ConditionAmountVoModel
                    content = String(format: "%d - %d", conditionModel.min,conditionModel.max)
                }
                if(indexPath.row == centerIndex) {
                    showImage = true;
                }
                cell.setCellWithContent(content, showImage: showImage)
            }else{
                if indexPath.row == 0{
                    content = "全部药房"
                }else{
                     let vo:GroupFilterVo = self.cityRange[indexPath.row] as! GroupFilterVo
                    content = vo.groupName;
                }
                if(indexPath.row == rightIndex) {
                    showImage = true;
                }
                cell.setCellWithContent(content, showImage: showImage)
            }
            
            return cell
        }
    }
    
    func tableView(atableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        atableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(atableView.isEqual(self.tableView) || atableView.isEqual(self.topTableView)){
            if(atableView.isEqual(self.topTableView) && indexPath.row  == self.topCoupons.count)
            {
                return
            }
            var couponModel:OnlineCouponVoModel! = nil
            let dictionayMu = NSMutableDictionary.init(capacity: 10)
            if(atableView.isEqual(self.tableView)) {
                couponModel = self.normalCoupons[indexPath.row] as! OnlineCouponVoModel
            }else{
                couponModel = self.topCoupons[indexPath.row] as! OnlineCouponVoModel
            }
            dictionayMu["是否置顶"] = "否"
            dictionayMu["优惠券内容"] = couponModel.couponRemark
            dictionayMu["是否开通微商"] = QWGlobalManager.sharedInstance().weChatBusiness ? "是" : "否";
            QWGlobalManager.sharedInstance().statisticsEventId("x_lqzx_dj", withLable: "领券中心", withParams: dictionayMu)
            if(couponModel.empty) {
                //如果该券已经领完,直接返回
                return
            }
            let viewC:CenterCouponDetailViewController = CenterCouponDetailViewController.init(nibName: "CenterCouponDetailViewController", bundle: nil);
            viewC.couponId=couponModel.couponId
            viewC.centerModel=couponModel;
            self.navigationController?.pushViewController(viewC, animated: true)
        }else if (atableView.isEqual(leftComboxView.tableView)){
            leftIndex = indexPath.row
            leftButton.buttonTitle = leftMenuItems[indexPath.row] as! String
            leftComboxView.dismissView();
            //发送接口重新搜索数据
            queryCouponCenterList(true)
            leftComboxView.tableView.reloadData()
            let dictionayMu = NSMutableDictionary.init(capacity: 10)
            dictionayMu["筛选内容"] = leftButton.buttonTitle
            QWGlobalManager.sharedInstance().statisticsEventId("x_lqzx_sx1", withLable:"领券中心", withParams: dictionayMu)
        }else  if (atableView.isEqual(rightComboxView.tableView)){
            rightIndex = indexPath.row;
            
            if(indexPath.row == 0){
                rightButton.buttonTitle = "全部药房"
            }else{
                 let vo:GroupFilterVo = self.cityRange[indexPath.row] as! GroupFilterVo
                rightButton.buttonTitle = vo.groupName
            }
            rightComboxView.dismissView()
            queryCouponCenterList(true)
            rightComboxView.tableView.reloadData()
            let dictionayMu = NSMutableDictionary.init(capacity: 10)
            dictionayMu["筛选内容"] = rightButton.buttonTitle
            QWGlobalManager.sharedInstance().statisticsEventId("领券中心_全部优惠券_按药房查找", withLable: "领券中心_全部优惠券_按药房查找", withParams: dictionayMu)
        }else{
            centerIndex = indexPath.row;
            var content:String! = nil
            if(indexPath.row == 0) {
                content = "满额金额"
            }else{
                let conditionModel:ConditionAmountVoModel = self.priceRange[indexPath.row] as! ConditionAmountVoModel
                content = String(format: "%d - %d", conditionModel.min,conditionModel.max)
            }
            
            centerButton.buttonTitle = content
            centerComboxView.dismissView()
            queryCouponCenterList(true)
            centerComboxView.tableView.reloadData()
        }
    }
    @IBAction func scrollToTop(sender: AnyObject)
    {
        self.tableView.setContentOffset(CGPointMake(0, 0), animated: true);
    }

    override func scrollViewDidScroll(scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if(scrollView.isEqual(self.tableView)) {
            fixedChooseStatusBar()
        }
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        super.scrollViewDidEndDragging(scrollView, willDecelerate: decelerate)
        if(scrollView.isEqual(self.tableView)) {
            //self.switchScreent()
        }
    }
    
    func fixedChooseStatusBar()
    {
        if(headerView != nil) {
            var rect = self.tableView.convertRect(headerView.frame, toView: self.view)
            if(rect.origin.y <= 0) {
                //需要固定在顶部
                if(headerView.superview != self.view) {
                    self.view.addSubview(self.headerView)
                    self.view.bringSubviewToFront(self.headerView)
                    var headRect = self.headerView.frame
                    headRect.origin = CGPointMake(0, 0)
                    self.headerView.frame = headRect
                }
            }else{
                //需要返回固定在tableview上
                if(headerView.superview != self.tableView) {
                    self.tableView.addSubview(self.headerView)
                    self.tableView.sendSubviewToBack(self.headerView)
                    var headRect = self.headerView.frame
                    headRect.origin = CGPointMake(0, 35)
                    self.headerView.frame = headRect
                }
            }
        }
    }
    
    func getCouponTicket(sender:UIButton!)
    {
        //在Cell上立即领取,必须先登录
        if(!QWGlobalManager.sharedInstance().loginStatus) {
            let loginViewController:LoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            let navigationController:QWBaseNavigationController = QWBaseNavigationController(rootViewController: loginViewController)
            loginViewController.isPresentType = true
            self.presentViewController(navigationController, animated: true, completion: { () -> Void in
                
            })
            return;
        }
        
        var couponModel:OnlineCouponVoModel! = nil
        if(topCoupons.count == 0) {
            couponModel = self.normalCoupons[sender.tag] as! OnlineCouponVoModel
            
        }else{
            if(sender.tag < 10000) {
                couponModel = self.topCoupons[sender.tag] as! OnlineCouponVoModel
            }else{
                couponModel = self.normalCoupons[sender.tag % 10000] as! OnlineCouponVoModel
            }
        }
//        if((couponModel.pick) || (couponModel.empty)) {
//            return
//        }
        if((couponModel.limitLeftCounts == 0) || (couponModel.empty)) {
            return
        }
        //如果是慢病券,需要校验用户是否是慢病用户
        if(couponModel.chronic) {
            let modelR:QueryFamilyMembersR = QueryFamilyMembersR()
            modelR.token = QWGlobalManager.sharedInstance().configure.userToken;
            FamilyMedicine.checkChronicDiseaseUser(modelR, success: {[unowned self] (model:ChronicDiseaseUserVoModel!) -> Void in
                
                //如果是慢病用户,直接调用接口领取
                if(model.isChronicDiseaseUser == "Y")
                {
                    
                    self.pickCouponTicket(couponModel)
                }else{
                    //否则提示用户先成为慢病用户
                    PromotionCustomAlertView.showCustomAlertViewAtView(self.view, withTitle: "只有慢病用户才能享受该优惠哦", andCancelButton: "我是慢病用户", andConfirmButton: "不领了", highLight: false, showImage: false, andCallback: {(index:NSInteger) -> Void in
                        
                        if(index == 0) {
                            if(QWUserDefault.getBoolBy(CHRONIC_DISEASE))
                            {
                                self.pushIntoMemberInfo()
                            }else{
                                QWUserDefault.setBool(true, key: CHRONIC_DISEASE)
                                self.pushIntoChronicDisease()
                            }
                        }
                    })
                }
                }, failure: { (e:HttpException!) -> Void in
            })
        }else{
            pickCouponTicket(couponModel)
        }
    }
    
    //领取优惠券
    func pickCouponTicket( couponModel:OnlineCouponVoModel)
    {
        
        let modelR:ActCouponPickModelR = ActCouponPickModelR()
        let mapInfoModel:MapInfoModel? = QWUserDefault.getObjectBy(APP_MAPINFOMODEL) as? MapInfoModel
        if((mapInfoModel) != nil) {
            modelR.city = mapInfoModel?.city
        }else{
            modelR.city = "苏州市"
        }
        modelR.token = QWGlobalManager.sharedInstance().configure.userToken;
        modelR.couponId = couponModel.couponId;
        modelR.platform = "2";
        modelR.version =  (NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
        
        Coupon.actCouponPick(modelR, success: { (myCouponVoModel:CouponPickVoModel!) -> Void in
            if(myCouponVoModel.apiStatus.longValue == 0) {
                couponModel.pick = true
                couponModel.myCouponId = myCouponVoModel.myCouponId
                couponModel.limitLeftCounts--
                if couponModel.limitLeftCounts <= 0 {
                    couponModel.limitLeftCounts = 0
                }
                self.reloadAllTableView()
                SVProgressHUD.showSuccessWithStatus("领取成功", duration: 0.8)
                let viewController:CouponSuccessViewController = CouponSuccessViewController(nibName: "CouponSuccessViewController", bundle: nil)
                myCouponVoModel.begin = couponModel.begin
                myCouponVoModel.end = couponModel.end
                viewController.myCouponModel = myCouponVoModel
                viewController.couponVoModel = couponModel;   //传过去couponModel，判断是否是预售券
                self.navigationController?.pushViewController(viewController, animated: true)
            }else{
                SVProgressHUD.showErrorWithStatus(myCouponVoModel.apiMessage, duration: 0.8)
            }
            }) { (e:HttpException!) -> Void in
                
        }

    }

    override func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        if(buttonIndex == 1) {
            if(QWUserDefault.getBoolBy(CHRONIC_DISEASE))
            {
                self.pushIntoMemberInfo()
            }else{
                QWUserDefault.setBool(true, key: CHRONIC_DISEASE)
                pushIntoChronicDisease()
            }
            
        }
        
    }
    
    //跳入家庭用药列表,添加慢病
    func pushIntoMemberInfo()
    {
        let viewController:FamilyMedicineListViewController! = UIStoryboard(name: "FamilyMedicineListViewController", bundle: nil).instantiateViewControllerWithIdentifier("FamilyMedicineListViewController") as! FamilyMedicineListViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    func pushIntoChronicDisease()
    {
        //引导用户认证为慢病用户
        let vcWebDirect:WebDirectViewController = UIStoryboard(name: "WebDirect", bundle: nil).instantiateViewControllerWithIdentifier("WebDirectViewController") as! WebDirectViewController
        //var strUrl:String = "http://192.168.5.250:8183/app/html/v2.2.0/slow_sick.html"
        
//        var strUrl:String = BASE_URL_V2 + "app/html/v2.2.0/" + "guide_page.html"
//        
//        
//        if(QWGlobalManager.sharedInstance().loginStatus) {
//            strUrl += String(format: "?token=%@", QWGlobalManager.sharedInstance().configure.userToken)
//        }else{
//            strUrl += String(format: "?token")
//            
//        }
//        vcWebDirect.setWVWithURL(strUrl, title: "如何认证慢病用户", withType:WebTitleType.WithJump)
        var modelChronicJump:WebDirectLocalModel? = WebDirectLocalModel()
        if let modelChronicJump = modelChronicJump {
            modelChronicJump.typeLocalWeb = WebLocalType.JumpChronicGuidePage
            vcWebDirect.setWVWithLocalModel(modelChronicJump)
        }
        
        vcWebDirect.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vcWebDirect, animated: true)
    }
    
    override func getNotifType(type: Enum_Notification_Type, data: AnyObject!, target obj: AnyObject!) {
        if(type == Enum_Notification_Type.NOtifCouponStatusChanged) {
            self.reloadAllTableView()
        }else if(type == Enum_Notification_Type.NotifLoginSuccess) {
            self.queryCouponCenterList(true)
        }
    }
    
    func reloadAllTableView() {
        self.tableView.reloadData()
        self.topTableView.reloadData()
    }
    

}
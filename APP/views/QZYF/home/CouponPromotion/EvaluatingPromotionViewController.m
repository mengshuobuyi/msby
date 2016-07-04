//
//  EvaluatingPromotionViewController.m
//  APP
//
//  Created by 李坚 on 15/8/26.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "EvaluatingPromotionViewController.h"
#import "RatingView.h"
#import "Promotion.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
#import "MyCouponDrugViewController.h"

@interface EvaluatingPromotionViewController ()<UITextViewDelegate,RatingViewDelegate>{
    CGFloat moveH;
    BOOL TextEditEnable;
}

@property (weak, nonatomic) IBOutlet RatingView *starView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *getButton;

@end

@implementation EvaluatingPromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"评价";
    
    TextEditEnable = YES;
    self.title = self.branchName;
    self.textView.delegate = self;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.cornerRadius = 4.0f;
    
    self.getButton.layer.masksToBounds = YES;
    self.getButton.layer.cornerRadius = 4.0f;
    [self.getButton addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = 4.0f;
    self.cancelButton.layer.borderWidth = 1.0f;
    self.cancelButton.layer.borderColor = RGBHex(qwColor2).CGColor;
    [self.cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    self.starView.userInteractionEnabled = YES;
    [self.starView setImagesDeselected:@"star_none_big" partlySelected:@"star_half_big" fullSelected:@"star_full_big" andDelegate:nil];
    self.starView.viewDelegate = self;
    [self.starView displayRating:self.star];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(sure:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
  
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification*)notification{
    
    NSDictionary*info=[notification userInfo];
    CGSize kbSize=[[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    DDLogVerbose(@"keyboard changed, keyboard width = %f, height = %f",
          kbSize.width,kbSize.height);
    
    //在这里调整UI位置
    CGFloat maxY = CGRectGetMaxY(self.textView.frame);
    CGFloat offset = APP_H - NAV_H - maxY - kbSize.height + 20;
    
    
    
    if(offset < 0){
        [UIView animateWithDuration:animationDuration animations:^{
            
            CGRect rect = self.view.frame;
            rect.origin.y = offset;
            self.view.frame = rect;
        }];
    }
}

- (void)keyboardWillHide:(NSNotification*)notification{
    
    NSDictionary*info=[notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y = NAV_H + 20;
        self.view.frame = rect;
    }];
}



- (void)hideKeyBoard{
    
    [self.textView resignFirstResponder];
}


-(void)ratingChanged:(float)newRating{
    
    self.star = newRating;
}

- (void)ratingChangeEnded:(float)newRating{
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    self.label.hidden = YES;

    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    if(textView.text.length > 99){

        [SVProgressHUD showErrorWithStatus:@"超过100个字符"];
        textView.text = [textView.text substringWithRange:NSMakeRange(0, 100)];
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if([self.textView.text isEqualToString:@""]){
        self.label.hidden = NO;
    }
    return YES;
}

#pragma mark - 提交按钮点击事件
- (void)sure:(id)sender{
    
    if(!QWGLOBALMANAGER.loginStatus){
        
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    if([self.textView.text isEqualToString:@""]){
        
        [SVProgressHUD showErrorWithStatus:@"请写点评价吧"];
        return;
    }
    if(self.star < 1.0){
        [SVProgressHUD showErrorWithStatus:@"请选择星星"];
        return;
    }
    if(self.textView.text.length > 100){
        [SVProgressHUD showErrorWithStatus:@"超过200个字符"];
        return;
    }
    commnetModelR *modelR = [commnetModelR new];
    modelR.orderId = self.orderId;
    modelR.star = self.star * 2;
    modelR.content = self.textView.text;
    modelR.token = QWGLOBALMANAGER.configure.userToken;
    
    [Promotion baseComment:modelR success:^(id obj) {
        
        BaseAPIModel *model = obj;
        if([model.apiStatus intValue] == 1){

            [SVProgressHUD showErrorWithStatus:model.apiMessage];
        }else{
            [SVProgressHUD showSuccessWithStatus:kWarning47];
            [self cancel:nil];
        }
        
    } failure:^(HttpException *e) {
        
//        [SVProgressHUD showErrorWithStatus:e.Edescription];
        
    }];
}

#pragma mark - 取消按钮点击事件
- (void)cancel:(id)sender{
    
    
    for(UIViewController *view in self.navigationController.viewControllers){
        if([view isKindOfClass:[MyCouponDrugViewController class]]){
            MyCouponDrugViewController *vc = (MyCouponDrugViewController *)view;
            vc.shouldJump = YES;
            [self.navigationController popToViewController:view animated:NO];
            return;
        }
    }
    MyCouponDrugViewController * myCouponDrug = [[MyCouponDrugViewController alloc]init];
    myCouponDrug.shouldJump = YES;
    [self.navigationController pushViewController:myCouponDrug animated:NO];
}

- (IBAction)popVCAction:(id)sender{
    if(self.didPopToRootView){
        [self cancel:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

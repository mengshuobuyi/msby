//
//  BuyerMessageViewController.m
//  APP
//
//  Created by PerryChen on 3/28/16.
//  Copyright © 2016 carret. All rights reserved.
//

#import "BuyerMessageViewController.h"
#import "SVProgressHUD.h"
@interface BuyerMessageViewController ()<UITextViewDelegate>
{
    NSInteger selectIndex;
    NSArray     *btnArray;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *paymentMethodSegControl;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UILabel *textCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *receiptBtn;
@property (nonatomic,strong) NSString *payway;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *midBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;

- (IBAction)actionPaymentMethod:(UISegmentedControl *)sender;
- (IBAction)actionRequireReceipt:(UIButton *)sender;

@end
@implementation BuyerMessageModel

@end
@implementation BuyerMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买家留言";
    selectIndex = -100;
    self.payway = [[NSString alloc]init];
    _commentTextView.delegate = self;
    _commentTextView.layer.cornerRadius = 5.0;
    _commentTextView.layer.borderColor = RGBHex(qwColor10).CGColor;
    _commentTextView.layer.borderWidth = 0.5;
    _commentTextView.layer.masksToBounds = YES;
    btnArray = @[_leftBtn,_midBtn,_rightBtn];
    
    UIButton *save = [[UIButton  alloc]initWithFrame:CGRectMake(0, 0,40,40)];
    save.titleLabel.font = fontSystem(kFontS3);
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save addTarget:self action:@selector(saveMessage)  forControlEvents:UIControlEventTouchUpInside];
    [save setTitleColor:RGBHex(qwColor1) forState:UIControlStateNormal];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithCustomView:save];
    self.navigationItem.rightBarButtonItem = btn;
    _receiptBtn.layer.cornerRadius = 3.0;
    _receiptBtn.layer.masksToBounds = YES;
    _receiptBtn.layer.borderWidth = 0.5;
    _receiptBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
   
     UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
     NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
     forKey:NSFontAttributeName];
     [_paymentMethodSegControl setTitleTextAttributes:attributes
     forState:UIControlStateNormal];
    if (_buyerMessage) {
        [self dealWithMessage];
    }
    
/*
 text
 */
    _leftBtn.layer.cornerRadius = 3.0;
    _leftBtn.layer.masksToBounds = YES;
    _leftBtn.layer.borderWidth = 0.5;
    _leftBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
    
    _rightBtn.layer.cornerRadius = 3.0;
    _rightBtn.layer.masksToBounds = YES;
    _rightBtn.layer.borderWidth = 0.5;
    _rightBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
    
    _midBtn.layer.masksToBounds = YES;
    _midBtn.layer.borderWidth = 0.5;
    _midBtn.layer.borderColor = RGBHex(qwColor1).CGColor;
    
}

-(void)dealWithMessage {
    if (_buyerMessage.selectedIndex >= 0) {
        UIButton *btn = btnArray[_buyerMessage.selectedIndex];
        btn.selected = YES;
        [btn setBackgroundColor:RGBHex(qwColor1)];
    }
    if (_buyerMessage.isselected) {
        _receiptBtn.selected = YES;
        [_receiptBtn setBackgroundColor:RGBHex(qwColor1)];
    }
    if (![_buyerMessage.message isEqualToString:@""]) {
        _commentTextView.text = _buyerMessage.message;
        _placeHolderLabel.hidden = YES;
        _textCountLabel.text = [NSString stringWithFormat:@"%d/50",_commentTextView.text.length];
    }
}

-(void)saveMessage {
    if (_commentTextView.text.length > 50) {
        [SVProgressHUD showErrorWithStatus:@"留言超出50字" duration:1.0];
        return;
    }
    BuyerMessageModel *model = [BuyerMessageModel new];
    model.selectedIndex = -1;
    for (int index = 0; index<3; index ++) {
        UIButton *btn = btnArray[index];
        if (btn.selected) {
            model.selectedIndex = index;
            [self choosePayway:index];
            break;
        }
    }
    NSString *rece = @"";
    if (_receiptBtn.isSelected) {
        if (StrIsEmpty(_payway)) {
            rece = @"要发票";
        }else {
            rece = @"/要发票";
        }
    }else {
        rece = @"";
    }
    NSString *comment = @"";
    if (StrIsEmpty(_payway) && !_receiptBtn.isSelected) {
        
    }else {
        comment = @"/";
    }
    if (!StrIsEmpty(_commentTextView.text)) {
        comment = [NSString stringWithFormat:@"%@%@",comment,_commentTextView.text];
    }else {
        comment = @"";
    }
    NSString *messageAll = [NSString stringWithFormat:@"%@%@%@",_payway?_payway:@"",rece?rece:@"",comment];
    model.isselected = _receiptBtn.isSelected;
    model.message = _commentTextView.text;
    if (self.message) {
        self.message(messageAll,model);
    }
    [self popVCAction:nil];
}

- (IBAction)actionPaymentMethod:(UISegmentedControl *)sender {

}

-(void)choosePayway:(NSInteger)index {
    switch (index) {
        case 0:
            self.payway = @"刷卡";
            break;
        case 1:
            self.payway = @"现金";
            break;
        case 2:
            self.payway = @"手机支付";
            break;
        default:
            self.payway = @"";
            break;
    }
}
- (IBAction)payWay:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (UIButton *btn in btnArray) {
        if (btn != sender) {
            btn.selected = NO;
            [btn setBackgroundColor:RGBHex(qwColor4)];
        }
    }
    if (sender.isSelected) {
        [sender setBackgroundColor:RGBHex(qwColor1)];
    }else {
        [sender setBackgroundColor:RGBHex(qwColor4)];
    }
}

- (IBAction)actionRequireReceipt:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [sender setBackgroundColor:RGBHex(qwColor1)];
    }else {
        [sender setBackgroundColor:RGBHex(qwColor4)];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    _placeHolderLabel.hidden = YES;
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        _placeHolderLabel.hidden = NO;
        [textView endEditing:YES];
    }else {
        _placeHolderLabel.hidden = YES;
        if (textView.text.length > 50) {
            [SVProgressHUD showErrorWithStatus:@"留言超出50字" duration:0.8f];
            textView.text = [textView.text substringToIndex:50];
        }
    }
    _textCountLabel.text = [NSString stringWithFormat:@"%lu/50",(unsigned long)textView.text.length];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""] && range.length > 0) {
        return YES;
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return YES;
    }
    if (range.location + text.length < 51) {
        return YES;
    }else {
        [SVProgressHUD showErrorWithStatus:@"留言超出50字" duration:0.8f];
        return NO;
    }
}
@end

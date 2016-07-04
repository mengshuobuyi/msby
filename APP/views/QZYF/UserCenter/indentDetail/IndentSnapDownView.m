//
//  IndentSnapDownView.m
//  APP
//
//  Created by qw_imac on 16/3/14.
//  Copyright © 2016年 carret. All rights reserved.
//

#import "IndentSnapDownView.h"

@implementation IndentSnapDownView

+(IndentSnapDownView *)indentSnapDownView{
    IndentSnapDownView *snapView = [[NSBundle mainBundle]loadNibNamed:@"IndentSnapDownView" owner:nil options:nil][0];
    return snapView;
}
-(void)updateUI:(double)time{
    NSInteger min = time / 60;
    NSInteger sec = time - min * 60;
    self.minLabel.text = [NSString stringWithFormat:@"%02i",min];
    self.secLabel.text = [NSString stringWithFormat:@"%02i",sec];
}

@end

//
//  MedicineListCell.m
//  wenyao
//
//  Created by Meng on 14-9-28.
//  Copyright (c) 2014年 xiezhenghong. All rights reserved.
//

#import "MedicineListCell.h"
#import "DrugModel.h"
#import "FavoriteModel.h"
#import "UIImageView+WebCache.h"
#import "CouponModel.h"
#import "FactoryModel.h"

@implementation MedicineListCell
@synthesize proName=proName;
@synthesize spec=spec;
@synthesize factory=factory;
@synthesize headImageView=headImageView;
@synthesize tagLabel=tagLabel;


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

+ (CGFloat)getCellHeight:(id)data{
    
    return 88.0f;
}

//setSenaioCell
- (void)setSenaioCell:(id)data
{
    [super setCell:data];
    HealthyScenarioDrugModel *senailModel=(HealthyScenarioDrugModel *)data;
    if (senailModel.proId) {
//        NSString *imageUrl = PORID_IMAGE(senailModel.proId);
        [self.headImageView setImageWithURL:[NSURL URLWithString:senailModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
    }
    if (self.headImageView.image == nil) {
        self.headImageView.image = [UIImage imageNamed:@"药品默认图片.png"];
    }
    
    
    
    //3.0的内容屏暂时隐藏
//    if([senailModel.promotionType intValue]==1){
//        self.coupnFlag.image=[UIImage imageNamed:@"ic_img_preferential"];
//    }else{
//        self.coupnFlag.hidden=YES;
//    }
    self.coupnFlag.hidden=YES;
}

- (void)setFactoryProductCell:(id)data{
    [super setCell:data];
    FactoryProduct *productModel=(FactoryProduct *)data;
    if (productModel.proId) {
//        NSString *imageUrl = PORID_IMAGE(productModel.proId);
        [self.headImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
    }
    if (self.headImageView.image == nil) {
        self.headImageView.image = [UIImage imageNamed:@"药品默认图片.png"];
    }
    
    
    //3.0的内容屏暂时隐藏
//    if([productModel.promotionType intValue]==1){
//        self.coupnFlag.image=[UIImage imageNamed:@"ic_img_preferential"];
//    }else{
//        self.coupnFlag.hidden=YES;
//    }
    self.coupnFlag.hidden=YES;
    
    self.factory.text = productModel.factory;
}

//我的收藏的列表
- (void)setMyFavCell:(id)data;
{
    [super setCell:data];
    MyFavProductListModel *productModel=(MyFavProductListModel *)data;
    if (productModel.proId) {
//        NSString *imageUrl = PORID_IMAGE(productModel.proId);
        [self.headImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
    }
    if (self.headImageView.image == nil) {
        self.headImageView.image = [UIImage imageNamed:@"药品默认图片.png"];
    }
    if([productModel.promotionType intValue]==1){
        self.coupnFlag.image=[UIImage imageNamed:@"ic_img_preferential"];
    }else{
        self.coupnFlag.hidden=YES;
    }
    
}




- (void)setCouponCell:(id)data{
    [super setCell:data];
    if([data isKindOfClass:[ProductsModel class]]){
        
        ProductsModel *mode = (ProductsModel *)data;
        self.proName.text = mode.name;
        self.spec.text = mode.spec;
        self.factory.text = mode.factory;
  
//        [self.headImageView setImageWithURL:[NSURL URLWithString:PORID_IMAGE(mode.proId)] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
        
[self.headImageView setImageWithURL:[NSURL URLWithString:mode.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
        
       
        
        if([mode.promotionType intValue]==1){
            self.coupnFlag.image=[UIImage imageNamed:@"ic_img_preferential"];
        }else{
            self.coupnFlag.hidden=YES;
        }
        
        return;
    }
}

- (void)setCell:(id)data{
    [super setCell:data];
    
    QueryProductByClassItemModel *productModel=(QueryProductByClassItemModel *)data;
    self.headImageView.image = [UIImage imageNamed:@"药品默认图片"];
    if (productModel.proId) {
        [self.headImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片"]];
    }else if (self.headImageView.image == nil) {
        self.headImageView.image = [UIImage imageNamed:@"药品默认图片"];
    }
    
    
    //3.0变成内容平，暂时隐藏
    self.coupnFlag.hidden=YES;
    
//    if([productModel.promotionType intValue]==1){
//        self.coupnFlag.image=[UIImage imageNamed:@"ic_img_preferential"];
//    }else{
//        self.coupnFlag.hidden=YES;
//    }
    self.factory.text = productModel.factory;
}

//组方
- (void)setFoumalCell:(id)data{
    [super setCell:data];
    
    
    DiseaseFormulaPruductclass *productModel=(DiseaseFormulaPruductclass *)data;
    if (productModel.proId) {
//        NSString *imageUrl = PORID_IMAGE(productModel.proId);
        [self.headImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
    }
    if (self.headImageView.image == nil) {
        self.headImageView.image = [UIImage imageNamed:@"药品默认图片.png"];
    }
    //3.0的内容屏暂时隐藏
//    if([productModel.promotionType intValue]==1){
//        self.coupnFlag.image=[UIImage imageNamed:@"ic_img_preferential"];
//    }else{
//        self.coupnFlag.hidden=YES;
//    }
    self.coupnFlag.hidden=YES;
    self.factory.text = productModel.factory;
}




-(void)setSearchCell:(id)data{
    [super setCell:data];
    productclassBykwId *productModel=(productclassBykwId *)data;
    if (productModel.proId) {
//        NSString *imageUrl = PORID_IMAGE(productModel.proId);
        [self.headImageView setImageWithURL:[NSURL URLWithString:productModel.imgUrl] placeholderImage:[UIImage imageNamed:@"药品默认图片.png"]];
    }
    if (self.headImageView.image == nil) {
        self.headImageView.image = [UIImage imageNamed:@"药品默认图片.png"];
    }
    self.proName.text = productModel.proName;
    self.spec.text = productModel.spec;
    if(productModel.factory){
        self.factory.text = productModel.factory;
    }else if (productModel.makeplace) {
        self.factory.text = productModel.makeplace;
    }
    
    if([productModel.promotionType intValue]==1){
        self.coupnFlag.image=[UIImage imageNamed:@"ic_img_preferential"];
    }else{
        self.coupnFlag.hidden=YES;
    }
}
- (void)UIGlobal{
    [super UIGlobal];
    self.contentView.backgroundColor = RGBHex(qwColor4);
    [self setSelectedBGColor:RGBHex(qwColor11)];
}
@end

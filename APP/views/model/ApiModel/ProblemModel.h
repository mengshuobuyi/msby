//
//  ProblemModel.h
//  APP
//
//  Created by qwfy0006 on 15/3/6.
//  Copyright (c) 2015年 carret. All rights reserved.
//

#import "BaseAPIModel.h"

@interface ProblemModel : BaseAPIModel

@end

//问题类型
@interface ProblemModule : BaseAPIModel

@property (strong, nonatomic) NSString          *classId;               //类型Id
@property (strong, nonatomic) NSString          *name;                  //名称
@property (strong, nonatomic) NSString          *moduleId;               //模块id
@end


@interface ProblemHomeModel : BaseAPIModel

@property (strong, nonatomic) NSString          *moduleId;               //模块id
@property (strong, nonatomic) NSString          *name;                   //名称
@property (strong, nonatomic) NSString          *imgUrl;                 //图片

@end

//常见用药问题列表
@interface ProblemListModel : BaseAPIModel

//@property (strong, nonatomic) NSString          *moduleId;               //模块id
@property (strong, nonatomic) NSString          *classId;               //类型Id
@property (strong, nonatomic) NSString          *teamId;                //问题组id
@property (strong, nonatomic) NSString          *question;              //问题
@property (strong, nonatomic) NSString          *answer;                //回答
@property (strong, nonatomic) NSString          *imgUr;                //图片url
              
@end

@interface ProblemListPage : BaseAPIModel

@property (strong, nonatomic) NSString          *imgUrl;                 //图片url
@property (strong, nonatomic) NSString          *page;              //当前页码
@property (strong, nonatomic) NSString          *pageSize;              //当前条数
@property (strong, nonatomic) NSString          *totalRecord;           //总共有多少条数据
@property (strong, nonatomic) NSString          *pageSum;             //总共有多少页
@property (strong, nonatomic) NSArray           *list;                  //当前页的内容

@end

//问题详情
@interface ProblemDetailModel : BaseAPIModel

@property (strong, nonatomic) NSString          *classId;               //类型Id
@property (strong, nonatomic) NSString          *teamId;                //问题组id
@property (strong, nonatomic) NSString          *imgUrl;                //图片url
@property (strong, nonatomic) NSString          *content;              //问答内容
@property (strong, nonatomic) NSString          *role;                 //角色 1：用户 2：药店

@end
@interface spmAssociationDisease : BaseAPIModel
@property (nonatomic,strong)NSString *currPage;
@property (nonatomic,strong)NSString *pageSize;
@property (nonatomic,strong)NSString *totalPage;
@property (nonatomic,strong)NSString *totalRecord;
@property (nonatomic,strong)NSArray  *data;

@end

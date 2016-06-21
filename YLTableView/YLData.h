//
//  ContentModal.h
//  YLTableView
//
//  Created by 鲁玉兰 on 16/6/20.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YLData : NSObject
@property (strong, nonatomic) NSString *headImageName;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userMode;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *contentImageName;
@property (assign, nonatomic, readonly) CGFloat cellHeight;
@property (assign, nonatomic) CGRect contentImageRect;

+ (instancetype)messageWithDict: (NSDictionary *)dict;


@end

//
//  YLContentTableViewCell.h
//  YLTableView
//
//  Created by 鲁玉兰 on 16/6/20.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLData.h"

@interface YLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userMode;
@property (weak, nonatomic) IBOutlet UILabel *content;

@property (nonatomic, strong) YLData *message;

@end

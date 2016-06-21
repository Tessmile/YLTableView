//
//  YLContentTableViewCell.m
//  YLTableView
//
//  Created by 鲁玉兰 on 16/6/20.
//  Copyright © 2016年 luyulan. All rights reserved.
//

#import "YLTableViewCell.h"
@interface YLTableViewCell()
@property (strong, nonatomic) UIImageView *contentImageView;
@end

@implementation YLTableViewCell

- (UIImageView *)contentImageView {
    if (!_contentImageView) {
        _contentImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_contentImageView];
    }
    return _contentImageView;
}


- (void)setMessage:(YLData *)message {
    _message = message;
    self.content.text = _message.content;
    self.headImageView.image = [UIImage imageNamed:_message.headImageName];
    self.userName.text = _message.userName;
    NSLog(@"content rect is %f",self.userMode.bounds.size.height);
    if (message.contentImageName.length) {
        self.contentImageView.hidden = NO;
        self.contentImageView.image = [UIImage imageNamed:message.contentImageName];
        self.contentImageView.frame = _message.contentImageRect;
       
    }
    else {
        self.contentImageView.hidden = YES;
    }
    
}
@end

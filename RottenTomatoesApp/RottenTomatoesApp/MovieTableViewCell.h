//
//  MovieTableViewCell.h
//  RottenTomatoesApp
//
//  Created by Tim Chiang on 2015/6/13.
//  Copyright (c) 2015年 Tim Chiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

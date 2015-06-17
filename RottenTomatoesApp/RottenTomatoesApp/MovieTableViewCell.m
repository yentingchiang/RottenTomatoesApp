//
//  MovieTableViewCell.m
//  RottenTomatoesApp
//
//  Created by Tim Chiang on 2015/6/13.
//  Copyright (c) 2015年 Tim Chiang. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
   
    [super prepareForReuse];
    
    self.posterView.image = nil;
    
}

@end

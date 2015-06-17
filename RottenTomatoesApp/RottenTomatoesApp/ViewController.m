//
//  ViewController.m
//  RottenTomatoesApp
//
//  Created by Tim Chiang on 2015/6/13.
//  Copyright (c) 2015年 Tim Chiang. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    
    NSString *postURLString = [self.movie valueForKeyPath:@"posters.detailed"];
    
    postURLString = [self convertPosterUrlStringToHeighRes:postURLString];
    [self.posterView setImageWithURL: [NSURL URLWithString:postURLString]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)convertPosterUrlStringToHeighRes: (NSString*)urlString {
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *retValue = urlString;
    if (range.length > 0) {
        retValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content5.flixster.com/"];
    }
    return retValue;
}


@end

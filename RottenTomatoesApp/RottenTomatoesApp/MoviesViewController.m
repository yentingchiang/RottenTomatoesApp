//
//  MoviesViewController.m
//  RottenTomatoesApp
//
//  Created by Tim Chiang on 2015/6/13.
//  Copyright (c) 2015年 Tim Chiang. All rights reserved.
//

#import "MoviesViewController.h"
#import "ViewController.h"
#import "MovieTableViewCell.h"
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD.h>

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;

@property (strong,nonatomic) UIRefreshControl *refreshControl;
@property (strong,nonatomic) UIView *headerView;
@property (strong,nonatomic) UILabel *errorLabel;

- (NSString*)getApiUrl;
- (void)loadData;
- (void)showNetworkErrorView:(BOOL)hidden;

@end

@implementation MoviesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self showNetworkErrorView:YES];
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull To Refresh"];
    [self.tableView addSubview:self.refreshControl];
    
    [self loadData];
    
}

- (void)showNetworkErrorView:(BOOL)hidden {

    if (self.errorLabel == nil) {
        self.errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        self.errorLabel.backgroundColor=[UIColor grayColor];
        self.errorLabel.textAlignment = NSTextAlignmentCenter;
        self.errorLabel.text = @"Network Error!";
        [self.tableView addSubview:self.errorLabel];
    }
    
    self.errorLabel.hidden = hidden;
}

- (void)handleRefresh:(UIRefreshControl *) refreshControl{
    [self performSelector:@selector(refreshData)];
}

- (void)refreshData {
    
    [self loadData];
    [self.refreshControl endRefreshing];
}

- (void)loadData {
    
    [SVProgressHUD show];
    
    NSString *apiUrlString = self.getApiUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiUrlString]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError != nil) {
           
            [self showNetworkErrorView:NO];
        }
        else{
            [self showNetworkErrorView:YES];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil ];
            self.movies = dict[@"movies"];
        }
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
        NSLog(@"end load data");
    }];
}

- (NSString*)getApiUrl {
    
    NSString *apiKey = @"dagqdghwaq3e3mxyrp7kmmj5";
    NSString *apiEndPoint = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=50&country=us&apikey=%@";

    NSString *apiUrlString = [NSString stringWithFormat:apiEndPoint, apiKey];
    
    return apiUrlString;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated: YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.movies.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.row];
    NSString *title = movie[@"title"];
    NSString *synopsis = movie[@"synopsis"];
    cell.titleLabel.text = title;
    cell.synopsisLabel.text = synopsis;
    
    NSString *postURLString = [movie valueForKeyPath:@"posters.thumbnail"];
    
    [cell.posterView setImageWithURL:[NSURL URLWithString: postURLString]];
    
    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MovieTableViewCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    ViewController *view = segue.destinationViewController;
    
    view.movie = movie;
    
}


@end

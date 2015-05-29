//
//  ViewController.m
//  tigerspikeList
//
//  Created by Paulo Pão on 10/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "ViewController.h"
#import "Library.h"
#import "CustomCell.h"
#import "Article.h"
#import "WebViewController.h"
// Used MBProgressHUD class from https://github.com/jdg/MBProgressHUD
// It is a load progress monitoring class that is very easily integrated and displays something is in progress
// In this case it was used to "10) Provide feedback to the user when performing any network request."
#import <MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSMutableArray *allArticles;
    
}

@property (strong, nonatomic)Library *library;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failedLoadArticles) name:@"loadFailure" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLoadingArticles) name:@"loadEnded" object:nil];
    
    self.library = [Library sharedInstance];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.library loadArticles];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)failedLoadArticles{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    if(NSClassFromString(@"UIAlertController")) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connection failed" message:@"Failed to retrieve data." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Connection failed"
                              message: @"Failed to retrieve data."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)finishedLoadingArticles{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    allArticles = [NSMutableArray arrayWithArray:[self.library getArticles]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
    
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160.0;
    
    return self.tableView.estimatedRowHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [allArticles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"listCell";
    
    Article *article = [allArticles objectAtIndex:[indexPath row]];
    
    CustomCell *cell = (CustomCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
    cell.titleLabel.text = article.aTitle;
    cell.descriptionLabel.text = article.aDescription;
    [cell.descriptionLabel sizeToFit];
    
    if ([article.aImage isEqual:[NSNull null]] || [article.aImage isEqualToString:@""]) {
        
        [cell.thumbnailImageView setImage:nil];
        [cell updateLabelConstraints];
        
    } else {
        
        [cell.thumbnailImageView sd_setImageWithURL:[NSURL URLWithString:article.aImage] placeholderImage:nil];
        [cell maintainLabelConstraints];
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    WebViewController *webVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Article *article = [allArticles objectAtIndex:[indexPath row]];
    webVC.url = article.aUrl;
    
}

@end
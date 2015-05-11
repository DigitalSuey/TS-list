//
//  ViewController.m
//  tigerspikeList
//
//  Created by Paulo Pão on 10/05/15.
//  Copyright (c) 2015 Paulo Pão. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "WebViewController.h"
#import "MBProgressHUD.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
    NSString *bundlePath = [paths objectAtIndex:0];
    NSString *plistPath = [bundlePath stringByAppendingPathComponent:@"list.plist"];
    
    self.list = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    WebViewController *webVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    webVC.url = [[self.list objectAtIndex:[indexPath row]] valueForKey:@"url"];
    
}

#pragma mark - UITableViewDelegate and UiTableViewDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 160.0;
    
    return self.tableView.estimatedRowHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"listCell";
    
    CustomCell *cell = (CustomCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.titleLabel.text = [[self.list objectAtIndex:[indexPath row]] valueForKey:@"name"];
    cell.descriptionLabel.text = [[self.list objectAtIndex:[indexPath row]] valueForKey:@"description"];
    
    [cell.descriptionLabel sizeToFit];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[[self.list objectAtIndex:[indexPath row]] valueForKey:@"icon"] isEqualToString:@""]) {
            [UIView animateWithDuration:0.2 animations:^{
                [cell.titleLeftConstraint setConstant:0];
                [cell.descriptionLeftConstraint setConstant:0];
                
                [cell layoutIfNeeded];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
            
        } else {
            cell.thumbnailImageView.alpha = 0;
            
            [UIView animateWithDuration:0.5 animations:^{
                cell.thumbnailImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.list objectAtIndex:[indexPath row]] valueForKey:@"icon"]]]];
                cell.thumbnailImageView.alpha = 1;
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }];
        }
    });
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
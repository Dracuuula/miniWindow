//
//  MainViewController.m
//  test
//
//  Created by SHJJ on 14-1-13.
//  Copyright (c) 2014年 Dracuuula. All rights reserved.
//

#import "MainViewController.h"

#define LENGTH_1 200
#define SMALL_HEIGHT 380

@interface MainViewController ()
{
    UIView * t1 ;
}

@end

@implementation MainViewController
@synthesize tableView;
@synthesize subView;
@synthesize videoView;
@synthesize contentView;
@synthesize videoWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.subView setFrame:CGRectMake(320, 480, 320, 480)];
    [self.view addSubview:self.subView];
    
    UIPanGestureRecognizer * panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGRAction:)];
    [self.subView addGestureRecognizer:panGR];
    
    //http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8
    //http://v.youku.com/v_show/id_XNjYyMTM2MzE2.html
//    NSURL *url = [NSURL URLWithString:@"http://v.youku.com/v_show/id_XNjYyMTM2MzE2.html"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.videoWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)panGRAction:(UIPanGestureRecognizer *)pan
{
    CGPoint panPoint = [pan translationInView:self.view];
    
    NSLog(@"panGRAction %@", NSStringFromCGPoint(panPoint));
    
    //
    if (panPoint.y > 0) {
        if (panPoint.y < LENGTH_1) {
            pan.view.frame = CGRectMake((320-((480-panPoint.y)*320)/480), panPoint.y, (320- (320-((480-panPoint.y)*320)/480)), (480 - panPoint.y));
            
            self.contentView.alpha = 1-panPoint.y/(LENGTH_1-10);
            
        }else if(panPoint.y < SMALL_HEIGHT){
            pan.view.frame = CGRectMake((320-((480-LENGTH_1)*320)/480), panPoint.y, (320- (320-((480-LENGTH_1)*320)/480)), (480 - LENGTH_1));
        }
    }

    if (pan.state == UIGestureRecognizerStateEnded) {
        if (panPoint.y > 100) {
            
            [UIView animateWithDuration:1.0 animations:^{
                pan.view.frame = CGRectMake((320-((480-LENGTH_1)*320)/480), SMALL_HEIGHT, (320- (320-((480-LENGTH_1)*320)/480)), (480 - LENGTH_1));
            } completion:^(BOOL finished){
                NSLog(@"finished 111 ");
            }];
            
            
        }else{
            
            [UIView animateWithDuration:1.0 animations:^{
                pan.view.frame = CGRectMake(0, 0, 320, 480);
                self.contentView.alpha = 1;
            } completion:^(BOOL finished){
                NSLog(@"finished 222 ");
            }];
            
        }
    }
//    self.contentView.alpha = ((480 - panPoint.y-50)/480);
    
    NSLog(@"pan.view.frame %@", NSStringFromCGRect(pan.view.frame));
}

#pragma mark - tabelview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellStr = @"cellStr";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    
    cell.textLabel.text = @"tap this cell, slide on appeared view";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:2.0 animations:^{
        [self.subView setFrame:CGRectMake(0, 0, 320, 480)];
    } completion:^(BOOL finished){
        NSLog(@"finished");
    }];
}

@end

//
//  ViewController.m
//  PopView
//
//  Created by 周翔 on 16/2/24.
//  Copyright © 2016年 周翔. All rights reserved.
//

#import "ViewController.h"
#import "SetNicknameView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clickBtn.frame = CGRectMake(0, 0, 200, 200);
    [clickBtn setTitle:@"click!" forState:UIControlStateNormal];
    clickBtn.center = self.view.center;
    [clickBtn setBackgroundColor:[UIColor greenColor]];
    [clickBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)buttonPressed:(UIButton *)btn
{
    SetNicknameView *nickView = [[SetNicknameView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.height)];
    [nickView showInView:self];
    [nickView setNicknameBlock:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"confirm!"
                                                        message:@"block setting succeed!!"
                                                       delegate:self
                                              cancelButtonTitle:@"cancel"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

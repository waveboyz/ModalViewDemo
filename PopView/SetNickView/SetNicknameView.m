//
//  SetNicknameView.m
//  ColorfulHome
//
//  Created by 周翔 on 16/2/24.
//  Copyright © 2016年 caijia. All rights reserved.
//

#import "SetNicknameView.h"
#import "AppDelegate.h"

#define DEVICE_IS_IPHONE5           ([UIScreen mainScreen].bounds.size.height == 568)
#define DEVICE_IS_IPHONE6           ([UIScreen mainScreen].bounds.size.height == 667)
#define DEVICE_IS_IPHONE6PLUS       ([UIScreen mainScreen].bounds.size.height == 736)
#define Screen_Width        [UIScreen mainScreen].bounds.size.width
#define Screen_Height       [UIScreen mainScreen].bounds.size.height
@interface SetNicknameView ()
<
    UIGestureRecognizerDelegate
>

@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIView *underView;
@property (nonatomic, assign) CGFloat padHeight;

@end

@implementation SetNicknameView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        if (DEVICE_IS_IPHONE6 || DEVICE_IS_IPHONE6PLUS) {
            _padHeight = 180;
        }else if(DEVICE_IS_IPHONE5){
            _padHeight = 120;
        }else{
            _padHeight = 100;
        }

        [self setViews];
    }
    
    return self;
}

- (void)setViews
{   
    _underView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _underView.backgroundColor = [UIColor blackColor];
    _underView.alpha = 0;
    _underView.userInteractionEnabled = YES;
    [self addSubview:_underView];
    
    /**
     中央视图
     */
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(30, _padHeight, Screen_Width - 60, Screen_Height - _padHeight * 2)];
    _centerView.backgroundColor = [UIColor redColor];
    _centerView.alpha = 0;
    _centerView.layer.cornerRadius = CGRectGetWidth(_centerView.frame)/54;
    [self addSubview:_centerView];
    
    /**
     头像
     */
    UIImageView *avatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(_centerView.frame.size.width/2 - 30, 20, 60, 60)];
    avatarImg.layer.cornerRadius = CGRectGetWidth(avatarImg.frame)/2;
    avatarImg.clipsToBounds = YES;
    [avatarImg setBackgroundColor:[UIColor redColor]];
    [_centerView addSubview:avatarImg];

    /**
     昵称
     */
    UILabel *nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(avatarImg.frame) + 5, _centerView.frame.size.width - 20, 15)];
    nameLbl.font = [UIFont systemFontOfSize:15.0f];
    nameLbl.textColor = [UIColor blackColor];
    nameLbl.text = @"name is **";
    nameLbl.textAlignment = NSTextAlignmentCenter;
    [_centerView addSubview:nameLbl];
    
    /**
     地址
     */
    UILabel *addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLbl.frame) + 5, _centerView.frame.size.width - 20, 15)];
    addressLbl.font = [UIFont systemFontOfSize:15.0f];
    addressLbl.textColor = [UIColor grayColor];
    addressLbl.textAlignment = NSTextAlignmentCenter;
    addressLbl.text = @"building No.";
    [_centerView addSubview:addressLbl];
    
    /**
     分割线
     */
    UILabel *lineLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(addressLbl.frame)+5, _centerView.frame.size.width - 120, 0.5)];
    lineLbl.backgroundColor = [UIColor grayColor];
    [_centerView addSubview:lineLbl];
    

    /**
     *  内容
     */
    CGFloat contentHeight = _centerView.frame.size.height - CGRectGetMaxY(addressLbl.frame) - 55;
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(addressLbl.frame) + 10, _centerView.frame.size.width - 40, contentHeight)];
    contentLbl.numberOfLines = 6;
    NSAttributedString *attStr =[[NSAttributedString alloc] initWithString:@"here is a long long long sentence here is a long long long sentencehere is a long long long sentencehere is a long long long sentence" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15.0f]}];
    CGSize size = [attStr boundingRectWithSize:CGSizeMake(contentLbl.frame.size.width, contentLbl.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    contentLbl.frame = CGRectMake(20, CGRectGetMaxY(addressLbl.frame) + 10, _centerView.frame.size.width - 40, size.height);
    contentLbl.font = [UIFont systemFontOfSize:15.0f];
    contentLbl.textAlignment = NSTextAlignmentCenter;

    contentLbl.attributedText = attStr;
    [_centerView addSubview:contentLbl];
    
    /**
     *  设置按钮
     */
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    commitBtn.frame = CGRectMake(20, _centerView.frame.size.height - 50, _centerView.frame.size.width - 40, 30);
    commitBtn.layer.cornerRadius = CGRectGetWidth(commitBtn.frame)/54;
    commitBtn.clipsToBounds = YES;
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [commitBtn setTitle:@"立即设置昵称" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [commitBtn setBackgroundImage:[self createImageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(showSetNickName) forControlEvents:UIControlEventTouchUpInside];
    [_centerView addSubview:commitBtn];
    [self animeData];
}

- (void)showSetNickName
{
    if (self.nicknameBlock) {
        self.nicknameBlock();
    }
}

-(void)animeData
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [_underView addGestureRecognizer:tapGesture];
    tapGesture.delegate = self;
    [UIView animateWithDuration:.25 animations:^{
        _centerView.alpha = 1;
        _underView.alpha = 0.8;
    } completion:^(BOOL finished) {
    }];
}

-(void)tappedCancel
{
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

- (void)showInView:(UIViewController *)Sview
{
    if(Sview==nil){
        [[UIApplication sharedApplication].delegate.window.rootViewController.tabBarController.view addSubview:self];
    }else{
        [[UIApplication sharedApplication].delegate.window addSubview:self];
    }
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
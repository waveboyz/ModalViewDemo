//
//  SetNicknameView.h
//  ColorfulHome
//
//  Created by 周翔 on 16/2/24.
//  Copyright © 2016年 caijia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SetNickNameBlock)();
@interface SetNicknameView : UIView
/**
 *  按钮触发block
 */
@property (nonatomic, copy) SetNickNameBlock nicknameBlock;
- (id)initWithFrame:(CGRect)frame andWithContentString:(NSString *)contentString;
- (void)showInView:(UIViewController *)Sview;
-(void)tappedCancel;

@end

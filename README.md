# ModalViewDemo
a simple sample of building a modal view
## SetNicknameView.h 接口解释
* `nicknameBlock`  点击设置按钮block
* `- (id)initWithFrame:(CGRect)frame andWithContentString:(NSString *)contentString;` 初始化接口，frame要射程屏幕长宽相同，contentstring为可编辑内容。
* `- (void)showInView:(UIViewController *)Sview;` modal接口，可以自己设置是覆盖到当前navigation controller上还是直接加载在screen上
* `-(void)tappedCancel;` 视图隐藏接口，点击背后黑色区块可以隐藏视图，可以在.m文件中将 `-(void)animeData`的`tapGesture`注释掉

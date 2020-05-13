//
//  LYRootViewController.m
//  LYLuckyCardDemo
//
//  Created by leo on 17/2/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "LYRootViewController.h"
#import "DZPMainView.h"
#import "Masonry.h"
#import "CMCommon.h"
#import <SGBrowserView.h>
#import "UGredEnvelopeView.h"
#define UGScreenW [UIScreen mainScreen].bounds.size.width
#define UGScerrnH [UIScreen mainScreen].bounds.size.height
// About __block
#define __weakSelf_(__self) __weak typeof(self) __self = self
@interface LYRootViewController ()
@property (nonatomic, strong) NSArray <DZPModel *> *dzpArray;   /**<   转盘活动数据 */
//大转盘
@property (nonatomic, strong)  UGredEnvelopeView *bigWheelView;    /**<   大转盘 调用*/
@end

@implementation LYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weakSelf_(__self);
    //在实际开发中的调用方式
    {//大转盘 右上
        self.bigWheelView = [[UGredEnvelopeView alloc] initWithFrame:CGRectMake(UGScreenW-80, 150, 70, 70) ];
        [self.view addSubview:_bigWheelView];
        [self.bigWheelView.imgView setImage:[UIImage imageNamed:@"dzp_btn"]];
        [self.bigWheelView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view.mas_right).with.offset(-10);
            make.width.mas_equalTo(70.0);
            make.height.mas_equalTo(70.0);
            make.top.equalTo(self.view.mas_top).offset(150+105);
        }];
        self.bigWheelView.cancelClickBlock = ^(void) {
            [__self.bigWheelView setHidden:YES];
        };
        self.bigWheelView.redClickBlock = ^(void) {
            [__self goDZP];
        };
    }
    
}

- (IBAction)showLuckyCardViewBtnClick:(id)sender {
    
    [self goDZP];
}


-(void)goDZP{
    self.dzpArray = [NSArray new];
    NSDictionary *jsonDic = [CMCommon readLocalFileWithName:@"turntableList"];
    
    NSLog(@"jsonDic = %@",jsonDic);
    self.dzpArray = (NSArray *)[jsonDic objectForKey:@"data"];
    
    if (self.dzpArray.count) {
        
        NSMutableArray *data =  [DZPModel mj_objectArrayWithKeyValuesArray:self.dzpArray];
        DZPModel *obj = [data objectAtIndex:0];
        NSLog(@"obj = %@",obj);
        
        
        DZPMainView *recordVC = [[DZPMainView alloc] initWithFrame:CGRectZero];
        
        CGPoint showCenter = CGPointMake([ [UIScreen mainScreen] bounds].size.width/2,[ [UIScreen mainScreen] bounds].size.height/2);
        [SGBrowserView showMoveView:recordVC moveToCenter:showCenter];
        recordVC.item = obj;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

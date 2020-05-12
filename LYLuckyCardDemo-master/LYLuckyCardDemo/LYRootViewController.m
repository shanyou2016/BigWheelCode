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
@interface LYRootViewController ()
@property (nonatomic, strong) NSArray <DZPModel *> *dzpArray;   /**<   转盘活动数据 */
@end

@implementation LYRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showLuckyCardViewBtnClick:(id)sender {
    
    self.dzpArray = [NSArray new];
    NSDictionary *jsonDic = [CMCommon readLocalFileWithName:@"turntableList"];
    
    NSLog(@"jsonDic = %@",jsonDic);
    self.dzpArray = (NSArray *)[jsonDic objectForKey:@"data"];
    
    if (self.dzpArray.count) {
        
        NSMutableArray *data =  [DZPModel mj_objectArrayWithKeyValuesArray:self.dzpArray];
        DZPModel *obj = [data objectAtIndex:0];
        NSLog(@"obj = %@",obj);

            
            DZPMainView *recordVC = [[DZPMainView alloc] initWithFrame:CGRectZero];
//            [self.view addSubview:recordVC];
//            [recordVC mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(self.view);
//            }];
              CGPoint showCenter = CGPointMake([ [UIScreen mainScreen] bounds].size.width/2,[ [UIScreen mainScreen] bounds].size.height/2);
            [SGBrowserView showMoveView:recordVC moveToCenter:showCenter];
            //                        recordVC.dataArray = [DZPprizeModel mj_objectArrayWithKeyValuesArray:obj.param.prizeArr];
            recordVC.item = obj;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

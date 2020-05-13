//
//  DZPTwo.m
//  UGBWApp
//
//  Created by ug on 2020/4/27.
//  Copyright © 2020 ug. All rights reserved.
//

#import "DZPTwoView.h"
#import "DZPTwoTableViewCell.h"
#import "Masonry.h"
#import "CMCommon.h"

#define RGBA(_R,_G,_B,_A) \
[UIColor colorWithRed:((_R) / 255.0) green:((_G) / 255.0) blue:((_B) / 255.0) alpha:_A]
@interface DZPTwoView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, weak)IBOutlet UITableView *tableView;                   /**<   列表TableView */


@end

@implementation DZPTwoView

- (instancetype)DZPTwoView {
    NSArray *objs= [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil];
    return [objs firstObject];

}


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (!self.subviews.count) {
        DZPTwoView *v = [[DZPTwoView alloc] initWithFrame:CGRectZero];
        [self addSubview:v];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self = [self DZPTwoView];
    }
    [self tableViewInit];
    return self;
}


- (UITableView *)tableViewInit {
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"DZPTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"DZPTwoTableViewCell"];
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.rowHeight = 25;
    
    return _tableView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DZPTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DZPTwoTableViewCell" forIndexPath:indexPath];
    DZPModel *model= self.dataArray[indexPath.row];
    cell.rowLB.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    cell.numberLB.text = model.codeNum;
    cell.recordLB.text = model.prize_name;
    if ((indexPath.row+1)%2 ==0) {
        cell.backgroundColor = RGBA(80, 40, 130, 0.8);
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  25.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)setDataArray:(NSArray<DZPModel *> *)dataArray{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:dataArray];
    _dataArray =  (NSMutableArray *)[[temp reverseObjectEnumerator] allObjects];
    [_tableView reloadData];
}
@end

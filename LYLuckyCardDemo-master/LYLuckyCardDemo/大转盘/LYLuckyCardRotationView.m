//
//  LYLuckyCardRotationView.m
//  LYLuckyCardDemo
//
//  Created by leo on 17/2/9.
//  Copyright © 2017年 leo. All rights reserved.
//

#import "LYLuckyCardRotationView.h"
#import "Masonry.h"
#import "LYLuckyCardCellView.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "CMCommon.h"
#import "PieView.h"
#import "Global.h"
#define kLuckyCardCellViewSize CGSizeMake(68, 173) //每个小格子大小

@interface LYLuckyCardRotationView () <CAAnimationDelegate>
{
    NSDictionary *data;//抽奖接口
}
@property (nonatomic, assign)  float angle;//奖品的角度
@property (strong, nonatomic) IBOutlet UIView *contentView;//转盘
@property (nonatomic, strong) NSMutableArray *cellArray;//奖品的视图
@property (weak, nonatomic) IBOutlet UIView *canRotationView;//可旋转的图
@property (nonatomic, strong) CABasicAnimation *animationPart;//动画
@property (weak, nonatomic) IBOutlet UIButton *myBtn;//点击按钮
@property (weak, nonatomic) IBOutlet UIView *winView;//可旋转的中奖View


@property (weak, nonatomic) IBOutlet UIView *bgView;//半透明背景
@property (weak, nonatomic) IBOutlet UIImageView *jpImgV;//奖品图
@property (weak, nonatomic) IBOutlet UILabel *jpLB;//奖品
@property (weak, nonatomic) IBOutlet UIImageView *zjImgV;//中奖文字

@end

@implementation LYLuckyCardRotationView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];//这里以后可以优化下，感觉约束没起作用跟这有关系
    }
    return self;
}

- (void)commonInit {//这里以后可以优化下，感觉约束没起作用跟这有关系
    [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setDataArray:(NSArray<DZPprizeModel *> *)dataArray{
    _dataArray = dataArray;
    self.cellArray = [NSMutableArray arrayWithCapacity:_dataArray.count];
    
    // 转盘添加扇形背景色
    PieView *pieView = [[PieView alloc] initWithFrame:self.canRotationView.bounds count:dataArray.count*2];
    [self.canRotationView addSubview:pieView];
    pieView.hidden = false;
    
    CGFloat angle = 2 * M_PI / (CGFloat)_dataArray.count;
    for (int i = 0; i < _dataArray.count; i++) {
        DZPprizeModel *model = [_dataArray objectAtIndex:i];
        CGRect cellFrame = CGRectZero;
        cellFrame.origin = CGPointMake(0, 0);
        cellFrame.size = kLuckyCardCellViewSize;
        LYLuckyCardCellView *cellView = [[LYLuckyCardCellView alloc] initWithFrame:cellFrame];
        [cellView.label setText:model.prizeName];
        [cellView.imageView sd_setImageWithURL:[NSURL URLWithString:model.prizeIcon] placeholderImage:[UIImage imageNamed:@"loading"]];
        cellView.layer.anchorPoint = CGPointMake(0.5, 1);
        cellView.layer.position = CGPointMake(self.canRotationView.bounds.size.width / 2.0, self.canRotationView.bounds.size.height / 2.0);
        cellView.transform = CGAffineTransformMakeRotation(angle * i);
        [self.canRotationView addSubview:cellView];
        [self.cellArray addObject:cellView];
    }
    [self setNeedsDisplay];
}

- (IBAction)beginAction:(id)sender {
    [self beignRotaion];
}

//开启动画方法
- (void)beignRotaion {
    [self animationPart1];
}

//动画方法
- (void)animationPart1 {
    [self.winView.layer removeAllAnimations];
    [self.canRotationView.layer removeAllAnimations];
    CABasicAnimation *animationPart1 = [CABasicAnimation animation];
    animationPart1.keyPath = @"transform.rotation";
    //  最初的动画位置
    animationPart1.fromValue = [NSNumber numberWithDouble:0.0];
    //    float f = (7.0-6.0)/7.0;
    //    //  结束的动画位置
    animationPart1.toValue = [NSNumber numberWithDouble:((5) * 2 * M_PI)];
    //    动画间隔时间
    animationPart1.duration= 3.0;
    animationPart1.autoreverses= NO;
    //    动画完成之后是否还原
    animationPart1.removedOnCompletion= NO;
    //    设置代理
    animationPart1.delegate = self;
    animationPart1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]; //由慢变快
    animationPart1.fillMode = kCAFillModeForwards;
    [self.canRotationView.layer addAnimation:animationPart1 forKey:@"beginAnima"];
}
//动画方法
- (void)animationPart :(float )angle{
    
    float bf = 5+angle;//5 表示转5
    self.animationPart = [CABasicAnimation animation];
    _animationPart.keyPath = @"transform.rotation";
    //  最初的动画位置
    _animationPart.fromValue = [NSNumber numberWithDouble:0.0];
    //  结束的动画位置
    _animationPart.toValue = [NSNumber numberWithDouble:bf * 2 * M_PI];
    //    动画间隔时间
    _animationPart.duration= 3.0;
    _animationPart.autoreverses= NO;
    //    动画完成之后是否还原
    _animationPart.removedOnCompletion= NO;
    //     动画的次数
    //    _animationPart1.repeatCount = CGFLOAT_MAX;
    //    设置代理
    _animationPart.delegate = self;
    _animationPart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]; //由快变慢
    _animationPart.fillMode = kCAFillModeForwards;
    [self.canRotationView.layer addAnimation:_animationPart forKey:@"animationPart"];
}

//动画方法
- (void)animationWinning {

    [self.winView setHidden:NO];
    [self.winView.layer removeAllAnimations];
    CABasicAnimation *animationWin = [CABasicAnimation animation];
    animationWin.keyPath = @"transform.rotation";
    //  最初的动画位置
    animationWin.fromValue = [NSNumber numberWithDouble:0.0];
    //    //  结束的动画位置
    animationWin.toValue = [NSNumber numberWithDouble:((5) * 2 * M_PI)];
    //    动画间隔时间
    animationWin.duration= 5.0;
    animationWin.autoreverses= NO;
    //    动画完成之后是否还原
    animationWin.removedOnCompletion= NO;
    //    设置代理
    animationWin.delegate = self;
    animationWin.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //线性
    animationWin.fillMode = kCAFillModeForwards;
    [self.winView.layer addAnimation:animationWin forKey:@"animationWin"];
}


#pragma mark -CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
//    NSLog(@"animationDidStart%@",self.canRotationView.layer.animationKeys);
    NSLog(@"animationDidStart%@",self.winView.layer.animationKeys);
    if ([self.canRotationView.layer.animationKeys[0] isEqualToString:@"beginAnima"]) {
        [self activityTurntableWin];
    }
    else if ([self.winView.layer.animationKeys[0] isEqualToString:@"animationWin"]) {

        self.bgView.hidden = NO;
        self.jpLB.hidden = NO;
        [self.jpLB setText:[data objectForKey:@"prizeName"] ];
        self.jpImgV.hidden = NO;
        [self.jpImgV sd_setImageWithURL:[NSURL URLWithString:[data objectForKey:@"prizeIcon"]]];
        self.zjImgV.hidden = NO;
  

        NSNumber * prizeflag = [self->data objectForKey:@"prizeflag"];
        if ([prizeflag isEqualToNumber:[[NSNumber alloc] initWithInt:1]]) {//中奖
            self.zjImgV.image = [UIImage imageNamed:@"dzp_win"];
        }
        else{
            self.zjImgV.image = [UIImage imageNamed:@"dzp_failure"];
        }


    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    NSLog(@"animationDidStop%@",self.winView.layer.animationKeys);
    if ([self.canRotationView.layer.animationKeys[0] isEqualToString:@"animationPart"] && flag) {
        NSNumber * prizeId = [data objectForKey:@"prizeId"];
        NSLog(@"奖品id = %@", prizeId );
        NSLog(@"prizeName= %@", [data objectForKey:@"prizeName"] );
        NSLog(@"prizeIcon= %@", [data objectForKey:@"prizeIcon"] );
        [self.canRotationView.layer removeAllAnimations];
        if (self.angle != -1) {
             [self animationWinning];
        }
        else{
            [self removeAnimations];
        }
      
    }
    if ([self.canRotationView.layer.animationKeys[0] isEqualToString:@"beginAnima"]) {

        if (self.angle != -1  && flag) {
            [self animationPart:self.angle];
        }
        else{
            [self removeAnimations];
        }
    }
    if ([self.winView.layer.animationKeys[0] isEqualToString:@"animationWin"]) {
        if (flag) {
              [self performSelector:@selector(winner) withObject:nil/*可传任意类型参数*/ afterDelay:3.0];
        }
        else{
            [self removeAnimations];
        }
      
    }
    
}


-(void)removeAnimations{
      [self winner];
     [self.canRotationView.layer removeAllAnimations];
}

-(void)winner{
     [self fireNotification];
    _myBtn.enabled = YES;
     [self.winView.layer removeAllAnimations];

    
    self.bgView.hidden = YES;
    [self.winView setHidden:YES];
    self.jpLB.hidden = YES;
    self.jpImgV.hidden = YES;
    self.zjImgV.hidden = YES;
    
    
}

-(void)fireNotification{
    //发送通知
    NSNumber * integral = [data objectForKey:@"integral"];
    NSDictionary *dict = @{@"MoenyNumber":integral};
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"setMoenyNumber" object:nil userInfo:dict]];
  
}
#pragma mark -网络请求  抽奖接口

- (void)activityTurntableWin {

    self.angle = -1;
    NSDictionary *jsonDic = [CMCommon readLocalFileWithName:@"turntableWin"];
    
    NSLog(@"jsonDic = %@",jsonDic);
    self->data =  (NSDictionary *)[jsonDic objectForKey:@"data"];
    
    
    NSNumber * prizeflag = [self->data objectForKey:@"prizeflag"];
    if ([prizeflag isEqualToNumber:[[NSNumber alloc] initWithInt:1]]) {//中奖
        NSNumber * prizeId = [self->data objectForKey:@"prizeId"];
        
        //计算角度，开启动画
        for (int i = 0; i < self.dataArray.count; i++) {
            DZPprizeModel *model = [self.dataArray objectAtIndex:i];
            if ([model.prizeId isEqualToNumber:prizeId ]) {
                
                float fcount = (float)self.dataArray.count;
                float fi = fcount - i*10/10;
                float angle = fi/fcount;
                //角度要如此计算：（count - i）/count
                self.angle = angle;
                break;
            }
        }
    } else  {//没中奖
        self->_myBtn.enabled = YES;
        NSLog(@"没中奖");
        [self animationWinning];
    }
    
    //===实际开发中有网络请求不到的情况，或者网络失败==》调用[self removeAnimations];
    
    
}

@end

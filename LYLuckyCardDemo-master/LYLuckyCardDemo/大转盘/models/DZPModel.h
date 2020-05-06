//
//  DZPModel.h
//  UGBWApp
//
//  Created by ug on 2020/5/2.
//  Copyright © 2020 ug. All rights reserved.
//

#import "MJExtension.h"             // 字典转模型

NS_ASSUME_NONNULL_BEGIN



@interface DZPprizeModel : NSObject
@property (nonatomic, strong) NSNumber *prizeId;   /**<   奖品id*/
@property (nonatomic, strong) NSString *prizeIcon;   /**<  奖品图标 */
@property (nonatomic, strong) NSString *prizeIconName;   /**<  图标名字 */
@property (nonatomic, strong) NSString *prizeName;   /**<  奖品名字 */
@property (nonatomic, strong) NSString *prizeAmount;   /**<  奖品金额 */
@property (nonatomic, strong) NSString *prizeType;   /**<  奖品类型 1为彩金 2为积分 3为其他 4为 未中奖 */

@property (nonatomic, strong) NSString *prizeMsg;   /**<  信息*/
@property (nonatomic,strong) NSNumber * prizeflag;   /**<是否中奖标识 0为未中奖 1为中奖*/
@property (nonatomic,strong) NSNumber * integralOld;   /**<抽奖前积分*/
@property (nonatomic,strong) NSNumber * integral;   /**<抽奖后积分（算上中奖的）*/
@end

@interface DZPparamModel : NSObject

@property (nonatomic, strong) NSString *membergame; /**i可以参与的游戏*/
@property (nonatomic, strong) NSArray<DZPprizeModel *> *prizeArr;

@property (nonatomic, strong) NSString *buy;   /**<   消耗抽奖的货币类型 1为积分 2为彩金*/
@property (nonatomic, strong) NSNumber *buy_amount;   /**<  消耗的金额 */
@property (nonatomic, strong) NSString *check_in_user_levels;   /**< 可以参与的层级 没有则是全部  */
@property (nonatomic, strong) NSArray<NSString*>  *content_turntable;   /**<  活动藐视 每个逗号前代表一行 */
@end


@interface DZPModel : NSObject
@property (nonatomic, strong) NSString *DZPid;   /**id*/
@property (nonatomic, strong) DZPparamModel *param;   /**/
@property (nonatomic, strong) NSString *start; /**i*/
@property (nonatomic, strong) NSString *end;   /**/
@property (nonatomic, strong) NSString *type;   /**/

//获取转盘活动抽奖日志
@property (nonatomic, strong) NSString *prize_name; /**i奖品名字*/
@property (nonatomic, strong) NSString *update_time;   /**< 抽奖时间戳  */
@property (nonatomic, strong) NSString *codeNum;  /**<   抽奖编号*/

@end

NS_ASSUME_NONNULL_END

最近公司要做转盘抽奖，看了些github 的代码，自己终于做出来了，现在总结下技术点，让以后有点记忆；

总体结构：

主转盘：主逻辑区（包括转盘+业务列表）DZPMainView

转盘：转盘代码     LYLuckyCardRotationView

转盘的cell：转盘每个抽奖区   LYLuckyCardCellView

这个结构是参考了https://github.com/ayangcool/LYLuckyCardDemo，谢谢该位码农的贡献；

实际使用中，感觉：主转盘 和 转盘 可以合成一个。这样转盘和业务不会垮类，我在开发中，主转盘的剩余积分就垮类，用通知来实现赋值；

转盘：转盘的动画用CABasicAnimation 的 transform.rotation 实现的；

动画有3个：1：在点击获取网络中奖数据时，这里会有网络请求时间，这个时间就有一个本地的旋转动画；

                       2：获得网络中奖数据时，做的动画，旋转到中奖点；

                       3：中奖后的中奖特效。

动画之前的连接是通过 CABasicAnimation 的delegate实现

- (void)animationDidStart:(CAAnimation *)anim;

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

  [self.winView.layer addAnimation:animationWin forKey:@"animationWin"];

[self.winView.layer.animationKeys[0] isEqualToString:@"animationWin"]

开发中注意的点，动画用完后，再开启其他动画前，一定要关闭之前动画

我用的是： [self.winView.layer removeAllAnimations];

取角度：(count - I)/count

其他做大转盘用的的知识和参考：

iOS 饼状图（扇形图）动画效果的实现

https://www.jianshu.com/p/e47adddc6308

其他网上大转盘开发思路

https://www.jianshu.com/p/4056faba6019

View的初始frame, 弹出隐藏

https://github.com/Shanguo/SGBrowserView

发现实际开发中，弹窗方式有问题，用到了上面的代码，非常感谢这位码农。

iOS 判断奇偶数

https://www.cnblogs.com/liuting-1204/p/5946366.html

iOS数组排序(倒叙 生序 降序)

https://www.jianshu.com/p/e9d561140f5b

iOS数组模型根据模型属性排序

https://www.jianshu.com/p/d7a7630c98e7

实际开发中大转盘调用方式；

#define UGScreenW [UIScreen mainScreen].bounds.size.width

#define UGScerrnH [UIScreen mainScreen].bounds.size.height

// About __block

#define __weakSelf_(__self) __weak typeof(self) __self = self

#define RGBA(_R,_G,_B,_A) \

[UIColor colorWithRed:((_R) /255.0) green:((_G) /255.0) blue:((_B) /255.0) alpha:_A]

我还没找到可以单独关闭莫个动画的办法，如果有那个小伙伴发现了可以留言。

https://github.com/shanyou2016/BigWheelCode

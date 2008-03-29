AutoMacro BETA - BY DLJ

See NGACN :
http://bbs.ngacn.com/read.php?tid=1523328&fpage=1
请记住,下载插件以上面提到的帖子提供的信息为准.


1.什么是AutoMacro, 这个插件是用来干什么的?

在WOW一开始的时候, BLZ提供了UI的自定义脚本和宏.
玩家通过编写脚本和宏, 简化各种操作.
甚至达到了非常智能的效果. (例如挂奥山自动上马跟随和杀人的插件)
为了防止过度的智能, WOW在2.0的版本后, 限制了脚本和宏的应用.

AutoMacro正是利用BLZ的UI代码的不完善, 
重新让宏达到智能的目的.


2. AutoMacro是什么原理 ?

AutoMacro自动检测,并且拒绝执行因为距离怒气状态等原因造成不能施放的技能.
例如

/cast 心灵震爆
/cast 精神鞭笞

这2句话的作用是,
如果心灵震爆冷却,那么就使用精神鞭笞.

这原本在WOW2.0之后是不起作用的宏.
但是只要安装了AutoMacro, 那么这种宏就能使用了.

越优先施放,有CD的技能就最好放前面.
而越普通,不需要CD的技能放在后面.


**重点**
需要注意的是 , AutoMacro只认识 /cast . 而不认识 /use /施放 ...
所以务必使用 /cast 技能名称




下面举某些职业的简单例子:


盗贼:
/cast 还击
/cast 鬼魅攻击
/cast 出血

盗贼还可以把所有的CD技能绑一起,
然后通过连续按两三次把BT技能与视频同时释放做个超人.

法师:
战场傻瓜AOE宏.
/cast 冰环
/cast 冲击波
/cast 奥爆术
请原谅我,我已经忘记了法师的技能名称. 请修改掉.


战士:
战斗版本:
/cast 冲锋
/cast [harm:1tb] 断根
/cast 压制
/cast 胜利冲锋
/cast 致死打击

狂暴版本:
/cast 拦截
/if IF_CSPELL()
/cast 拳击
/end
/cast [harm:1tb] 断根
/cast 胜利冲锋
/cast 致死打击
/cast 狂暴之怒
/cast 旋风斩


[harm:1tb]的意思是,给对方增加DEBUFF. 如果DEBUFF已经存在, 则跳过. 
/if IF_CSPELL()
/cast 拳击
/end
这是/if /end的配对. 其中/if后跟着lua的条件语句.
IF_CSPELL()是AutoMacro内置的函数.意思是对方正在施法.



术士:
/cast [harm:1tb] 痛苦诅咒
/cast [harm:1tb] 腐熟
/cast [harm:1tb] 献祭
/cast [harm:1tb] 暗影箭


..其他职业的略. 
基本就是差不多.







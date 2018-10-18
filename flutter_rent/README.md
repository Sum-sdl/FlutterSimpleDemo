# Flutter App

完全的Flutter项目案例，不断更新中

### IOS 打包问题
- open ios/Runner.xcworkspace  打包xcode开发界面

- 添加了远程库需要通过 pod install 来下载一次远程代码

- flutter build ios 只能打包模拟器版本，推荐通过xcode去打包发布IOS包 

- IOS 打包一定要将Logo图片**配置完整**，不然会打包异常，debug不影响运行


### 开发坑
- 解决ListView跟布局的时候，内容顶部的自动padding-top，处理：自己手动添加padding属性即可

- safeArea能解决很多状态栏高度问题

### 总结
- 一组状态管理的时候，状态需要由父组件管理，child做成无状态的widget

- 触发 setState 方法，就会全部Widget会重新new一遍

- StatefulWidget widget重新new，不影响对应的State状态,Flutter已经做好了State保存，重复利用

- StatefulWidget 调用setState 方法就会触发State.build方法,ui重新new一遍,内部状态createState在不受父组件影响的情况下
只会走一遍new方法，State.build方法会走很多次



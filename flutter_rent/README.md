# Flutter App

完全的Flutter项目案例，不断更新中


#### 总结
- 一组状态管理的时候，状态需要由父组件管理，child做成无状态的widget

- 触发 setState 方法，就会全部重新new一遍

- StatefulWidget 调用setState 方法就会触发State.build方法,ui重新new一遍,内部状态createState在不受父组件影响的情况下
只会走一遍new方法，State.build方法会走很多次
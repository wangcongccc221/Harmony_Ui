/**
 * 主页面文件
 * 功能：应用的主界面，包含主要功能入口和导航
 * 用途：用户登录后的主要操作界面
 */

// 导入HeaderBar组件
import { HeaderBar } from '../components/HeaderBar'

@Entry
@Component
struct HomePage {
  // 页面状态
  @State currentUser: string = '张三'
  @State userRole: string = '管理员'
  
  // 创建HeaderBar组件的引用
  private headerBar: HeaderBar = new HeaderBar()

  build() {
    Column() {
      // 使用HeaderBar组件
      HeaderBar()
        .onAppear(() => {
          // 页面出现时设置用户信息
          this.setUserInfo()
        })
      
      // 页面主要内容区域
      Column() {
        Text('欢迎使用应用')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 20 })
        
        // 功能按钮区域
        Row() {
          Button('聊天')
            .onClick(() => {
              // 跳转到聊天页面
            })
          
          Button('好友')
            .onClick(() => {
              // 跳转到好友页面
            })
          
          Button('设置')
            .onClick(() => {
              // 跳转到设置页面
            })
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
        .margin({ top: 40 })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 20, right: 20 })
    }
    .height('100%')
    .width('100%')
  }

  /**
   * 设置用户信息
   */
  private setUserInfo(): void {
    // 这里可以从用户服务获取真实的用户信息
    this.headerBar.setUserInfo(this.currentUser, this.userRole)
  }

  /**
   * 更新用户信息
   * @param name 用户名
   * @param role 用户角色
   */
  updateUserInfo(name: string, role: string): void {
    this.currentUser = name
    this.userRole = role
    this.setUserInfo()
  }
}
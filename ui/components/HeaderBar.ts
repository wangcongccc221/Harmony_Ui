/**
 * 全局顶部空间组件
 * 功能：显示公司logo和用户个人信息
 * 用途：在所有页面顶部提供统一的品牌展示和用户信息显示
 */

// HarmonyOS ArkTS组件
@Entry
@Component
struct HeaderBar {
  // 用户信息状态变量
  @State userName: string = '张三'
  @State userRole: string = '管理员'
  @State userAvatar: Resource = $r('app.media.default_avatar')
  @State isUserMenuOpen: boolean = false

  build() {
    Row() {
      // 左侧公司Logo区域
      Row() {
        Image($r('app.media.logo'))
          .width(40)
          .height(40)
          .objectFit(ImageFit.Contain)
        
        Text('公司名称')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ left: 12 })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)
      
      Blank()
      
      // 右侧用户信息区域
      Row() {
        Image(this.userAvatar)
          .width(36)
          .height(36)
          .borderRadius(18)
          .objectFit(ImageFit.Cover)
          .border({ width: 2, color: '#e0e0e0' })
        
        Column() {
          Text(this.userName)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#333333')
            .textAlign(TextAlign.End)
          
          Text(this.userRole)
            .fontSize(12)
            .fontColor('#666666')
            .textAlign(TextAlign.End)
        }
        .alignItems(HorizontalAlign.End)
        .margin({ left: 12 })
        
        Image($r('app.media.menu_icon'))
          .width(16)
          .height(16)
          .margin({ left: 12 })
          .onClick(() => {
            this.toggleUserMenu()
          })
      }
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height(60)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#ffffff')
    .border({ width: { bottom: 1 }, color: '#e0e0e0' })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
  }

  /**
   * 切换用户菜单显示状态
   */
  toggleUserMenu(): void {
    this.isUserMenuOpen = !this.isUserMenuOpen
    // TODO: 实现用户菜单的显示/隐藏逻辑
  }

  /**
   * 设置用户信息
   * @param name 用户名
   * @param role 用户角色
   * @param avatar 用户头像资源
   */
  setUserInfo(name: string, role: string, avatar?: Resource): void {
    this.userName = name
    this.userRole = role
    if (avatar) {
      this.userAvatar = avatar
    }
  }
}

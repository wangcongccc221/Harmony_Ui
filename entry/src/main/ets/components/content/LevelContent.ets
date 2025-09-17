/**
 * 等级内容组件
 * 功能：显示等级相关的内容和功能
 * 用途：在Home页面中作为等级内容显示
 * 集成 Omni-UI 主题系统
 */

import { OmniThemeManager, OmniThemeType } from '../../utils/OmniThemeManager'

@Component
export struct LevelContent {
  private omniThemeManager = OmniThemeManager.getInstance()
  @State currentThemeType: OmniThemeType = OmniThemeType.BLUE  // 直接跟踪主题类型
  @State themeChangeFlag: number = 0  // 主题变化标志状态
  private themeChangeCallback?: (theme: OmniThemeType) => void  // 保存回调引用

  // 组件初始化时设置主题
  aboutToAppear() {
    this.currentThemeType = this.omniThemeManager.getCurrentThemeType()
    this.themeChangeFlag = this.omniThemeManager.getThemeChangeFlag()
    
    // 创建并保存主题变化回调
    this.themeChangeCallback = (theme: OmniThemeType) => {
      this.currentThemeType = theme
      this.themeChangeFlag = this.omniThemeManager.getThemeChangeFlag()
    }
    
    // 注册主题变化回调
    this.omniThemeManager.addThemeChangeCallback(this.themeChangeCallback)
  }

  // 组件更新时检查主题变化标志
  aboutToUpdate() {
    const latestFlag = this.omniThemeManager.getThemeChangeFlag()
    if (this.themeChangeFlag !== latestFlag) {
      this.themeChangeFlag = latestFlag
      this.currentThemeType = this.omniThemeManager.getCurrentThemeType()
    }
  }

  // 组件销毁时移除回调
  aboutToDisappear() {
    // 移除主题变化回调
    if (this.themeChangeCallback) {
      this.omniThemeManager.removeThemeChangeCallback(this.themeChangeCallback)
    }
  }

  // 获取当前主题配置
  getCurrentTheme() {
    return this.omniThemeManager.getCurrentTheme()
  }
  build() {
    Column() {
      // 等级标题
      Text('等级')
        .fontSize(this.getCurrentTheme().fontSizeXl)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getCurrentTheme().textColor)
        .margin({ top: 20, bottom: 20 })
      
      // 等级内容区域
      Column() {
        Text('用户等级系统')
          .fontSize(this.getCurrentTheme().fontSizeLg)
          .fontColor(this.getCurrentTheme().textColor)
          .margin({ bottom: 15 })
        
        Text('这里可以显示用户的等级信息')
          .fontSize(this.getCurrentTheme().fontSizeMd)
          .fontColor(this.getCurrentTheme().subTextColor)
          .margin({ bottom: 10 })
        
        Text('比如：当前等级、经验值、升级进度等')
          .fontSize(this.getCurrentTheme().fontSizeMd)
          .fontColor(this.getCurrentTheme().subTextColor)
          .margin({ bottom: 10 })
        
        Text('可以添加等级徽章、进度条等组件')
          .fontSize(this.getCurrentTheme().fontSizeMd)
          .fontColor(this.getCurrentTheme().subTextColor)
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(this.getCurrentTheme().backgroundColor)
  }
}

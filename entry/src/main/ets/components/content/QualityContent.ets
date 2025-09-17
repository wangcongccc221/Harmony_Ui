/**
 * 品质内容组件
 * 功能：显示品质相关的内容和功能
 * 用途：在Home页面中作为品质内容显示
 * 集成 Omni-UI 主题系统
 */

import { OmniThemeManager, OmniThemeType } from '../../utils/OmniThemeManager'

@Component
export struct QualityContent {
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
      // 品质标题
      Text('品质')
        .fontSize(this.getCurrentTheme().fontSizeXl)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getCurrentTheme().textColor)
        .margin({ top: 20, bottom: 20 })
      
      // 品质内容区域
      Column() {
        Text('品质管理系统')
          .fontSize(this.getCurrentTheme().fontSizeLg)
          .fontColor(this.getCurrentTheme().textColor)
          .margin({ bottom: 15 })
        
        Text('这里可以显示品质相关的信息')
          .fontSize(this.getCurrentTheme().fontSizeMd)
          .fontColor(this.getCurrentTheme().subTextColor)
          .margin({ bottom: 10 })
        
        Text('比如：产品品质、服务质量、用户评价等')
          .fontSize(this.getCurrentTheme().fontSizeMd)
          .fontColor(this.getCurrentTheme().subTextColor)
          .margin({ bottom: 10 })
        
        Text('可以添加品质评分、评价列表等组件')
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

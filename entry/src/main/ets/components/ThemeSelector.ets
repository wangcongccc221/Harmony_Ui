/**
 * 主题选择器组件
 * 功能：提供主题选择弹窗
 * 用途：让用户选择彩色主题
 */

import { OmniThemeManager, OmniThemeType } from '../utils/OmniThemeManager'
import { OmniUIUtils } from '../utils/OmniUIUtils'

@Component
export struct ThemeSelector {
  private omniThemeManager = OmniThemeManager.getInstance()
  private omniUIUtils = OmniUIUtils.getInstance()
  @State currentTheme: OmniThemeType = OmniThemeType.BLUE
  @State selectedTheme: OmniThemeType = OmniThemeType.BLUE  // 用户选择的主题（未确认）
  onThemeSelected?: (theme: OmniThemeType) => void
  onCancel?: () => void

  // 初始化当前主题
  aboutToAppear() {
    this.currentTheme = this.omniThemeManager.getCurrentThemeType()
    this.selectedTheme = this.currentTheme  // 初始选择当前主题
  }

  // 选择主题（预览，不立即应用）
  selectTheme(theme: OmniThemeType) {
    this.selectedTheme = theme
  }

  // 确认应用主题
  confirmTheme() {
    this.currentTheme = this.selectedTheme
    if (this.onThemeSelected) {
      this.onThemeSelected(this.selectedTheme)
    }
  }

  // 取消选择
  cancel() {
    if (this.onCancel) {
      this.onCancel()
    }
  }

  // 构建主题选项
  @Builder
  buildThemeOption(themeType: OmniThemeType, icon: string, title: string, description: string) {
    Row() {
      Text(icon)
        .fontSize(24)
        .margin({ right: 12 })
      
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.omniThemeManager.getCurrentTheme().textColor)
        
        Text(description)
          .fontSize(12)
          .fontColor(this.omniThemeManager.getCurrentTheme().subTextColor)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 选中状态指示器
      if (this.selectedTheme === themeType) {
        Text('✓')
          .fontSize(20)
          .fontColor(this.omniThemeManager.getCurrentTheme().primary)
          .fontWeight(FontWeight.Bold)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.selectedTheme === themeType 
      ? this.omniThemeManager.getCurrentTheme().primary + '20' 
      : this.omniThemeManager.getCurrentTheme().surfaceColor)
    .borderRadius(12)
    .margin({ bottom: 12 })
    .onClick(() => {
      this.selectTheme(themeType)
    })
  }

  build() {
    // 背景遮罩
    Column() {
      // 主题选择弹窗
      Column() {
        // 标题
        Text('选择主题')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.omniThemeManager.getCurrentTheme().textColor)
          .margin({ bottom: 20 })

        // 主题选项 - 使用滚动视图支持更多主题
        Scroll() {
          Column() {
            // 彩色主题组
            Text('彩色主题')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.omniThemeManager.getCurrentTheme().subTextColor)
              .margin({ bottom: 8, top: 8 })
              .alignSelf(ItemAlign.Start)

            // 蓝色主题选项
            this.buildThemeOption(OmniThemeType.BLUE, '🔵', '蓝色主题', '现代科技感蓝色系')
            
            // 绿色主题选项
            this.buildThemeOption(OmniThemeType.GREEN, '🟢', '绿色主题', '自然清新绿色系')
            
            // 紫色主题选项
            this.buildThemeOption(OmniThemeType.PURPLE, '🟣', '紫色主题', '优雅神秘紫色系')
            
            // 橙色主题选项
            this.buildThemeOption(OmniThemeType.ORANGE, '🟠', '橙色主题', '活力温暖橙色系')
            
            // 粉色主题选项
            this.buildThemeOption(OmniThemeType.PINK, '🌸', '粉色主题', '温柔浪漫粉色系')
            
            // 青色主题选项
            this.buildThemeOption(OmniThemeType.TEAL, '🟦', '青色主题', '清新淡雅青色系')
          }
          .width('100%')
        }
        .height(400)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Auto)
        .width('100%')

        // 确认和取消按钮
        Row() {
          // 取消按钮
          Button('取消')
            .layoutWeight(1)
            .height(44)
            .fontSize(16)
            .fontColor(this.omniThemeManager.getCurrentTheme().textColor)
            .backgroundColor(this.omniThemeManager.getCurrentTheme().surfaceColor)
            .border({ width: 1, color: this.omniThemeManager.getCurrentTheme().borderColor })
            .borderRadius(8)
            .margin({ top: 20, right: 8 })
            .onClick(() => {
              this.cancel()
            })

          // 确认按钮
          Button('确认')
            .layoutWeight(1)
            .height(44)
            .fontSize(16)
            .fontColor('#FFFFFF')
            .backgroundColor(this.omniThemeManager.getCurrentTheme().primary)
            .borderRadius(8)
            .margin({ top: 20, left: 8 })
            .onClick(() => {
              this.confirmTheme()
            })
        }
        .width('100%')
      }
      .width('80%')
      .padding(24)
      .backgroundColor(this.omniThemeManager.getCurrentTheme().surfaceColor)
      .borderRadius(16)
      .shadow({
        radius: 20,
        color: '#00000020',
        offsetX: 0,
        offsetY: 4
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#00000060')  // 半透明黑色背景
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      // 点击背景关闭弹窗
      this.cancel()
    })
  }
}
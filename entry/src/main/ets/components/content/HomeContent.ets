/**
 * 主页内容组件
 * 功能：显示主页相关的内容和功能
 * 用途：在Home页面中作为主页内容显示
 * 集成 Omni-UI 组件
 */

import { OmniThemeManager, OmniThemeType, ExtendedOmniThemeStyle } from '../../utils/OmniThemeManager'
import { OmniSearchV2, OmniTag, TagItemInfo, TagMode } from '@wuba58/omni-ui'
// 导入 IBest-UI 组件
import { IBestButton, IBestTag, IBestIcon } from '@ibestservices/ibest-ui'

@Component
export struct HomeContent {
  private omniThemeManager = OmniThemeManager.getInstance()
  @State searchText: string = ''
  @State selectedTags: string[] = ['热门', '推荐']
  @State currentThemeType: OmniThemeType = OmniThemeType.BLUE  // 当前主题类型状态
  @State themeChangeFlag: number = 0  // 主题变化标志状态
  private themeChangeCallback?: (theme: OmniThemeType) => void  // 保存回调引用
  
  // 标签数据
  @State tagData: TagItemInfo[] = [
    new TagItemInfo({ title: '热门', isSelected: true }),
    new TagItemInfo({ title: '推荐', isSelected: true }),
    new TagItemInfo({ title: '最新', isSelected: false }),
    new TagItemInfo({ title: '精选', isSelected: false })
  ]

  // 组件初始化时设置主题状态
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

  // 获取当前主题配置的方法
  getCurrentTheme(): ExtendedOmniThemeStyle {
    return this.omniThemeManager.getCurrentTheme()
  }
  
  build() {
    Scroll() {
      Column() {
        // 主页标题
        Text('欢迎回来！')
          .fontSize(this.getCurrentTheme().fontSizeXl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getCurrentTheme().textColor)
          .margin({ top: 20, bottom: 20 })
        
        // 搜索区域
        Column() {
          Text('搜索功能')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getCurrentTheme().textColor)
            .margin({ bottom: 10 })
          
          OmniSearchV2({
            submitCallback: (text: string) => {
              this.searchText = text
              console.log('搜索内容:', text)
            }
          })
          .width('100%')
          .height(40)
        }
        .width('100%')
        .padding(20)
        .backgroundColor(this.getCurrentTheme().surfaceColor)
        .borderRadius(12)
        .margin({ bottom: 20 })
        
        // 标签区域
        Column() {
          Text('热门标签')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getCurrentTheme().textColor)
            .margin({ bottom: 15 })
          
          OmniTag({
            tagItems: this.tagData,
            mode: TagMode.FLEX,
            selectable: true,
            onItemClick: (tagItemInfo: TagItemInfo, index: number) => {
              // 切换选中状态
              tagItemInfo.isSelected = !tagItemInfo.isSelected
              console.log('选中标签:', tagItemInfo.title, tagItemInfo.isSelected)
            }
          })
          .width('100%')
        }
        .width('100%')
        .padding(20)
        .backgroundColor(this.getCurrentTheme().surfaceColor)
        .borderRadius(12)
        .margin({ bottom: 20 })
        
        // 数据表格区域
        Column() {
          Text('实时数据')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getCurrentTheme().textColor)
            .margin({ bottom: 15 })
          
          // 仪表板小组件 - 带动态波形图
          Row() {
            // 数据1 - 客流量
            Column() {
              Text('15')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().primary)
                .margin({ bottom: 8 })
              
              Divider()
                .color(this.getCurrentTheme().borderColor)
                .strokeWidth(1)
                .margin({ bottom: 8 })
              
              // 模拟波形图
              Row() {
                ForEach([1, 3, 2, 4, 3, 5, 2, 3, 4, 2], (item: number, index: number) => {
                  Rect()
                    .width(3)
                    .height(item * 2)
                    .fill(this.getCurrentTheme().primary)
                    .margin({ right: 1 })
                    .animation({
                      duration: 800,
                      curve: Curve.EaseInOut,
                      iterations: -1,
                      playMode: PlayMode.Alternate,
                      delay: index * 50
                    })
                })
              }
              .height(20)
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Bottom)
              
              Text('一小时客流量')
                .fontSize(10)
                .fontColor(this.getCurrentTheme().subTextColor)
                .textAlign(TextAlign.Center)
                .margin({ top: 4 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(12)
            .border({ width: { right: 1 }, color: this.getCurrentTheme().borderColor })
            
            // 数据2 - 在线数
            Column() {
              Text('8')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().primary)
                .margin({ bottom: 8 })
              
              Divider()
                .color(this.getCurrentTheme().borderColor)
                .strokeWidth(1)
                .margin({ bottom: 8 })
              
              // 模拟波形图
              Row() {
                ForEach([2, 4, 3, 5, 4, 6, 3, 4, 5, 3], (item: number, index: number) => {
                  Rect()
                    .width(3)
                    .height(item * 2)
                    .fill(this.getCurrentTheme().primary)
                    .margin({ right: 1 })
                    .animation({
                      duration: 900,
                      curve: Curve.EaseInOut,
                      iterations: -1,
                      playMode: PlayMode.Alternate,
                      delay: index * 60
                    })
                })
              }
              .height(20)
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Bottom)
              
              Text('当前在线')
                .fontSize(10)
                .fontColor(this.getCurrentTheme().subTextColor)
                .textAlign(TextAlign.Center)
                .margin({ top: 4 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(12)
            .border({ width: { right: 1 }, color: this.getCurrentTheme().borderColor })
            
            // 数据3 - 访问量
            Column() {
              Text('234')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().primary)
                .margin({ bottom: 8 })
              
              Divider()
                .color(this.getCurrentTheme().borderColor)
                .strokeWidth(1)
                .margin({ bottom: 8 })
              
              // 模拟波形图
              Row() {
                ForEach([3, 5, 4, 6, 5, 7, 4, 5, 6, 4], (item: number, index: number) => {
                  Rect()
                    .width(3)
                    .height(item * 2)
                    .fill(this.getCurrentTheme().primary)
                    .margin({ right: 1 })
                    .animation({
                      duration: 1000,
                      curve: Curve.EaseInOut,
                      iterations: -1,
                      playMode: PlayMode.Alternate,
                      delay: index * 70
                    })
                })
              }
              .height(20)
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Bottom)
              
              Text('今日访问')
                .fontSize(10)
                .fontColor(this.getCurrentTheme().subTextColor)
                .textAlign(TextAlign.Center)
                .margin({ top: 4 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(12)
            .border({ width: { right: 1 }, color: this.getCurrentTheme().borderColor })
            
            // 数据4 - 设备状态
            Column() {
              Text('12')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().primary)
                .margin({ bottom: 8 })
              
              Divider()
                .color(this.getCurrentTheme().borderColor)
                .strokeWidth(1)
                .margin({ bottom: 8 })
              
              // 模拟波形图
              Row() {
                ForEach([1, 2, 3, 2, 4, 3, 2, 3, 2, 1], (item: number, index: number) => {
                  Rect()
                    .width(3)
                    .height(item * 2)
                    .fill(this.getCurrentTheme().primary)
                    .margin({ right: 1 })
                    .animation({
                      duration: 1100,
                      curve: Curve.EaseInOut,
                      iterations: -1,
                      playMode: PlayMode.Alternate,
                      delay: index * 80
                    })
                })
              }
              .height(20)
              .justifyContent(FlexAlign.End)
              .alignItems(VerticalAlign.Bottom)
              
              Text('设备状态')
                .fontSize(10)
                .fontColor(this.getCurrentTheme().subTextColor)
                .textAlign(TextAlign.Center)
                .margin({ top: 4 })
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(12)
          }
          .width('100%')
          .backgroundColor(this.getCurrentTheme().surfaceColor)
          .border({ width: 1, color: this.getCurrentTheme().borderColor })
          .borderRadius(8)
        }
        .width('100%')
        .padding(20)
        .backgroundColor(this.getCurrentTheme().surfaceColor)
        .borderRadius(12)
        .margin({ bottom: 20 })
        
        // 快捷操作区域
        Column() {
          Text('快捷操作')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getCurrentTheme().textColor)
            .margin({ bottom: 15 })
          
          Row() {
            Column() {
              Text('📊')
                .fontSize(32)
                .margin({ bottom: 8 })
              Text('数据统计')
                .fontSize(14)
                .fontColor(this.getCurrentTheme().subTextColor)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(15)
            .backgroundColor(this.getCurrentTheme().backgroundColor)
            .borderRadius(8)
            .margin({ right: 10 })
            
            Column() {
              Text('📈')
                .fontSize(32)
                .margin({ bottom: 8 })
              Text('趋势分析')
                .fontSize(14)
                .fontColor(this.getCurrentTheme().subTextColor)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(15)
            .backgroundColor(this.getCurrentTheme().backgroundColor)
            .borderRadius(8)
            .margin({ right: 10 })
            
            Column() {
              Text('⚙️')
                .fontSize(32)
                .margin({ bottom: 8 })
              Text('系统设置')
                .fontSize(14)
                .fontColor(this.getCurrentTheme().subTextColor)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .padding(15)
            .backgroundColor(this.getCurrentTheme().backgroundColor)
            .borderRadius(8)
          }
          .width('100%')
        }
        .width('100%')
        .padding(20)
        .backgroundColor(this.getCurrentTheme().surfaceColor)
        .borderRadius(12)
        .margin({ bottom: 20 })
      }
      .width('100%')
      .padding({ left: 20, right: 20 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getCurrentTheme().backgroundColor)
  }
}

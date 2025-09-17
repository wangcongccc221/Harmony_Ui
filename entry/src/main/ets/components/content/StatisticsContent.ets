/**
 * 统计内容组件
 * 功能：显示统计相关的内容和数据
 * 用途：在Home页面中作为统计内容显示
 * 集成 Omni-UI 图表组件
 */

import { OmniPieChart, OmniLineChart, PieDataType, LineDataType, Options } from '@wuba58/omni-ui'
import { OmniThemeManager, OmniThemeType } from '../../utils/OmniThemeManager'

@Component
export struct StatisticsContent {
  private omniThemeManager = OmniThemeManager.getInstance()
  @State currentThemeType: OmniThemeType = OmniThemeType.BLUE  // 直接跟踪主题类型
  @State themeChangeFlag: number = 0  // 主题变化标志状态
  private themeChangeCallback?: (theme: OmniThemeType) => void  // 保存回调引用
  
  // 饼图数据
  private pieData: PieDataType[] = [
    { name: '用户', value: 35, color: '#FF6B6B' },
    { name: '订单', value: 25, color: '#4ECDC4' },
    { name: '商品', value: 20, color: '#45B7D1' },
    { name: '其他', value: 20, color: '#96CEB4' }
  ]

  // 折线图数据
  private lineData: number[] = [120, 200, 150, 300, 250, 400]
  private lineLabels: string[] = ['1月', '2月', '3月', '4月', '5月', '6月']

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
    Scroll() {
      Column() {
        // 统计标题
        Text('数据统计')
          .fontSize(this.getCurrentTheme().fontSizeXl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getCurrentTheme().textColor)
          .margin({ top: 20, bottom: 20 })
        
        // 统计卡片区域
        Column() {
          // 数据概览卡片
          Row() {
                    Column() {
                      Text('总用户数')
                        .fontSize(14)
                        .fontColor(this.getCurrentTheme().subTextColor)
                      Text('1,234')
                        .fontSize(24)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(this.getCurrentTheme().primary)
                    }
                    .layoutWeight(1)
                    .alignItems(HorizontalAlign.Center)

                    Column() {
                      Text('总订单数')
                        .fontSize(14)
                        .fontColor(this.getCurrentTheme().subTextColor)
                      Text('5,678')
                        .fontSize(24)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(this.getCurrentTheme().primary)
                    }
                    .layoutWeight(1)
                    .alignItems(HorizontalAlign.Center)
                  }
                  .width('100%')
                  .padding(20)
                  .backgroundColor(this.getCurrentTheme().surfaceColor)
                  .borderRadius(12)
                  .margin({ bottom: 20 })
          
          // 饼图区域
          Column() {
            Text('数据分布')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.getCurrentTheme().textColor)
              .margin({ bottom: 15 })
            
            OmniPieChart({
              options: new Options({
                series: [{
                  name: '数据分布',
                  data: this.pieData,
                  radius: ['40%', '70%'],
                  center: ['50%', '50%']
                }],
                legend: {
                  show: true,
                  orient: 'horizontal',
                  left: 'center',
                  top: '10%'
                }
              })
            })
            .width(300)
            .height(300)
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getCurrentTheme().surfaceColor)
          .borderRadius(12)
          .margin({ bottom: 20 })
          
          // 折线图区域
          Column() {
            Text('月度趋势')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.getCurrentTheme().textColor)
              .margin({ bottom: 15 })
            
            OmniLineChart({
              options: new Options({
                series: [{
                  name: '月度趋势',
                  data: this.lineData,
                  lineStyle: {
                    color: this.getCurrentTheme().primary
                  }
                }],
                xAxis: {
                  type: 'category',
                  data: this.lineLabels
                },
                yAxis: {
                  type: 'value'
                }
              })
            })
            .width('100%')
            .height(200)
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
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getCurrentTheme().backgroundColor)
  }
}

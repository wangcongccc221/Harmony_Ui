import { HomeContent } from '../components/content/HomeContent'
import { StatisticsContent } from '../components/content/StatisticsContent'
import { LevelContent } from '../components/content/LevelContent'
import { QualityContent } from '../components/content/QualityContent'
import { ThemeSelector } from '../components/ThemeSelector'
import { OmniThemeManager, OmniThemeType } from '../utils/OmniThemeManager'
import { OmniUIInit } from '../utils/OmniUIInit'
import { OmniUIUtils } from '../utils/OmniUIUtils'
import { OmniBottomTabBar, OmniBottomBarItem } from '@wuba58/omni-ui'
// 导入 IBest-UI 组件
import { IBestButton, IBestIcon, IBestTag, IBestInit } from '@ibestservices/ibest-ui'
import { window } from '@kit.ArkUI'

@Entry
@Component
struct Page {
  @State currentPage: string = '主页'
  @State currentThemeType: OmniThemeType = OmniThemeType.BLUE  // 当前主题类型状态
  @State showThemeSelector: boolean = false  // 控制主题选择器显示
  @State forceRefresh: number = 0  // 强制刷新标志
  private omniThemeManager = OmniThemeManager.getInstance()  // Omni-UI 主题管理器实例
  private omniUIInit = OmniUIInit.getInstance()  // Omni-UI 初始化实例
  private omniUIUtils = OmniUIUtils.getInstance()  // Omni-UI 工具实例
  
  // 页面初始化时初始化 Omni-UI 和 IBest-UI
  aboutToAppear() {
    this.omniUIInit.init()
    this.omniThemeManager.init()
    // 暂时注释掉 IBest-UI 初始化，避免 WindowStage 参数问题
    // IBestInit({}, windowStage) // 初始化 IBest-UI
  }
  
  // 获取当前主题配置的方法
  getCurrentTheme() {
    // 确保获取最新的主题配置
    const theme = this.omniThemeManager.getCurrentTheme()
    console.log('获取主题配置:', this.currentThemeType, theme)
    return theme
  }

  // 判断是否为浅色主题（所有彩色主题都是深色系）
  isLightTheme(): boolean {
    return false  // 所有彩色主题都是深色系
  }

  // 获取当前主题的主色调（基于页面状态）
  getThemePrimaryColor(): string {
    const themeConfigs = this.omniThemeManager.getAllThemes()
    const primaryColor = themeConfigs[this.currentThemeType]?.primary
    return typeof primaryColor === 'string' ? primaryColor : '#007AFF'
  }

  build() {
    Stack() {
      Column() {
        // 顶部区域：Logo和用户信息（横跨整个宽度，黑色背景）
        Row() {
        // 左侧公司Logo区域
        Row() {
          // 临时用文字代替图片
          Text('LOGO')
            .width(40)
            .height(40)
            .fontSize(12)
            .fontColor('#ffffff')
            .textAlign(TextAlign.Center)
            .backgroundColor('#ff0000') // 改成红色，更容易看到
            .borderRadius(4)
          
           Text('公司名称')
             .fontSize(18)
             .fontWeight(FontWeight.Medium)
             .fontColor(this.getCurrentTheme().textColor)
             .margin({ left: 12 })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Start)
        
        Blank()
        
         // 右侧用户信息区域
         Row() {
           // 临时用文字代替头像
           Text('头像')
             .width(36)
             .height(36)
             .fontSize(10)
             .fontColor('#ffffff')
             .textAlign(TextAlign.Center)
             .backgroundColor('#666666')
             .borderRadius(18)
             .border({ width: 2, color: '#ffffff' })
           
           Column() {
             Text('张三')
               .fontSize(14)
               .fontWeight(FontWeight.Medium)
               .fontColor(this.getCurrentTheme().surfaceColor)
               .textAlign(TextAlign.End)
             
             Text('管理员')
               .fontSize(12)
               .fontColor(this.getCurrentTheme().subTextColor)
               .textAlign(TextAlign.End)
           }
           .alignItems(HorizontalAlign.End)
           .margin({ left: 12 })
           
          // 主题选择按钮 - 使用 IBest-UI
          IBestButton({
            text: '🎨',
            type: 'primary',
            buttonSize: 'small',
            round: true,
            onBtnClick: () => {
              // 显示主题选择器
              this.showThemeSelector = true
            }
          })
          .margin({ left: 12 })
         }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.End)
       }
       .width('100%')
       .height(60)
       .padding({ left: 20, right: 20 })
       .backgroundColor(this.getCurrentTheme().headerColor) // 使用主题色
      
      // 主要内容区域 - 使用 Omni-UI 底部导航栏
      Column() {
        // 内容显示区域
        Column() {
          if (this.currentPage === '主页') {
            if (this.forceRefresh % 2 === 0) {
              HomeContent()
            } else {
              // 空组件，用于强制重新渲染
              Column() {
                HomeContent()
              }
            }
          } else if (this.currentPage === '水果信息') {
            // 水果信息页面内容
            Column() {
              Text('水果信息页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 })
              
              Text('这里将显示水果的详细信息')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          } else if (this.currentPage === '载入程序') {
            // 载入程序页面内容
            Column() {
              Text('载入程序页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 })
              
              Text('这里将显示程序载入功能')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          } else if (this.currentPage === '历史加工') {
            // 历史加工页面内容
            Column() {
              Text('历史加工页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 })
              
              Text('这里将显示历史加工记录')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          } else if (this.currentPage === '实时统计') {
            // 实时统计页面内容
            Column() {
              Text('实时统计页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 })
              
              Text('这里将显示实时统计数据')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          } else if (this.currentPage === '结束加工') {
            // 结束加工页面内容
            Column() {
              Text('结束加工页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 })
              
              Text('这里将显示结束加工功能')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          } else if (this.currentPage === '打印') {
            // 打印页面内容
            Column() {
              Text('打印页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 })
              
              Text('这里将显示打印功能')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          } else if (this.currentPage === '更多') {
            // 更多页面内容
            Column() {
              Text('更多页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 })
              
              Text('这里将显示更多功能选项')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
          } else {
            // 默认显示主页内容
            if (this.forceRefresh % 2 === 0) {
              HomeContent()
            } else {
              Column() {
                HomeContent()
              }
            }
          }
        }
        .width('100%')
        .height('100%')
        .backgroundColor(this.getCurrentTheme().surfaceColor)
        .layoutWeight(1)
        
        }
        .width('100%')
        .layoutWeight(1)
      }
      .height('100%')
      .width('100%')
      
      // 底部导航栏 - 一行布局，使用IBestButton获得方方正正样式
      Row() {
        // 主页按钮
        IBestButton({
          text: '主页',
          type: this.currentPage === '主页' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '主页',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '主页'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
        
        // 水果信息按钮
        IBestButton({
          text: '水果信息',
          type: this.currentPage === '水果信息' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '水果信息',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '水果信息'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
        
        // 载入程序按钮
        IBestButton({
          text: '载入程序',
          type: this.currentPage === '载入程序' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '载入程序',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '载入程序'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
        
        // 历史加工按钮
        IBestButton({
          text: '历史加工',
          type: this.currentPage === '历史加工' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '历史加工',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '历史加工'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
        
        // 实时统计按钮
        IBestButton({
          text: '实时统计',
          type: this.currentPage === '实时统计' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '实时统计',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '实时统计'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
        
        // 结束加工按钮
        IBestButton({
          text: '结束加工',
          type: this.currentPage === '结束加工' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '结束加工',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '结束加工'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
        
        // 打印按钮
        IBestButton({
          text: '打印',
          type: this.currentPage === '打印' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '打印',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '打印'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
        
        // 更多按钮
        IBestButton({
          text: '更多',
          type: this.currentPage === '更多' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '更多',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '更多'
            console.log('切换到页面:', this.currentPage)
            this.omniUIUtils.showInfo(`已切换到${this.currentPage}页面`)
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 })
      }
      .width('100%')
      .height(80)  // 增加导航栏高度
      .backgroundColor(this.getThemePrimaryColor())  // 使用页面状态获取主题色
      .border({ width: { top: 1 }, color: this.getCurrentTheme().borderColor })
      .position({ x: 0, y: '100%' })
      .translate({ y: -80 })  // 向上偏移导航栏高度，完全贴死底部
      
      // 主题选择器弹窗
      if (this.showThemeSelector) {
        ThemeSelector({
          onThemeSelected: (theme: OmniThemeType) => {
            console.log('开始切换主题:', theme)
            
            // 先设置主题管理器中的主题
            this.omniThemeManager.setTheme(theme)
            
            // 然后更新页面状态以触发界面重新渲染
            this.currentThemeType = theme
            
            // 强制刷新所有组件
            this.forceRefresh++
            
            // 关闭弹窗
            this.showThemeSelector = false
            
            // 显示成功提示
            const themeName = this.omniThemeManager.getThemeName(theme)
            this.omniUIUtils.showSuccess(`已切换到${themeName}`)
            
            console.log('主题切换完成:', theme, '当前主题类型:', this.currentThemeType, '刷新标志:', this.forceRefresh)
          },
          onCancel: () => {
            this.showThemeSelector = false
          }
        })
      }
    }
  }
}
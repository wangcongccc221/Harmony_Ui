import { HomeContent } from '../components/content/HomeContent';
import { StatisticsContent } from '../components/content/StatisticsContent';
import { LevelContent } from '../components/content/LevelContent';
import { QualityContent } from '../components/content/QualityContent';
import { ThemeSelector } from '../components/ThemeSelector';
import { OmniThemeManager, OmniThemeType } from '../utils/OmniThemeManager';
import { OmniUIInit } from '../utils/OmniUIInit';
import { OmniUIUtils } from '../utils/OmniUIUtils';
import { OmniBottomTabBar, OmniBottomBarItem } from '@wuba58/omni-ui';
import { IBestButton, IBestIcon, IBestTag, IBestInit } from '@ibestservices/ibest-ui';
import { window } from '@kit.ArkUI';
import { HeaderBar } from '../components/HeaderBar';

@Entry
@Component
struct Page {
  @State currentPage: string = '主页';
  @State currentThemeType: OmniThemeType = OmniThemeType.BLUE;
  @State showThemeSelector: boolean = false;
  private omniThemeManager = OmniThemeManager.getInstance();
  private omniUIInit = OmniUIInit.getInstance();
  private omniUIUtils = OmniUIUtils.getInstance();

  aboutToAppear() {
    this.omniUIInit.init();
    this.omniThemeManager.init();
  }

  getCurrentTheme() {
    return this.omniThemeManager.getCurrentTheme();
  }

  build() {
    Stack() {
      Column() {
        // 使用 HeaderBar 组件，不再重复代码
        HeaderBar()

        // 主要内容区域
        Column() {
          if (this.currentPage === '主页') {
            HomeContent();
          } else if (this.currentPage === '水果信息') {
            Column() {
              Text('水果信息页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 });

              Text('这里将显示水果的详细信息')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 });
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center);
          } else if (this.currentPage === '载入程序') {
            Column() {
              Text('载入程序页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 });

              Text('这里将显示程序载入功能')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 });
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center);
          } else if (this.currentPage === '历史加工') {
            Column() {
              Text('历史加工页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 });

              Text('这里将显示历史加工记录')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 });
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center);
          } else if (this.currentPage === '实时统计') {
            Column() {
              Text('实时统计页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 });

              Text('这里将显示实时统计数据')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 });
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center);
          } else if (this.currentPage === '结束加工') {
            Column() {
              Text('结束加工页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 });

              Text('这里将显示结束加工功能')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 });
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center);
          } else if (this.currentPage === '打印') {
            Column() {
              Text('打印页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 });

              Text('这里将显示打印功能')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 });
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center);
          } else if (this.currentPage === '更多') {
            Column() {
              Text('更多页面')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getCurrentTheme().textColor)
                .margin({ top: 50 });

              Text('这里将显示更多功能选项')
                .fontSize(16)
                .fontColor(this.getCurrentTheme().subTextColor)
                .margin({ top: 20 });
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center);
          } else {
            HomeContent();
          }
        }
        .width('100%')
        .height('100%')
        .backgroundColor(this.getCurrentTheme().surfaceColor)
        .layoutWeight(1);
      }
      .height('100%')
      .width('100%');

      // 底部导航栏
      Row() {
        IBestButton({
          text: '主页',
          type: this.currentPage === '主页' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '主页',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '主页';
            this.omniUIUtils.showInfo(`已切换到主页页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
        
        IBestButton({
          text: '水果信息',
          type: this.currentPage === '水果信息' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '水果信息',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '水果信息';
            this.omniUIUtils.showInfo(`已切换到水果信息页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
        
        IBestButton({
          text: '载入程序',
          type: this.currentPage === '载入程序' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '载入程序',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '载入程序';
            this.omniUIUtils.showInfo(`已切换到载入程序页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
        
        IBestButton({
          text: '历史加工',
          type: this.currentPage === '历史加工' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '历史加工',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '历史加工';
            this.omniUIUtils.showInfo(`已切换到历史加工页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
        
        IBestButton({
          text: '实时统计',
          type: this.currentPage === '实时统计' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '实时统计',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '实时统计';
            this.omniUIUtils.showInfo(`已切换到实时统计页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
        
        IBestButton({
          text: '结束加工',
          type: this.currentPage === '结束加工' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '结束加工',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '结束加工';
            this.omniUIUtils.showInfo(`已切换到结束加工页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
        
        IBestButton({
          text: '打印',
          type: this.currentPage === '打印' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '打印',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '打印';
            this.omniUIUtils.showInfo(`已切换到打印页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
        
        IBestButton({
          text: '更多',
          type: this.currentPage === '更多' ? 'primary' : 'default',
          buttonSize: 'normal',
          plain: this.currentPage !== '更多',
          fontWeight: FontWeight.Bold,
          onBtnClick: () => {
            this.currentPage = '更多';
            this.omniUIUtils.showInfo(`已切换到更多页面`);
          }
        })
        .layoutWeight(1)
        .margin({ top: 8, bottom: 8, left: 2, right: 2 });
      }
      .width('100%')
      .height(80)
      .backgroundColor(this.getCurrentTheme().headerColor) // 使用主题色
      .border({ width: { top: 1 }, color: this.getCurrentTheme().borderColor })
      .position({ x: 0, y: '100%' })
      .translate({ y: -80 });

      if (this.showThemeSelector) {
        ThemeSelector({
          onThemeSelected: (theme: OmniThemeType) => {
            this.omniThemeManager.setTheme(theme);
            this.currentThemeType = theme;
            this.showThemeSelector = false;
            const themeName = this.omniThemeManager.getThemeName(theme);
            this.omniUIUtils.showSuccess(`已切换到${themeName}`);
          },
          onCancel: () => {
            this.showThemeSelector = false;
          }
        });
      }
    }
  }
}
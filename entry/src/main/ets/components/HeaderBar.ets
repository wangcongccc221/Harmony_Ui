/**
 * 全局顶部空间组件
 * 功能：显示公司logo和用户个人信息
 * 用途：在所有页面顶部提供统一的品牌展示和用户信息显示
 */

import { OmniThemeManager, OmniThemeType, ExtendedOmniThemeStyle, ThemeChangeCallback } from '../../utils/OmniThemeManager';
import { window } from '@kit.ArkUI';

@Component
export struct HeaderBar {
  // 主题管理器实例
  private omniThemeManager = OmniThemeManager.getInstance();
  // 当前主题类型状态
  @State private currentThemeType: OmniThemeType = this.omniThemeManager.getCurrentThemeType();
  // 主题变化标志，用于触发组件更新
  @State private themeChangeFlag: number = 0;
  // 主题变化回调引用
  private themeChangeCallback?: ThemeChangeCallback;

  // 用户信息状态变量
  @State userName: string = '张三';
  @State userRole: string = '管理员';
  @State userAvatar: Resource = $r('app.media.default_avatar');
  @State isUserMenuOpen: boolean = false;

  aboutToAppear() {
    this.currentThemeType = this.omniThemeManager.getCurrentThemeType();
    this.themeChangeFlag = this.omniThemeManager.getThemeChangeFlag();

    this.themeChangeCallback = (theme: OmniThemeType) => {
      this.currentThemeType = theme;
      this.themeChangeFlag = this.omniThemeManager.getThemeChangeFlag();
    };
    this.omniThemeManager.addThemeChangeCallback(this.themeChangeCallback);
  }

  aboutToDisappear() {
    if (this.themeChangeCallback) {
      this.omniThemeManager.removeThemeChangeCallback(this.themeChangeCallback);
    }
  }

  getCurrentTheme(): ExtendedOmniThemeStyle {
    return this.omniThemeManager.getCurrentTheme();
  }

  build() {
    Column() {
      // 顶部区域：Logo和用户信息
      Row() {
        // 左侧公司Logo区域
        Row() {
          Image($r('app.media.logo'))
            .width(40)
            .height(40)
            .objectFit(ImageFit.Contain)

          Text($r('app.string.company_name'))
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getCurrentTheme().textColor)
            .margin({ left: 12 });
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
            .border({ width: 2, color: this.getCurrentTheme().borderColor });

          Column() {
            Text(this.userName)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.getCurrentTheme().textColor)
              .textAlign(TextAlign.End);

            Text(this.userRole)
              .fontSize(12)
              .fontColor(this.getCurrentTheme().subTextColor)
              .textAlign(TextAlign.End);
          }
          .alignItems(HorizontalAlign.End)
          .margin({ left: 12 });
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.End);
      }
      .width('100%')
      .height(60)
      .padding({ left: 20, right: 20 });

      // 底部区域：导航按钮（垂直排列）
      Column() {
        // 主页按钮
        Button($r('app.string.home_page'))
          .width(80)
          .height(40)
          .fontSize(14)
          .fontColor(this.getCurrentTheme().textColor)
          .backgroundColor(this.getCurrentTheme().surfaceColor)
          .borderRadius(8)
          .onClick(() => {
            console.log('主页按钮被点击');
          });

        // 统计按钮
        Button($r('app.string.statistics'))
          .width(80)
          .height(40)
          .fontSize(14)
          .fontColor(this.getCurrentTheme().textColor)
          .backgroundColor(this.getCurrentTheme().surfaceColor)
          .borderRadius(8)
          .margin({ top: 8 })
          .onClick(() => {
            console.log('统计按钮被点击');
          });

        // 等级按钮
        Button($r('app.string.level'))
          .width(80)
          .height(40)
          .fontSize(14)
          .fontColor(this.getCurrentTheme().textColor)
          .backgroundColor(this.getCurrentTheme().surfaceColor)
          .borderRadius(8)
          .margin({ top: 8 })
          .onClick(() => {
            console.log('等级按钮被点击');
          });
      }
      .width('100%')
      .padding({ left: 20, right: 20, bottom: 15 })
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .backgroundColor(this.getCurrentTheme().headerColor)
    .border({ width: { bottom: 1 }, color: this.getCurrentTheme().borderColor })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 });
  }

  toggleUserMenu(): void {
    this.isUserMenuOpen = !this.isUserMenuOpen;
  }

  setUserInfo(name: string, role: string, avatar?: Resource): void {
    this.userName = name;
    this.userRole = role;
    if (avatar) {
      this.userAvatar = avatar;
    }
  }
}
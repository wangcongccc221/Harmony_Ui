/**
 * Omni-UI 主题管理器
 * 功能：基于 Omni-UI 主题系统，提供深色/浅色主题切换
 * 用途：统一管理应用的主题切换和主题配置
 */

import { OmniTheme, OmniThemeStyle } from '@wuba58/omni-ui'

// 主题类型枚举
export enum OmniThemeType {
  BLUE = 'blue',
  GREEN = 'green',
  PURPLE = 'purple',
  ORANGE = 'orange',
  PINK = 'pink',
  TEAL = 'teal'
}

// 扩展的主题配置接口
export interface ExtendedOmniThemeStyle extends OmniThemeStyle {
  // 背景色
  backgroundColor: string
  surfaceColor: string
  // 文字颜色
  textColor: string
  subTextColor: string
  // 边框颜色
  borderColor: string
  // 头部颜色
  headerColor: string
}


// 蓝色主题配置 - 现代科技深色系
const BLUE_THEME: ExtendedOmniThemeStyle = {
  primary: '#4A90E2',
  primaryColorWithOpacity: (opacity: number) => `rgba(74, 144, 226, ${opacity})`,
  fontSizeXs: 10,
  fontSizeSm: 12,
  fontSizeMd: 14,
  fontSizeLg: 16,
  fontSizeXl: 20,
  backgroundColor: '#1A233A',
  surfaceColor: '#2A3A5B',
  textColor: '#E0E6F0',
  subTextColor: '#9CA3AF',
  borderColor: '#4C5774',
  headerColor: '#233150'
}

// 绿色主题配置 - 自然深色系
const GREEN_THEME: ExtendedOmniThemeStyle = {
  primary: '#50C878',
  primaryColorWithOpacity: (opacity: number) => `rgba(80, 200, 120, ${opacity})`,
  fontSizeXs: 10,
  fontSizeSm: 12,
  fontSizeMd: 14,
  fontSizeLg: 16,
  fontSizeXl: 20,
  backgroundColor: '#1B322C',
  surfaceColor: '#2C4F42',
  textColor: '#ECF8E8',
  subTextColor: '#A3B5A1',
  borderColor: '#446E5C',
  headerColor: '#11211E'
}

// 紫色主题配置 - 优雅深色系
const PURPLE_THEME: ExtendedOmniThemeStyle = {
  primary: '#9370DB',
  primaryColorWithOpacity: (opacity: number) => `rgba(147, 112, 219, ${opacity})`,
  fontSizeXs: 10,
  fontSizeSm: 12,
  fontSizeMd: 14,
  fontSizeLg: 16,
  fontSizeXl: 20,
  backgroundColor: '#2D1E40',
  surfaceColor: '#43325B',
  textColor: '#F0EBF5',
  subTextColor: '#B3A2C7',
  borderColor: '#645582',
  headerColor: '#1F142D'
}

// 橙色主题配置 - 活力深色系
const ORANGE_THEME: ExtendedOmniThemeStyle = {
  primary: '#FF8C42',
  primaryColorWithOpacity: (opacity: number) => `rgba(255, 140, 66, ${opacity})`,
  fontSizeXs: 10,
  fontSizeSm: 12,
  fontSizeMd: 14,
  fontSizeLg: 16,
  fontSizeXl: 20,
  backgroundColor: '#3A2B1A',
  surfaceColor: '#5E482D',
  textColor: '#FDEFE1',
  subTextColor: '#C4B29B',
  borderColor: '#8C6C49',
  headerColor: '#2E2214'
}

// 粉色主题配置 - 温柔深色系
const PINK_THEME: ExtendedOmniThemeStyle = {
  primary: '#E57373',
  primaryColorWithOpacity: (opacity: number) => `rgba(229, 115, 115, ${opacity})`,
  fontSizeXs: 10,
  fontSizeSm: 12,
  fontSizeMd: 14,
  fontSizeLg: 16,
  fontSizeXl: 20,
  backgroundColor: '#3A242B',
  surfaceColor: '#5A3B43',
  textColor: '#F7EBEB',
  subTextColor: '#C9B7B7',
  borderColor: '#85606A',
  headerColor: '#2D1A21'
}

// 青色主题配置 - 清新深色系
const TEAL_THEME: ExtendedOmniThemeStyle = {
  primary: '#4DB6AC',
  primaryColorWithOpacity: (opacity: number) => `rgba(77, 182, 172, ${opacity})`,
  fontSizeXs: 10,
  fontSizeSm: 12,
  fontSizeMd: 14,
  fontSizeLg: 16,
  fontSizeXl: 20,
  backgroundColor: '#1D3A38',
  surfaceColor: '#2E5B58',
  textColor: '#EAF8F7',
  subTextColor: '#A3BDBB',
  borderColor: '#53807D',
  headerColor: '#132624'
}

// 主题配置数据
const THEME_CONFIGS: Record<OmniThemeType, ExtendedOmniThemeStyle> = {
  [OmniThemeType.BLUE]: BLUE_THEME,
  [OmniThemeType.GREEN]: GREEN_THEME,
  [OmniThemeType.PURPLE]: PURPLE_THEME,
  [OmniThemeType.ORANGE]: ORANGE_THEME,
  [OmniThemeType.PINK]: PINK_THEME,
  [OmniThemeType.TEAL]: TEAL_THEME
}

// 主题变化回调函数类型
export type ThemeChangeCallback = (theme: OmniThemeType) => void

// Omni-UI 主题管理器类
export class OmniThemeManager {
  private static instance: OmniThemeManager
  private currentTheme: OmniThemeType = OmniThemeType.BLUE
  private themeChangeCallbacks: ThemeChangeCallback[] = []  // 主题变化回调列表
  private themeChangeFlag: number = 0  // 主题变化标志，每次主题变化时递增
  
  // 单例模式
  static getInstance(): OmniThemeManager {
    if (!OmniThemeManager.instance) {
      OmniThemeManager.instance = new OmniThemeManager()
    }
    return OmniThemeManager.instance
  }
  
  /**
   * 初始化主题系统
   */
  init(): void {
    // 初始化 Omni-UI 主题系统
    OmniTheme.init()
    
    // 设置当前主题
    this.applyTheme(this.currentTheme)
  }
  
  /**
   * 获取当前主题配置
   */
  getCurrentTheme(): ExtendedOmniThemeStyle {
    return THEME_CONFIGS[this.currentTheme]
  }
  
  /**
   * 获取当前主题类型
   */
  getCurrentThemeType(): OmniThemeType {
    return this.currentTheme
  }
  
  /**
   * 设置主题
   */
  setTheme(theme: OmniThemeType): void {
    const previousTheme = this.currentTheme
    this.currentTheme = theme
    this.applyTheme(theme)
    
    // 更新主题变化标志
    this.themeChangeFlag++
    
    // 通知所有注册的回调函数
    this.notifyThemeChange(theme)
    
    console.log(`Omni-UI 主题已切换到: ${theme}, 标志: ${this.themeChangeFlag}`)
  }
  
  /**
   * 切换主题（在彩色主题之间循环切换）
   */
  toggleTheme(): void {
    const themes: OmniThemeType[] = [
      OmniThemeType.BLUE,
      OmniThemeType.GREEN,
      OmniThemeType.PURPLE,
      OmniThemeType.ORANGE,
      OmniThemeType.PINK,
      OmniThemeType.TEAL
    ]
    const currentIndex = themes.indexOf(this.currentTheme)
    const nextIndex = (currentIndex + 1) % themes.length
    this.currentTheme = themes[nextIndex]
    this.applyTheme(this.currentTheme)
    
    // 更新主题变化标志
    this.themeChangeFlag++
    
    // 通知所有注册的回调函数
    this.notifyThemeChange(this.currentTheme)
    
    console.log(`Omni-UI 主题已切换到: ${this.currentTheme}, 标志: ${this.themeChangeFlag}`)
  }
  
  /**
   * 应用主题到 Omni-UI 系统
   */
  private applyTheme(theme: OmniThemeType): void {
    const themeConfig = THEME_CONFIGS[theme]
    
    // 设置 Omni-UI 主题样式
    OmniTheme.setThemeStyle({
      primary: themeConfig.primary,
      primaryColorWithOpacity: themeConfig.primaryColorWithOpacity,
      fontSizeXs: themeConfig.fontSizeXs,
      fontSizeSm: themeConfig.fontSizeSm,
      fontSizeMd: themeConfig.fontSizeMd,
      fontSizeLg: themeConfig.fontSizeLg,
      fontSizeXl: themeConfig.fontSizeXl
    })
  }
  
  /**
   * 获取所有可用主题
   */
  getAllThemes(): Record<OmniThemeType, ExtendedOmniThemeStyle> {
    return THEME_CONFIGS
  }
  
  /**
   * 获取主题名称
   */
  getThemeName(theme: OmniThemeType): string {
    const themeNames: Record<OmniThemeType, string> = {
      [OmniThemeType.BLUE]: '蓝色主题',
      [OmniThemeType.GREEN]: '绿色主题',
      [OmniThemeType.PURPLE]: '紫色主题',
      [OmniThemeType.ORANGE]: '橙色主题',
      [OmniThemeType.PINK]: '粉色主题',
      [OmniThemeType.TEAL]: '青色主题'
    }
    return themeNames[theme] || '未知主题'
  }
  
  /**
   * 获取主题变化标志
   */
  getThemeChangeFlag(): number {
    return this.themeChangeFlag
  }
  
  /**
   * 注册主题变化回调
   */
  addThemeChangeCallback(callback: ThemeChangeCallback): void {
    this.themeChangeCallbacks.push(callback)
  }
  
  /**
   * 移除主题变化回调
   */
  removeThemeChangeCallback(callback: ThemeChangeCallback): void {
    const index = this.themeChangeCallbacks.indexOf(callback)
    if (index > -1) {
      this.themeChangeCallbacks.splice(index, 1)
    }
  }
  
  /**
   * 通知所有注册的回调函数主题已变化
   */
  private notifyThemeChange(theme: OmniThemeType): void {
    this.themeChangeCallbacks.forEach(callback => {
      try {
        callback(theme)
      } catch (error) {
        console.error('主题变化回调执行失败:', error)
      }
    })
  }
}

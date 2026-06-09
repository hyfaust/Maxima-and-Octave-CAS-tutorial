import { defineConfig } from 'vitepress'
import katexPlugin from './plugins/katex.js'

export default defineConfig({
  title: 'CAS学习教程',
  description: '使用Octave和Maxima学习计算机代数系统',
  ignoreDeadLinks: true,
  base: '/Maxima-and-Octave-CAS-tutorial/',
  lang: 'zh-CN',
  themeConfig: {
    nav: [
      { text: '首页', link: '/' },
      { text: '教程', link: '/guide/' },
      { text: '示例代码', link: '/examples/' }
    ],
    sidebar: {
      '/guide/': [
        {
          text: '入门级',
          items: [
            { text: '符号计算基础', link: '/guide/01-symbolic-basics/' }
          ]
        },
        {
          text: '基础级',
          items: [
            { text: '微积分基础', link: '/guide/02-calculus/' }
          ]
        },
        {
          text: '进阶级',
          items: [
            { text: '线性代数', link: '/guide/03-linear-algebra/' },
            { text: '微分方程', link: '/guide/04-differential-equations/' }
          ]
        },
        {
          text: '高级',
          items: [
            { text: '泛函分析应用', link: '/guide/05-functional-analysis/' },
            { text: '流体力学应用', link: '/guide/06-fluid-mechanics/' }
          ]
        }
      ]
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/hyfaust/Maxima-and-Octave-CAS-tutorial' }
    ],
    footer: {
      message: '基于GPL v3协议发布',
      copyright: 'Copyright © 2026 CAS Learn'
    },
    search: {
      provider: 'local'
    },
    outline: {
      level: [2, 3],
      label: '页面导航'
    },
    lastUpdated: {
      text: '最后更新于'
    },
    docFooter: {
      prev: '上一页',
      next: '下一页'
    }
  },
  markdown: {
    lineNumbers: true,
    config: (md) => {
      md.use(katexPlugin)
      // Alias octave -> matlab, maxima -> scheme for syntax highlighting
      const defaultFence = md.renderer.rules.fence.bind(md.renderer.rules)
      md.renderer.rules.fence = (tokens, idx, options, env, self) => {
        const token = tokens[idx]
        if (token.info === 'octave') token.info = 'matlab'
        if (token.info === 'maxima') token.info = 'scheme'
        return defaultFence(tokens, idx, options, env, self)
      }
    }
  },
  vite: {},
  head: [
    ['link', { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/katex@0.16.0/dist/katex.min.css' }]
  ],
  theme: {
    custom: true
  }
})
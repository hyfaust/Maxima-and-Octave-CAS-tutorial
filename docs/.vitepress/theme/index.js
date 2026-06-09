import DefaultTheme from 'vitepress/theme'
import Layout from './Layout.vue'
import CodeComparison from './components/CodeComparison.vue'
import ConceptTooltip from './components/ConceptTooltip.vue'
import DifficultyIndicator from './components/DifficultyIndicator.vue'
import ProgressTracker from './components/ProgressTracker.vue'
import './custom.css'

export default {
  extends: DefaultTheme,
  Layout,
  enhanceApp({ app }) {
    // Register global components
    app.component('CodeComparison', CodeComparison)
    app.component('ConceptTooltip', ConceptTooltip)
    app.component('DifficultyIndicator', DifficultyIndicator)
    app.component('ProgressTracker', ProgressTracker)
  }
}
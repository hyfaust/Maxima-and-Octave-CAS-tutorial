<template>
  <span class="concept-tooltip" @mouseenter="showTooltip" @mouseleave="hideTooltip">
    <span class="concept-text">{{ term }}</span>
    <span class="tooltip-content" v-if="isVisible" :style="tooltipStyle">
      <span class="tooltip-arrow"></span>
      <span class="tooltip-title">{{ term }}</span>
      <span class="tooltip-description">{{ description }}</span>
      <span class="tooltip-formula" v-if="formula">
        <span class="formula-label">公式：</span>
        <span class="formula-content" v-html="formula"></span>
      </span>
      <span class="tooltip-example" v-if="example">
        <span class="example-label">示例：</span>
        <span class="example-content">{{ example }}</span>
      </span>
    </span>
  </span>
</template>

<script setup>
import { ref, computed } from 'vue'

const props = defineProps({
  term: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  formula: {
    type: String,
    default: ''
  },
  example: {
    type: String,
    default: ''
  }
})

const isVisible = ref(false)
const tooltipPosition = ref({ x: 0, y: 0 })

const tooltipStyle = computed(() => ({
  left: `${tooltipPosition.value.x}px`,
  top: `${tooltipPosition.value.y}px`
}))

const showTooltip = (event) => {
  const rect = event.target.getBoundingClientRect()
  tooltipPosition.value = {
    x: rect.left + rect.width / 2,
    y: rect.top - 10
  }
  isVisible.value = true
}

const hideTooltip = () => {
  isVisible.value = false
}
</script>

<style scoped>
.concept-tooltip {
  position: relative;
  display: inline-block;
  border-bottom: 1px dotted var(--vp-c-brand);
  cursor: help;
  color: var(--vp-c-brand);
}

.tooltip-content {
  position: fixed;
  z-index: 1000;
  width: 320px;
  padding: 1rem;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  transform: translateX(-50%) translateY(-100%);
  pointer-events: none;
  opacity: 0;
  transition: opacity 0.2s, transform 0.2s;
}

.concept-tooltip:hover .tooltip-content {
  opacity: 1;
  transform: translateX(-50%) translateY(-100%) translateY(-8px);
}

.tooltip-arrow {
  position: absolute;
  bottom: -6px;
  left: 50%;
  transform: translateX(-50%) rotate(45deg);
  width: 12px;
  height: 12px;
  background: var(--vp-c-bg-soft);
  border-right: 1px solid var(--vp-c-divider);
  border-bottom: 1px solid var(--vp-c-divider);
}

.tooltip-title {
  display: block;
  font-weight: 700;
  font-size: 1.1em;
  margin-bottom: 0.5rem;
  color: var(--vp-c-brand);
}

.tooltip-description {
  display: block;
  font-size: 0.95em;
  line-height: 1.5;
  color: var(--vp-c-text-1);
  margin-bottom: 0.75rem;
}

.tooltip-formula,
.tooltip-example {
  display: block;
  font-size: 0.9em;
  margin-top: 0.5rem;
  padding-top: 0.5rem;
  border-top: 1px solid var(--vp-c-divider);
}

.formula-label,
.example-label {
  font-weight: 600;
  color: var(--vp-c-text-2);
  display: block;
  margin-bottom: 0.25rem;
}

.formula-content {
  font-family: var(--vp-font-family-mono);
  background: var(--vp-c-bg-alt);
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
  display: block;
}

.example-content {
  font-style: italic;
  color: var(--vp-c-text-2);
}
</style>
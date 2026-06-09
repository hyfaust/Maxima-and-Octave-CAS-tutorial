<template>
  <div class="difficulty-indicator">
    <span class="difficulty-label">难度：</span>
    <span class="difficulty-stars">
      <span v-for="star in 5" :key="star" class="star" :class="{ filled: star <= level, empty: star > level }">
        {{ star <= level ? '★' : '☆' }}
      </span>
    </span>
    <span class="difficulty-text">{{ difficultyText }}</span>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  level: {
    type: Number,
    required: true,
    validator: (value) => value >= 1 && value <= 5
  }
})

const difficultyText = computed(() => {
  const texts = {
    1: '入门',
    2: '基础',
    3: '进阶',
    4: '高级',
    5: '专家'
  }
  return texts[props.level] || '未知'
})
</script>

<style scoped>
.difficulty-indicator {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 6px;
  margin: 1rem 0;
  font-size: 0.95em;
}

.difficulty-label {
  font-weight: 600;
  color: var(--vp-c-text-2);
}

.difficulty-stars {
  display: inline-flex;
  gap: 0.1rem;
}

.star {
  font-size: 1.2em;
  color: var(--vp-c-divider);
  transition: color 0.2s;
}

.star.filled {
  color: #ffd700;
}

.star.empty {
  color: var(--vp-c-divider);
}

.difficulty-text {
  font-weight: 600;
  color: var(--vp-c-brand);
  margin-left: 0.25rem;
}
</style>
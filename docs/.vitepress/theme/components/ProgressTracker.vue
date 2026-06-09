<template>
  <div class="progress-tracker" v-if="isVisible">
    <div class="progress-header">
      <h4>学习进度</h4>
      <button class="close-button" @click="hide">×</button>
    </div>
    <div class="progress-stats">
      <div class="stat-item">
        <span class="stat-label">已完成</span>
        <span class="stat-value">{{ completedCount }}/{{ totalCount }}</span>
      </div>
      <div class="stat-item">
        <span class="stat-label">完成率</span>
        <span class="stat-value">{{ completionRate }}%</span>
      </div>
    </div>
    <div class="progress-bar">
      <div class="progress-fill" :style="{ width: completionRate + '%' }"></div>
    </div>
    <div class="progress-chapters">
      <div v-for="chapter in chapters" :key="chapter.id" class="chapter-progress">
        <div class="chapter-header">
          <span class="chapter-name">{{ chapter.name }}</span>
          <span class="chapter-status" :class="{ completed: chapter.completed }">
            {{ chapter.completed ? '✓' : '○' }}
          </span>
        </div>
        <div class="chapter-topics">
          <div v-for="topic in chapter.topics" :key="topic.id" class="topic-item">
            <span class="topic-status" :class="{ completed: topic.completed }">
              {{ topic.completed ? '●' : '○' }}
            </span>
            <span class="topic-name">{{ topic.name }}</span>
          </div>
        </div>
      </div>
    </div>
    <div class="progress-actions">
      <button class="action-button" @click="resetProgress">重置进度</button>
      <button class="action-button primary" @click="exportProgress">导出进度</button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'

const isVisible = ref(true)

const chapters = ref([
  {
    id: 1,
    name: '符号计算基础',
    completed: false,
    topics: [
      { id: '1.1', name: '变量与表达式定义', completed: false },
      { id: '1.2', name: '基本代数运算', completed: false },
      { id: '1.3', name: '方程求解', completed: false },
      { id: '1.4', name: '函数定义与绘图', completed: false }
    ]
  },
  {
    id: 2,
    name: '微积分基础',
    completed: false,
    topics: [
      { id: '2.1', name: '极限计算', completed: false },
      { id: '2.2', name: '导数与微分', completed: false },
      { id: '2.3', name: '积分计算', completed: false },
      { id: '2.4', name: '级数展开', completed: false }
    ]
  },
  {
    id: 3,
    name: '线性代数',
    completed: false,
    topics: [
      { id: '3.1', name: '矩阵定义与基本运算', completed: false },
      { id: '3.2', name: '线性方程组求解', completed: false },
      { id: '3.3', name: '特征值与特征向量', completed: false },
      { id: '3.4', name: '矩阵分解', completed: false }
    ]
  },
  {
    id: 4,
    name: '微分方程',
    completed: false,
    topics: [
      { id: '4.1', name: '常微分方程求解', completed: false },
      { id: '4.2', name: '偏微分方程基础', completed: false },
      { id: '4.3', name: '数值解法与符号解法对比', completed: false },
      { id: '4.4', name: '边值问题', completed: false }
    ]
  },
  {
    id: 5,
    name: '泛函分析应用',
    completed: false,
    topics: [
      { id: '5.1', name: '变分法基础', completed: false },
      { id: '5.2', name: '欧拉-拉格朗日方程', completed: false },
      { id: '5.3', name: '泛函极值问题', completed: false },
      { id: '5.4', name: '在力学中的应用', completed: false }
    ]
  },
  {
    id: 6,
    name: '流体力学应用',
    completed: false,
    topics: [
      { id: '6.1', name: '流体力学基本方程', completed: false },
      { id: '6.2', name: '流函数与势函数', completed: false },
      { id: '6.3', name: '简单流动问题的符号解', completed: false },
      { id: '6.4', name: '量纲分析与相似性', completed: false },
      { id: '6.5', name: '瑞利空化泡问题', completed: false }
    ]
  }
])

const totalCount = computed(() => {
  return chapters.value.reduce((total, chapter) => total + chapter.topics.length, 0)
})

const completedCount = computed(() => {
  return chapters.value.reduce((total, chapter) => {
    return total + chapter.topics.filter(topic => topic.completed).length
  }, 0)
})

const completionRate = computed(() => {
  return Math.round((completedCount.value / totalCount.value) * 100)
})

const hide = () => {
  isVisible.value = false
}

const resetProgress = () => {
  chapters.value.forEach(chapter => {
    chapter.completed = false
    chapter.topics.forEach(topic => {
      topic.completed = false
    })
  })
  saveProgress()
}

const exportProgress = () => {
  const data = {
    exportDate: new Date().toISOString(),
    completionRate: completionRate.value,
    chapters: chapters.value
  }
  
  const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = 'cas-learn-progress.json'
  document.body.appendChild(a)
  a.click()
  document.body.removeChild(a)
  URL.revokeObjectURL(url)
}

const saveProgress = () => {
  localStorage.setItem('cas-learn-progress', JSON.stringify(chapters.value))
}

const loadProgress = () => {
  const saved = localStorage.getItem('cas-learn-progress')
  if (saved) {
    try {
      const parsed = JSON.parse(saved)
      chapters.value = parsed
    } catch (e) {
      console.error('Failed to load progress:', e)
    }
  }
}

// Watch for changes and save
watch(chapters, saveProgress, { deep: true })

// Load progress on mount
onMounted(loadProgress)
</script>

<style scoped>
.progress-tracker {
  position: fixed;
  bottom: 2rem;
  right: 2rem;
  width: 320px;
  background: var(--vp-c-bg-soft);
  border: 1px solid var(--vp-c-divider);
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  z-index: 1000;
  overflow: hidden;
}

.progress-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  border-bottom: 1px solid var(--vp-c-divider);
  background: var(--vp-c-bg-alt);
}

.progress-header h4 {
  margin: 0;
  font-size: 1rem;
  font-weight: 600;
}

.close-button {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: var(--vp-c-text-2);
  padding: 0;
  line-height: 1;
}

.close-button:hover {
  color: var(--vp-c-text-1);
}

.progress-stats {
  display: flex;
  justify-content: space-around;
  padding: 1rem;
  border-bottom: 1px solid var(--vp-c-divider);
}

.stat-item {
  text-align: center;
}

.stat-label {
  display: block;
  font-size: 0.85em;
  color: var(--vp-c-text-2);
  margin-bottom: 0.25rem;
}

.stat-value {
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--vp-c-brand);
}

.progress-bar {
  height: 8px;
  background: var(--vp-c-divider);
  margin: 0 1rem;
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--vp-c-brand), var(--vp-c-brand-light));
  transition: width 0.3s ease;
}

.progress-chapters {
  max-height: 300px;
  overflow-y: auto;
  padding: 1rem;
}

.chapter-progress {
  margin-bottom: 1rem;
}

.chapter-progress:last-child {
  margin-bottom: 0;
}

.chapter-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5rem;
}

.chapter-name {
  font-weight: 600;
  font-size: 0.95em;
}

.chapter-status {
  font-size: 1.2em;
  color: var(--vp-c-divider);
}

.chapter-status.completed {
  color: #10b981;
}

.chapter-topics {
  padding-left: 1rem;
}

.topic-item {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.25rem 0;
  font-size: 0.9em;
}

.topic-status {
  font-size: 0.8em;
  color: var(--vp-c-divider);
}

.topic-status.completed {
  color: #10b981;
}

.topic-name {
  color: var(--vp-c-text-1);
}

.progress-actions {
  display: flex;
  gap: 0.5rem;
  padding: 1rem;
  border-top: 1px solid var(--vp-c-divider);
  background: var(--vp-c-bg-alt);
}

.action-button {
  flex: 1;
  padding: 0.5rem 1rem;
  border: 1px solid var(--vp-c-divider);
  border-radius: 6px;
  background: var(--vp-c-bg);
  color: var(--vp-c-text-1);
  cursor: pointer;
  font-size: 0.9em;
  transition: all 0.2s;
}

.action-button:hover {
  background: var(--vp-c-bg-soft);
  border-color: var(--vp-c-brand);
}

.action-button.primary {
  background: var(--vp-c-brand);
  color: white;
  border-color: var(--vp-c-brand);
}

.action-button.primary:hover {
  background: var(--vp-c-brand-dark);
}

@media (max-width: 768px) {
  .progress-tracker {
    bottom: 1rem;
    right: 1rem;
    width: calc(100% - 2rem);
    max-width: 320px;
  }
}
</style>
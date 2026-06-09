<template>
  <div class="code-comparison">
    <div class="code-block">
      <div class="code-block-header">
        <span class="language-icon">🐙</span>
        <span class="language-name">Octave</span>
        <button class="copy-button" @click="copyCode('octave')" :class="{ copied: octaveCopied }">
          {{ octaveCopied ? '已复制' : '复制' }}
        </button>
      </div>
      <div class="code-block-content">
        <pre><code class="language-matlab">{{ octaveCode }}</code></pre>
      </div>
    </div>
    <div class="code-block">
      <div class="code-block-header">
        <span class="language-icon">🔮</span>
        <span class="language-name">Maxima</span>
        <button class="copy-button" @click="copyCode('maxima')" :class="{ copied: maximaCopied }">
          {{ maximaCopied ? '已复制' : '复制' }}
        </button>
      </div>
      <div class="code-block-content">
        <pre><code class="language-maxima">{{ maximaCode }}</code></pre>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const props = defineProps({
  octaveCode: {
    type: String,
    required: true
  },
  maximaCode: {
    type: String,
    required: true
  }
})

const octaveCopied = ref(false)
const maximaCopied = ref(false)

const copyCode = async (language) => {
  const code = language === 'octave' ? props.octaveCode : props.maximaCode
  
  try {
    await navigator.clipboard.writeText(code)
    
    if (language === 'octave') {
      octaveCopied.value = true
      setTimeout(() => {
        octaveCopied.value = false
      }, 2000)
    } else {
      maximaCopied.value = true
      setTimeout(() => {
        maximaCopied.value = false
      }, 2000)
    }
  } catch (err) {
    console.error('Failed to copy code:', err)
  }
}
</script>

<style scoped>
.code-comparison {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  margin: 1.5rem 0;
  border: 1px solid var(--vp-c-divider);
  border-radius: 8px;
  overflow: hidden;
}

.code-block {
  border-right: 1px solid var(--vp-c-divider);
}

.code-block:last-child {
  border-right: none;
}

.code-block-header {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1rem;
  background: var(--vp-c-bg-soft);
  border-bottom: 1px solid var(--vp-c-divider);
  font-weight: 600;
}

.language-icon {
  font-size: 1.2em;
}

.language-name {
  flex: 1;
}

.copy-button {
  padding: 0.25rem 0.75rem;
  border: 1px solid var(--vp-c-divider);
  border-radius: 4px;
  background: var(--vp-c-bg);
  color: var(--vp-c-text-1);
  cursor: pointer;
  font-size: 0.85em;
  transition: all 0.2s;
}

.copy-button:hover {
  background: var(--vp-c-bg-soft);
  border-color: var(--vp-c-brand);
}

.copy-button.copied {
  background: var(--vp-c-brand);
  color: white;
  border-color: var(--vp-c-brand);
}

.code-block-content {
  padding: 1rem;
  background: var(--vp-c-bg-alt);
  overflow-x: auto;
}

.code-block-content pre {
  margin: 0;
  padding: 0;
}

.code-block-content code {
  font-family: var(--vp-font-family-mono);
  font-size: 0.9em;
  line-height: 1.6;
}

@media (max-width: 768px) {
  .code-comparison {
    grid-template-columns: 1fr;
  }
  
  .code-block {
    border-right: none;
    border-bottom: 1px solid var(--vp-c-divider);
  }
  
  .code-block:last-child {
    border-bottom: none;
  }
}
</style>
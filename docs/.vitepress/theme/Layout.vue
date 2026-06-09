<template>
  <div class="custom-layout">
    <DefaultTheme.Layout />
    <ProgressTracker />
  </div>
</template>

<script setup>
import DefaultTheme from 'vitepress/theme'
import ProgressTracker from './components/ProgressTracker.vue'
</script>

<style scoped>
.custom-layout {
  position: relative;
}
</style>
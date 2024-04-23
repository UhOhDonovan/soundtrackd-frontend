<script setup lang="ts">
import { ref } from 'vue'

defineProps<{ msg: string }>()

const testAPI = async () => {
  const response = await fetch("http://localhost:5345/", {
    method: "GET"
  })
  console.log(await response.json())
}

const count = ref(0)
</script>

<template>
  <div class="card">
    <h1>{{ msg }}</h1>
    <button type="button" @click="testAPI">Test API</button>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>

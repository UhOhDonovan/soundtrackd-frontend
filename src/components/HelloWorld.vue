<script setup lang="ts">
import { ref } from 'vue'

defineProps<{ msg: string }>()

const testAPI = async () => {
  const response = await fetch("http://localhost:5345/", {
    method: "GET"
  })
  console.log(await response.json())
}

</script>

<template>
  <div class="card">
    <h1 class="row">{{ msg }}</h1>
    <div class="row justify-content-center">
      <RouterLink to="/login" class="col-2 button">
        Login
      </RouterLink>
      <br>
      <RouterLink to="/register" class="col-2 button">
        Register
      </RouterLink>
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>

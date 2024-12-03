<script setup lang="ts">
// import { ref } from 'vue'
let test = localStorage.getItem("token")

defineProps<{ msg: string }>()

const testAPI = async () => {
  const response = await fetch("/api", {
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
      <button @click="testAPI()" class="col-2 button">
        tester
      </button>
    </div>
    <p hidden="true">{{test }}</p>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>

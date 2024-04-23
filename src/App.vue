<script setup lang="ts">
</script>

<template>
  <div class="row align-items-center">
    <RouterLink to="/" class="col-auto">
      <img src="/databases-logo.png" class="logo" alt="Soundtracked logo" />
    </RouterLink>
    <h1 class="col-auto">Soundtracked</h1>
  </div>
  <main>
    <RouterView />
  </main>
  <br>
    <h5>Current route path: {{ $route.fullPath }}</h5>
    <nav>
      <RouterLink to="/">Go To Home</RouterLink>
      <div></div>
      <RouterLink to="/about"> Go To About</RouterLink>
    </nav>
</template>

<style scoped>
.logo {
  height: 6em;
  padding-top: 1em;
  padding-bottom: 1.5em;
  padding-right: 0em;
  will-change: filter;
  transition: filter 300ms;
}

.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}

.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>

<script setup lang="ts">
</script>

<template>
  <div class="row" style="justify-content: left;">
    <RouterLink to="/">
      <img src="/soundtrackd-logo.png" class="logo" alt="Soundtrackd logo" style="margin-right: 5px;" />
    </RouterLink>
    <h1>Soundtrackd</h1>
  </div>
  <main>
    <RouterView />
  </main>
  <br>
  <h5>Current route path: {{ $route.fullPath }}</h5>
  <nav>
    <RouterLink to="/">Go To Home</RouterLink>
    <div></div>
    <RouterLink to="/search"> Go To Search</RouterLink>
    <div></div>
    <RouterLink to="/register">Go To Register</RouterLink>
    <div></div>
    <RouterLink to="/login">Go To Login</RouterLink>
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
  filter: drop-shadow(0 0 2em #00D3C0);
}
</style>

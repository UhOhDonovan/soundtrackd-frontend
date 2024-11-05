<script setup lang="ts">
import NavBar from "./components/NavBar.vue";
</script>

<template>
  <NavBar />
  
  
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

.nav-link {
  float: center;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.nav-link a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

</style>

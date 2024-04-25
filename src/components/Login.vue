<script setup lang="ts">
function login(){
  console.log("login was clicked");
}
</script>

<template>
  <div>
    <h2>Welcome back!</h2>
    <label for="email">Email:</label>
    <input type="email" name="email" class="field">
    <br>
    <label for="password">Password:</label>
    <input type="password" name="password" class="field">
    <br>
    <button @click="login" class="button">Login</button>
    <p>Don't have an account? <RouterLink to="/register">Create one!</RouterLink></p>
  </div>
</template>

<style scoped>
  .button{
    background-color: #00D3C0;
  }
  .button:hover{
    color:white;
  }
</style>

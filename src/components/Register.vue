<script setup lang="ts">
function register(){
  console.log("register was clicked");
}
</script>

<template>
  <div>
    <h2>Create your account!</h2>
    <label for="email">Email: </label>
    <input type="email" name="email">
    <br>
    <label for="username">Username: </label>
    <input type="username" name="username">
    <br>
    <label for="password">Password: </label>
    <input type="password" name="password">
    <br>
    <button @click="register" class="button">Register</button>
    <p>Already have an account? <RouterLink to="/Login">Log in!</RouterLink></p>
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

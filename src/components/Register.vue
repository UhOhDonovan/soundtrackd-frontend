<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter()

let email = ""
let username = ""
let  password = ""
let error = ""

function register(){
  if(password.length < 3){
    console.log("password too short");
  }
  else{
    sendInfo(email, username, password)
    //router.push({ path: '/login'})
  }
}

const sendInfo = async (email: string, username: string, password: string) => {
  // IK this is sketchy but it's the only way I could get it to work
  const response = await fetch(`http://localhost:5345/register/?email=${email}&username=${username}&password=${password}`, {
    method: "POST",
    mode: 'no-cors',
  })
  console.log(response)
  if (!response.ok){
    error = response.statusText
    console.log(`Error: ${error}`)
  }
  else{
    router.push({ path: '/login'})
  }

  console.log(response.ok)
}

</script>

<template>
  <div>
    <h2>Create your account!</h2>
    <p class="error-text">{{ error }}</p>
    <form @submit.prevent="register">
      <div class="form-group">
        <label for="email">Email: </label>
        <input type="email" name="email" v-model="email">
      </div>
      <div class="form-group">
        <label for="username">Username: </label>
        <input type="username" name="username" v-model="username">
      </div>
      <div class="form-group">
        <label for="password">Password: </label>
        <input type="password" name="password" v-model="password">
      </div>
      <br>
      <button type="submit" class="button">Register</button>
    </form>
  
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
  .error-text{
    color: red;
  }

</style>

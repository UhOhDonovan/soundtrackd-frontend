<script setup lang="ts">
import { useRouter } from 'vue-router';
import { ref } from 'vue';

// import Cookies from "js-cookie";
const router = useRouter()

let userfield: string = "";
let password: string = "";
let error = ref("");

function login() {
  console.log("login was clicked");
  if(userfield.length == 0) {
    console.log("Please enter a username")
    error.value = "Please enter a username"
  }
  else if(password.length == 0) {
    console.log("Please enter a password")
    error.value = "Please enter a password"
  }
  else{
    sendInfo(userfield, password);
  }
}

const sendInfo = async (userfield: string, password: string) => {
  // IK this is sketchy but it's the only way I could get it to work
  const request = {
    user_field: userfield,
    password: password,
  }

  const response = await fetch(`http://localhost:5345/token`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(request)
  })

  console.log(response)
  if (!response.ok) {
    error.value = response.statusText
    console.log(`Error: ${error.value}`)
  }
  else {
    router.push({ path: '/' })
  }

  console.log(response.ok)
}
</script>

<template>
  <div>
    <h2>Welcome back!</h2>
    <label for="email">Email or Username: </label>
    <input type="email" name="email" class="field" v-model="userfield">
    <br>
    <label for="password">Password: </label>
    <input type="password" name="password" class="field" v-model="password">
    <br>
    <div v-if="error" id="error-message" style="color: red; margin-top: 10px;">
      {{ error }}
    </div>    
    <button @click="login" class="button">Login</button>
    <p>Don't have an account? <RouterLink to="/register">Create one!</RouterLink>
    </p>
  </div>
</template>
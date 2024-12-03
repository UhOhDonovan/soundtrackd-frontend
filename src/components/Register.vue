<script setup lang="ts">
import { useRouter } from 'vue-router';
import { ref } from 'vue';

const router = useRouter()

let email = ""
let username = ""
let password = ""
let confirmPassword = ""
let error = ref("")

function register() {
  // check for any obvious errors in the user's submission
  if(email.length == 0) {
    console.log("Please enter an email")
    error.value = "Please enter an email"
  }
  else if(username.length == 0) {
    console.log("Please enter a username")
    error.value = "Please enter a username"
  }
  else if(password.length == 0) {
    console.log("Please enter a password")
    error.value = "Please enter a password"
  }
  else if(confirmPassword.length == 0) {
    console.log("Please confirm your password")
    error.value = "Please confirm password"
  }
  else if (password.length < 10) {
    console.log("password too short")
    error.value = "Your password is too short (must be at least 10 characters)"
  }
  else if (password != confirmPassword) {
    console.log("passwords do not match")
    error.value = "Your password does not match its confirmation"
  }
  // we are good to go!
  else {
    //router.push({ path: '/login' })
    sendInfo(email, username, password)
  }
}

const sendInfo = async (email: string, username: string, password: string) => {
  const response = await fetch(`http://localhost:5345/register`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
    "email": email,
    "username": username,
    "password": password,
    }),
  });

  console.log(response)
  if (!response.ok) {
    error.value = response.statusText
    console.log(`Error: ${error.value}`)
  }
  else {
    router.push({ path: '/login' })
  }

  console.log(response.ok)
}

</script>

<template>
  <div>
    <h2>Create your account!</h2>
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
      <div class="form-group">
        <label for="confirmPassword">Confirm Password: </label>
        <input type="password" name="confirmPassword" v-model="confirmPassword">
      </div>
      <div v-if="error" id="error-message" style="color: red; margin-top: 10px;">
        {{ error }}
      </div>    
      <br>
      <button type="submit" class="button">Register</button>
    </form>

    <p>Already have an account? <RouterLink to="/Login">Log in!</RouterLink>
    </p>
  </div>
</template>

<style scoped>
.button {
  background-color: #00D3C0;
}

.button:hover {
  color: white;
}

.error-text {
  color: red;
}
</style>

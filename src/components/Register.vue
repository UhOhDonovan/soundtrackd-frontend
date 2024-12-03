<script setup lang="ts">
import { useRouter } from "vue-router";
const router = useRouter();

let email = "";
let username = "";
let password = "";
let password_confirmation = "";
let error = "";

function register() {
  if (password.length < 3) {
    console.log("password too short");
  } else {
    sendInfo(email, username, password, password_confirmation);
    //router.push({ path: '/login'})
  }
}

const sendInfo = async (
  email: string,
  username: string,
  password: string,
  password_confirmation: string
) => {
  // IK this is sketchy but it's the only way I could get it to work
  const request = {
    email: email,
    username: username,
    password: password,
    password_confirmation: password_confirmation,
  };

  const response = await fetch(`/api/users/register`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(request),
  });

  console.log(response);
  if (!response.ok) {
    error = response.statusText;
    console.log(`Error: ${error}`);
  } else {
    router.push({ path: "/login" });
  }

  console.log(response.ok);
};
</script>

<template>
  <div>
    <h2>Create your account!</h2>
    <p class="error-text">{{ error }}</p>
    <form @submit.prevent="register">
      <div class="form-group">
        <label for="email">Email: </label>
        <input type="email" name="email" v-model="email" />
      </div>
      <div class="form-group">
        <label for="username">Username: </label>
        <input type="username" name="username" v-model="username" />
      </div>
      <div class="form-group">
        <label for="password">Password: </label>
        <input type="password" name="password" v-model="password" />
      </div>
      <div class="form-group">
        <label for="password_confirmation">Confirm Password: </label>
        <input
          type="password"
          name="password_confirmation"
          v-model="password_confirmation"
        />
      </div>
      <br />
      <button type="submit" class="button">Register</button>
    </form>

    <p>Already have an account? <RouterLink to="/Login">Log in!</RouterLink></p>
  </div>
</template>

<style scoped>
.button {
  background-color: #00d3c0;
}

.button:hover {
  color: white;
}

.error-text {
  color: red;
}
</style>

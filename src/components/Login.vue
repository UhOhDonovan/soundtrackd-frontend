<script setup lang="ts">
import { useRouter } from "vue-router";
// import Cookies from "js-cookie";
const router = useRouter();

let username: string = "";
let password: string = "";
let error: string = "";

function login() {
  console.log("login was clicked");
  sendInfo(username, password);
}

const sendInfo = async (username: string, password: string) => {
  // IK this is sketchy but it's the only way I could get it to work
  const request = {
    username: username,
    password: password,
  };

  const response = await fetch(`http://localhost:5345/users/token`, {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: new URLSearchParams(request),
  });

  console.log(response);
  if (!response.ok) {
    error = response.statusText;
    console.log(`Error: ${error}`);
  } else {
    const token = await response.json();
    localStorage.setItem("token", token.access_token);
    router.push({ path: "/" });
  }

  console.log(response.ok);
};

const testToken = async () => {
  const response = await fetch("http://localhost:5345/users/me", {
    method: "GET",
    headers: {
      "accept": "application/json",
      "Authorization": `Bearer ${localStorage.getItem('token')}`
    }
  });
  if (response.ok) {
    console.log(await response.text())
  }
};
</script>

<template>
  <div>
    <h2>Welcome back!</h2>
    <label for="username">Username: </label>
    <input type="username" name="username" class="field" v-model="username" />
    <br />
    <label for="password">Password: </label>
    <input type="password" name="password" class="field" v-model="password" />
    <br />
    <button @click="login" class="button">Login</button>
    <button @click="testToken" class="button" hidden="true">Test</button>
    <p>
      Don't have an account? <RouterLink to="/register">Create one!</RouterLink>
    </p>
  </div>
</template>

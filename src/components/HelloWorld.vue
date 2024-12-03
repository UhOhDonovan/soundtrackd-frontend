<script lang="ts">
// import { ref } from 'vue'
export default {
  props: {
    msg: String,
  },
  data() {
    return{
      test: localStorage.getItem("token"),
      username: localStorage.getItem("username"),
    }
  },
  methods: {
    testAPI: async () => {
      const response = await fetch("http://localhost:5345/", {
        method: "GET"
      })
      console.log(await response.json())
    }
  },
  mounted(){
    window.addEventListener('user-changed', (event) => {
      console.log("hworld event recieved")
      this.username = (<any>event).detail.storage;
    });
  }
}
</script>

<template>
  <div class="card">
    <h1 class="row">{{ msg }}</h1>
    <div class="row justify-content-center" v-if="username == ''">
      <RouterLink to="/login" class="col-2 button">
        Login
      </RouterLink>
      <br>
      <RouterLink to="/register" class="col-2 button">
        Register
      </RouterLink>
      <button hidden="true" @click="testAPI()" class="col-2 button">
        tester
      </button>
    </div>
    <div v-else>
      <h2 style="font-weight:400"><RouterLink to="/search">Search for an album</RouterLink> to get started reading and writing reviews!</h2>
    </div>
    <p hidden="true">{{test }}</p>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>

<script lang="ts">
export default {
  data(){
    return{
      username: localStorage.getItem('username'),
    }
  },
  mounted(){
    window.addEventListener('user-changed', (event) => {
      console.log("event recieved")
      this.username = (<any>event).detail.storage;
    });
  },
  methods: {
    sign_out(){
      localStorage.setItem('username', "")
      localStorage.setItem('token', "")
      window.dispatchEvent(new CustomEvent('user-changed', {
        detail: {
          storage: localStorage.getItem('username')
        }
      }));
    }
  }
}
</script>

<template>
  <div class="row" style="justify-content: left;">
    <RouterLink to="/">
      <img src="/soundtrackd-logo.png" class="logo" alt="Soundtrackd logo" style="margin-right: 5px;" />
    </RouterLink>
    <RouterLink to="/"><h1 class="logo-text">Soundtrackd</h1></RouterLink>
  </div>
  <nav>
    <li>
    </li>
    <li class="nav-link"><RouterLink to="/">Home</RouterLink></li>
    <li class="nav-link"><RouterLink to="/search">Search</RouterLink></li>
    <li v-if="!username" class="nav-link"><RouterLink to="/login">Log In</RouterLink></li>
    <li v-if="!username" class="nav-link"><RouterLink to="/register">Sign Up</RouterLink></li>
    <li v-if="username" class="nav-link"><RouterLink :to="`/profile/${username}`">My Profile ({{ username }})</RouterLink></li>
    <li v-if="username" class="nav-link" id="sign-out"><a href="#" @click.prevent="sign_out()">Sign Out</a></li>

  </nav>
  
  <main>
    <RouterView :key="$route.fullPath"/>
  </main>
  <br>
  <h5 hidden="true">Current route path: {{ $route.fullPath }}</h5>
  <nav>
    <RouterLink to="/">Go To Home</RouterLink>
    <div></div>
    <RouterLink to="/search"> Go To Search</RouterLink>
    <div></div>
    <RouterLink v-if="!username" to="/register">Go To Register</RouterLink>
    <div v-if="!username"></div>
    <RouterLink v-if="!username" to="/login">Go To Login</RouterLink>
    <div v-if="username" ></div>
    <RouterLink v-if="username" :to="`/profile/${username}`">Go To My Profile ({{ username }})</RouterLink>
    <div v-if="username" ></div>
    <a v-if="username" href="#" @click.prevent="sign_out()">Sign Out</a>
  </nav>
</template>

<style scoped>
.logo {
  height: 3em;
  padding-top: 1em;
  padding-bottom: 1.5em;
  padding-right: 0em;
  will-change: filter;
  transition: filter 300ms;
}

.logo:hover {
  filter: drop-shadow(0 0 2em #00D3C0);
}
.logo-text{
  font-size: 2em;
  color: #213547;
}
nav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #00D3C0;
}
li {
  float: left;
  display: block;
}
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
#sign-out {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

</style>

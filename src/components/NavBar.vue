<script setup lang="ts">

</script>

<template>
  <div class="grid-container" style="display:flex; flex-direction: row">
    <div class="item1">
      <RouterLink to="/">
        <img src="/soundtrackd-logo.png" class="logo" alt="Soundtrackd logo" style="margin-right: 5px;" />
      </RouterLink>
    </div>
    <div class="item2">
      <RouterLink to="/"><h1 class="logo-text">Soundtrackd</h1></RouterLink>
    </div>
    <div class="item3">
      <nav>
        <li class="nav-link"><RouterLink to="/">Home</RouterLink></li>
        <li class="nav-link"><RouterLink to="/search">Search</RouterLink></li>
        <li class="nav-link"><RouterLink to="/login">Log In</RouterLink></li>
        <li class="nav-link"><RouterLink to="/register">Sign Up</RouterLink></li>
      </nav>
    </div>
    <div class="item4">
      <nav>
        <li class="nav-link"><RouterLink to="/">Home</RouterLink></li>
        <li class="nav-link"><RouterLink to="/search">Search</RouterLink></li>
        <li class="nav-link"><RouterLink to="/login">Log In</RouterLink></li>
        <li class="nav-link"><RouterLink to="/register">Sign Up</RouterLink></li>
      </nav>
    </div>
  </div>
</template>

<style scoped>
/* .grid-container{
  display: grid;
  grid-template-columns: 10% 20% 70%;
  height: 10%;
} */
.grid-container {
  display: grid;
  grid-template-columns: 30px 200px auto;
  grid-gap: 10px;
  background-color: #2196F3;
  padding: 10px;
}

.grid-container > div {
  background-color: rgba(255, 255, 255, 0.8);
  text-align: center;
  padding: 20px 0;
  font-size: 30px;
}

.logo {
  height: 50px;
  padding-top: 10px;
  padding-bottom: 10px;
  padding-right: 10px;
  will-change: filter;
  transition: filter 300ms;
}
/*
.logo:hover {
  filter: drop-shadow(0 0 2em #00D3C0);
}
*/
.logo-text{
  font-size: 30px;
  color: #213547;
  padding-right: 10px;
}
nav {
  height: 65px;
  /* width: 500px; */
  background-color: #00D3C0;
}

li {
  float: left;
  margin: 20px;
  display: block;
}
</style>

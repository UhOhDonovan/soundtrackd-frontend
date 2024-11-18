import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";

import { createMemoryHistory, createRouter } from "vue-router";
import HelloWorld from "./components/HelloWorld.vue";
import Search from "./components/Search.vue";
import Register from "./components/Register.vue";
import Login from "./components/Login.vue";
import Album from "./components/Album.vue";

const routes = [
  { path: "/", name: 'HelloWorld', component: HelloWorld, props: {
    msg: 'Welcome to Soundtrackd!'
  } },
  { path: "/search", name: 'Search', component: Search },
  { path: "/register", name: 'Register', component: Register},
  { path: "/login", name: 'Login', component: Login},
  { path: "/album/:id", name: 'Album', component: Album, props: true},

];

const router = createRouter({
  history: createMemoryHistory(),
  routes,
});

createApp(App).use(router).mount("#app");


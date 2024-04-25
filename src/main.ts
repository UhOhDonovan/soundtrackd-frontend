import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";

import { createMemoryHistory, createRouter } from "vue-router";
import HelloWorld from "./components/HelloWorld.vue";
import About from "./components/About.vue";
import Register from "./components/Register.vue";
import Login from "./components/Login.vue";

const routes = [
  { path: "/", component: HelloWorld, props: {
    msg: 'Welcome to Soundtrackd!'
  } },
  { path: "/about", component: About },
  { path: "/register", component: Register},
  { path: "/login", component: Login},
];

const router = createRouter({
  history: createMemoryHistory(),
  routes,
});

createApp(App).use(router).mount("#app");

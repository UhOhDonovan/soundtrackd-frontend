import { createApp } from "vue";
import "./style.css";
import App from "./App.vue";

import { createMemoryHistory, createRouter } from "vue-router";
import HelloWorld from "./components/HelloWorld.vue";
import About from "./components/About.vue";

const routes = [
  { path: "/", component: HelloWorld, props: {
    msg: 'Welcome to Soundtracked!'
  } },
  { path: "/about", component: About },
];

const router = createRouter({
  history: createMemoryHistory(),
  routes,
});

createApp(App).use(router).mount("#app");

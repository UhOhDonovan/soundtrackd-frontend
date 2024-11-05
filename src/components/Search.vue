<script lang="ts">
// import { computed } from 'vue'
// import { useRoute, useRouter } from 'vue-router'
export default {
  data() {
    return {
      search_results: [{
        name: '',
        artists: [{name: ''}],
        images: [{url: ''}]
      }],
      url_root: "http://localhost:5345/search/album",
      q: ""
    }
  },
  methods: {
    search_spotify() {
      fetch(this.url_root + "?q=" + this.q)
      .then(res => res.json())
      .then(data => this.search_results = data['items'])
    }
  }
  
}


// const router = useRouter()
// const route = useRoute()
// const url_root = "http://localhost:5345/search/album";
// let q = "";
// let result = 1;

// const search_spotify = () => {
//     result = result + 1;
//     fetch(url_root + "?q=" + q)
//     .then(res => res.json())
//     .then(data => console.log(data))
//   }
</script>

<template>
    <h2>Search</h2>
    <input v-model.trim="q" maxlength="20">
    <button @click="search_spotify()" class="col-2 button">
      Search
    </button>
    <div v-for="result in search_results"> 
      <p>{{ result['name'] }}</p>
      <img :src="`${result['images'][0]['url']}`" style="width:100px"></img>
      <p v-for="artist in result['artists']">{{ artist['name'] }}</p>
    </div>
</template>
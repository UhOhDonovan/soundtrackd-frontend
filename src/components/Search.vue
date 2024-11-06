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
    <div v-if="search_results[0]['name']">
      <div class="row">
        <div class="column" v-for="result in search_results.slice(0, 5)">
          <div class="card" v-if="result">
            <p>{{ result['name'] }}</p>
            <img :src="`${result['images'][0]['url']}`" style="width:100px"></img>
            <p v-for="artist in result['artists']">{{ artist['name'] }}</p>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="column" v-for="result in search_results.slice(5, 10)">
          <div class="card" v-if="result">
            <p>{{ result['name'] }}</p>
            <img :src="`${result['images'][0]['url']}`" style="width:100px"></img>
            <p v-for="artist in result['artists']">{{ artist['name'] }}</p>
          </div>
        </div>
      </div>
    </div>
</template>

<style scoped>
* {
  box-sizing: border-box;
}

body {
  font-family: Arial, Helvetica, sans-serif;
}

/* Float four columns side by side */
.column {
  float: left;
  width: 25%;
  padding: 0 10px;
}

/* Remove extra left and right margins, due to padding in columns */
.row {margin: 10px -5px 20px;}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Style the counter cards */
.card {
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2); /* this adds the "card" effect */
  border-radius: 15px;
  padding: 16px;
  text-align: center;
  background-color: #f1f1f1;
  transition: background-color 0.3s ease;
}

.card:hover {
  background-color: #e0e0e0;
}



/* Responsive columns - one column layout (vertical) on small screens */
@media screen and (max-width: 600px) {
  .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}
</style>
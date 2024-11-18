<script lang="ts">
export default {
  data() {
    return {
      search_results: [{
        name: '',
        id: '',
        artists: [{name: ''}],
        images: [{url: ''}]
      }],
      url_root: "http://localhost:5345/search/album",
      q: "",
      is_searching: false
    }
  },
  methods: {
    search_spotify() {
      this.is_searching = true;
      fetch(this.url_root + "?q=" + this.q)
      .then(res => res.json())
      .then(data => {this.search_results = data['items'];
        this.is_searching = false
      })
    }
  }
  
}
</script>

<template>
    <h2>Search</h2>
    <input v-model.trim="q" maxlength="50" @keyup.enter="search_spotify()">
    <button @click="search_spotify()" class="col-2 button">
      Search
    </button>
    <p class="search-progress" v-if="is_searching">Searching for "{{ q }}"</p>
    <div v-if="search_results[0]['name'] && !is_searching">
      <div class="row" v-for="i in [0,4,8,12,16]">
        <div class="column" v-for="result in search_results.slice(i, i+4)">
          <div class="card" v-if="result" @click="$router.push({name: 'Album', params: {id: result.id}})">
            <img id="album-cover":src="`${result['images'][0]['url']}`"></img>
            <p id="album-title">{{ result['name'] }}</p>
            <!-- <img id="album-cover":src="`${result['images'][0]['url']}`" style="width:100px"></img> -->
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
  width: 100%;
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
.card img {
  width: 100%;
  height: auto;
}

.card:hover {
  background-color: #e0e0e0;
}

#album-title {
  font-weight: bold;
  font-size: 15pt;
}



/* Responsive columns - one column layout (vertical) on small screens */
@media screen and (max-width: 600px) {
  .column {
    width: 100%;
    display: block;
    margin-bottom: 20px;
  }
}

@keyframes flickerAnimation {
  0%   { opacity:1; }
  50%  { opacity:0.25; }
  100% { opacity:1; }
}
@-o-keyframes flickerAnimation{
  0%   { opacity:1; }
  50%  { opacity:0.25; }
  100% { opacity:1; }
}
@-moz-keyframes flickerAnimation{
  0%   { opacity:1; }
  50%  { opacity:0.25; }
  100% { opacity:1; }
}
@-webkit-keyframes flickerAnimation{
  0%   { opacity:1; }
  50%  { opacity:0.25; }
  100% { opacity:1; }
}

.search-progress {
  -webkit-animation: flickerAnimation 1.25s infinite;
  -moz-animation: flickerAnimation 1.25s infinite;
  -o-animation: flickerAnimation 1.25s infinite;
  animation: flickerAnimation 1.25s infinite;
}
</style>
<script lang="ts">
import { defineProps } from 'vue';

// import { computed } from 'vue'
// import { useRoute, useRouter } from 'vue-router'
defineProps({
  id: String
})

export default {
  data() {
    return {
      album_info: {
        name: '',
        artists: [{name: ''}],
        images: [{url: ''}],
        tracks: {
          items: [
            { name: '',
              track_number: 0,
              external_urls: {
                spotify: ''
              }
            }
          ]
        }
      },
      url_root: "http://localhost:5345/search/album/id?id=",
      q: "",
      is_loading: false,
      spotify_id: this.$route.params.id
    }
  },
  methods: {
    get() {
      this.is_loading = true;
      fetch(this.url_root + this.spotify_id)
      .then(res => res.json())
      .then(data => {this.album_info = data;
        this.is_loading = false
      })
    }
  }  
}
</script>

<template>
    <h2>Album</h2>
    <button @click="get()">get it</button>
    <p class="search-progress" v-if="is_loading">retrieving album {{ spotify_id }}</p>
    <p>id={{spotify_id}}</p>
    <div v-if="album_info.name">
      <p>name: {{ album_info.name }}</p>
      <img :src="`${album_info['images'][0]['url']}`">
      <div v-for="track in album_info['tracks']['items']">
        <p>{{ track.track_number }}. <a v-bind:href="`${track['external_urls']['spotify']}`">{{ track.name }}</a></p>
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
  width: 50px;
  height: auto;
}

.card:hover {
  background-color: #e0e0e0;
}

#album-title {
  font-weight: bold;
  font-size: 15pt;
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
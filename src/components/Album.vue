<script lang="ts">
import { defineProps } from 'vue';
import Review from "./Review.vue";

defineProps({
  id: String
})

export default {
  components: {Review},
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
    },
    artist_string(artists: {name: string}[]) {
      let result = "";
      for (let i = 0; i < artists.length - 1; i++){
        result += artists[i].name + ", "
      }
      if (result != ""){
        result += "and "
      }
      result += artists[artists.length - 1]["name"]
      return result
    }
  },
  mounted(){
    this.get()
  }
}
</script>

<template>
    <p class="search-progress" v-if="is_loading">Loading album info</p>
    <div class="container">
      <div class="album-column">
        <div v-if="album_info.name">
          <img :src="`${album_info['images'][0]['url']}`">
          <p id="album-title">{{ album_info.name }}</p>
          <p id="artists">{{ artist_string(album_info.artists) }}</p>
          <div v-for="track in album_info['tracks']['items']">
            <p>{{ track.track_number }}. <a v-bind:href="`${track['external_urls']['spotify']}`">{{ track.name }}</a></p>
          </div>
        </div>
      </div>
      <div class="review-column">
        <Review />
        <div class="card" v-for="i in [1,2,3,4,5]">Placeholder review {{ i }}</div>
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

.container {
    display: flex;
    overflow-x: auto;
    white-space: wrap;
}

.album-column {
    flex: 0 0 auto;
    width: 30%;
    height: 100vh;
    border: 1px solid #ccc;
    /* margin-right: 10px; */
    padding: 10px;
    box-sizing: border-box;
    overflow-y: auto;
    /* overflow-x: hidden; */
    /* white-space: wrap; */
}
.review-column {
    flex: 0 0 auto;
    width: 70%;
    height: 100vh;
    border: 1px solid #ccc;
    /* margin-right: 10px; */
    padding: 10px;
    box-sizing: border-box;
    overflow-y: auto;
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
  margin: 20px;
  text-align: center;
  background-color: #f1f1f1;
  transition: background-color 0.3s ease;
}
img {
  width: 75%;
  height: auto;
}

.card:hover {
  background-color: #e0e0e0;
}

#album-title {
  font-weight: bold;
  font-size: 15pt;
  word-break: break-word;
  word-wrap: break-word;
  overflow-wrap: break-word
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
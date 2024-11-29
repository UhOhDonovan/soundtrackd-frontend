<script lang="ts">
import Review from "./Review.vue";


export default {
  name: 'Album',
  components: {Review},
  props: {
    id: String,
  },
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
      spotify_id: this.$route.params.id,
      is_writing: false,
      temp_review: {
        id: 123124211,
        posted_by: "SpooderNoob",
        album_spotify_id: "1woCvthHJakakroP6dXNxs",
        post_date: "11/24/2024",
        post_time: "7:55 PM",
        rating: 9,
        body: "This is a  crazy review about the album on this page! It was so crazy and wild ot listen to it! What a crazy world we live in.",
      },
      show_album: false,
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
  <div class="container">
    <div class="album-column">
      <p class="search-progress" v-if="is_loading">Loading album info...</p>
        <div v-else-if="album_info.name">
          <img :src="`${album_info['images'][0]['url']}`">
          <p id="album-title">{{ album_info.name }}</p>
          <p id="artists">{{ artist_string(album_info.artists) }}</p>
          <div v-for="track in album_info['tracks']['items']">
            <p>{{ track.track_number }}. <a v-bind:href="`${track['external_urls']['spotify']}`" target="_bind">{{ track.name }}</a></p>
          </div>
        </div>
      </div>
      <div class="review-column">
        <div class="write-container" v-if="is_writing">
          <div class="review-col-header" style="justify-content: space-between;">
            <button class="button" @click="is_writing = false">Cancel</button>
            <h1>Write a Review</h1>
            <button class="button" @click="is_writing = false">Publish Review</button>
          </div>
          <div class="review-form">
            <strong class="review-title">[user]'s review of {{ album_info.name }}</strong>
            <div>
              <label for="rating">Rating (optional, 1-10): <input id="rating" type="number" min=1 max=10 style="font-size: 1em"></label>
            </div>
            <div>
              <label for="review-text">Review content:</label>
              <textarea id="review-text"></textarea>
            </div>
          </div>
        </div>
        <div class="read-container" v-else="!is_writing">
          <div class="review-col-header">
            <h1>Reviews</h1>
            <button class="button" @click="is_writing = true" style="margin: 40px; margin-top: 50px; margin-left: 20px;">Write Review</button>
          </div>
          <Review :review="temp_review" :show-album="true" v-for="i in [1,2,3,4,5,6,7,8,9]"/>
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

.container {
    display: flex;
    overflow-x: auto;
    white-space: wrap;
}
h1 {
  padding-left: 20px;
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

img {
  width: 75%;
  height: auto;
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

.review-col-header {
  display: flex;
  width: 100%;
  justify-content: left;
}

.button {
  height: 50px;
  margin-top: 50px;
}

textarea {
  resize: none;
  width: 100%;
  min-height: 50vh;
  font-family: inherit;
  padding: 10px;
  font-size: 1em;
}

.review-form {
  font-size: 1.25em;
  text-align: left;
}
</style>
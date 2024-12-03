<script lang="ts">
import Review from "./Review.vue";
type ReviewData = {
  id: Number,
  rating: Number,
  post_time: String,
  album_spotify_id: String,
  posted_by: String,
  post_date: String,
  body: String,
  album_info: {
            "title": String,
            "cover_url": String,
        }
}

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
        external_urls: {
          spotify: '',
        },
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
      url_root: "/api/",
      q: "",
      is_loading: false,
      reviews_loading: false,
      spotify_id: this.$route.params.id,
      reviews: new Array<ReviewData>,
      show_album: false,
      is_writing: false,
      written_rating: undefined,
      written_body: "",
    }
  },
  methods: {
    get_album() {
      this.is_loading = true;
      fetch(this.url_root + "search/album/id?id=" +this.spotify_id)
      .then(res => res.json())
      .then(data => {this.album_info = data;
        this.is_loading = false
      })
    },
    get_reviews() {
      this.reviews_loading = true;
      fetch(this.url_root + "review/list/" +this.spotify_id)
      .then(res => res.json())
      .then(data => {
        for (let i=0; i < data.length; i++){
          this.reviews.push(data[i]);
        };
        this.reviews_loading = false
      })
    },
    artist_string(artists: {name: string}[]) {
      let result = "";
      if (artists.length > 2){
        for (let i = 0; i < artists.length - 1; i++){
          result += artists[i].name + ", "
        }
      }
      else if (artists.length == 2){
        result += artists[0].name + " "
      }
      if (result !== ""){
        result += "and "
      }
      result += artists[artists.length - 1]["name"]
      return result
    },
    close_review(){
      this.written_rating = undefined;
      this.written_body = "";
      this.is_writing = false;
    },
    async submit_review(){
      if (this.written_body || this.written_rating){
        const response = await fetch(`/api/review/write`, {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${localStorage.getItem("token")}`,
          },
          body: JSON.stringify({ 
            "album_spotify_id": this.id,
            "body": this.written_body,
            "rating": this.written_rating,
          }),
        });

        console.log(response.json());
        if (!response.ok) {
          let error = response.statusText;
          console.log(`Error: ${error}`);
          if(error === "Unauthorized"){
            console.log("Your session has expired, please log in again.")
            // let password = prompt("Your session has expired. Please re-enter your password to continue.")
          }
        } else {
          this.close_review()
          this.get_reviews()
        }
        console.log(response.ok);
      }
    }
  },
  mounted(){
    this.get_album(),
    this.get_reviews()
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
        <small>(<a v-bind:href="`${album_info['external_urls']['spotify']}`" target="_bind">Open in Spotify</a>)</small>
        <div v-for="track in album_info['tracks']['items']">
          <p>{{ track.track_number }}. <a v-bind:href="`${track['external_urls']['spotify']}`" target="_bind">{{ track.name }}</a></p>
        </div>
      </div>
    </div>
    <div class="review-column">
      <div class="write-container" v-if="is_writing">
        <div class="review-col-header" style="justify-content: space-between;">
          <button class="button" @click="close_review()">Cancel</button>
          <h1>Write a Review</h1>
          <button class="button" @click="submit_review()">Publish Review</button>
        </div>
        <div class="review-form">
          <strong class="review-title">[user]'s review of {{ album_info.name }}</strong>
          <div>
            <label for="rating">Rating (optional, 1-10): <input id="rating" v-model="written_rating" type="number" min=1 max=10 style="font-size: 1em"></label>
          </div>
          <div>
            <label for="review-text">Review content:</label>
            <textarea id="review-text" v-model="written_body"></textarea>
          </div>
        </div>
      </div>
      <div class="read-container" v-else="!is_writing">
        <div class="review-col-header">
          <h1>Reviews</h1>
          <button class="button" @click="is_writing = true" style="margin: 40px; margin-top: 50px; margin-left: 20px;">Write Review</button>
        </div>
        <p class="search-progress" v-if="is_loading">Loading album reviews...</p>
        <Review v-else-if="reviews.length > 0" v-for="review in reviews" :review="review" :show-album="false"/>
        <div v-else style="font-size: 2em">
          <p>No reviews found.</p>
          <p>Be the first to write one!</p>
        </div>
        <p v-for="review in reviews" hidden="false"> {{ review }}</p> <!-- Hide metadata by default -->
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

img {
  width: 75%;
  height: auto;
}

#album-title {
  font-weight: bold;
  font-size: 16pt;
  word-break: break-word;
  word-wrap: break-word;
  overflow-wrap: break-word;
  margin: 0;
}
#artists {
  margin: 0;
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
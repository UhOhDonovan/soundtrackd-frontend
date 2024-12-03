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
  name: 'Profile',
  components: {Review},
  props: {
    viewed_user: String,
  },
  data() {
    return {
      url_root: "http://localhost:5345/",
      is_loading: false,
      review_list: new Array<ReviewData>,
      show_album: true,
    }
  },
  methods: {
    get_reviews() {
      this.is_loading = true;
      // NEED TO MAKE API ENDPOINT TO GET BY USERNAME
      fetch(this.url_root + "review/list/user/" + this.viewed_user)
      .then(res => res.json())
      .then(data => {
        for (let i=0; i < data.length; i++){
          this.review_list.push(data[i]);
        };
        this.is_loading = false
      })
    },

  },
  mounted(){
    this.get_reviews()
  },
}
</script>

<template>
  <div style="margin-left:2.5%; margin-right:2.5%">
    <h1> {{ viewed_user }}'s Reviews</h1>
    <p class="search-progress" v-if="is_loading">Loading reviews...</p>
    <Review v-else-if="review_list" v-for="review in review_list" :review="review" :show-album="true"/>
    <p v-else>No reviews found.</p>
  </div>
</template>

<style scoped>
* {
  box-sizing: border-box;
}

body {
  font-family: Arial, Helvetica, sans-serif;
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
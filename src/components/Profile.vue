<script lang="ts">
import Review from "./Review.vue";


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
      temp_review: {
        id: 123124211,
        posted_by: "SpooderNoob",
        album_spotify_id: "1woCvthHJakakroP6dXNxs",
        post_date: "11/24/2024",
        post_time: "7:55 PM",
        rating: 9,
        body: "This is a  crazy review about the album on this page! It was so crazy and wild ot listen to it! What a crazy world we live in.",
      },
      review_list: [{
        id: 123124211,
        posted_by: "SpooderNoob",
        album_spotify_id: "1woCvthHJakakroP6dXNxs",
        post_date: "11/24/2024",
        post_time: "7:55 PM",
        rating: 9,
        body: "This is a  crazy review about the album on this page! It was so crazy and wild ot listen to it! What a crazy world we live in.",
      }],
      show_album: true,
    }
  },
  methods: {
    get_reviews() {
      // NOT FUNCTIONAL
      this.is_loading = true;
      // fetch(this.url_root + "search/album/id?id=" +this.spotify_id)
      // .then(res => res.json())
      // .then(data => {this.album_info = data;
      //   this.is_loading = false
      // })
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
    <Review v-for="review in review_list" :review="review" :show-album="true"/>
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
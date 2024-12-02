<script lang="ts">
import { PropType } from 'vue';
// TODO: likely revise this data structure, adding necessary info from the API
type ReviewData = {
  id: Number,
  posted_by: String,
  album_spotify_id: String,
  // album_name: String,
  post_date: String,
  post_time: String,
  rating: Number,
  body: String,
}

export default {
  name: 'Review',
  props: {
    id: String,
    review: Object as PropType<ReviewData>,
    showAlbum: Boolean,
  },
  data() {
    return {
      is_loading: false,
    }
  },
  methods: {
    // TODO: Replace with function to retrieve review from id
    // get() {
    //   this.is_loading = true;
    //   fetch(this.url_root + this.spotify_id)
    //   .then(res => res.json())
    //   .then(data => {this.album_info = data;
    //     this.is_loading = false
    //   })
    // }
  },
  mounted(){
    // this.get()
  }
}
</script>

<template>
  <div class="review">
      <p class="search-progress" v-if="is_loading">Loading review info</p>
      <div v-else-if="review">
        <div class="review-header">
          <div class="description">
            <strong><RouterLink :to="{name: 'Profile', params: {viewed_user: review.posted_by}}">{{review.posted_by}}'s</RouterLink> review<span v-if="showAlbum"> of <RouterLink :to="{name: 'Album', params: {id: review.album_spotify_id}}">[album name]</RouterLink></span></strong>
          </div>
          <p id="rating" v-if="review.rating">Rating: {{ review.rating }}</p>
        </div>
        <div class="review-content">
          <p id="text">"{{ review.body }}"</p>
        </div>
      </div>
    </div>
</template>

<style scoped>
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

.review {
  border: 1px solid #ccc;
  padding: 20px;
  margin: 20px;
  border-radius: 10px;
  /* max-width: 600px; */
  font-family: Arial, sans-serif;
}
.review-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  overflow-x:visible;
}
.post-header img {
  border-radius: 50%;
  width: 50px;
  height: 50px;
  margin-right: 10px;
}
.review-content {
  margin-top: 10px;
}
</style>
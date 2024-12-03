<script lang="ts">
import { PropType } from "vue";
// TODO: likely revise this data structure, adding necessary info from the API
type ReviewData = {
  id: Number;
  rating: Number;
  post_time: String;
  album_spotify_id: String;
  posted_by: String;
  post_date: String;
  body: String;
  album_info: {
    title: String;
    cover_url: String;
  };
};

export default {
  name: "Review",
  props: {
    id: String,
    review: Object as PropType<ReviewData>,
    showAlbum: Boolean,
  },
  data() {
    return {
      is_loading: false,
    };
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
  mounted() {
    // this.get()
  },
};
</script>

<template>
  <div class="review">
    <p class="search-progress" v-if="is_loading">Loading review info</p>
    <div v-else-if="review" style="display: flex">
      <div
        v-if="showAlbum && review.album_info.cover_url"
        style="width: 20%; margin: 1%"
      >
        <img :src="`${review.album_info.cover_url}`" />
      </div>
      <div style="width: 100%">
        <div
          class="review-header"
          style="margin-left: 20px; margin-right: 20px"
        >
          <div class="description">
            <strong
              ><RouterLink
                :to="{
                  name: 'Profile',
                  params: { viewed_user: review.posted_by as string},
                }"
                >{{ review.posted_by as string }}</RouterLink
              >'s review<span v-if="showAlbum">
                of
                <RouterLink
                  :to="{
                    name: 'Album',
                    params: { id: review.album_spotify_id as string },
                  }"
                  >{{ review.album_info.title as string }}</RouterLink
                ></span
              ></strong
            >
          </div>
          <p id="rating" v-if="review.rating">Rating: {{ review.rating }}</p>
        </div>
        <hr style="margin: 0%" />
        <div
          class="review-content"
          style="margin-left: 20px; margin-right: 20px"
        >
          <p id="text">"{{ review.body }}"</p>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
* {
  font-size: 1.05em;
}
img {
  width: 100%;
  height: auto;
  min-height: 150px;
  min-width: 150px;
}
a {
  font-weight: bold;
}
@keyframes flickerAnimation {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.25;
  }
  100% {
    opacity: 1;
  }
}
@-o-keyframes flickerAnimation {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.25;
  }
  100% {
    opacity: 1;
  }
}
@-moz-keyframes flickerAnimation {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.25;
  }
  100% {
    opacity: 1;
  }
}
@-webkit-keyframes flickerAnimation {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.25;
  }
  100% {
    opacity: 1;
  }
}

.search-progress {
  -webkit-animation: flickerAnimation 1.25s infinite;
  -moz-animation: flickerAnimation 1.25s infinite;
  -o-animation: flickerAnimation 1.25s infinite;
  animation: flickerAnimation 1.25s infinite;
}

.review {
  border: 1px solid #ccc;
  /* padding-left: 20px;
  padding-right: 20px; */
  margin: 20px;
  border-radius: 10px;
  /* max-width: 600px; */
  font-family: Arial, sans-serif;
}
.review-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  overflow-x: visible;
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

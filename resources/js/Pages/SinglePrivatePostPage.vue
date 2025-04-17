<script setup>
import Navbar from "@/Components/Navbar.vue";
import { Link, usePage } from "@inertiajs/vue3";
import axios from "axios";
import { computed, onMounted, ref } from "vue";

const props = defineProps({ post: Object });

const authUser = usePage().props.auth.user;

const query = computed(() => {
    const urlParams = new URLSearchParams(usePage().url.split('?')[1] || '');
    return { from: urlParams.get('from') || 'all' };
});

const backLink = computed(() => {
    if (query.value.from === 'public') return '/public-posts';
    if (query.value.from === 'private') return '/private-posts';
    return '/all-posts';
});

const likeCount = ref(0);
const liked = ref(false);
const comments = ref([]);
const commentText = ref("");
const replyingTo = ref(null);
const editingComment = ref(null);
const editContent = ref("");

const fetchLikeStatus = async () => {
    if (!authUser) return;
    const res = await axios.post(
        "/check-like",
        { post_id: props.post.id },
        {
            headers: { id: authUser?.id },
        }
    );
    liked.value = res.data.liked;
};

const fetchLikeCount = async () => {
    const res = await axios.get(`/like-count/${props.post.id}`);
    likeCount.value = res.data.like_count;
};

const toggleLike = async () => {
    if (!authUser) return;
    const res = await axios.post(
        "/toggle-like",
        { post_id: props.post.id },
        {
            headers: { id: authUser.id },
        }
    );
    liked.value = !liked.value;
    likeCount.value = res.data.like_count;
};

const fetchComments = async () => {
    const res = await axios.post(`/posts/${props.post.id}/comment-list`);
    comments.value = res.data;
};

const postComment = async () => {
    if (!authUser) return;
    await axios.post(
        `/posts/${props.post.id}/comments`,
        {
            content: commentText.value,
            parent_id: replyingTo.value,
        },
        {
            headers: { id: authUser.id },
        }
    );
    commentText.value = "";
    replyingTo.value = null;
    fetchComments();
};

const deleteComment = async (id) => {
    await axios.post(
        `/comments/${id}`,
        {},
        {
            headers: { id: authUser.id },
        }
    );
    fetchComments();
};

const updateComment = async (id) => {
    await axios.post(
        `/comment/${id}`,
        {
            content: editContent.value,
        },
        {
            headers: { id: authUser.id },
        }
    );
    editingComment.value = null;
    editContent.value = "";
    fetchComments();
};

onMounted(() => {
    fetchLikeCount();
    fetchComments();
    if (authUser) fetchLikeStatus();
});
</script>

<template>
    <Navbar />
    <div class="container mt-5 pt-4">
        <Link :href="backLink" class="btn btn-outline-primary mb-4">
            <i class="fas fa-arrow-left me-1"></i> Back to {{ query.from === 'public' ? 'Public Posts' : query.from === 'private' ? 'Private Posts' : 'My Posts' }}
        </Link>
    </div>
    <div class="container">
        <!-- Post -->
        <div class="card mb-5 shadow border-0">
            <div class="card-body p-3">
                <!-- Post Image Container -->
                <div
                    class="image-container mb-4"
                    style="background-color: #f8f9fa; padding: 1rem; border-radius: 0.5rem; max-width: 800px; margin: 0 auto;"
                >
                    <img
                        v-if="post.image"
                        :src="`/${post.image}`"
                        style="max-width: 100%; max-height: 500px; height: auto; display: block; margin: 0 auto; border-radius: 0.5rem; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);"
                        alt="Post Thumbnail"
                    />
                    <div
                        v-else
                        class="bg-light d-flex align-items-center justify-content-center"
                        style="max-width: 100%; height: 200px; border-radius: 0.5rem; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);"
                    >
                        <span class="text-muted fs-5">No Image</span>
                    </div>
                </div>
                <!-- Tags -->
                <div class="mb-3">
                    <span
                        v-for="tag in post.tags"
                        :key="tag.id"
                        class="badge bg-primary bg-opacity-75 text-white me-1"
                    >
                        {{ tag.name }}
                    </span>
                </div>
                <!-- Title and Content -->
                <h2 class="card-title mb-4 fw-bold" style="font-size: 1.75rem;">{{ post.title }}</h2>
                <div v-html="post.content" class="card-text text-secondary" style="line-height: 1.8;"></div>
            </div>
        </div>

        <!-- Like -->
        <div class="mb-4 d-flex align-items-center">
            <button class="btn btn-outline-primary me-3 transition-hover" @click="toggleLike">
                <i :class="liked ? 'fas fa-thumbs-up' : 'far fa-thumbs-up'"></i>
                {{ liked ? "Liked" : "Like" }}
            </button>
            <span class="text-muted">{{ likeCount }} likes</span>
        </div>

        <!-- Comment Input -->
        <div class="card mb-5 shadow border-0">
            <div class="card-body p-4">
                <h5 class="card-title fw-semibold mb-3">Leave a Comment</h5>
                <textarea
                    class="form-control mb-3"
                    v-model="commentText"
                    rows="3"
                    placeholder="Write something..."
                    style="border-radius: 0.5rem;"
                ></textarea>
                <div class="d-flex justify-content-between align-items-center">
                    <div v-if="replyingTo" class="text-muted small">
                        Replying to comment #{{ replyingTo }}
                        <a
                            href="#"
                            @click.prevent="replyingTo = null"
                            class="ms-2 text-danger"
                            >Cancel</a
                        >
                    </div>
                    <button class="btn btn-primary transition-hover" @click="postComment">
                        <i class="fas fa-paper-plane me-1"></i> Post
                    </button>
                </div>
            </div>
        </div>

        <!-- Comments -->
        <div
            v-for="comment in comments"
            :key="comment.id"
            class="card mb-3 shadow-sm border-0"
        >
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <strong class="fw-semibold">{{ comment.user?.name }}</strong>
                    <div>
                        <button
                            class="btn btn-sm btn-outline-primary me-1 transition-hover"
                            @click="replyingTo = comment.id"
                        >
                            <i class="fas fa-reply"></i>
                        </button>
                        <button
                            v-if="authUser?.id === comment.user_id"
                            class="btn btn-sm btn-outline-warning me-1 transition-hover"
                            @click="
                                () => {
                                    editingComment = comment.id;
                                    editContent = comment.content;
                                }
                            "
                        >
                            <i class="fas fa-edit"></i>
                        </button>
                        <button
                            v-if="authUser?.id === comment.user_id"
                            class="btn btn-sm btn-outline-danger transition-hover"
                            @click="deleteComment(comment.id)"
                        >
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </div>
                </div>

                <div v-if="editingComment === comment.id" class="mt-3">
                    <input v-model="editContent" class="form-control mb-2" style="border-radius: 0.5rem;" />
                    <div class="d-flex justify-content-end gap-2">
                        <button
                            class="btn btn-sm btn-primary transition-hover"
                            @click="updateComment(comment.id)"
                        >
                            Save
                        </button>
                        <button
                            class="btn btn-sm btn-secondary transition-hover"
                            @click="editingComment = null"
                        >
                            Cancel
                        </button>
                    </div>
                </div>
                <div v-else class="mt-2 text-secondary">
                    {{ comment.content }}
                </div>

                <!-- Replies -->
                <div
                    v-if="comment.replies && comment.replies.length"
                    class="mt-3 ms-4 border-start ps-3"
                >
                    <div
                        v-for="reply in comment.replies"
                        :key="reply.id"
                        class="mb-2 small text-muted"
                    >
                        <strong>{{ reply.user?.name }}</strong
                        >: {{ reply.content }}
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.transition-hover {
    transition: background-color 0.2s ease, transform 0.2s ease;
}
.transition-hover:hover {
    transform: translateY(-2px);
}
.card-text {
    line-height: 1.8;
    color: #6c757d;
}
.btn-primary {
    background-color: #0057b8;
    border-color: #0057b8;
}
.btn-primary:hover {
    background-color: #004a9b;
    border-color: #004a9b;
}
.btn-outline-primary {
    color: #0057b8;
    border-color: #0057b8;
}
.btn-outline-primary:hover {
    background-color: #0057b8;
    color: #fff;
}
.image-container {
    text-align: center;
}
</style>
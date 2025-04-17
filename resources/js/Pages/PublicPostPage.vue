<script setup>
import Navbar from "@/Components/Navbar.vue";
import { Link, usePage } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";
import axios from "axios";
import { computed, onMounted, ref, watch } from "vue";

const props = defineProps({
    posts: Object,
});

const toaster = createToaster({ position: "top-right" });
const page = usePage();
const authUser = computed(() => page.props.auth?.user ?? null);

const bookmarkedStatus = ref({});

const initializeBookmarkStatus = () => {
    const initialStatus = {};
    if (props.posts && props.posts.data) {
        props.posts.data.forEach((post) => {
            initialStatus[post.id] = post.is_bookmarked ?? false;
        });
    }
    bookmarkedStatus.value = initialStatus;
};

onMounted(() => {
    initializeBookmarkStatus();
});

watch(() => props.posts.data, initializeBookmarkStatus, { deep: true });

const toggleBookmarkHandler = async (postId) => {
    if (!authUser.value) {
        toaster.warning("Please login to bookmark posts.");
        return;
    }

    const currentStatus = bookmarkedStatus.value[postId] ?? false;
    bookmarkedStatus.value[postId] = !currentStatus;

    try {
        const response = await axios.post(
            "/toggle-bookmark",
            { post_id: postId },
            {
                headers: {
                    "X-CSRF-TOKEN": page.props.csrf_token,
                },
            }
        );

        if (response.data.status === "success") {
            console.log("Bookmark status updated:", response.data.message);
        } else {
            bookmarkedStatus.value[postId] = currentStatus;
            toaster.error(
                response.data.message || "Failed to update bookmark."
            );
        }
    } catch (error) {
        console.error("Bookmark toggle error:", error);
        bookmarkedStatus.value[postId] = currentStatus;
        toaster.error("An error occurred while updating the bookmark.");
    }
};

const stripHtml = (html) => {
    if (!html) return "";
    let doc = new DOMParser().parseFromString(html, "text/html");
    return doc.body.textContent || "";
};
</script>

<template>
    <Navbar />
    <div class="container mt-5 pt-4">
        <h1 class="mb-5 fw-bold text-dark" style="font-size: 2.25rem;">Explore Public Posts</h1>
        <div class="row">
            <div
                class="col-md-4 mb-4"
                v-for="post in props.posts.data"
                :key="post.id"
            >
                <div class="card h-100 shadow border-0 transition-hover">
                    <!-- Tags -->
                    <div
                        v-if="post.tags && post.tags.length > 0"
                        class="position-absolute top-0 start-0 p-2"
                        style="z-index: 1"
                    >
                        <span
                            v-for="tag in post.tags"
                            :key="tag.id"
                            class="badge bg-primary bg-opacity-75 text-white me-1"
                        >
                            {{ tag.name }}
                        </span>
                    </div>

                    <!-- Image or fallback -->
                    <Link :href="`/public-posts/${post.id}?from=public`" preserve-state>
                        <img
                            v-if="post.image"
                            :src="`/${post.image}`"
                            class="card-img-top"
                            style="height: 180px; object-fit: cover; border-top-left-radius: 0.5rem; border-top-right-radius: 0.5rem;"
                            alt="Post Image"
                        />
                        <div
                            v-else
                            class="bg-light d-flex align-items-center justify-content-center card-img-top"
                            style="height: 180px; border-top-left-radius: 0.5rem; border-top-right-radius: 0.5rem;"
                        >
                            <span class="text-muted fs-5">No Image</span>
                        </div>
                    </Link>

                    <!-- Card Body -->
                    <div class="card-body d-flex flex-column p-4">
                        <h5 class="card-title mb-2">
                            <Link
                                :href="`/public-posts/${post.id}?from=public`"
                                class="text-decoration-none text-dark fw-semibold stretched-link"
                                preserve-state
                                >{{ post.title }}</Link
                            >
                        </h5>
                        <p
                            class="card-text text-secondary flex-grow-1"
                            style="
                                overflow: hidden;
                                display: -webkit-box;
                                -webkit-line-clamp: 3;
                                -webkit-box-orient: vertical;
                                line-height: 1.6;
                            "
                        >
                            {{ stripHtml(post.content) }}
                        </p>

                        <!-- Buttons Container -->
                        <div
                            class="mt-auto d-flex justify-content-between align-items-center"
                            style="z-index: 2; position: relative"
                        >
                            <Link
                                :href="`/public-posts/${post.id}?from=public`"
                                class="btn btn-sm btn-primary"
                                title="Read More"
                                preserve-state
                            >
                                <i class="fas fa-book-open me-1"></i> Read More
                            </Link>

                            <button
                                @click.stop="toggleBookmarkHandler(post.id)"
                                class="btn btn-sm"
                                :class="
                                    bookmarkedStatus[post.id]
                                        ? 'btn-warning'
                                        : 'btn-outline-secondary'
                                "
                                :disabled="!authUser"
                                :title="
                                    authUser
                                        ? bookmarkedStatus[post.id]
                                            ? 'Remove bookmark'
                                            : 'Save post'
                                        : 'Login to save posts'
                                "
                            >
                                <i
                                    :class="
                                        bookmarkedStatus[post.id]
                                            ? 'fas fa-bookmark'
                                            : 'far fa-bookmark'
                                    "
                                ></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- No Posts Message -->
            <div
                v-if="!props.posts.data || props.posts.data.length === 0"
                class="col-12 text-center mt-5"
            >
                <p class="text-muted fs-4">No publicly available posts detected.</p>
            </div>
        </div>

        <!-- Pagination -->
        <div class="d-flex justify-content-center mt-5 mb-4">
            <nav v-if="props.posts.links && props.posts.links.length > 3">
                <ul class="pagination shadow-sm">
                    <li
                        v-for="(link, i) in props.posts.links"
                        :key="i"
                        class="page-item"
                        :class="{
                            active: link.active,
                            disabled: !link.url,
                        }"
                    >
                        <Link
                            class="page-link"
                            v-if="link.url"
                            :href="link.url"
                            v-html="link.label"
                            preserve-scroll
                            preserve-state
                        />
                        <span
                            v-else
                            class="page-link"
                            v-html="link.label"
                            aria-disabled="true"
                        />
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</template>

<style scoped>
.transition-hover {
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.transition-hover:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1) !important;
}
.card-title a:hover {
    text-decoration: none;
    color: #0057b8;
}
.card-text {
    line-height: 1.6;
    color: #6c757d;
}
.stretched-link::after {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 1;
    content: "";
}
.card-body .btn,
.card-body button {
    z-index: 2;
    position: relative;
}
.pagination .page-link {
    border-radius: 0.25rem;
    margin: 0 2px;
    color: #0057b8;
}
.pagination .page-item.active .page-link {
    background-color: #0057b8;
    border-color: #0057b8;
}
</style>
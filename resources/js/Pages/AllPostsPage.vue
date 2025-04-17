<script setup>
import { defineProps, ref, watch } from "vue";
import { Link, router } from "@inertiajs/vue3";
import Navbar from "@/Components/Navbar.vue";

const props = defineProps({
    posts: Array,
});

// For table headers
const headers = [
    { text: "Title", value: "title" },
    { text: "Image", value: "image" },
    { text: "Visibility", value: "visibility" },
    { text: "Actions", value: "actions" },
];

// Search
const searchField = ref("");

// Watch search field and fetch filtered posts
watch(searchField, (newValue) => {
    router.reload({
        data: { search: newValue },
        preserveState: true,
        preserveScroll: true,
    });
});

// Actions
function editPost(id) {
    router.visit(`/edit-post/${id}`);
}

function deletePost(id) {
    if (confirm("Are you sure you want to delete this post?")) {
        router.post(
            `/delete-post/${id}`,
            {},
            {
                onSuccess: () => alert("Post deleted!"),
            }
        );
    }
}
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <h2 class="mb-4 fw-bold">All My Posts</h2>

        <!-- Search Bar -->
        <input
            type="text"
            class="form-control mb-4"
            placeholder="Search by title, content, tags, or username..."
            v-model="searchField"
        />

        <!-- Data Table -->
        <EasyDataTable
            :headers="headers"
            :items="props.posts"
            :rows-per-page="5"
            table-class-name="custom-table"
        >
            <!-- Image -->
            <template #item-image="{ image }">
                <img
                    v-if="image"
                    :src="`/${image}`"
                    alt="Post Image"
                    class="img-thumbnail"
                    style="max-height: 60px"
                />
                <span v-else class="text-muted">No Image</span>
            </template>

            <!-- Actions -->
            <template #item-actions="{ id, visibility }">
                <Link
                    v-if="visibility === 'public'"
                    :href="`/public-posts/${id}?from=all`"
                    class="btn btn-sm btn-outline-primary me-2"
                    preserve-state
                >
                    View
                </Link>
                <Link
                    v-if="visibility === 'private'"
                    :href="`/private-posts/${id}?from=all`"
                    class="btn btn-sm btn-outline-primary me-2"
                    preserve-state
                >
                    View
                </Link>
                <button
                    @click="editPost(id)"
                    class="btn btn-sm btn-primary me-2"
                >
                    Edit
                </button>
                <button @click="deletePost(id)" class="btn btn-sm btn-danger">
                    Delete
                </button>
            </template>
        </EasyDataTable>
    </div>
</template>

<style scoped>
.custom-table {
    margin-top: 20px;
}
.custom-table :deep(.table) {
    border-radius: 0.5rem;
    overflow: hidden;
}
.custom-table :deep(thead) {
    background-color: #0057b8;
    color: white;
}
.custom-table :deep(.btn) {
    font-size: 0.875rem;
}
</style>
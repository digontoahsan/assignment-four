<script setup>
import Navbar from "@/Components/Navbar.vue";
import { useForm } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";
import { ref } from "vue";
import { QuillEditor } from "@vueup/vue-quill";

const toaster = createToaster();
const tagInput = ref("");
const tags = ref([]);

const addTag = () => {
    const name = tagInput.value.trim();
    if (name && !tags.value.includes(name)) {
        tags.value.push(name);
    }
    tagInput.value = "";
};

const removeTag = (name) => {
    tags.value = tags.value.filter((t) => t !== name);
};

const form = useForm({
    title: "",
    content: "",
    image: null,
    visibility: "public",
    tags: tags.value,
});

function handleFileChange(event) {
    form.image = event.target.files[0];
}

function createPost() {
    form.tags = tags.value;
    form.post("/create-post", {
        forceFormData: true,
        onSuccess: () => {
            toaster.success("Post created successfully!");
            form.reset();
            tags.value = [];
        },
        onError: (errors) => {
            toaster.error(errors.title || errors.content || "Something went wrong");
        },
    });
}
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <div class="card shadow-sm">
            <div class="card-header bg-primary text-white text-center">
                <h3>Create a New Blog Post</h3>
            </div>
            <div class="card-body">
                <form @submit.prevent="createPost">
                    <!-- Title -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Post Title</label>
                        <input v-model="form.title" class="form-control" placeholder="Enter your post title" />
                    </div>

                    <!-- Content -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Post Content</label>
                        <QuillEditor
                            v-model:content="form.content"
                            theme="snow"
                            contentType="html"
                            toolbar="full"
                            style="min-height: 250px; background-color: #fff;"
                        />
                    </div>

                    <!-- Visibility -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Visibility</label>
                        <select v-model="form.visibility" class="form-select">
                            <option value="public">Public</option>
                            <option value="private">Private</option>
                        </select>
                    </div>

                    <!-- Image -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Featured Image</label>
                        <input type="file" @change="handleFileChange" class="form-control" />
                    </div>

                    <!-- Tags -->
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tags</label>
                        <div class="d-flex">
                            <input
                                v-model="tagInput"
                                @keyup.enter.prevent="addTag"
                                placeholder="Type tag and press Enter"
                                class="form-control me-2"
                            />
                            <button type="button" @click="addTag" class="btn btn-outline-secondary">
                                Add Tag
                            </button>
                        </div>
                        <div class="mt-2">
                            <span
                                v-for="tag in tags"
                                :key="tag"
                                class="badge bg-info text-dark me-1"
                            >
                                {{ tag }}
                                <span @click="removeTag(tag)" style="cursor: pointer" class="ms-1">&times;</span>
                            </span>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-lg btn-success w-50">
                            Publish Post
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</template>

<style>
/* You can add extra visual polish here if needed */
</style>
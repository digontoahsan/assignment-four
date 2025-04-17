<script setup>
import { router } from "@inertiajs/vue3";
import { createToaster } from "@meforma/vue-toaster";

import DashboardStats from "@/Components/DashboardStats.vue";
import Navbar from "@/Components/Navbar.vue";
import RecentBookmarks from "@/Components/RecentBookmarks.vue";
import RecentComments from "@/Components/RecentComments.vue";
import RecentPosts from "@/Components/RecentPosts.vue";

const props = defineProps({
    recentPosts: Array,
    recentComments: Array,
    recentBookmarks: Array,
    totalPosts: Number,
    totalComments: Number,
    totalBookmarks: Number,
});

const toaster = createToaster({ position: "top-right" });

function logout() {
    router.post(
        "/user-logout",
        {},
        {
            onSuccess: () => {},
            onError: () => {
                toaster.error("Logout failed!");
            },
        }
    );
}
</script>

<template>
    <div class="dashboard">
        <Navbar />

        <div class="container mt-4">
            <div class="text-center mb-5">
                <h1 class="display-5 fw-bold">Welcome Back 👋</h1>
                <p class="lead text-muted">
                    Here's a quick overview of your blog activity
                </p>
            </div>

            <!-- Stats Section -->
            <div class="row g-4 mb-5">
                <div class="col-lg-4 col-md-6">
                    <DashboardStats
                        :total-posts="totalPosts"
                        :total-comments="totalComments"
                        :total-bookmarks="totalBookmarks"
                    />
                </div>
                <div class="col-lg-8 col-md-6">
                    <div class="alert alert-info shadow-sm">
                        Stay consistent and keep your readers engaged! 🚀
                    </div>
                </div>
            </div>

            <!-- Recent Activity Section -->
            <div class="row gy-4">
                <div class="col-12">
                    <h3 class="mb-3 border-bottom pb-2">📌 Your Latest Posts</h3>
                    <RecentPosts :posts="recentPosts" />
                </div>

                <div class="col-12">
                    <h3 class="mb-3 border-bottom pb-2">💬 Recent Comments</h3>
                    <RecentComments :recent-comments="recentComments" />
                </div>

                <div class="col-12">
                    <h3 class="mb-3 border-bottom pb-2">🔖 Bookmarked Posts</h3>
                    <RecentBookmarks :recent-bookmarks="recentBookmarks" />
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.dashboard h1,
.dashboard h3 {
    color: #343a40;
}
</style>
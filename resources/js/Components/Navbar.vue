<template>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <!-- Brand Logo -->
            <Link
                class="navbar-brand fw-bold text-white"
                :href="user ? '/dashboard' : '/'"
            >
                <i class="fas fa-blog me-2"></i>Blogify
            </Link>

            <button
                class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav"
                aria-controls="navbarNav"
                aria-expanded="false"
                aria-label="Toggle navigation"
            >
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <!-- Authenticated User Links -->
                    <template v-if="user">
                        <!-- Private Posts Link -->
                        <li class="nav-item me-2">
                            <Link
                                href="/private-posts"
                                class="nav-link"
                                :class="{ active: $page.url === '/private-posts' }"
                            >
                                Private Posts
                            </Link>
                        </li>
                        <!-- Public Posts Link -->
                        <li class="nav-item me-2">
                            <Link
                                href="/public-posts"
                                class="nav-link"
                                :class="{ active: $page.url === '/public-posts' }"
                            >
                                Public Posts
                            </Link>
                        </li>
                        <li class="nav-item me-2">
                            <Link
                                href="/all-posts"
                                class="nav-link"
                                :class="{ active: $page.url === '/all-posts' }"
                            >
                                My Posts
                            </Link>
                        </li>
                        <li class="nav-item me-3">
                            <Link
                                href="/profile"
                                class="nav-link"
                                :class="{ active: $page.url === '/profile' }"
                            >
                                Profile
                            </Link>
                        </li>
                        <li class="nav-item me-2">
                            <Link
                                href="/create-post"
                                class="btn btn-sm btn-outline-light"
                            >
                                <i class="fas fa-plus me-1"></i> Create Post
                            </Link>
                        </li>
                        <li class="nav-item">
                            <Link
                                href="/user-logout"
                                method="post"
                                as="button"
                                class="btn btn-sm btn-outline-danger"
                            >
                                Logout
                            </Link>
                        </li>
                    </template>

                    <!-- Guest User Links -->
                    <template v-else>
                        <!-- Public Posts Link -->
                        <li class="nav-item me-2">
                            <Link
                                href="/public-posts"
                                class="nav-link"
                                :class="{ active: $page.url === '/public-posts' }"
                            >
                                Public Posts
                            </Link>
                        </li>
                        <li class="nav-item me-2">
                            <Link
                                href="/login"
                                class="btn btn-sm btn-outline-light"
                            >
                                Login
                            </Link>
                        </li>
                        <li class="nav-item">
                            <Link
                                href="/user-register"
                                class="btn btn-sm btn-success"
                            >
                                Register
                            </Link>
                        </li>
                    </template>
                </ul>
            </div>
        </div>
    </nav>
</template>

<script setup>
import { Link, usePage } from "@inertiajs/vue3";
import { computed } from "vue";

const page = usePage();
const user = computed(() => page.props.auth?.user ?? null);
</script>

<style scoped>
.nav-link.active {
    font-weight: bold;
    color: #f8f9fa !important;
    border-bottom: 2px solid #0d6efd;
}
</style>

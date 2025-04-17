<script setup>
import Navbar from "@/Components/Navbar.vue";
import { Link } from "@inertiajs/vue3";
</script>

<template>
    <Navbar />
    <section class="hero-section d-flex align-items-center text-white py-5">
        <div class="container text-center">
            <h1 class="display-3 fw-bold mb-3">
                Share Your Voice with the World
            </h1>
            <p class="lead mb-4">
                Dive into a world of stories, ideas, and insights — or start telling your own.
            </p>

            <div class="d-flex flex-column flex-md-row justify-content-center gap-3 mt-4">
                <Link
                    href="/public-posts"
                    class="btn btn-outline-light btn-lg px-4"
                >
                    Explore Blogs
                </Link>
                <Link
                    href="/user-register"
                    class="btn btn-primary btn-lg px-4"
                >
                    Join Now
                </Link>
                <Link
                    href="/login"
                    class="btn btn-success btn-lg px-4"
                >
                    Sign In
                </Link>
            </div>
        </div>
    </section>
</template>

<style scoped>
.hero-section {
    background: linear-gradient(
            rgba(0, 0, 0, 0.6),
            rgba(0, 0, 0, 0.6)
        ),
        url('https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=1350&q=80') no-repeat center center;
    background-size: cover;
    min-height: 90vh;
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>

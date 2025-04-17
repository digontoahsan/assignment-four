<template>
    <Navbar />
    <div class="container mt-5">
        <h2>Profile</h2>
        <div class="card p-4">
            <div class="mb-3">
                <img
                :src="user.profile_pic ? `/uploads/profile/${user.profile_pic}` : '/images/default-profile.png'"
                alt="Profile Picture"
                @error="(e) => e.target.src = '/images/default-profile.png'"
                class="rounded-circle"
                style="width: 100px; height: 100px; object-fit: cover;"
                />
            </div>
            <p><strong>Name:</strong> {{ user.username }}</p>
            <p><strong>Email:</strong> {{ user.email }}</p>

            <div class="d-flex gap-2 mt-3">
                <Link href="/edit-profile" class="btn btn-sm btn-primary">Edit Profile</Link>
            </div>
        </div>
    </div>
</template>

<script setup>
import Navbar from "@/Components/Navbar.vue";
import { Link, usePage } from "@inertiajs/vue3";

const { props } = usePage();
const user = props.user;

// Compute the image URL based on whether the user has uploaded one
const profileImageUrl = user.profile_picture
    ? `/uploads/profile/${user.profile_picture}`
    : '/images/default-profile.png';
</script>

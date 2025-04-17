<script setup>
import Navbar from "@/Components/Navbar.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { ref, watch } from "vue";
import { useToast } from "vue-toastification";

const { props } = usePage();
const toast = useToast();

const user = props.user;

const profileImagePreview = ref(
    user.profile_pic ? `/uploads/profile/${user.profile_pic}` : "/images/default-profile.png"
);

const form = useForm({
    username: user.username || "",
    email: user.email || "",
    profile_pic: null,
});

const onFileChange = (e) => {
    const file = e.target.files[0];
    if (file) {
        form.profile_pic = file;
        profileImagePreview.value = URL.createObjectURL(file);
    }
};

const updateProfile = () => {
    form.post("/update-profile", {
        preserveScroll: true,
        onSuccess: () => {
            toast.success("Profile updated successfully!");
        },
        onError: (errors) => {
            if (Object.keys(errors).length) {
                Object.values(errors).forEach((msg) => {
                    toast.error(msg);
                });
            } else {
                toast.error("Something went wrong.");
            }
        },
    });
};
</script>

<template>
    <Navbar />
    <div class="container mt-5">
        <h2>Edit Profile</h2>
        <div class="card p-4">
            <form @submit.prevent="updateProfile" enctype="multipart/form-data">
                <!-- Profile image preview -->
                <div class="mb-4 text-center">
                    <img
                        :src="profileImagePreview"
                        alt="Profile Picture"
                        class="rounded-circle"
                        style="width: 120px; height: 120px; object-fit: cover;"
                    />
                </div>

                <div class="mb-3">
                    <label for="username" class="form-label">Name</label>
                    <input
                        type="text"
                        id="username"
                        class="form-control"
                        v-model="form.username"
                        required
                    />
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input
                        type="email"
                        id="email"
                        class="form-control"
                        v-model="form.email"
                        required
                    />
                </div>

                <div class="mb-3">
                    <label for="profile_pic" class="form-label">Profile Picture</label>
                    <input
                        type="file"
                        id="profile_pic"
                        class="form-control"
                        @change="onFileChange"
                        accept="image/*"
                    />
                </div>

                <button type="submit" class="btn btn-success">Update Profile</button>
            </form>
        </div>
    </div>
</template>
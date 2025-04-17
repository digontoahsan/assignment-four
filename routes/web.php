<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TagController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\BookmarkController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\NotificationController;
use App\Http\Middleware\TokenVerificationMiddleware;

Route::get('/', [UserController::class, 'index']);

Route::post('/user-registration', [UserController::class, 'UserRegistration']);
Route::post('/user-login', [UserController::class, 'UserLogin']);

Route::get('/user-register', [UserController::class, 'RegistrationPage']);
Route::get('/login', [UserController::class, 'Login']);


Route::post('/public-posts', [PostController::class, 'PublicPosts']);
Route::get('/public-posts', [PostController::class, 'PublicPosts']);
Route::get('/public-posts/{id}', [PostController::class, 'ShowSinglePost']);

Route::post('/posts/{postId}/comment-list', [CommentController::class, 'CommentList']);

Route::post('/tags', [TagController::class, 'GetTags']);


Route::middleware(TokenVerificationMiddleware::class)->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'Dashboard']);
    Route::post('/user-logout', [UserController::class, 'UserLogout']);

    Route::get('/profile', [UserController::class, 'ProfilePage']);
    Route::get('/edit-profile', [UserController::class, 'EditProfilePage']);
    Route::post('/update-profile', [UserController::class, 'UpdateProfile']);

    Route::post('/create-post', [PostController::class, 'CreatePost']);
    Route::match(['get', 'post'], '/post-list', [PostController::class, 'showAllPosts']);

    Route::post('/post-by-id', [PostController::class, 'PostById']);
    Route::post('/update-post', [PostController::class, 'PostUpdate']);
    Route::post('/delete-post/{id}', [PostController::class, 'PostDelete']);

    Route::get('/create-post', [PostController::class, 'PostCreate']);
    Route::get('/all-posts', [PostController::class, 'showAllPosts']);
    Route::get('/edit-post/{id}', [PostController::class, 'ShowEditPostPage']);

    Route::get('/private-posts', [PostController::class, 'showPrivatePosts']);
    Route::get('/private-posts/{id}', [PostController::class, 'ShowSinglePrivatePost']);

    Route::post('/create-tag', [TagController::class, 'CreateTag']);

    Route::post('/posts/{postId}/comments', [CommentController::class, 'CommentCreate']);
    Route::post('/comment/{commentId}', [CommentController::class, 'CommentUpdate']);
    Route::post('/comments/{commentId}', [CommentController::class, 'CommentDelete']);

    Route::post('/toggle-like', [LikeController::class, 'toggleLike']);
    Route::get('/like-count/{post_id}', [LikeController::class, 'likeCount']);
    Route::post('/check-like', [LikeController::class, 'checkLike']);

    Route::post('/toggle-bookmark', [BookmarkController::class, 'toggleBookmark']);
    Route::post('/check-bookmark', [BookmarkController::class, 'checkBookmark']);

    Route::post('/send-notification', [NotificationController::class, 'sendNotification']);
    Route::get('/notifications', [NotificationController::class, 'getUserNotifications']);
    Route::post('/mark-as-read', [NotificationController::class, 'markAsRead']);
});

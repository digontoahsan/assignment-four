-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 17, 2025 at 08:37 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog_final`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(9, 1, 2, '2025-04-17 10:43:49', '2025-04-17 10:43:49'),
(11, 1, 1, '2025-04-17 10:44:40', '2025-04-17 10:44:40'),
(15, 1, 5, '2025-04-17 10:56:06', '2025-04-17 10:56:06'),
(16, 1, 4, '2025-04-17 10:59:04', '2025-04-17 10:59:04');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `parent_id`, `content`, `created_at`, `updated_at`) VALUES
(1, 1, 7, NULL, 'Hello...', '2025-04-16 11:01:34', '2025-04-16 11:01:34');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`, `created_at`, `updated_at`) VALUES
(8, 1, 7, '2025-04-17 11:16:56', '2025-04-17 11:16:56');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_29_210511_create_posts_table', 1),
(5, '2025_03_29_210514_create_tags_table', 1),
(6, '2025_03_29_210520_create_post_tags_table', 1),
(7, '2025_03_29_210523_create_comments_table', 1),
(8, '2025_03_29_210528_create_likes_table', 1),
(9, '2025_03_29_210534_create_bookmarks_table', 1),
(10, '2025_03_29_210541_create_notifications_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('like','comment','reply') NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `visibility` enum('public','private') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `title`, `content`, `image`, `visibility`, `created_at`, `updated_at`) VALUES
(1, 1, 'Korean BBQ Yum Yum Rice Bowls', '<p>I came home from the studio on Sunday night after teaching a workshop over the weekend, and I settled into the couch with my phone and my cookie to get in the Mindless Introvert Zone and opened up my social apps and there it was all over everything:&nbsp;the news. And my brain trying to process it: no no no no no.</p><p>This morning as I&nbsp;sit here at my little breakfast counter trying to write this post about Korean BBQ Yum Yum Rice Bowls, I’m just way&nbsp;lost. Even for as much as I love food and adore these bowls and&nbsp;feel so lucky&nbsp;to write about all things delicious and good, the&nbsp;words feel – or ARE – completely awkward today. Writing about something called YUM YUM RICE BOWLS right now… it feels&nbsp;flaky at best, offensive at worst.</p><p><br></p><p>So&nbsp;instead I’m just kind of aimlessly typing and pausing and staring into&nbsp;my tea latte that has long since gone cold, feeling overwhelmed and sad and bleary-eyed behind my glasses and being okay leaning into that, and also knowing that somewhere&nbsp;there are people&nbsp;feeling that searing loss&nbsp;in a much more acutely&nbsp;personal way and wanting and needing to have my eyes open to that. I’m saying, in the words&nbsp;<a href=\"https://www.facebook.com/Jen-Hatmaker-203920953040241/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(115, 64, 96);\">Jen Hatmaker</a>:&nbsp;<em>I see this evil and I condemn it fully</em>. As is often the case when things start to fall apart, I’m finding slivers of hope and encouragement from&nbsp;thought leaders&nbsp;and loving communities all by way of the amazing internet — I mean, it’s not always what it should be, but these are the times when I think we can really use&nbsp;our 21st century connectedness to find each other. To learn, to&nbsp;listen, to&nbsp;love and to have a voice for good&nbsp;in times when the world feels like a dark and scary place. I hope we feel that even here, on a food blog. We see it, we name it, we condemn it, and we stand with each other on the side of good.</p><p><br></p><p>I think&nbsp;one of the only&nbsp;ways to bravely move forward&nbsp;in these dark days&nbsp;is to do what&nbsp;tiny little things&nbsp;we can to restore the balance – to keep&nbsp;the goodness coming. There is so much of it in each of us in our food and our homes and our hearts, right? Do you feel that? We have to tirelessly bring it&nbsp;all day every day. If love is the majority and love &gt; hate, right now, for many of us, food can be our symbol of love and our practical way to right the balances.</p>', 'uploads/1744818233.jpg', 'public', '2025-04-16 09:43:53', '2025-04-16 09:43:53'),
(2, 1, '5 Ingredient Spicy Pork', '<p>Maybe it’s because of&nbsp;<a href=\"https://pinchofyum.com/sauces-that-make-everything-better\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(115, 64, 96);\">Sauce Week</a>&nbsp;exhaustion (a very real and good thing), or maybe it’s just because 5 ingredient recipes are always good – but either way, I am really feeling this spicy pork this week.</p><p><br></p><p><br></p><p>The original recipe is from these&nbsp;<a href=\"https://www.bonappetit.com/recipe/spicy-pork-bowl-with-greens-and-carrots\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(115, 64, 96);\">Spicy Pork Bowls on Bon Appetit</a>, and I can’t remember who shared it first on our team Slack #potluck channel, but it got passed around and loved and eventually printed and grease-stained, and now just the pork itself has become a staple in my kitchen.</p><p>Keeping this post quick today because what’s there to show you, really? You shake up 5 ingredients in a jar. That’s basically the recipe.</p><p>You will have no problem finding ways to eat this pork, but let me just recommend it with eggs and kimchi and rice for a breakfast bowl, with noodles and stir-fried veggies, in a fusion burrito, and with the standard rice / carrots / greens combo as seen here.</p><p>ALSO DO NOT FORGET: a drizzle of sesame oil, a splash of soy sauce, and a quick shot of rice vinegar will serve you well, flavor-lovers.</p>', 'uploads/1744818469.jpg', 'private', '2025-04-16 09:47:49', '2025-04-16 09:47:49'),
(3, 1, 'Detox Rainbow Roll-Ups with Peanut Sauce', '<p>If Rainbow Roll-Up doesn’t give you some association with a packaged, neon-colored fruit leather situation all wrapped up in a little paper coil, then who are you even? I’m having a moderately hard time separating these from the single greatest snack food of my childhood.</p><p>This is not that kind of rainbow roll-up, though. This is a rainbow roll-up that’s a nutritional powerhouse with foods like: carrots. chickpeas. curry. red cabbage. peanuts. dark leafy greens.</p><p>See, mom? I can eat like an adult after all.</p>', 'uploads/1744821112.jpg', 'public', '2025-04-16 10:31:53', '2025-04-16 10:31:53'),
(4, 1, 'One-Pan Farro with Tomatoes and Kale', '<p>If the goal is maximum flavor, incredible texture, satisfying and wholesome ingredients, and LOW KEY cooking, this is the one-pot unicorn that checks every single box.</p><p>This recipe is amazing. It seems humble and slightly too healthy at first glance, I know. But it’s something of a miracle.</p><p>It’s nutty, chewy, rustic, and just the slightest bit brothy, which is compelling and unexpected and delicious. It’s spoonable like a stew, but textured and chewy more like a pasta. The flavors are mellow from gently cooked thinly sliced onion and garlic, sweet and tomatoey, and earthy and hearty from the kale. Torn basil and a sprinkle of Parmesan take it to a new level, and the extra olive oil that I recommend (require) creates a silky, satisfying, and luscious texture situation. And finally, the red pepper flakes – should you choose to go that route – give it just enough of a spark to keep you hooked bite after bite after chewy, savory bite.</p>', 'uploads/1744821340.jpg', 'public', '2025-04-16 10:35:40', '2025-04-16 10:35:40'),
(5, 1, 'Spaghetti with Crispy Zucchini', '<p>Hi-ho! It’s crispy zucchini spaghetti day, which means a big happy plate of steamy, twirly, saucy spaghetti (nothing too fancy here) piled high with roasty zucchini pieces surrounded by crispities of golden panko layered with a blanket of melted cheese and some bits of fresh basil.</p><p>It’s crunchy, summery, gardeny, cheesy in whatever way you want it to be cheesy (goat cheese, anyone?), steamy and satisfying, and totally perfect for a very hungry night because spaghetti doesn’t let us down.</p><p>Also: it’s very SOS-able.</p>', 'uploads/1744822007.jpg', 'public', '2025-04-16 10:46:47', '2025-04-16 10:46:47'),
(6, 1, 'Lemon Rosemary Chicken Soup', '<p>I texted my friends at 8am on Monday morning – “anyone want to come for a playdate today? I’m making soup.”</p><p>I was craving for something brothy, satisfying, and bright. Like the feeling of sinking into the couch on a cold day, wrapped in a blanket, sun on my face – that, but soup. Lemon rosemary chicken soup.</p><p><br></p><p>Both friends were at my house within two hours, sitting at my tiny kitchen island, drinking coffee while I chopped random veggies I had found in my fridge for soup and our kids played like wild little animals down in the basement. Which, honestly, is the exact kind of life I have always dreamed of.</p><p><br></p>', 'uploads/1744822177.jpg', 'public', '2025-04-16 10:49:37', '2025-04-16 10:49:37'),
(7, 1, 'Chicken Tortilla Soup', '<p>It’s hard to take a parade around Soup Town without a quick jaunt through everyone’s favorite smoky, scoopy, top-able chicken tortilla soup.</p><p>Thin, but not too brothy. Just enough to stand up to deep, cozy spoonfuls and piles on piles on piles of toppings but not feel like a chili or stew. Tender chicken shreds, buttery pinto beans, all the veg flavor but no big chunks, just the right amount of heat throughout…</p><p>Ugh, is there a park bench somewhere? We might be here a while.</p><p><br></p><p>It’s hard to pinpoint exactly the origin of tortilla soup, but it is generally attributed to Central Mexico and especially popular in Mexico City, where it was possibly born in the nearby state of Tlaxcala (which in Nahuatl means “land of the corn” or “place where tortillas abound”). In this great&nbsp;<a href=\"https://www.ful-filled.com/2021/04/12/traditional-mexican-tortilla-soup/\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(115, 64, 96);\">guest post</a>&nbsp;by Lorena Masso over on the ful-filled blog, she talks a lot about how this soup in particular represents the blending of Indigenous and Spanish cultures in much of Mexican cuisine. For example, she says Spaniards are generally thought to have introduced the concept of soup while corn is, of course, an important and vital ingredient in native culture.</p><p>Lorena also talks about how tortilla soup can be found all over Mexico and the toppings and ingredients can definitely vary from state to state. But no matter where you find it, you can always count on a rich chicken broth, roasted tomatoes, and chilis.</p>', 'uploads/1744822294.jpg', 'public', '2025-04-16 10:51:34', '2025-04-16 10:51:34');

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `tag_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `post_tags`
--

INSERT INTO `post_tags` (`id`, `post_id`, `tag_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 3, 2, NULL, NULL),
(3, 4, 2, NULL, NULL),
(4, 5, 2, NULL, NULL),
(5, 6, 3, NULL, NULL),
(6, 7, 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Dinner', '2025-04-16 09:43:53', '2025-04-16 09:43:53'),
(2, 'Vegetarian', '2025-04-16 10:31:53', '2025-04-16 10:31:53'),
(3, 'Soup', '2025-04-16 10:49:37', '2025-04-16 10:49:37'),
(4, 'Salad', '2025-04-16 11:19:29', '2025-04-16 11:19:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_pic` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `profile_pic`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin@example.com', '123', NULL, '2025-04-16 00:17:28', '2025-04-16 00:17:28'),
(9, 'ahsan', 'ahsan@domain.com', '123', '68013ae0167d2.jpg', '2025-04-17 11:26:00', '2025-04-17 11:31:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookmarks_user_id_foreign` (`user_id`),
  ADD KEY `bookmarks_post_id_foreign` (`post_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_user_id_foreign` (`user_id`),
  ADD KEY `comments_post_id_foreign` (`post_id`),
  ADD KEY `comments_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `likes_user_id_foreign` (`user_id`),
  ADD KEY `likes_post_id_foreign` (`post_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `posts_user_id_foreign` (`user_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_tags_post_id_foreign` (`post_id`),
  ADD KEY `post_tags_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_name_unique` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `post_tags`
--
ALTER TABLE `post_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `post_tags_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

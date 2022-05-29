-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 23, 2021 at 06:26 AM
-- Server version: 10.3.32-MariaDB-0ubuntu0.20.04.1
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin_newgogrocer`
--

-- --------------------------------------------------------

--
-- Table structure for table `aboutuspage`
--

CREATE TABLE `aboutuspage` (
  `about_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `aboutuspage`
--

INSERT INTO `aboutuspage` (`about_id`, `title`, `description`) VALUES
(1, 'About Us', '<p><strong>About Us</strong><br />\r\nGogrocer&nbsp;&nbsp;is a online Delivery &nbsp;Mobile App as a Service. We are committed to nurturing a neutral platform and are helping food establishments maintain high standards through Hyperpure. Food Hygiene Ratings is a coveted mark of quality among our restaurant partners.c</p>');

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `receiver_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `society` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_id` int(11) NOT NULL,
  `society_id` int(11) NOT NULL,
  `house_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pincode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `select_status` int(11) NOT NULL,
  `added_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `email`, `password`, `admin_image`, `remember_token`, `role_id`, `role_name`) VALUES
(1, 'GoGrocer Admin', 'admin@demo.com', '$2y$10$VD8DroA2J31Zfsvhef3zUO7dwBeLlXMmmggstTzkzsZ6WdgtBC6UK', 'images/admin/profile/07-04-20/070420120712pm-604a0cadf94914c7ee6c6e552e9b4487-curved-check-mark-circle-icon-by-vexels.png', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_driver_incentive`
--

CREATE TABLE `admin_driver_incentive` (
  `id` int(11) NOT NULL,
  `incentive` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_payouts`
--

CREATE TABLE `admin_payouts` (
  `payout_id` int(11) NOT NULL,
  `payout_date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `respond_payout_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payout_amt` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_link`
--

CREATE TABLE `app_link` (
  `id` int(11) NOT NULL,
  `android_app_link` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ios_app_link` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_link`
--

INSERT INTO `app_link` (`id`, `android_app_link`, `ios_app_link`) VALUES
(1, 'fdgfdg', 'gdfgdfg');

-- --------------------------------------------------------

--
-- Table structure for table `app_notice`
--

CREATE TABLE `app_notice` (
  `app_notice_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `notice` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_notice`
--

INSERT INTO `app_notice` (`app_notice_id`, `status`, `notice`) VALUES
(1, 1, 'This is Test Notice. Admin can change it.');

-- --------------------------------------------------------

--
-- Table structure for table `callback_req`
--

CREATE TABLE `callback_req` (
  `callback_req_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `processed` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cancel_for`
--

CREATE TABLE `cancel_for` (
  `res_id` int(11) NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cancel_for`
--

INSERT INTO `cancel_for` (`res_id`, `reason`) VALUES
(6, 'TAKING TO MUCH TIME'),
(7, 'PRICE IS DIFFRENT FROM OTHER STORE'),
(8, 'Changed My Mind.'),
(9, 'NOT INTERESTED'),
(10, 'NOT INTERESTED');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(11) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `varient_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `qty` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cart_payments`
--

CREATE TABLE `cart_payments` (
  `py_id` int(11) NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cart_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_gateway` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_rewards`
--

CREATE TABLE `cart_rewards` (
  `cart_rewards_id` int(11) NOT NULL,
  `cart_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rewards` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_status`
--

CREATE TABLE `cart_status` (
  `status_id` int(11) NOT NULL,
  `pending` datetime DEFAULT NULL,
  `confirm` datetime DEFAULT NULL,
  `out_for_delivery` datetime DEFAULT NULL,
  `completed` datetime DEFAULT NULL,
  `cancelled` datetime DEFAULT NULL,
  `cart_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `added_by` int(11) NOT NULL DEFAULT 0,
  `tax_type` int(11) NOT NULL DEFAULT 0,
  `tax_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_per` float NOT NULL DEFAULT 0,
  `tx_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

CREATE TABLE `city` (
  `city_id` int(11) NOT NULL,
  `city_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `country_code`
--

CREATE TABLE `country_code` (
  `code_id` int(11) NOT NULL,
  `country_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `country_code`
--

INSERT INTO `country_code` (`code_id`, `country_code`) VALUES
(1, 91);

-- --------------------------------------------------------

--
-- Table structure for table `coupon`
--

CREATE TABLE `coupon` (
  `coupon_id` int(11) NOT NULL,
  `coupon_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `coupon_description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `cart_value` int(100) NOT NULL,
  `amount` int(100) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uses_restriction` int(11) NOT NULL DEFAULT 1,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currency`
--

CREATE TABLE `currency` (
  `id` int(11) NOT NULL,
  `currency_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_sign` char(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currency`
--

INSERT INTO `currency` (`id`, `currency_name`, `currency_sign`) VALUES
(1, 'INR', 'Rs');

-- --------------------------------------------------------

--
-- Table structure for table `deal_product`
--

CREATE TABLE `deal_product` (
  `deal_id` int(11) NOT NULL,
  `varient_id` int(11) NOT NULL,
  `deal_price` float NOT NULL,
  `valid_from` datetime NOT NULL,
  `valid_to` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_boy`
--

CREATE TABLE `delivery_boy` (
  `dboy_id` int(11) NOT NULL,
  `boy_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `boy_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `boy_city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `boy_loc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `store_id` int(11) NOT NULL DEFAULT 0,
  `store_dboy_id` int(11) NOT NULL DEFAULT 0,
  `added_by` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `id_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_lat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_lng` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_rating`
--

CREATE TABLE `delivery_rating` (
  `rating_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `dboy_id` int(11) NOT NULL,
  `rating` float NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_bank`
--

CREATE TABLE `driver_bank` (
  `ac_id` int(11) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `ac_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ifsc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `holder_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `upi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_callback_req`
--

CREATE TABLE `driver_callback_req` (
  `callback_req_id` int(11) NOT NULL,
  `driver_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `driver_phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `processed` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL,
  `driver_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_incentive`
--

CREATE TABLE `driver_incentive` (
  `id` int(11) NOT NULL,
  `dboy_id` int(11) NOT NULL,
  `earned_till_now` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid_till_now` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remaining` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_notification`
--

CREATE TABLE `driver_notification` (
  `not_id` int(11) NOT NULL,
  `not_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `not_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `dboy_id` int(11) NOT NULL,
  `read_by_driver` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` int(11) NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fcm`
--

CREATE TABLE `fcm` (
  `id` int(11) NOT NULL,
  `sender_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `server_key` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_server_key` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `driver_server_key` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fcm`
--

INSERT INTO `fcm` (`id`, `sender_id`, `server_key`, `store_server_key`, `driver_server_key`) VALUES
(1, '352076647507', 'AAAAUflnTFM:APA91bENvJ_m7EYr0iyqcolGcB3DdSV_K5tKBDOJherPDN0TlQsYNeUzS92HSz0Ou1c_d0ty2Mvp_XAcxYMhqdh0XQG57cMC_8P2N_lFZmZQT55EZ2sfAx_d84ztVMYHGWaUfYwD-vQN', 'AAAAUflnTFM:APA91bENvJ_m7EYr0iyqcolGcB3DdSV_K5tKBDOJherPDN0TlQsYNeUzS92HSz0Ou1c_d0ty2Mvp_XAcxYMhqdh0XQG57cMC_8P2N_lFZmZQT55EZ2sfAx_d84ztVMYHGWaUfYwD-vQN', 'AAAAUflnTFM:APA91bENvJ_m7EYr0iyqcolGcB3DdSV_K5tKBDOJherPDN0TlQsYNeUzS92HSz0Ou1c_d0ty2Mvp_XAcxYMhqdh0XQG57cMC_8P2N_lFZmZQT55EZ2sfAx_d84ztVMYHGWaUfYwD-vQN');

-- --------------------------------------------------------

--
-- Table structure for table `firebase`
--

CREATE TABLE `firebase` (
  `f_id` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `firebase`
--

INSERT INTO `firebase` (`f_id`, `status`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `firebase_iso`
--

CREATE TABLE `firebase_iso` (
  `iso_id` int(11) NOT NULL,
  `iso_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `firebase_iso`
--

INSERT INTO `firebase_iso` (`iso_id`, `iso_code`) VALUES
(1, 'INR');

-- --------------------------------------------------------

--
-- Table structure for table `freedeliverycart`
--

CREATE TABLE `freedeliverycart` (
  `id` int(11) NOT NULL,
  `min_cart_value` float NOT NULL DEFAULT 0,
  `del_charge` float NOT NULL DEFAULT 0,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `freedeliverycart`
--

INSERT INTO `freedeliverycart` (`id`, `min_cart_value`, `del_charge`, `store_id`) VALUES
(1, 1000, 20, 0),
(2, 2000, 40, 37);

-- --------------------------------------------------------

--
-- Table structure for table `id_types`
--

CREATE TABLE `id_types` (
  `type_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `id_types`
--

INSERT INTO `id_types` (`type_id`, `name`) VALUES
(1, 'Aadhar Card');

-- --------------------------------------------------------

--
-- Table structure for table `image_space`
--

CREATE TABLE `image_space` (
  `space_id` int(11) NOT NULL,
  `digital_ocean` int(11) NOT NULL,
  `aws` int(11) NOT NULL,
  `same_server` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `image_space`
--

INSERT INTO `image_space` (`space_id`, `digital_ocean`, `aws`, `same_server`) VALUES
(1, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `licensebox`
--

CREATE TABLE `licensebox` (
  `id` int(11) NOT NULL,
  `license` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `installed_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'inactive',
  `message` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `list_cart`
--

CREATE TABLE `list_cart` (
  `l_cid` int(11) NOT NULL,
  `l_vid` int(11) NOT NULL,
  `l_qty` int(11) NOT NULL,
  `l_uid` int(11) NOT NULL,
  `ord_by_photo_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mapbox`
--

CREATE TABLE `mapbox` (
  `map_id` int(11) NOT NULL,
  `mapbox_api` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `mapbox`
--

INSERT INTO `mapbox` (`map_id`, `mapbox_api`) VALUES
(1, 'pk.eyJ1IjogdffdCJhIjoiY2tzb2RiNndsM3BxMzJvb2RmZmNzZWZyNSJ9.zo7JmhVR5yqsRSvmyiXspw');

-- --------------------------------------------------------

--
-- Table structure for table `map_api`
--

CREATE TABLE `map_api` (
  `id` int(11) NOT NULL,
  `map_api_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `map_api`
--

INSERT INTO `map_api` (`id`, `map_api_key`) VALUES
(1, 'AIzaSyCg2IaYHAhKS3JEaOzwtjO8Y7iaA');

-- --------------------------------------------------------

--
-- Table structure for table `map_settings`
--

CREATE TABLE `map_settings` (
  `map_id` int(11) NOT NULL,
  `mapbox` int(11) NOT NULL,
  `google_map` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `map_settings`
--

INSERT INTO `map_settings` (`map_id`, `mapbox`, `google_map`) VALUES
(1, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `membership_bought`
--

CREATE TABLE `membership_bought` (
  `buy_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `mem_id` int(11) NOT NULL,
  `mem_start_date` date NOT NULL,
  `mem_end_date` date NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `buy_date` date NOT NULL,
  `paid_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_gateway` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'success'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `membership_plan`
--

CREATE TABLE `membership_plan` (
  `plan_id` int(11) NOT NULL,
  `image` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `plan_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `free_delivery` int(11) NOT NULL DEFAULT 0,
  `reward` int(11) NOT NULL DEFAULT 0,
  `instant_delivery` int(11) NOT NULL DEFAULT 0,
  `plan_description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `days` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL,
  `hide` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `membership_plan`
--

INSERT INTO `membership_plan` (`plan_id`, `image`, `plan_name`, `free_delivery`, `reward`, `instant_delivery`, `plan_description`, `days`, `price`, `hide`) VALUES
(1, '/images/coupon/2021-11-16/3d156563ec9bea6830340cb3dfeb6212.jpg', 'ffrfr', 1, 2, 1, '<h2 style=\"text-align:center\"><strong>Benefits of this&nbsp;membership plan</strong></h2>\r\n\r\n<ul>\r\n	<li><strong>Get 2x rewards points&nbsp;</strong><strong>for 30 days</strong><br />\r\n	you will be able to get 2x rewards point then a normal user if your cart value matches the crieteria.</li>\r\n	<li><strong>Get Instant Delivery for 30 days</strong><br />\r\n	you will be able to get instant/same day delivery</li>\r\n	<li><strong>Get free Delivery&nbsp;for 30 days</strong><br />\r\n	you will be able to get free delivery on any order</li>\r\n</ul>', 30, 100, 0);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_01_07_073615_create_tagged_table', 1),
(2, '2014_01_07_073615_create_tags_table', 1),
(3, '2016_06_29_073615_create_tag_groups_table', 1),
(4, '2016_06_29_073615_update_tags_table', 1),
(5, '2021_02_26_153036_create_jobs_table', 2),
(14, '2014_10_12_000000_create_users_table', 3),
(15, '2014_10_12_100000_create_password_resets_table', 3),
(16, '2016_06_01_000001_create_oauth_auth_codes_table', 3),
(17, '2016_06_01_000002_create_oauth_access_tokens_table', 3),
(18, '2016_06_01_000003_create_oauth_refresh_tokens_table', 3),
(19, '2016_06_01_000004_create_oauth_clients_table', 3),
(20, '2016_06_01_000005_create_oauth_personal_access_clients_table', 3),
(21, '2019_08_19_000000_create_failed_jobs_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `minimum_maximum_order_value`
--

CREATE TABLE `minimum_maximum_order_value` (
  `min_max_id` int(100) NOT NULL,
  `min_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `minimum_maximum_order_value`
--

INSERT INTO `minimum_maximum_order_value` (`min_max_id`, `min_value`, `max_value`, `store_id`) VALUES
(1, '100', '2000', 38),
(2, '200', '5000', 37),
(3, '200', '5000', 40),
(5, '100', '10000', 43),
(6, '100', '10000', 44);

-- --------------------------------------------------------

--
-- Table structure for table `msg91`
--

CREATE TABLE `msg91` (
  `id` int(11) NOT NULL,
  `sender_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `msg91`
--

INSERT INTO `msg91` (`id`, `sender_id`, `api_key`, `active`) VALUES
(1, 'GOGRCR', '1970Lo360194030P1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notificationby`
--

CREATE TABLE `notificationby` (
  `noti_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sms` int(11) NOT NULL,
  `app` int(11) NOT NULL,
  `email` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('00083c02f16a192fb7420243f8906043f58a873ef9ca230d9198390454efe0d8d98bb521c9f29489', 2, 1, 'token', '[]', 0, '2021-06-10 13:54:41', '2021-06-10 13:54:41', '2022-06-10 13:54:41'),
('0023f9b34fccf14329f8cfca962e51edc277f5486d5859f211f141b454cfb5df9f167eedfceaf949', 48, 1, 'token', '[]', 0, '2021-11-20 09:36:04', '2021-11-20 09:36:04', '2022-11-20 09:36:04'),
('0029b45ad755ef8bf278ff9e2a2c27ca426063641bbc72e91c6a0b60940f3efffa8cfd6d2098312e', 2, 1, 'token', '[]', 0, '2021-11-24 11:40:51', '2021-11-24 11:40:51', '2022-11-24 11:40:51'),
('002bcce466c60ba9a0db463da301bff7397a95ad8c226f0a1b4c0302e34c047a5caf7c3f2a6a8422', 50, 1, 'token', '[]', 0, '2021-11-19 12:57:00', '2021-11-19 12:57:00', '2022-11-19 12:57:00'),
('00391c93ac04a39e18a1f6ff0c60cfc5091d8e276cd57fbd9f64797b79110263bf32635dd2035899', 50, 1, 'token', '[]', 0, '2021-11-18 16:53:37', '2021-11-18 16:53:37', '2022-11-18 16:53:37'),
('003bfb5727e146b7253e599590f80d64193f8c2cbd3305eae61549fd8d92266594a92ca6c85221a8', 2, 1, 'token', '[]', 0, '2021-11-25 10:29:53', '2021-11-25 10:29:53', '2022-11-25 10:29:53'),
('00803e084a48a51e56efd5f0f3645f128130dcaa3598488ee952a0d68504784a6f3fb54022db19ee', 68, 1, 'token', '[]', 0, '2021-12-14 10:57:22', '2021-12-14 10:57:22', '2022-12-14 10:57:22'),
('00aa54710ea97228d866ecb7db2c3f651e1cd439e0b9b8725c4eb787a79865f42fca2bcc662c8d06', 68, 1, 'token', '[]', 0, '2021-12-14 10:34:48', '2021-12-14 10:34:48', '2022-12-14 10:34:48'),
('016b7b8809c13862f4a23a82c71f80ef6a2987dccb1447c0e1483c7ac9d80a420345e2442331480b', 2, 1, 'token', '[]', 0, '2021-12-04 14:15:17', '2021-12-04 14:15:17', '2022-12-04 14:15:17'),
('01ea6e2aeca9528e81df65f59108f10f4fe3b9b19da31bad5040beb501ecc41731c8e90f95e83d84', 76, 1, 'token', '[]', 0, '2021-12-03 12:25:48', '2021-12-03 12:25:48', '2022-12-03 12:25:48'),
('0235c28d31843b0fb515f945cf14542e0a96eaf45ff30a30c99e26ca300f3fbf4c440ad4af5f4b55', 37, 1, 'token', '[]', 0, '2021-11-18 10:21:15', '2021-11-18 10:21:15', '2022-11-18 10:21:15'),
('0251de3a81f5c1d6e061bae4bbd0aec60d40dfeb47e909477e4e8b2ea0a4831c29065bff332297b1', 2, 1, 'token', '[]', 0, '2021-06-16 18:48:03', '2021-06-16 18:48:03', '2022-06-16 18:48:03'),
('026d88a7f5293037a5c1d51edae9fa2817adcaf0be487f166ada39c4cdc425829c6d8ab9c6b4d521', 80, 1, 'token', '[]', 0, '2021-12-21 17:36:12', '2021-12-21 17:36:12', '2022-12-21 17:36:12'),
('027cf40b0e4bd4e602d894b84ad95cfdf5852f37bb1ef96c65675e4e5410525ace9b7991e76d11f2', 50, 1, 'token', '[]', 0, '2021-11-22 09:59:25', '2021-11-22 09:59:25', '2022-11-22 09:59:25'),
('0285743eb24536bb4334d78fa9770808bc8f9ca80594e28a306ede11e620bf847fb2248ac834e862', 50, 1, 'token', '[]', 0, '2021-12-02 11:13:55', '2021-12-02 11:13:55', '2022-12-02 11:13:55'),
('02a8f4409dda4df2e37de13bf6c73d31c913e05c944ad2722a940b4399f6adb8f3b99dc5ce168deb', 48, 1, 'token', '[]', 0, '2021-11-20 10:50:17', '2021-11-20 10:50:17', '2022-11-20 10:50:17'),
('02b09b1c1fb8170c44b2eeb40e3a0a5a2c49e08ad518c413a45933bd6a73400254c074683081b06e', 2, 1, 'token', '[]', 0, '2021-11-30 10:25:49', '2021-11-30 10:25:49', '2022-11-30 10:25:49'),
('02c250c0a92691126c66ee80c0fc87313621322db7d6c0231b4944fc6d9bb8b78cdcd190b0090095', 2, 1, 'token', '[]', 0, '2021-12-02 15:07:36', '2021-12-02 15:07:36', '2022-12-02 15:07:36'),
('02cb6c55b8b9d52e8f7ceb5c4d0ead0ce6656d7348a374fad4fc4aaae2b8f6b656f7b802cd05b46d', 2, 1, 'token', '[]', 0, '2021-12-16 10:48:27', '2021-12-16 10:48:27', '2022-12-16 10:48:27'),
('035592cb3fb88216fc8fda697ce599fa149051811e1abd7d85e7ca722a66064ce03bc90f9fd745fc', 2, 1, 'token', '[]', 0, '2021-06-22 09:26:48', '2021-06-22 09:26:48', '2022-06-22 09:26:48'),
('03666a5d753686eb325461d0d8b57a0e517ac9bc50534ea64a68f30fb5bb4181cc91946deebe8de9', 68, 1, 'token', '[]', 0, '2021-12-02 15:45:17', '2021-12-02 15:45:17', '2022-12-02 15:45:17'),
('037e5d4a9a528006996eb888326dd27a4e4d1de5bb22a5100f9ce0ab4f3ea973cb0fc1078ad234ad', 80, 1, 'token', '[]', 0, '2021-12-09 18:37:13', '2021-12-09 18:37:13', '2022-12-09 18:37:13'),
('03b09c28bdecb6a5260f25176a92c22b8dfc5c562baaf76211f46f9e43189927b5c12993ccde720a', 2, 1, 'token', '[]', 0, '2021-12-10 16:24:38', '2021-12-10 16:24:38', '2022-12-10 16:24:38'),
('03c6c9eed905a486c152fbff8c18b862906083e5b447f0206301d101425ac3bae3eaf369cfcc4d5f', 50, 1, 'token', '[]', 0, '2021-12-03 12:27:32', '2021-12-03 12:27:32', '2022-12-03 12:27:32'),
('03c9e3495c87fd8b8a478a4b3cc2470a96e009a2d6a1c23b939aacd0aca307ee91b4cb73068064ed', 2, 1, 'token', '[]', 0, '2021-12-04 10:49:07', '2021-12-04 10:49:07', '2022-12-04 10:49:07'),
('048010248e0d62c59a85e14320e9c72a986ddd5fe95f0aa87c965a7bafa8f0557240fc831eeccfac', 37, 1, 'token', '[]', 0, '2021-11-15 16:19:29', '2021-11-15 16:19:29', '2022-11-15 16:19:29'),
('04a9bf951c2988499eb5b5755355387ab22d51acf55a9b5c040aff07de4a1254745a4ba77d568ec3', 80, 1, 'token', '[]', 0, '2021-12-16 16:30:12', '2021-12-16 16:30:12', '2022-12-16 16:30:12'),
('04aa05aa4d0424b7261ebfe82525726bb4b0a3f84d217ce69bbe30b0572833a467881f5da3a6bdd6', 2, 1, 'token', '[]', 0, '2021-11-12 16:53:14', '2021-11-12 16:53:14', '2022-11-12 16:53:14'),
('04d4f55c526338d190d4be3806d1b41af883ead7b02f5878cbcfa79ccbd15b707a0043087a197e63', 2, 1, 'token', '[]', 0, '2021-12-13 18:35:50', '2021-12-13 18:35:50', '2022-12-13 18:35:50'),
('0504591b798ddae605d7c368a26f08c6cc46e0b2ee127e737fb97091825a99e377bf909659be2c88', 50, 1, 'token', '[]', 0, '2021-11-30 19:23:01', '2021-11-30 19:23:01', '2022-11-30 19:23:01'),
('051bf32fd72eb2973bfa0b5ac774dea499d18051e973305c8e0e0b572586f7de847d9b46262af0e9', 50, 1, 'token', '[]', 0, '2021-12-03 13:02:42', '2021-12-03 13:02:42', '2022-12-03 13:02:42'),
('052df9e73c202340637fc485163f71b0c100da9a1e6ebf9894cf7c3246365b0f9c03c9c7cd7e8fad', 50, 1, 'token', '[]', 0, '2021-12-03 10:49:59', '2021-12-03 10:49:59', '2022-12-03 10:49:59'),
('05419191d75b3c4610591d4fd4b2fd52b8f2e1a2c91bba8f9e27c8bce0c0bf15c7015eef78e0f378', 37, 1, 'token', '[]', 0, '2021-11-18 11:13:40', '2021-11-18 11:13:40', '2022-11-18 11:13:40'),
('0583f8c679dbd946cd88b0c5bad01a3fe29f69b4bd2cac99640a3f4f912bfe540ce386bf5b1033c6', 50, 1, 'token', '[]', 0, '2021-11-24 16:54:50', '2021-11-24 16:54:50', '2022-11-24 16:54:50'),
('05939ca89f11438df9fc5f296dc7df585a38f399cd37e2c276d543dd3193cce434eea89ad4c3ac9c', 61, 1, 'token', '[]', 0, '2021-12-01 11:08:24', '2021-12-01 11:08:24', '2022-12-01 11:08:24'),
('05dc687a8f60ceea6a4f4462fe975439adb2119851337c344b1da3302e783179ee50ff41d5242c63', 50, 1, 'token', '[]', 0, '2021-12-01 10:47:38', '2021-12-01 10:47:38', '2022-12-01 10:47:38'),
('05fa9d69fad11051d37d29fd0c83326e6c0383f26afe12d186e5e592d9ccd50c7acd4f21e812debd', 80, 1, 'token', '[]', 0, '2021-12-16 18:50:42', '2021-12-16 18:50:42', '2022-12-16 18:50:42'),
('06070f7e1d8ebe62bf973280dc2eb7a5587253ed3c830b1c27273a8340dbbda9bd2160bf0ce9d56b', 50, 1, 'token', '[]', 0, '2021-11-29 13:58:40', '2021-11-29 13:58:40', '2022-11-29 13:58:40'),
('064a74a7a2bfa854bc3277be96ec05bf399c57aa4ad3cdd1a2984584fdca8818347c2c1bf2a764c6', 2, 1, 'token', '[]', 0, '2021-11-30 18:45:01', '2021-11-30 18:45:01', '2022-11-30 18:45:01'),
('065454f1243f277c5c18ab61aa16c2746d426e739eabafe2e0cfb131248be0f136b826fbfeb6f18e', 2, 1, 'token', '[]', 0, '2021-12-06 16:05:07', '2021-12-06 16:05:07', '2022-12-06 16:05:07'),
('0701a55bdbd3840df79b01e552f86c1d25c59d53af4fc761cd01a5dff119389fa60dbdab35d8c02e', 37, 1, 'token', '[]', 0, '2021-11-18 09:39:12', '2021-11-18 09:39:12', '2022-11-18 09:39:12'),
('07548567119df6c52f6da23fd8c1e840f7b3b6cd672eee3b8750a1a52b25bbe519c30a97a9de6ee6', 2, 1, 'token', '[]', 0, '2021-12-06 15:51:42', '2021-12-06 15:51:42', '2022-12-06 15:51:42'),
('076673ab8d87fc5caa4f701d3a52c07c07705623f94ea7ecbe8b7aadea9847ef6305724454dd316f', 2, 1, 'token', '[]', 0, '2021-12-13 09:43:55', '2021-12-13 09:43:55', '2022-12-13 09:43:55'),
('077b8abe628b535499514a95aa95255459533d2680d1cf7ca39eb313a5c6c446e8f691b94f1de19c', 50, 1, 'token', '[]', 0, '2021-11-29 16:25:03', '2021-11-29 16:25:03', '2022-11-29 16:25:03'),
('078d8dff14d42cf2d917c2b6f76ad4611d0c59dacf98d8fce3fc170ca28cecb626b3b8ca969f895f', 2, 1, 'token', '[]', 0, '2021-11-30 12:27:25', '2021-11-30 12:27:25', '2022-11-30 12:27:25'),
('07a5d0593d7613086238644b2f991508d67173d557d1d0c1add4babfef014d551747de437255dda8', 50, 1, 'token', '[]', 0, '2021-11-30 12:02:57', '2021-11-30 12:02:57', '2022-11-30 12:02:57'),
('07b8b57a066575099869125097816bd36d083e0c5379f373e2aa17787cd6ceacb687e496b7808259', 2, 1, 'token', '[]', 0, '2021-12-17 15:33:29', '2021-12-17 15:33:29', '2022-12-17 15:33:29'),
('07e301f954c59eff9ed580fa6987c51b03931b673ec2f0bcd952bb9916466a38d7f2401ebf1fb5f7', 80, 1, 'token', '[]', 0, '2021-12-21 10:21:16', '2021-12-21 10:21:16', '2022-12-21 10:21:16'),
('083ce357e044463aa06c2b0ffdeb60db08879d2d5b69679d4b2b09e7b32216b79cc8b0a9b2813684', 2, 1, 'token', '[]', 0, '2021-06-17 11:25:29', '2021-06-17 11:25:29', '2022-06-17 11:25:29'),
('085928f7978e1304f61645c7dcf69fd07dc75272ffce2d937236d7270f027a3f5ebff54aae22746d', 51, 1, 'token', '[]', 0, '2021-11-19 14:13:58', '2021-11-19 14:13:58', '2022-11-19 14:13:58'),
('088a14b0f99610d881003fb679911669c4aacc42979d32ccf2da8d23bf8762caa91c34d367d887cd', 37, 1, 'token', '[]', 0, '2021-11-18 09:47:08', '2021-11-18 09:47:08', '2022-11-18 09:47:08'),
('088c0dd0209201b73bdd8aae165359319b25418d8c33aa9f1969ead6ef9f8f43ed12a928d6530992', 80, 1, 'token', '[]', 0, '2021-12-04 18:39:56', '2021-12-04 18:39:56', '2022-12-04 18:39:56'),
('089348b505049cc715421235dc3f0e6d2894aade89d675fb5f6cfb151f7118af12db1e5ac388a233', 2, 1, 'token', '[]', 0, '2021-12-16 17:41:29', '2021-12-16 17:41:29', '2022-12-16 17:41:29'),
('08a5c62c529e4212bd53e55eb12b9818fc4dcacd8d7ce9a6ea6b1851a4bd5c70c1ca3ba4ad52b745', 2, 1, 'token', '[]', 0, '2021-12-14 10:14:52', '2021-12-14 10:14:52', '2022-12-14 10:14:52'),
('08c4a78b913af22298f132e4ebead6023c009cc9ae2f17c539dd22264617bf94fe5cdb4b2fb46e34', 80, 1, 'token', '[]', 0, '2021-12-21 12:07:46', '2021-12-21 12:07:46', '2022-12-21 12:07:46'),
('08d0bde9562f783b19dc9f0b01a3d7b0bf0521b92b09333c0552ce364b9b5964cf9cea23acae288b', 50, 1, 'token', '[]', 0, '2021-11-30 19:30:54', '2021-11-30 19:30:54', '2022-11-30 19:30:54'),
('090ddb1aa2ecb804bf54e082c70b99f550fd8d55d57471fae750dfcd62989ae7279bc842f710fd9a', 2, 1, 'token', '[]', 0, '2021-06-22 14:36:50', '2021-06-22 14:36:50', '2022-06-22 14:36:50'),
('09192d5916c0dda236c6e58d2a6c276d13268e607cdc0956260bcd04b1eb572acd602a4378e2dede', 2, 1, 'token', '[]', 0, '2021-06-10 08:19:07', '2021-06-10 08:19:07', '2022-06-10 08:19:07'),
('093e035bbcefcc9fa10947a843fd6839593219af3c1cae8569fb382e2e1adbbc95f45c751b850ccc', 37, 1, 'token', '[]', 0, '2021-11-18 10:54:01', '2021-11-18 10:54:01', '2022-11-18 10:54:01'),
('09d5ab9b9a5c7f2ef864124f691babeb77b83799f7bf27617b47865aa4c0643633065757b0ba182e', 2, 1, 'token', '[]', 0, '2021-06-22 16:22:22', '2021-06-22 16:22:22', '2022-06-22 16:22:22'),
('09ddabf76da3e23121a86cc46d2e87cbe6b0a497bc8b36ef712f43933ce0a8d6eec70cfe2e4686d6', 2, 1, 'token', '[]', 0, '2021-12-14 10:25:23', '2021-12-14 10:25:23', '2022-12-14 10:25:23'),
('09f24d071164edccc7731c4e26394ef7f9ebd1d14ca39bca631e7d9ddb62923d6aee9e7bf2f1fce7', 68, 1, 'token', '[]', 0, '2021-12-03 13:16:09', '2021-12-03 13:16:09', '2022-12-03 13:16:09'),
('0a0e3cd066089849dee6bb411f6718bc3ac30aa04b138c8b90a27bce93e74c03596914ee93387ecc', 2, 1, 'token', '[]', 0, '2021-12-07 11:49:40', '2021-12-07 11:49:40', '2022-12-07 11:49:40'),
('0a1b0f25fde55adaa5cca10cec3b9b108e17e280592aca16c17f666189d44cade917cfb39f4e554c', 2, 1, 'token', '[]', 0, '2021-11-29 14:45:39', '2021-11-29 14:45:39', '2022-11-29 14:45:39'),
('0a4ca599f1a60775719a17b37b7ca8b4c347e8020096a8166413a2590175550e35c8233a82811846', 2, 1, 'token', '[]', 0, '2021-12-09 11:49:10', '2021-12-09 11:49:10', '2022-12-09 11:49:10'),
('0a831ccedad9c81155af96eec3ba135ae8255807f92951777116d84ee2c04c073122d6de2dec730d', 37, 1, 'token', '[]', 0, '2021-11-17 09:31:15', '2021-11-17 09:31:15', '2022-11-17 09:31:15'),
('0a8ee7e6c090ea55d8c66c2202bb3091f6a7581bb234a9f0bbc502d978df63e22ed1de2d5be08804', 80, 1, 'token', '[]', 0, '2021-12-08 12:26:26', '2021-12-08 12:26:26', '2022-12-08 12:26:26'),
('0ab4baeededd15b6902b51ba1c04bebf1d39b3d4bea29ec3c0d6da60783c5f70579840c46ab17c64', 50, 1, 'token', '[]', 0, '2021-11-18 16:30:54', '2021-11-18 16:30:54', '2022-11-18 16:30:54'),
('0b0620efbf0b6584aa0bc4090d0970f7421aa0f8a3f4a0f0b0a68ae70c3713d7687d942f2d482baf', 2, 1, 'token', '[]', 0, '2021-11-11 11:16:01', '2021-11-11 11:16:01', '2022-11-11 11:16:01'),
('0b43f65f31bedeb45e04190ab92361af937b36bb4561b96f24a263d45af197eecb5704ab339cd2b0', 2, 1, 'token', '[]', 0, '2021-12-09 17:06:35', '2021-12-09 17:06:35', '2022-12-09 17:06:35'),
('0b459361abd79a820db292498d2b6e9dcb0acff9187f96d74adf1dac200380acfef4e453f3b4ee9b', 80, 1, 'token', '[]', 0, '2021-12-21 14:24:13', '2021-12-21 14:24:13', '2022-12-21 14:24:13'),
('0b5f6ef047b9becdb971ec52ca2c8221f361b685b12700dba16408d66de5620f5be43c333d073aca', 50, 1, 'token', '[]', 0, '2021-12-02 16:34:10', '2021-12-02 16:34:10', '2022-12-02 16:34:10'),
('0b61e47ae42788f9ed805e56b01b2f92981b2ac45357a7d2b28c058cc60d5cb3f7307a3e3d3a9166', 2, 1, 'token', '[]', 0, '2021-06-11 17:13:19', '2021-06-11 17:13:19', '2022-06-11 17:13:19'),
('0b761e599bdb89fc8c6ba494e061c109f53f3c9cd64ce5761dd72c0784767f7d4a8748d4d47b49c5', 80, 1, 'token', '[]', 0, '2021-12-03 14:47:13', '2021-12-03 14:47:13', '2022-12-03 14:47:13'),
('0b8b616d3f1a0d565683b95c98e00d04a40ef781e8b12f5007e12b5cd471bad6752773418c27183d', 50, 1, 'token', '[]', 0, '2021-11-30 19:18:17', '2021-11-30 19:18:17', '2022-11-30 19:18:17'),
('0be59b7325549c2eb5328c5ac43568d114b61a99a72a03b60e02756931a2b557b88f681695c39be7', 37, 1, 'token', '[]', 0, '2021-11-18 10:22:56', '2021-11-18 10:22:56', '2022-11-18 10:22:56'),
('0c64dd3668fd3acd5a52bfd6a4ade2c4ce9116bbe6c81c660cf4db692655daa12f88d04598139041', 68, 1, 'token', '[]', 0, '2021-12-21 15:36:05', '2021-12-21 15:36:05', '2022-12-21 15:36:05'),
('0c7534ff37763d1d1e8a3fab1b5dd5e8d6d73b61a8f72aa0bbce1adade5229c31a5861cce4095845', 80, 1, 'token', '[]', 0, '2021-12-03 13:03:25', '2021-12-03 13:03:25', '2022-12-03 13:03:25'),
('0c7ce0cdba4be5960cb571ed8c9d29d1d24a5e7e374717701736b9dc1a22f58a7636437d0aef9394', 37, 1, 'token', '[]', 0, '2021-11-13 11:45:33', '2021-11-13 11:45:33', '2022-11-13 11:45:33'),
('0ccd9dff93053102248d37dee359aed671710ec78b317473461f87e8fa41164faa6a2b1c46643071', 50, 1, 'token', '[]', 0, '2021-11-30 12:42:09', '2021-11-30 12:42:09', '2022-11-30 12:42:09'),
('0d6a6d2193cf60bef2f35b7768a20cb297fbafb17c4cdbc0ffef4ced640f4ad1b6f060c83e69ca23', 2, 1, 'token', '[]', 0, '2021-12-09 12:02:45', '2021-12-09 12:02:45', '2022-12-09 12:02:45'),
('0d977d0649a3c6ebe995e59fcf49befc40335c51f655155ff8b915390a68ab1c04638e6e0cdcf904', 2, 1, 'token', '[]', 0, '2021-11-30 11:41:30', '2021-11-30 11:41:30', '2022-11-30 11:41:30'),
('0da2994f1145a5fe305b1a48e96371923e811a1d9567497a4bf358d217826c5da40093ab87e9930c', 2, 1, 'token', '[]', 0, '2021-11-30 11:58:47', '2021-11-30 11:58:47', '2022-11-30 11:58:47'),
('0daee7ef57dfee2782b33b809cb74c5af3557ca7e80adb2bd4855acc4ee85e067b8c35359b564cbf', 48, 1, 'token', '[]', 0, '2021-11-18 18:25:21', '2021-11-18 18:25:21', '2022-11-18 18:25:21'),
('0ddd7bdaf78cb1dfb6ebff25eeb62ca0c83746d36daa8745fbd19700b371b41b65ce78d5c94a1f2b', 48, 1, 'token', '[]', 0, '2021-11-19 12:46:25', '2021-11-19 12:46:25', '2022-11-19 12:46:25'),
('0de82cbf1b0c60a1391aa5e6534e2e6f799dd907c39364092581753f1c61580ee7a4b3b587d8d413', 2, 1, 'token', '[]', 0, '2021-06-09 09:55:37', '2021-06-09 09:55:37', '2022-06-09 09:55:37'),
('0def818140c000dcad0731f59bcd3b378d128e3246f3be9b13015aafda4b4512b4ff11aef46c86a5', 37, 1, 'token', '[]', 0, '2021-11-18 11:15:03', '2021-11-18 11:15:03', '2022-11-18 11:15:03'),
('0e17ae0a70ce746ad57413a630199dfdec0685d6ffcca8e84ccf2e38f16e1368d333c047579940f3', 50, 1, 'token', '[]', 0, '2021-11-30 15:34:16', '2021-11-30 15:34:16', '2022-11-30 15:34:16'),
('0e307061eac582f355435522893c39747beacb8ee06f496b57ec59a6e4b96bbfe465ffc907f3ef2a', 37, 1, 'token', '[]', 0, '2021-11-17 18:10:28', '2021-11-17 18:10:28', '2022-11-17 18:10:28'),
('0e4670792aa7d6d68bbb3a25f7dc057d341fbb8f925053d82193fff746052c8360e1b43951f04843', 2, 1, 'token', '[]', 0, '2021-11-30 16:45:03', '2021-11-30 16:45:03', '2022-11-30 16:45:03'),
('0e5165aa26255fbe24931c90a28dbef269f01fc54381b82332da5d2b9c53d1319ff098bf4efd50e7', 37, 1, 'token', '[]', 0, '2021-11-18 10:43:18', '2021-11-18 10:43:18', '2022-11-18 10:43:18'),
('0ecfd915b933d1d09996fa9c236ca9f58e1de113a031e365f72e6ec089800bf18881db15ca1466dd', 80, 1, 'token', '[]', 0, '2021-12-03 13:37:13', '2021-12-03 13:37:13', '2022-12-03 13:37:13'),
('0efa150147bd45b1b1b9e083e7386e453d698ef1dd3dbefc830f651f3b9e6e3ccbaf17e3f2ca4aac', 2, 1, 'token', '[]', 0, '2021-11-11 11:26:09', '2021-11-11 11:26:09', '2022-11-11 11:26:09'),
('0f004c0fb133eb13652d5d0479d39769f008e3b5d6e264fc7c68f10c470ad8d9914c8dfa3d37b26b', 80, 1, 'token', '[]', 0, '2021-12-03 14:11:40', '2021-12-03 14:11:40', '2022-12-03 14:11:40'),
('0f3bf60f8192b63cfdb2cb58836b1b3308fc2eaea3bcf7479cef1f381230a54140a8aee1f52fd701', 2, 1, 'token', '[]', 0, '2021-11-29 14:50:52', '2021-11-29 14:50:52', '2022-11-29 14:50:52'),
('0f448c7c0420b89a7e3fde0b640e301bd4ab6b15cbfef7f5a3712ffdd90ab2f881a0c8e36769ad0a', 37, 1, 'token', '[]', 0, '2021-11-13 09:59:36', '2021-11-13 09:59:36', '2022-11-13 09:59:36'),
('0f644e3e1941002fcde8d18acb5b192392754fed9780436d675db964f3845c5a9852ef388de0e1ba', 2, 1, 'token', '[]', 0, '2021-11-27 11:28:10', '2021-11-27 11:28:10', '2022-11-27 11:28:10'),
('0f77cf9a70efa44adc810a4802b006ed241039e3483d2b966fcade11b6a743cc1977fb72f1efaaf2', 50, 1, 'token', '[]', 0, '2021-12-03 12:52:01', '2021-12-03 12:52:01', '2022-12-03 12:52:01'),
('0f995f63fda70fc8eef2adb066ab5f06227bf9d5009fae37bf0b3d8455225a47a2a2dea150826cd3', 50, 1, 'token', '[]', 0, '2021-11-20 11:38:16', '2021-11-20 11:38:16', '2022-11-20 11:38:16'),
('0fe9907e6470439f88f2e0bc287ee2a576a4fd875c501ec2871a2156b6329ca5bf9632432a1231d5', 2, 1, 'token', '[]', 0, '2021-12-03 18:07:04', '2021-12-03 18:07:04', '2022-12-03 18:07:04'),
('100694dc2205dd46fc730b1a55db0408431fab8f7a255976bf8ff0e98a1f48d27e6150d657f16412', 37, 1, 'token', '[]', 0, '2021-11-18 12:53:21', '2021-11-18 12:53:21', '2022-11-18 12:53:21'),
('100f3bef600e0c75e257993476a72b8260de13e36da41243f71dce2d2aff4ce83bc18c4e467185d3', 2, 1, 'token', '[]', 0, '2021-12-07 18:11:37', '2021-12-07 18:11:37', '2022-12-07 18:11:37'),
('1012964dc743e6bb977264a8724c2b11d10e85b047b226a6cc32d9e5e0ceaf2126c2b2cbfa6dbe80', 50, 1, 'token', '[]', 0, '2021-12-02 17:05:15', '2021-12-02 17:05:15', '2022-12-02 17:05:15'),
('10130d37f4e9e8b52db97bedf89bf6b72254e6b774ee1a42baf628daa7e7c6804d85529f174818c8', 2, 1, 'token', '[]', 0, '2021-12-13 15:20:53', '2021-12-13 15:20:53', '2022-12-13 15:20:53'),
('10469744f18e5eb1f8364ae92ca4105bf78cd3ffbf22c9b962396335237bc83a0e04de08a3f110d4', 37, 1, 'token', '[]', 0, '2021-11-12 18:28:15', '2021-11-12 18:28:15', '2022-11-12 18:28:15'),
('1054ba12a7647846817d43654db03275d057fb928fd2a96a73906f9d1b13b64f9391c36630316262', 80, 1, 'token', '[]', 0, '2021-12-16 16:29:55', '2021-12-16 16:29:55', '2022-12-16 16:29:55'),
('10969648495f103f853494b92dd5aabe913c97f435b97c2139b87d70a3cb96c338aced4c396aaee2', 48, 1, 'token', '[]', 0, '2021-11-29 10:12:05', '2021-11-29 10:12:05', '2022-11-29 10:12:05'),
('109809459ede8809dc1e8ebfcf21579ec05f8e10619f3aecceb25877424dd40eaa19c84aa159881c', 2, 1, 'token', '[]', 0, '2021-12-16 16:59:40', '2021-12-16 16:59:40', '2022-12-16 16:59:40'),
('10a83d0da0174679342b2934fbd8e589aa3d1c2e2dc3c1abab5efa80e10d09aee4335e0a7b4f1a7e', 2, 1, 'token', '[]', 0, '2021-12-06 18:07:11', '2021-12-06 18:07:11', '2022-12-06 18:07:11'),
('10d8cfe042bba828483f7a785d27827fa1ab4be755ef7b1abb244e6e07036f077d6cbcf170356723', 2, 1, 'token', '[]', 0, '2021-12-07 18:29:22', '2021-12-07 18:29:22', '2022-12-07 18:29:22'),
('10dd607a20b62e880161fc4a7278a163f77c60f859054fd24fbbefc824db5a50b525244137075e1a', 2, 1, 'token', '[]', 0, '2021-12-13 10:36:37', '2021-12-13 10:36:37', '2022-12-13 10:36:37'),
('11335e17af7e6a4fbb41fa5ee8839dadaa4d846ca5f60c2b8d9c67e7a3317e9a94ade8f3cdfa6f6f', 2, 1, 'token', '[]', 0, '2021-12-13 14:23:06', '2021-12-13 14:23:06', '2022-12-13 14:23:06'),
('113ee5ad881eeef59ea2ea89595c25718722683d7bdf092750c6ac536a63b8dbb4b39ea043dbab68', 93, 1, 'token', '[]', 0, '2021-12-08 13:25:05', '2021-12-08 13:25:05', '2022-12-08 13:25:05'),
('1149b6406fe029d2d913b99775854186d36f68f2edeb3b3c3bd47bad3c1cec213aebb184a2a058d1', 2, 1, 'token', '[]', 0, '2021-12-13 09:38:53', '2021-12-13 09:38:53', '2022-12-13 09:38:53'),
('119e2cff1820a8cdb11b1ed6258ca38b2dd3ff3bf8d88bba9bce43a51a75bc8ff8db3f6c5c60ae02', 80, 1, 'token', '[]', 0, '2021-12-03 18:19:36', '2021-12-03 18:19:36', '2022-12-03 18:19:36'),
('11aeaaaf438fa7e3036115a3f31b299dbc2caa322096ba0bc7292786f0d73ae3b49be5f1b5cd4ed5', 2, 1, 'token', '[]', 0, '2021-11-26 16:18:11', '2021-11-26 16:18:11', '2022-11-26 16:18:11'),
('11e9cae31fa027a14ae302c7899726ac2e0b2857a5c5593237fc0114ea04911ca65f881838bd4ab3', 50, 1, 'token', '[]', 0, '2021-12-02 18:03:20', '2021-12-02 18:03:20', '2022-12-02 18:03:20'),
('11f55b29c283373846b4cbc2fea950ecf458f2bbc4b12e700a6033e9eeda82c609f404fb71153bf8', 50, 1, 'token', '[]', 0, '2021-12-03 12:55:36', '2021-12-03 12:55:36', '2022-12-03 12:55:36'),
('11ff1a1b9c8bc9efceb98a801b7199a21f706ba5efbda03982351b8b04bc036ef69e920c3cd13a67', 48, 1, 'token', '[]', 0, '2021-11-29 10:02:46', '2021-11-29 10:02:46', '2022-11-29 10:02:46'),
('121f8f5b66762da42617579496c517dbc9aa17adc6007ce2b8555d0e70f64e80ac8fcc24c0a934ad', 37, 1, 'token', '[]', 0, '2021-11-17 18:20:38', '2021-11-17 18:20:38', '2022-11-17 18:20:38'),
('122f9cb16d7fb20e5803e03d00296c9b6e49372fb3262b0b0f1c70073f5f1de774768a446d4174cc', 37, 1, 'token', '[]', 0, '2021-11-17 17:40:44', '2021-11-17 17:40:44', '2022-11-17 17:40:44'),
('123ff8a563fb7f2211ef562e377521c8588f4407a0f8d1303f25e3918a0ec6817bd0939e126150c1', 50, 1, 'token', '[]', 0, '2021-12-02 16:47:46', '2021-12-02 16:47:46', '2022-12-02 16:47:46'),
('125f5815513bde6f0faea2a185cdbbe0cbf7143471fa82b1236afb9fed19593e6d4cb40e0e4cc75f', 37, 1, 'token', '[]', 0, '2021-11-18 10:55:10', '2021-11-18 10:55:10', '2022-11-18 10:55:10'),
('1269b40ecf9a9e75cef1f8e4ed1fd0472516b34da22e522c25f13255899f7fa0d7a1e2314e9636f0', 37, 1, 'token', '[]', 0, '2021-11-17 12:54:32', '2021-11-17 12:54:32', '2022-11-17 12:54:32'),
('126e1ac14398b6d4322a371bdea8cb74133fb748b9e9346bc4996fa728825b39e78d338ce9ca1ceb', 80, 1, 'token', '[]', 0, '2021-12-06 10:24:21', '2021-12-06 10:24:21', '2022-12-06 10:24:21'),
('1286e5fe9b9a3c8ad55d8cbaa1b8e1c0c0eb1cfc425850eafbff28917c08e68624c925a6aed4bc3d', 50, 1, 'token', '[]', 0, '2021-12-21 15:19:20', '2021-12-21 15:19:20', '2022-12-21 15:19:20'),
('129196e51937b2ca496d7c2bdf69f59fe32d5d6c9478873a739562efa5e0c1def480613368cd92c5', 2, 1, 'token', '[]', 0, '2021-11-02 17:59:28', '2021-11-02 17:59:28', '2022-11-02 17:59:28'),
('12be1416853fd23460c9f29307debb45a4371f8079a870edc3b2adef968e9001f6547e9717c7a3f9', 48, 1, 'token', '[]', 0, '2021-11-19 17:41:51', '2021-11-19 17:41:51', '2022-11-19 17:41:51'),
('1318a080e0fe7066707abb67b94f0415c351d37dc670306e701ed942affa80d9ddaa502882885aed', 50, 1, 'token', '[]', 0, '2021-11-20 14:47:17', '2021-11-20 14:47:17', '2022-11-20 14:47:17'),
('131c7e53db67d63be791e8a3a1b77f1bcc196e78a7f29e12f9ff1c9f61c358aa5e1746aa5323381a', 2, 1, 'token', '[]', 0, '2021-11-20 10:08:45', '2021-11-20 10:08:45', '2022-11-20 10:08:45'),
('13370e983e10fed8dcc2641134f45af02e48ae9bc81405b875be0135f26e3c8c316e282a60ac6d7d', 2, 1, 'token', '[]', 0, '2021-11-26 17:56:12', '2021-11-26 17:56:12', '2022-11-26 17:56:12'),
('135b21342cc56607c23d4092c16aeecfc0782840d064fa2f38ecb22ff3684bf5776bd0b92ec48401', 2, 1, 'token', '[]', 0, '2021-12-06 14:16:32', '2021-12-06 14:16:32', '2022-12-06 14:16:32'),
('137523838db66bd68702414d0bfdefe76d3d006db8c450bcabbe213a8d2cedfe5a4e49670c108690', 2, 1, 'token', '[]', 0, '2021-12-16 16:59:10', '2021-12-16 16:59:10', '2022-12-16 16:59:10'),
('138c6b1c8a757c8ca9c091876d869209e6746316474a0f5fe26c04e963ce2bc0513a28ed9f01f6de', 37, 1, 'token', '[]', 0, '2021-11-18 10:17:03', '2021-11-18 10:17:03', '2022-11-18 10:17:03'),
('13a1a05c67ea5ae212fe3bba63e9dab7cef125f6e79d135c7c85286ec6e8a65d18e8d996cbfbbc58', 50, 1, 'token', '[]', 0, '2021-11-30 18:54:41', '2021-11-30 18:54:41', '2022-11-30 18:54:41'),
('13b3e8ae0f4df1f352e28eb6ae78b4ef34d11e0ad967c358816151f96d1259fe85dcafe3a69ab884', 2, 1, 'token', '[]', 0, '2021-11-23 17:21:03', '2021-11-23 17:21:03', '2022-11-23 17:21:03'),
('13d84419803f26c868e7efa9f35aa474dbd8f4c2839e22db78ee243a272370aed49fac62e89d4c6a', 50, 1, 'token', '[]', 0, '2021-11-24 16:45:00', '2021-11-24 16:45:00', '2022-11-24 16:45:00'),
('13de0cb8fafe6fa7eaccc6eb6e5a7e9dac979904f6eeb21911bcf99a0a36a596f9f623b508959e4a', 37, 1, 'token', '[]', 0, '2021-11-18 09:38:29', '2021-11-18 09:38:29', '2022-11-18 09:38:29'),
('13e0c36519594dc2601951d8914317c1bc678ff70730278f69fa82276f6d640fc3ea4090cb14a29c', 2, 1, 'token', '[]', 0, '2021-12-07 18:10:50', '2021-12-07 18:10:50', '2022-12-07 18:10:50'),
('140180274a39edb362f34b095a60b08572f0e92cc648928b3a94180ef3998cb1bef5555d252e6c65', 2, 1, 'token', '[]', 0, '2021-12-04 18:04:27', '2021-12-04 18:04:27', '2022-12-04 18:04:27'),
('1403c99f38f52fb7f34bf792f44c521e0e79e1b9f539aac348f9a837c037932041887afe73467734', 37, 1, 'token', '[]', 0, '2021-11-19 18:32:41', '2021-11-19 18:32:41', '2022-11-19 18:32:41'),
('1412576280d2861f02f9e9a1722ca2a029b1f985af545f931fcac75c19bd282a85ae4fd0b7b0fa12', 2, 1, 'token', '[]', 0, '2021-12-16 16:53:21', '2021-12-16 16:53:21', '2022-12-16 16:53:21'),
('141316d2328735d614810cb8f72407bb69bdd7285f3e858b4c2fc18f08e660127ad095db83707bfc', 2, 1, 'token', '[]', 0, '2021-12-07 17:06:44', '2021-12-07 17:06:44', '2022-12-07 17:06:44'),
('1483763a7534c290bfa0545a0408c0223556c699b0dbd8103a49777eead0965a0c8e2980a0f8d169', 2, 1, 'token', '[]', 0, '2021-12-13 14:54:24', '2021-12-13 14:54:24', '2022-12-13 14:54:24'),
('1483fb5ca5e9a083ea39fef60b49f08abd6a182d882aedc18d573096ded3328d7c5c866b51233942', 2, 1, 'token', '[]', 0, '2021-11-22 14:12:22', '2021-11-22 14:12:22', '2022-11-22 14:12:22'),
('14957f524184c653d485b7dd2c277cc5f6b16e3002323e72076208b3846643181cd9f43f128168ec', 2, 1, 'token', '[]', 0, '2021-06-22 14:36:23', '2021-06-22 14:36:23', '2022-06-22 14:36:23'),
('14ace50cfac4464f505f32c2df3f86276c260ca8d71d9d8be6363add4b71ab4120e4cbba7c2d9cb8', 50, 1, 'token', '[]', 0, '2021-11-20 11:16:01', '2021-11-20 11:16:01', '2022-11-20 11:16:01'),
('14d525b2356ab7332e9f3a799134185be36b7d7b530694c7fb82a67df80175e2267ff0ba59c4f347', 2, 1, 'token', '[]', 0, '2021-06-15 12:55:48', '2021-06-15 12:55:48', '2022-06-15 12:55:48'),
('14ff080a52f82eb10603d62f3e4e0561281b5a6b817167b9bb9575374e65a6a59edbcdbe410c665b', 2, 1, 'token', '[]', 0, '2021-12-13 10:37:55', '2021-12-13 10:37:55', '2022-12-13 10:37:55'),
('157903833f9e4d83c3da3f42c0ae731c7e739c4f96d59af0cba5b004a38b689a04f63797cf0990e8', 50, 1, 'token', '[]', 0, '2021-11-20 16:42:26', '2021-11-20 16:42:26', '2022-11-20 16:42:26'),
('15a17441bc16c6b5d536f3ba17cbf159bbe926be0f9a51ecbec88c894d83e853a1d8ddd63cbf5346', 2, 1, 'token', '[]', 0, '2021-12-10 15:54:31', '2021-12-10 15:54:31', '2022-12-10 15:54:31'),
('15faeebc6d510fd432ff6664f5f35e438d22c70d208cfcb2023ec7142738d5e23f66d3af72e75fcb', 68, 1, 'token', '[]', 0, '2021-12-13 10:39:50', '2021-12-13 10:39:50', '2022-12-13 10:39:50'),
('1619da94bac67e4046dc2d9211b559af5ca3ae2694446ca81368bc2e275bc06d76a0c1c9af9568cf', 2, 1, 'token', '[]', 0, '2021-11-02 18:09:22', '2021-11-02 18:09:22', '2022-11-02 18:09:22'),
('16263cb5e446cb62d7b7d603823320b8780537029fb9d584a2a6e9ab46a49efdec7f30bd39580eaa', 2, 1, 'token', '[]', 0, '2021-11-02 14:38:53', '2021-11-02 14:38:53', '2022-11-02 14:38:53'),
('167100c0ef311bbe29a158d6a65eaaf7408964cfca762e032de6189b475321878e75101829c9e40d', 37, 1, 'token', '[]', 0, '2021-11-18 10:17:19', '2021-11-18 10:17:19', '2022-11-18 10:17:19'),
('16cabf264f28031762ee1825d357e76c13c34799021646cef5f1cbfa4f0c706ec43c04462e82cb43', 37, 1, 'token', '[]', 0, '2021-11-18 10:43:50', '2021-11-18 10:43:50', '2022-11-18 10:43:50'),
('16d55b13d52530f53310590037cee4b545f6ae389a586ed04822a1bbf8d44a44fa93d3908dff9412', 2, 1, 'token', '[]', 0, '2021-11-30 11:59:10', '2021-11-30 11:59:10', '2022-11-30 11:59:10'),
('16dc50284be83b0497cdc3bc7f67dd301e0a84aeac7107efbab5a36e08da625170e317d3154ed9eb', 93, 1, 'token', '[]', 0, '2021-12-08 13:25:40', '2021-12-08 13:25:40', '2022-12-08 13:25:40'),
('17069f81713b1b7017e3e25db773c67894ee10fb3b7b8c77e8693faa4ca4e917f875e391673bbae5', 50, 1, 'token', '[]', 0, '2021-12-02 17:44:53', '2021-12-02 17:44:53', '2022-12-02 17:44:53'),
('171e6a228d0328a8451fee68c50b789f05aa720121b74799737fceed4f1ce08be30cd581b292d72b', 2, 1, 'token', '[]', 0, '2021-12-07 17:39:53', '2021-12-07 17:39:53', '2022-12-07 17:39:53'),
('17326aba95427f528c64337ab089b215f15b34a5e004cb67c9e089d19de88b3dd6e869c987e47153', 37, 1, 'token', '[]', 0, '2021-11-13 12:24:54', '2021-11-13 12:24:54', '2022-11-13 12:24:54'),
('17488f8ecfc9b5cd9cc78dd9164c917488e4f789bb18874372855ed0e9917d627fae97d23d3c0fc6', 50, 1, 'token', '[]', 0, '2021-12-13 15:52:06', '2021-12-13 15:52:06', '2022-12-13 15:52:06'),
('1754f9eba79c569f1ba4c2f34d807ec2f4a73842356452a9ccef58fe3df3014785dd0ad4bdc7d332', 80, 1, 'token', '[]', 0, '2021-12-10 17:08:54', '2021-12-10 17:08:54', '2022-12-10 17:08:54'),
('175662e765fee3eea7a94f18cbf2cdfb72aabcdd3675e3ee9fa3a3b140ee54003289aba557aaa72e', 2, 1, 'token', '[]', 0, '2021-11-25 12:45:21', '2021-11-25 12:45:21', '2022-11-25 12:45:21'),
('175f40f3de13178733956be78e707f2808f87c8fc0099c1a37c2a70aeca4e56e88dbd01a666875de', 50, 1, 'token', '[]', 0, '2021-12-03 13:42:43', '2021-12-03 13:42:43', '2022-12-03 13:42:43'),
('1770c03825dae550762d4f5f682ddb55ea16b2a4d3e6821af29d67c82a03c25adbf781168e689307', 37, 1, 'token', '[]', 0, '2021-11-18 11:00:20', '2021-11-18 11:00:20', '2022-11-18 11:00:20'),
('178227ad695d0126ff7a77b022e94161613cfa4a0fafc0522507e081b06aa6c87b210da88efe49ac', 2, 1, 'token', '[]', 0, '2021-06-22 16:54:47', '2021-06-22 16:54:47', '2022-06-22 16:54:47'),
('178370ab4cbbb241c7313a76e13bfe795c0443b089b13ac51a140f403c7381ff8e4d7b3b39c594e9', 51, 1, 'token', '[]', 0, '2021-11-30 18:00:24', '2021-11-30 18:00:24', '2022-11-30 18:00:24'),
('178b3548eaa84d9fcd4ef60d4ffbb858f473b0b5b88a3dd9c5536d5c22e5e05294f6342256b2cca3', 68, 1, 'token', '[]', 0, '2021-12-14 10:56:33', '2021-12-14 10:56:33', '2022-12-14 10:56:33'),
('1795de2d0be1b152635216393ebafdf5e5ce0d25048340925b8418dcf2371166d113f50c671c3c25', 48, 1, 'token', '[]', 0, '2021-11-29 11:19:43', '2021-11-29 11:19:43', '2022-11-29 11:19:43'),
('17c3016f6b700b22bccfd0c545932579bbd1bbf159480ce7de4145df54332653334dbfe35c4844f8', 2, 1, 'token', '[]', 0, '2021-12-13 16:07:30', '2021-12-13 16:07:30', '2022-12-13 16:07:30'),
('17c5f6db0bfd114ed10f2f7de74b3a231b98c605b2654b9c0dba8b07c95e3bdc80c0cc4bd56cb544', 2, 1, 'token', '[]', 0, '2021-11-29 18:50:31', '2021-11-29 18:50:31', '2022-11-29 18:50:31'),
('17d2f6f3dca43b3dd35c951342592af13cd5c8922c2d180922c8633d1faf40bd223445b5ce4a8915', 50, 1, 'token', '[]', 0, '2021-11-19 12:57:26', '2021-11-19 12:57:26', '2022-11-19 12:57:26'),
('17f900808203c0e613fc2ac8411232c99c8437d9f9ce8793df1d5efd93f23f940fce66b3c2a6f2cd', 50, 1, 'token', '[]', 0, '2021-11-27 17:44:24', '2021-11-27 17:44:24', '2022-11-27 17:44:24'),
('185eae1bd577792b7fbf43bd14f42bd138a0a233003555435cd0fac471b0ce69aa98282c73b56950', 51, 1, 'token', '[]', 0, '2021-11-30 17:39:25', '2021-11-30 17:39:25', '2022-11-30 17:39:25'),
('1866ac8d4a030a514781457c47bd08a50370a334bcdea00b1f9267d41d45084da28de361e3a594dd', 80, 1, 'token', '[]', 0, '2021-12-03 14:47:34', '2021-12-03 14:47:34', '2022-12-03 14:47:34'),
('18e0ad7a2a44c9b2c196851a654fe65d90d0412a49fe2b2a697fd900554cb9338a6c8dc70247ce8c', 2, 1, 'token', '[]', 0, '2021-12-13 16:08:40', '2021-12-13 16:08:40', '2022-12-13 16:08:40'),
('18fd5330a446c2c017328004aaceb1a6f7120c36d81c221bee524df4fb56a59afb934d41764d5190', 2, 1, 'token', '[]', 0, '2021-06-16 16:58:45', '2021-06-16 16:58:45', '2022-06-16 16:58:45'),
('190230415513d3827a59df0db42f2d73e42103f6ee3b584a56b7dc46a7a9ec65229ff203a896df85', 50, 1, 'token', '[]', 0, '2021-12-01 11:28:03', '2021-12-01 11:28:03', '2022-12-01 11:28:03'),
('192eb367eb5a1a84e03e6af52c75398f34718376629c421d517ea3c721393c53aacdd5120acc19cc', 37, 1, 'token', '[]', 0, '2021-11-18 10:55:53', '2021-11-18 10:55:53', '2022-11-18 10:55:53'),
('1932b44ab5e1844b6e0b1129030d4a3106674e6b33bdd55c3e09d3cb42fec1d616a6de400f31cbe6', 2, 1, 'token', '[]', 0, '2021-12-08 15:14:07', '2021-12-08 15:14:07', '2022-12-08 15:14:07'),
('19342c99569d7b13e4d15c5a11f937bd5df8819c72d204d3a26449851ced37b707b465848bbe22de', 2, 1, 'token', '[]', 0, '2021-11-12 15:46:25', '2021-11-12 15:46:25', '2022-11-12 15:46:25'),
('19399c6e4c302b74ff070ab5273622f1cca6ed2f46659fb6436014e3b838236f1c28d68d7c4accd6', 50, 1, 'token', '[]', 0, '2021-12-02 09:37:48', '2021-12-02 09:37:48', '2022-12-02 09:37:48'),
('1945fa72c1b7d0f6cac57e84e103e68d4adddf384f41c5720f941c622a8db6a1e1d3e323005f81dc', 50, 1, 'token', '[]', 0, '2021-11-24 16:52:52', '2021-11-24 16:52:52', '2022-11-24 16:52:52'),
('196927531514fa84b49c08f18e08620ae704683e5e1ae1099fa565624056805f7faa1dd54e134550', 50, 1, 'token', '[]', 0, '2021-12-02 11:16:38', '2021-12-02 11:16:38', '2022-12-02 11:16:38'),
('1983014c19fb0663bbf105c9459a89d87b81e78f37e515b957db349d42e4576c1b5a6a5d9ddd7185', 2, 1, 'token', '[]', 0, '2021-11-29 18:09:06', '2021-11-29 18:09:06', '2022-11-29 18:09:06'),
('198a63653bec06d7d959ea61e261fd678ba5bf38a2c1089f63f797e966606010fcaece9b3aa5de2c', 2, 1, 'token', '[]', 0, '2021-12-10 16:04:54', '2021-12-10 16:04:54', '2022-12-10 16:04:54'),
('19b77d13f48ceb0ab3e1af85f40686d9d982a48d81c14f421c16af4f8514151995955fb605c06269', 2, 1, 'token', '[]', 0, '2021-12-14 11:40:07', '2021-12-14 11:40:07', '2022-12-14 11:40:07'),
('19c15537413339169cd5526b2649073fba5d49511ba3a8d94688dfdb7647ad9debfac370c6b17e43', 80, 1, 'token', '[]', 0, '2021-12-21 13:34:35', '2021-12-21 13:34:35', '2022-12-21 13:34:35'),
('19d3afaebda52603a87b017b405666479c62b7e592395fdc4660d03c8baae744c36ccdbc0466fd19', 50, 1, 'token', '[]', 0, '2021-12-14 15:32:55', '2021-12-14 15:32:55', '2022-12-14 15:32:55'),
('19ea7a06b6f36a80e8f5ea80616d924e22620e89bb51238224dad113c241901a39a46e4f44254509', 74, 1, 'token', '[]', 0, '2021-12-03 12:08:44', '2021-12-03 12:08:44', '2022-12-03 12:08:44'),
('1a09bfaf6b136f6c0984a74b30ceef74159ec9e543181e1b29ce8de61d292dfc1d74dbd793a1db68', 50, 1, 'token', '[]', 0, '2021-12-01 14:53:11', '2021-12-01 14:53:11', '2022-12-01 14:53:11'),
('1a2957480ed23d3703f80fb4628a7c564182b52b383bcccd4525cdd42f3c5c011ad34dcc3da85792', 50, 1, 'token', '[]', 0, '2021-12-13 14:19:43', '2021-12-13 14:19:43', '2022-12-13 14:19:43'),
('1a404f3eca08585aeeec3f76054eddccc094fae8298f01c785291e82f4ab8980bf9c2548ad6c7cfb', 50, 1, 'token', '[]', 0, '2021-12-13 17:53:47', '2021-12-13 17:53:47', '2022-12-13 17:53:47'),
('1a5221af9b7a7db72b23c3e13cd10d11deba9fdf2ca4caf83fa86701e0b7a62641de21bc3c9abfff', 50, 1, 'token', '[]', 0, '2021-11-20 14:47:24', '2021-11-20 14:47:24', '2022-11-20 14:47:24'),
('1a6142c7a820adf8304759a0773f3049f5143fba19d315fd36e61fbac3d0d81d664f471dbec525ea', 37, 1, 'token', '[]', 0, '2021-11-18 09:54:00', '2021-11-18 09:54:00', '2022-11-18 09:54:00'),
('1a70d161b2659989b3bdc32a415c9a5911e1d6d0da4e0226dcf23c7bfcd1f495c6ca1d927c9c5822', 2, 1, 'token', '[]', 0, '2021-12-07 18:14:35', '2021-12-07 18:14:35', '2022-12-07 18:14:35'),
('1a8d0b2b367c6ef6a75981853166ad49ba367ed20b003b0ee747a87a5e70aa52978359a1c9a214f0', 37, 1, 'token', '[]', 0, '2021-11-17 17:21:54', '2021-11-17 17:21:54', '2022-11-17 17:21:54'),
('1aa3f9dc8ebf5c4364f4a37f551e1db3bf1d9e8bd6f5a0e748fb7310795c9a475c29ed584389fc33', 2, 1, 'token', '[]', 0, '2021-12-16 10:43:39', '2021-12-16 10:43:39', '2022-12-16 10:43:39'),
('1ab4547e244fa41025355abccb7ee5a551c76206fa42e2ac4f82f4d37f1307bd12023ec410d6b6b8', 50, 1, 'token', '[]', 0, '2021-11-30 15:24:33', '2021-11-30 15:24:33', '2022-11-30 15:24:33'),
('1ac1c6209626039d1bca0e3c24b09f5226ab4865b370773795cc6eddcfa474670ef240ce9f91fa83', 107, 1, 'token', '[]', 0, '2021-12-10 11:30:17', '2021-12-10 11:30:17', '2022-12-10 11:30:17'),
('1b2064a9b9fb9b3cfe455be9c0b0b61e01455fd9b8d1f67d4e20df6666bb6ce13fbb9b36356a03aa', 2, 1, 'token', '[]', 0, '2021-12-17 12:51:32', '2021-12-17 12:51:32', '2022-12-17 12:51:32'),
('1ba2b4360bf9ec99b565199338c5587a00e984fe02eddd9e723c15a2396cfbcb9f03958d74e4981f', 68, 1, 'token', '[]', 0, '2021-12-03 13:15:57', '2021-12-03 13:15:57', '2022-12-03 13:15:57'),
('1bbb6b1f6a985051ec1993f5cf4eb1dd099fcd21b32661feb2ad871284d463e2865538a1679c1322', 2, 1, 'token', '[]', 0, '2021-12-10 17:04:45', '2021-12-10 17:04:45', '2022-12-10 17:04:45'),
('1bc0aab37b9c991d87370dc429c58d0b6a76b0c21754bcaead108512b347176b7d21c5e22a36b9fa', 48, 1, 'token', '[]', 0, '2021-11-29 12:23:52', '2021-11-29 12:23:52', '2022-11-29 12:23:52'),
('1c0adb927ff498c420a557b2a9cfc8edf87ec379396980209bb0b5941dc0290316f4467d767bdddb', 37, 1, 'token', '[]', 0, '2021-11-17 17:56:35', '2021-11-17 17:56:35', '2022-11-17 17:56:35'),
('1c0b869b24d53af8e1bb984bd60e191cc5fea6da8671597cab00f027d34fe3e85ed2932d4650907f', 2, 1, 'token', '[]', 0, '2021-06-10 08:53:46', '2021-06-10 08:53:46', '2022-06-10 08:53:46'),
('1c38f46e860eea47fc046a5484163d400b653d3b80b3017afbfbb92886d61b3291414414133127d7', 80, 1, 'token', '[]', 0, '2021-12-17 12:19:17', '2021-12-17 12:19:17', '2022-12-17 12:19:17'),
('1c4b06731d98474c51b823f3eb825ec22d27941279451804bc42fec9a9afca0fd4a845ba053d1e8d', 37, 1, 'token', '[]', 0, '2021-11-18 09:38:32', '2021-11-18 09:38:32', '2022-11-18 09:38:32'),
('1c7ad1361d3d0cbb3d714b2a1815703e79685e58765130d2fe1c81a9a2fb54db763eee80da4ab697', 37, 1, 'token', '[]', 0, '2021-11-18 15:59:12', '2021-11-18 15:59:12', '2022-11-18 15:59:12'),
('1c7e4f31a1f7bbe175d71f32403aabc4f37b5d1c33b06cb716ce622cd46e796ae931f14d88596296', 2, 1, 'token', '[]', 0, '2021-12-06 10:38:42', '2021-12-06 10:38:42', '2022-12-06 10:38:42'),
('1c9b780d4dd16a048e147a763457fe7ba768be233ddd3b14f01a8e66476e8a20daa7b9a7d81f7ac7', 2, 1, 'token', '[]', 0, '2021-11-26 17:56:08', '2021-11-26 17:56:08', '2022-11-26 17:56:08'),
('1c9dbe902c318d2ccc44bc29262c9d9be28c725810e213b6c82252302e32563e00d3ac4c4788da10', 37, 1, 'token', '[]', 0, '2021-11-18 09:38:35', '2021-11-18 09:38:35', '2022-11-18 09:38:35'),
('1ca41da25f01096842ef80aeadf9942244b8500b95b78a0bddc8a0cc3977d50bbf27d4b7d1e8ff3d', 50, 1, 'token', '[]', 0, '2021-11-29 12:38:44', '2021-11-29 12:38:44', '2022-11-29 12:38:44'),
('1d634d5c7fd070bf5075c6b59de92a028da7d369deb09df6d6f27337c240e2534ee1a2448e46f5b5', 80, 1, 'token', '[]', 0, '2021-12-06 11:25:13', '2021-12-06 11:25:13', '2022-12-06 11:25:13'),
('1d78ecf817460388cd9f9f96dcf1f0a7453995ff978af899cf6a745b8d747156c1adeed0df5a9b73', 2, 1, 'token', '[]', 0, '2021-12-08 14:16:42', '2021-12-08 14:16:42', '2022-12-08 14:16:42'),
('1d793267fabebf6ea1345d9fbfe23a298feb995f7117b4520ae3513e416d2cbe74c39aa4febe0a6e', 68, 1, 'token', '[]', 0, '2021-12-03 13:52:25', '2021-12-03 13:52:25', '2022-12-03 13:52:25'),
('1db6c1b314d10f11dda5ac997479b1519e06684cea14caba705c8217e7bf698dcb2703315231f775', 37, 1, 'token', '[]', 0, '2021-11-18 09:46:58', '2021-11-18 09:46:58', '2022-11-18 09:46:58'),
('1dbc918a0b712595a186e5685b4530faacf3948b35795e9bf5e8134ca0bc7f2f432857b40287b1d2', 2, 1, 'token', '[]', 0, '2021-12-07 17:58:56', '2021-12-07 17:58:56', '2022-12-07 17:58:56'),
('1dd126a577302a00db4cb988a1d931cd9cd85a751137bbb08d00e5da6ee120a9b2dcf99caf92c75e', 48, 1, 'token', '[]', 0, '2021-11-18 18:19:12', '2021-11-18 18:19:12', '2022-11-18 18:19:12'),
('1dfff4033e6a1f6160811e2935ef94a50a97d8a1f8fe561d913b6eced53ea0f796cc8491b05a1a74', 37, 1, 'token', '[]', 0, '2021-11-18 15:36:46', '2021-11-18 15:36:46', '2022-11-18 15:36:46'),
('1e38fc189f0f3d5650bbd0bb140522f73a0e86a485be7d1a8b6e0888be8e2c534b90882ba62f7fbe', 2, 1, 'token', '[]', 0, '2021-11-30 14:15:30', '2021-11-30 14:15:30', '2022-11-30 14:15:30'),
('1e72aff83cd51b8f2d9eb4cfad312928c06d9eba7a0fae6b623e316135985379320d718554ef2874', 50, 1, 'token', '[]', 0, '2021-11-20 14:57:45', '2021-11-20 14:57:45', '2022-11-20 14:57:45'),
('1e8b8a9bb496429ff3d980b6098a99917f8451a88cedacbb474d49536732ed510bc36c530eeb5a8b', 80, 1, 'token', '[]', 0, '2021-12-16 17:00:48', '2021-12-16 17:00:48', '2022-12-16 17:00:48'),
('1eb99820e8e482f26f83a2375aa94fd59534d1df069779ea7e13b4c04547cceaa1e304aed3df149c', 80, 1, 'token', '[]', 0, '2021-12-03 17:10:00', '2021-12-03 17:10:00', '2022-12-03 17:10:00'),
('1ecd544db8a4cc06dca55895ab6e4a9bdb1c99fb63934cf32dc5b51ede28f8cca808314e88f04bf5', 61, 1, 'token', '[]', 0, '2021-12-01 10:28:37', '2021-12-01 10:28:37', '2022-12-01 10:28:37'),
('1ee48c43f4ae08f0fd993b00acda59236a1e800cf7505cd757ed1f8094272d2f7fc2baf114cb1c37', 2, 1, 'token', '[]', 0, '2021-12-13 11:55:01', '2021-12-13 11:55:01', '2022-12-13 11:55:01'),
('1ef4283c699364be32ff770ab609c37422e40ea8137a2963545740d1c8368af95307ebb83fd8dccf', 2, 1, 'token', '[]', 0, '2021-11-26 17:57:38', '2021-11-26 17:57:38', '2022-11-26 17:57:38'),
('1ef65ab750a7d330d7df659926e9a248fdf26602afca6203770834bd79f31ee5ecc2ea1dd4574386', 2, 1, 'token', '[]', 0, '2021-11-29 10:28:50', '2021-11-29 10:28:50', '2022-11-29 10:28:50'),
('1f31597f525ef8553853581a0d45b3263fbcbb16828c3e7af55551a566e7fbfbbe658c0833b3429b', 80, 1, 'token', '[]', 0, '2021-12-10 19:23:31', '2021-12-10 19:23:31', '2022-12-10 19:23:31'),
('1f44ef5b1afb4bd2fef1002878cde6e07f8c70edd8cbb4073b3aeafab2032e0d13ad6db3b569e2e8', 80, 1, 'token', '[]', 0, '2021-12-07 10:18:41', '2021-12-07 10:18:41', '2022-12-07 10:18:41'),
('1f5535dd9c319479380e2b07aefb2fd016eab195d89a58e11225dacd4343050b16ee017dcdef9689', 50, 1, 'token', '[]', 0, '2021-11-30 15:03:06', '2021-11-30 15:03:06', '2022-11-30 15:03:06'),
('1fd7212910dad8e04aa6e9f78a295560fe732aa78ad73aa724910dfbf0e85858316ea25f202499ee', 50, 1, 'token', '[]', 0, '2021-11-30 13:02:56', '2021-11-30 13:02:56', '2022-11-30 13:02:56'),
('20014923905dd0253b87d1002b215cd095ab7f6a03fb435e65c6b8402df2ada57fce0fbe4b31475d', 50, 1, 'token', '[]', 0, '2021-12-02 12:25:56', '2021-12-02 12:25:56', '2022-12-02 12:25:56'),
('2038f89daa62d1db60ebad4d905435b77bc3558a7986b609d8c0f2feb83c6e58d7a0000c78cc1635', 2, 1, 'token', '[]', 0, '2021-12-07 17:59:04', '2021-12-07 17:59:04', '2022-12-07 17:59:04'),
('20749b8b588a4e31c7a72a9419627c607db44226b0d91cbade942436dfb0243e3a88ef4eec5f3904', 80, 1, 'token', '[]', 0, '2021-12-16 18:39:45', '2021-12-16 18:39:45', '2022-12-16 18:39:45'),
('20b127311933bf96205042197602e746dc21d723f4edb75561b1235eee56274679485294bdd3d1af', 37, 1, 'token', '[]', 0, '2021-11-13 12:32:31', '2021-11-13 12:32:31', '2022-11-13 12:32:31'),
('20d70b7041edcf30c900c648b6b8668cd3b2325b754ddd014f05c4a1bc424cc66caffd2447c75e8a', 50, 1, 'token', '[]', 0, '2021-11-30 18:48:00', '2021-11-30 18:48:00', '2022-11-30 18:48:00'),
('2143a38d97df9c139948ba87505489c96a9cb722ffb16d8aa99d2a9b7970cfa77a8b01950abe76ff', 2, 1, 'token', '[]', 0, '2021-12-07 12:35:21', '2021-12-07 12:35:21', '2022-12-07 12:35:21'),
('2149d3e183c783f39e4ad60b9c44108efe586a055abb0563cc4d57abf5af759d9ac7a51cc414831f', 37, 1, 'token', '[]', 0, '2021-11-15 09:36:50', '2021-11-15 09:36:50', '2022-11-15 09:36:50'),
('214f85e9a6dbd370d6ca7242739e72b5ca6091c95c5e7fb40243c56028d1b9750623edea7ea9447b', 2, 1, 'token', '[]', 0, '2021-12-04 18:00:37', '2021-12-04 18:00:37', '2022-12-04 18:00:37'),
('216438d1866823e63099609bf4f299aaad0e78db373e2d9a1c9115576cb51a14a495550db29f37e0', 2, 1, 'token', '[]', 0, '2021-12-09 10:56:28', '2021-12-09 10:56:28', '2022-12-09 10:56:28'),
('2174c898f871b694b9babdca87c9199473a671a4d92b7b0b8128af31c0a3a6fbb7f50239ab3aa6c4', 50, 1, 'token', '[]', 0, '2021-11-24 16:54:07', '2021-11-24 16:54:07', '2022-11-24 16:54:07'),
('21b74465ce4dbc209f327e3a03909c1bc99c3d8c2935801e14dcc2d68e45913365232b5da1e1ecb6', 50, 1, 'token', '[]', 0, '2021-12-13 12:27:05', '2021-12-13 12:27:05', '2022-12-13 12:27:05'),
('21dd3b47687e20f7b433f7d3cb251841a86c918d8955fb721ee171f8bb860d28e4dc16f6697f9818', 2, 1, 'token', '[]', 0, '2021-12-16 10:44:00', '2021-12-16 10:44:00', '2022-12-16 10:44:00'),
('21ee2654598a0386383b45b7ace908bc8601ebcb434a89de10e1cfef3957a0c3b75db5d57fe03876', 50, 1, 'token', '[]', 0, '2021-12-13 17:46:33', '2021-12-13 17:46:33', '2022-12-13 17:46:33'),
('2222c4531e6a99cf5e075d2ded69b89863638b1bc953dad0c8eb8cfa1be658515a4fdb596b4a62ab', 2, 1, 'token', '[]', 0, '2021-11-26 19:22:39', '2021-11-26 19:22:39', '2022-11-26 19:22:39'),
('223f4533b2ec55a58f6d582a5aa278d839bc56044c7c988e85426a407a310bb686b4edd9e579e4ff', 68, 1, 'token', '[]', 0, '2021-12-14 10:32:23', '2021-12-14 10:32:23', '2022-12-14 10:32:23'),
('2249acd6e3421f8e6b829f1b64fdbb5d6e52d651cbf97afdde86f0f87f7776354a0eecc7433097c2', 37, 1, 'token', '[]', 0, '2021-11-18 10:43:14', '2021-11-18 10:43:14', '2022-11-18 10:43:14'),
('22cf12d4542caa057c356675417598b4c2ef479a71e513623cabd121d698cd89030d64f5a35f9eb9', 80, 1, 'token', '[]', 0, '2021-12-03 14:21:33', '2021-12-03 14:21:33', '2022-12-03 14:21:33'),
('22d381ce7714b6ff9831d8309d184458383b8025d3877af1caa6eaa7a7946d77d052f463abbf1905', 2, 1, 'token', '[]', 0, '2021-12-17 15:13:24', '2021-12-17 15:13:24', '2022-12-17 15:13:24'),
('230a287e803861acf21de6fc5c55c30617b796f64ce5104338aa6976e2526e23ed3d1c6ad87baa2e', 37, 1, 'token', '[]', 0, '2021-11-13 12:23:21', '2021-11-13 12:23:21', '2022-11-13 12:23:21'),
('23379bd3f08afffe7af3916198603503de3efb755d277301982d3298691ef34f3d66567e06fcc244', 51, 1, 'token', '[]', 0, '2021-11-30 18:31:33', '2021-11-30 18:31:33', '2022-11-30 18:31:33'),
('2342e1f191db61c608220876b3134cab559dd8879caaf31d9331d9fd4402462f8a4c0984da5be785', 2, 1, 'token', '[]', 0, '2021-11-23 17:02:01', '2021-11-23 17:02:01', '2022-11-23 17:02:01'),
('236aa08ba30506dd0d1d33ff186f87105f9c7c8e53cceaf6d5b4315a9967526b9c6f19d3d4ebce66', 51, 1, 'token', '[]', 0, '2021-11-30 18:00:26', '2021-11-30 18:00:26', '2022-11-30 18:00:26'),
('23709066386fac23ec49127a2ec5845470c24c44957a7b8755ea5eb8e2e2181431241b7464a15892', 80, 1, 'token', '[]', 0, '2021-12-06 10:07:50', '2021-12-06 10:07:50', '2022-12-06 10:07:50'),
('237122783c9c09bbd00813e79cf1cf974fb629994ac44a5a2fd6fe32d4428ba88109a33c1dedb96a', 2, 1, 'token', '[]', 0, '2021-11-26 19:11:56', '2021-11-26 19:11:56', '2022-11-26 19:11:56'),
('2376aa796dab39dadcd757c4ad5b2c429aa63439da692559eca56ed7586ecc57b64afd1aa42e691c', 2, 1, 'token', '[]', 0, '2021-12-07 11:07:55', '2021-12-07 11:07:55', '2022-12-07 11:07:55'),
('2428a39ea1b3a7b073c05b9c3de262eaf576ca2040ff4c85b9881efdf0b896caff1967092f1c3433', 2, 1, 'token', '[]', 0, '2021-11-29 14:51:26', '2021-11-29 14:51:26', '2022-11-29 14:51:26'),
('2430bb984c2d970eede0019b2c61f7e35b9cc85dec007df5ca9275c7c05dae77112cb7710a3dd879', 2, 1, 'token', '[]', 0, '2021-12-16 17:11:11', '2021-12-16 17:11:11', '2022-12-16 17:11:11'),
('248f04c7e31722978cab1d735024723436bab94ef55bca8ef6ace9bf29d59d296eeaa714de80e38e', 50, 1, 'token', '[]', 0, '2021-11-30 19:34:08', '2021-11-30 19:34:08', '2022-11-30 19:34:08'),
('24a87564ff8e0b73cd145a849de4b27c9bddaec9e2b595e446ee08c241d528288a36f65a5d253cb5', 37, 1, 'token', '[]', 0, '2021-11-18 10:59:56', '2021-11-18 10:59:56', '2022-11-18 10:59:56'),
('24b11973df6e9ded6f3a2b0eb78e7e8c347c20592e2267dc80f245f22e0f7e8722405ac775a8e994', 2, 1, 'token', '[]', 0, '2021-12-14 10:37:24', '2021-12-14 10:37:24', '2022-12-14 10:37:24'),
('251c8347e0ebe6acebf901bd74b57867b9445462e758b6d2488ff272805df23f99c47bf70489ba18', 50, 1, 'token', '[]', 0, '2021-12-03 13:05:59', '2021-12-03 13:05:59', '2022-12-03 13:05:59'),
('251ff0a2a1657aa4b9c640a589ea4b8fe116b7ef5654b3e052f12716b991ba5f76272b9525518394', 50, 1, 'token', '[]', 0, '2021-11-30 12:41:01', '2021-11-30 12:41:01', '2022-11-30 12:41:01'),
('2520d057e07be196a48958d77c26b86b3ff52fc65609be09deb7d8fe6b184aba0c120ce90c871fdc', 50, 1, 'token', '[]', 0, '2021-12-03 13:05:43', '2021-12-03 13:05:43', '2022-12-03 13:05:43'),
('25260b3c8278ae88b10e66eced625800e2dd0d3a6cfdd46de7d279443068fa68cb2d3edaec2f0f0a', 2, 1, 'token', '[]', 0, '2021-11-26 09:38:35', '2021-11-26 09:38:35', '2022-11-26 09:38:35'),
('255a09db43de7cb3405c73e947d3c0feb5df3df34cc2542ca9b1c9987f9ef9e8648780ab7dfd9151', 50, 1, 'token', '[]', 0, '2021-12-01 10:23:15', '2021-12-01 10:23:15', '2022-12-01 10:23:15'),
('256514dd09a25e729e40975cd8d64a9b455c62a2d872da38e1c88e6d3daf8dbc65f751bf5274a41a', 48, 1, 'token', '[]', 0, '2021-11-20 09:46:41', '2021-11-20 09:46:41', '2022-11-20 09:46:41'),
('2571ce13c693b941d96879b5de4c1583b3a2d8a0131c10f35658de126cdbb19c57af7666958526d1', 37, 1, 'token', '[]', 0, '2021-11-16 15:49:16', '2021-11-16 15:49:16', '2022-11-16 15:49:16'),
('2583c147b9bb8f77300b2f2024289f6bdd6d51d777e7186ba68445ac2db607cf46ba4d75304ef9ab', 2, 1, 'token', '[]', 0, '2021-11-29 17:22:49', '2021-11-29 17:22:49', '2022-11-29 17:22:49'),
('25929ebbe8051c1cec242c806708eb754c927446a9706b8aeddd4fecb58c25936e35e5a4de0034cd', 80, 1, 'token', '[]', 0, '2021-12-16 16:31:07', '2021-12-16 16:31:07', '2022-12-16 16:31:07'),
('2599ee4cc274acc0c7c439ce928cbfeb3821fb81d5d842c251e700f14089d46b3c7b7e73de9b7976', 2, 1, 'token', '[]', 0, '2021-11-30 15:52:26', '2021-11-30 15:52:26', '2022-11-30 15:52:26'),
('25ab227dc6016d8b2b4f222a13b85dfa52158c27d7f3047ef8deb9786cac1660fab5d33c2d9a9871', 2, 1, 'token', '[]', 0, '2021-12-08 11:01:11', '2021-12-08 11:01:11', '2022-12-08 11:01:11'),
('25c05d4f918b648aa537b0e24f4beb77d2c2493ac9015a057839fcc837e810de5171a913fbe39eea', 2, 1, 'token', '[]', 0, '2021-06-09 08:06:11', '2021-06-09 08:06:11', '2022-06-09 08:06:11'),
('25d096f67c2c3c123cc8b75aef1065d92814387f7e0785ff4bebaec89dc785c4817002f2a622f9b5', 50, 1, 'token', '[]', 0, '2021-11-24 16:13:02', '2021-11-24 16:13:02', '2022-11-24 16:13:02'),
('26015759419729e7e625b84aed48cd845650e3a295133d65052cc2f8711ef6a1de29e7add0395fd0', 2, 1, 'token', '[]', 0, '2021-11-29 14:41:04', '2021-11-29 14:41:04', '2022-11-29 14:41:04'),
('2619c214a279d18093d2fe3f6dd3ed0652cb202daef0838b86cd1ddcc8b9356038f8056e905c9774', 68, 1, 'token', '[]', 0, '2021-12-03 13:19:05', '2021-12-03 13:19:05', '2022-12-03 13:19:05'),
('2673b4114837e30cf544d878802d7a5187446da8cb30ebb46153fc1d5fd763daa8c8ab2079feed20', 2, 1, 'token', '[]', 0, '2021-12-02 16:25:15', '2021-12-02 16:25:15', '2022-12-02 16:25:15'),
('26814b2393b47ae09f7c98ee3c5e9c8d8bd341b598498bce300410310c375743cf0f4797142123bb', 2, 1, 'token', '[]', 0, '2021-12-13 15:22:04', '2021-12-13 15:22:04', '2022-12-13 15:22:04');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('26921315fde16034c8743433c61154b71bf3e5564ba9bb149d37fa0e4ac5f57310fe22d4b811ba84', 2, 1, 'token', '[]', 0, '2021-12-03 18:27:22', '2021-12-03 18:27:22', '2022-12-03 18:27:22'),
('26ae52396467105b9731820e831ccaf7c9fe34dec26cd4ba3a391ab986c905b9878ec0afbe04d804', 2, 1, 'token', '[]', 0, '2021-12-13 15:23:18', '2021-12-13 15:23:18', '2022-12-13 15:23:18'),
('26c615c2bcc817903df9d6c5117c2974afccd736cd8125109b6cc9ef759955eb56a7c4ee752a4bfc', 2, 1, 'token', '[]', 0, '2021-06-15 21:36:30', '2021-06-15 21:36:30', '2022-06-15 21:36:30'),
('26e57f8c1ae15a08f47c5ba099da917e91491e96a4b4d27514979af7ef48656c748ec79db319cf5e', 50, 1, 'token', '[]', 0, '2021-11-29 16:55:19', '2021-11-29 16:55:19', '2022-11-29 16:55:19'),
('2720d625aeccc2d2f3e8128aa49889d710a68eb6cf105ff3de1c18a4dff655f17e8791af9e32eacd', 2, 1, 'token', '[]', 0, '2021-06-23 05:19:58', '2021-06-23 05:19:58', '2022-06-23 05:19:58'),
('273ecc3dce3987f07fee35a0ec8bea271eb24f0cccc4fa581458eee05ed0b1f66f996495a6fa311e', 108, 1, 'token', '[]', 0, '2021-12-10 17:08:09', '2021-12-10 17:08:09', '2022-12-10 17:08:09'),
('27a271b850019cd1053cc7733574d92ab069c1f0b587248cac70e8e0955fde2b563cd75fbe7ebf5d', 50, 1, 'token', '[]', 0, '2021-12-02 10:53:54', '2021-12-02 10:53:54', '2022-12-02 10:53:54'),
('27b56bf72be7989cf3e359487cb8c0a21d5018af8806e023752e57885699da560958af7959a4d628', 37, 1, 'token', '[]', 0, '2021-11-17 18:22:00', '2021-11-17 18:22:00', '2022-11-17 18:22:00'),
('27c154cbef73e2452e0e73d9b166051cb42fa00bdfbf13598277f681088cd272f0933ac9c2630684', 37, 1, 'token', '[]', 0, '2021-11-13 15:05:12', '2021-11-13 15:05:12', '2022-11-13 15:05:12'),
('27f2ccc06840357a3fbb82a47aa61c0c4be3ef93ae88df760b8432d915f93886d78e3b04a2d6a6ef', 2, 1, 'token', '[]', 0, '2021-12-07 17:59:50', '2021-12-07 17:59:50', '2022-12-07 17:59:50'),
('28b29e8ba0fec94ff4a520d084700ed38ca3aa0ae13917e2dfd2f495838b17ff80d8823d6c0b1ef2', 37, 1, 'token', '[]', 0, '2021-11-13 18:05:02', '2021-11-13 18:05:02', '2022-11-13 18:05:02'),
('28c6ff3d7acc6d495a298a27fe9cb2ac86214ed71eeb7f38bde16aa5b7820511ac4ec1fdd0158068', 50, 1, 'token', '[]', 0, '2021-12-01 10:55:10', '2021-12-01 10:55:10', '2022-12-01 10:55:10'),
('28eb0b5ee9607ddcafa5ea9470d57b6c752d8c024be16a40a52cebee58f2e1db2ba45139c8fc7f86', 37, 1, 'token', '[]', 0, '2021-11-18 13:01:54', '2021-11-18 13:01:54', '2022-11-18 13:01:54'),
('292862516c386df6a1cb6e7d7d79b977c4de5f029bb44db9ca03a19ac546d6e1d6dab04aa2a412ea', 50, 1, 'token', '[]', 0, '2021-11-24 16:41:49', '2021-11-24 16:41:49', '2022-11-24 16:41:49'),
('294f18113852d6b35f1e005a451e740ecd2818067226643995e33e060b0cfc9284498cab082cefb6', 50, 1, 'token', '[]', 0, '2021-11-30 18:50:32', '2021-11-30 18:50:32', '2022-11-30 18:50:32'),
('296f32fe7ace52c8f37581d3468f76b03691aca78f83c9aa07f1545cea9f162f5110f560d36844c6', 2, 1, 'token', '[]', 0, '2021-06-16 18:43:46', '2021-06-16 18:43:46', '2022-06-16 18:43:46'),
('297c1aa0401e33e5e45c299af88e14b2c41732ed19319369dff17d2f8e0ceac55b077869638f71f6', 48, 1, 'token', '[]', 0, '2021-11-19 14:15:00', '2021-11-19 14:15:00', '2022-11-19 14:15:00'),
('29eb6c56e2ff227ce496d34b2163b5b9a04eebfce78b8373bff9ec2786de7d990e0f4b216ef75d2f', 50, 1, 'token', '[]', 0, '2021-11-24 16:04:58', '2021-11-24 16:04:58', '2022-11-24 16:04:58'),
('29f0636512eac9a41902f2a90d178475cdb2ec9df26e45ff690819c677f50751c15c5f955d6da667', 37, 1, 'token', '[]', 0, '2021-11-18 16:11:40', '2021-11-18 16:11:40', '2022-11-18 16:11:40'),
('2a24177f4755e69f8db734ae33072dc8e82173bc2b4e94981938ce93551e0a3d0809474c3f598e0a', 48, 1, 'token', '[]', 0, '2021-11-20 10:45:03', '2021-11-20 10:45:03', '2022-11-20 10:45:03'),
('2a61829c3734a95fc3243420feaa73446558aad5cda195d6cceeb252d495b0134502a80faaf71d3b', 108, 1, 'token', '[]', 0, '2021-12-10 11:32:14', '2021-12-10 11:32:14', '2022-12-10 11:32:14'),
('2a68aa849d0750046a768ce9831e6f464f1537dc388163e6f6d5550cc8b6564b8e40b44f2320e20d', 2, 1, 'token', '[]', 0, '2021-11-30 14:59:16', '2021-11-30 14:59:16', '2022-11-30 14:59:16'),
('2b08adfd6ddf1f8b9e36f6cf657922c33d534b532ed0e1b77088d4617e2f6d81e441823a2fe8eb48', 37, 1, 'token', '[]', 0, '2021-11-18 09:38:38', '2021-11-18 09:38:38', '2022-11-18 09:38:38'),
('2b2d32685f50a045bfe973520e534c92c7eb9445207cbd4544922ca6e5ec375b5ff12012c3162535', 80, 1, 'token', '[]', 0, '2021-12-03 14:09:28', '2021-12-03 14:09:28', '2022-12-03 14:09:28'),
('2b36dd1f966fafbd8038b7887b0fdb63a9ff08a36f1c5bdc97f073cac9ec0c3643d98d86de245125', 80, 1, 'token', '[]', 0, '2021-12-21 14:50:54', '2021-12-21 14:50:54', '2022-12-21 14:50:54'),
('2b6b7c257e8737136ca09f36625e908fca52c8f352b9df4e6e34cd5328e42bd077a6de42e6dd7bb3', 2, 1, 'token', '[]', 0, '2021-11-26 17:57:31', '2021-11-26 17:57:31', '2022-11-26 17:57:31'),
('2b74e79248c83d45d847c721f87cb8a3a4d461002663c8a20434edae37a0428b5c3bfdbcc26f411d', 2, 1, 'token', '[]', 0, '2021-12-01 18:08:17', '2021-12-01 18:08:17', '2022-12-01 18:08:17'),
('2b9e91087530251c40657004355bcfc611c95ed606cb999ff998d15852d9c806d61381e814111575', 37, 1, 'token', '[]', 0, '2021-11-18 10:59:51', '2021-11-18 10:59:51', '2022-11-18 10:59:51'),
('2ba90b1eb48b803add0e90a4838ae66c5eb9917bce6f6abee7617d2c9471d88fdeda334f46131cb2', 61, 1, 'token', '[]', 0, '2021-12-01 10:21:15', '2021-12-01 10:21:15', '2022-12-01 10:21:15'),
('2bc933e04fa726f72b32b6a3c93f391982c4c8ddb33f75c2bbf90edc33f356ea24bac34cc39dcb27', 50, 1, 'token', '[]', 0, '2021-12-03 13:11:32', '2021-12-03 13:11:32', '2022-12-03 13:11:32'),
('2bf8c55e44ef9cab912c50150a9228d107c07f777e31f18f42f2b46abb3740e7ef677e50e9ea0cb0', 50, 1, 'token', '[]', 0, '2021-12-03 13:04:28', '2021-12-03 13:04:28', '2022-12-03 13:04:28'),
('2bfacd47d711043bd83cae7ab77049c0bba632a8e6d05075e747943080d82895acb0f97ef301deb7', 37, 1, 'token', '[]', 0, '2021-11-15 12:25:17', '2021-11-15 12:25:17', '2022-11-15 12:25:17'),
('2c0fff25e470135402d090bb83efeff80f88439e194b512068ab3fa3aea5d069e487faeabe498b00', 80, 1, 'token', '[]', 0, '2021-12-16 18:39:16', '2021-12-16 18:39:16', '2022-12-16 18:39:16'),
('2c3e35cf557609c7fdf828fae8f40dcc1d5c92d2e88a509ef6b8f13b8095cc9aa7cac23299ed062d', 2, 1, 'token', '[]', 0, '2021-12-08 10:53:16', '2021-12-08 10:53:16', '2022-12-08 10:53:16'),
('2c5092117867e5d7c47f3526cfb14d31752da07ef134c5680e2d29ffbb73b02bba2c516148afd5a0', 50, 1, 'token', '[]', 0, '2021-11-18 16:50:43', '2021-11-18 16:50:43', '2022-11-18 16:50:43'),
('2c7193673828d97ca3fd78fac12dcb1a745de08d23d05dce1a3bf4ecc7b6185b457fb8681630c2c1', 50, 1, 'token', '[]', 0, '2021-11-20 12:19:38', '2021-11-20 12:19:38', '2022-11-20 12:19:38'),
('2cc9c9375d25a4e981fdb990cd636344bfe8dbc8ebfcdc8541fa7ce43399b64e37737b1c45b02957', 50, 1, 'token', '[]', 0, '2021-12-14 15:26:25', '2021-12-14 15:26:25', '2022-12-14 15:26:25'),
('2ccb7902b53fd703918865ca1a6a3cb86aefdb3ee578f8beac6867eefd3c5188ec452588ded6bf0f', 2, 1, 'token', '[]', 0, '2021-11-25 17:11:22', '2021-11-25 17:11:22', '2022-11-25 17:11:22'),
('2ceb9868ef4458d30abb241748054b40247833b2a30837d6a2f9ec07c85a7f72f720e1d11e6df85f', 37, 1, 'token', '[]', 0, '2021-11-18 12:50:07', '2021-11-18 12:50:07', '2022-11-18 12:50:07'),
('2d0b547a0a07e7bab78b38ed36bdc0ddb8969bd9854f74291621e2b7402de902bad1dac9944decb0', 2, 1, 'token', '[]', 0, '2021-06-19 01:32:56', '2021-06-19 01:32:56', '2022-06-19 01:32:56'),
('2d20215cb9939c644e0cee0576b158eddb70fea7216e1b254a6b1c1488bd5a74bab8b3af0b4330ec', 51, 1, 'token', '[]', 0, '2021-11-30 17:59:37', '2021-11-30 17:59:37', '2022-11-30 17:59:37'),
('2d6888a6e5c72df15889ea5c2c07f8ce819f190f14b482d2e1430de42a71a4511c384dedb4d3ba16', 2, 1, 'token', '[]', 0, '2021-12-04 14:15:20', '2021-12-04 14:15:20', '2022-12-04 14:15:20'),
('2d808fb933ba82459a427f1c91e15c7dd0445c66a4f18c0cacededda3a42c4b80718e66308a75c6f', 37, 1, 'token', '[]', 0, '2021-11-18 10:50:24', '2021-11-18 10:50:24', '2022-11-18 10:50:24'),
('2da83e93018451a12d38d9e6c74ed28756684970e56519581903d48f1fee3f8542f7d8f65edbce9f', 50, 1, 'token', '[]', 0, '2021-11-26 15:38:52', '2021-11-26 15:38:52', '2022-11-26 15:38:52'),
('2dbf390f1afb22ffe15d456a52a624d625ab397c736b4a6a94c86b27e8b759e89510afc94b782a24', 2, 1, 'token', '[]', 0, '2021-11-29 14:44:48', '2021-11-29 14:44:48', '2022-11-29 14:44:48'),
('2dfeb504c9966684ca804a2a06d82a19150015b34d2635e4f399925a1cbcf1dbe136a61006d76f55', 80, 1, 'token', '[]', 0, '2021-12-03 14:09:12', '2021-12-03 14:09:12', '2022-12-03 14:09:12'),
('2e041cf64f0ac856176b15064d8e7ba12d52c5769c806d3a10b2f397c9c969b98fcf6794d48189a5', 2, 1, 'token', '[]', 0, '2021-11-29 17:13:41', '2021-11-29 17:13:41', '2022-11-29 17:13:41'),
('2e18c02cee8b33276ef907ad359c79a73541a78a37f36efc73123f15fecc7830ca965bf0be23fae2', 2, 1, 'token', '[]', 0, '2021-11-20 15:41:11', '2021-11-20 15:41:11', '2022-11-20 15:41:11'),
('2e2b708ba084d0a955fbd14ec25334db3fbad94926e43e852e64a2def62505cd6c25caa13dafe61c', 2, 1, 'token', '[]', 0, '2021-11-11 11:48:05', '2021-11-11 11:48:05', '2022-11-11 11:48:05'),
('2e2f51a019667b3256b14678b87ad5075f791f297a423d806497c2a18973f81e826b5057c7bc4f3f', 2, 1, 'token', '[]', 0, '2021-12-16 16:50:18', '2021-12-16 16:50:18', '2022-12-16 16:50:18'),
('2e3335c2e9ba2da4dc8dc7bd4eeb8909f35170f33759071c5255b447ea228f92290c5ba552b2df17', 50, 1, 'token', '[]', 0, '2021-11-18 17:02:17', '2021-11-18 17:02:17', '2022-11-18 17:02:17'),
('2e409e037c0a4e3de05ed73edee7fd5ff21d62c249b6c622439d2dc658a2d9ea2cbc74b689c8ad40', 50, 1, 'token', '[]', 0, '2021-11-30 10:35:22', '2021-11-30 10:35:22', '2022-11-30 10:35:22'),
('2e59702b0f04d036575e29ce408e2c162fe75e2db0855bdba1ea7f51f16307f698bad10ca9a6c54d', 2, 1, 'token', '[]', 0, '2021-06-22 16:48:44', '2021-06-22 16:48:44', '2022-06-22 16:48:44'),
('2e6175c0fd1a04c86e8b1b845c93c84c0abdba6c5ab26e7a1857ab88179346326fcaac8ed5622542', 66, 1, 'token', '[]', 0, '2021-12-01 11:55:15', '2021-12-01 11:55:15', '2022-12-01 11:55:15'),
('2e9c113745d69d81c5c762898227fd99dd65cb7aefc9497ffe631cb063708e87b15e02bf4926a9e9', 68, 1, 'token', '[]', 0, '2021-12-13 15:44:09', '2021-12-13 15:44:09', '2022-12-13 15:44:09'),
('2ea94dbf24b602d762f2d2ec02389d5fd0b0eafc5e760fe1dc855c08628f58f20c49b4991fe1e591', 2, 1, 'token', '[]', 0, '2021-11-26 17:41:53', '2021-11-26 17:41:53', '2022-11-26 17:41:53'),
('2eb735b14bea223864c83e26ec03654da3cfd63750c996ad2832cf5783e09637b5341ad04c647cef', 2, 1, 'token', '[]', 0, '2021-11-26 17:49:00', '2021-11-26 17:49:00', '2022-11-26 17:49:00'),
('2ec1c72041cec112b8f8473ae3fc105b27a3b9063a339a303829cd63a3c4c234da703ab1b46fb063', 2, 1, 'token', '[]', 0, '2021-11-02 14:35:01', '2021-11-02 14:35:01', '2022-11-02 14:35:01'),
('2edee133f2adbbf640970642dd1e59ec991f997813e430d4bbf2f264abbb04257a18a93bccb02b93', 2, 1, 'token', '[]', 0, '2021-11-30 18:08:22', '2021-11-30 18:08:22', '2022-11-30 18:08:22'),
('2ef319b7202dbcd20626c71aca4feb0708f05ecd6c0f1dfaf9279738300dafbd98d89b9b15ae3baa', 50, 1, 'token', '[]', 0, '2021-12-02 10:53:51', '2021-12-02 10:53:51', '2022-12-02 10:53:51'),
('2f080049343f87e35b5911e8d37c32f62f86a62138f7833f45219fd9c0f56641ecbef0d839da2fab', 37, 1, 'token', '[]', 0, '2021-11-18 10:55:13', '2021-11-18 10:55:13', '2022-11-18 10:55:13'),
('2f15f2729beec6bc6a94b8e35c74e04cd4a2c6a969a9508cd0e03e7debc42df0f3fc904dc82a4c5b', 2, 1, 'token', '[]', 0, '2021-12-06 14:37:00', '2021-12-06 14:37:00', '2022-12-06 14:37:00'),
('2f485da465c2f4c8876241d20d6b7157595b269c151e72d425352004dd2114903775d36af03aa5c7', 48, 1, 'token', '[]', 0, '2021-11-20 10:44:59', '2021-11-20 10:44:59', '2022-11-20 10:44:59'),
('2f50b617f008331b307572bd492d0989cb8b91d3a5a9233b4808f51cb79f00a86bbabf0f3759f2bc', 37, 1, 'token', '[]', 0, '2021-11-18 10:53:27', '2021-11-18 10:53:27', '2022-11-18 10:53:27'),
('2f558cb743364a62d982aef3984b508e1caa491af725d15f2990ec416b6a4434e1ae484738c071a3', 50, 1, 'token', '[]', 0, '2021-11-24 17:14:03', '2021-11-24 17:14:03', '2022-11-24 17:14:03'),
('2f6162f352b66b2c40c51f1b872b450fe94ca46a48e4fe8b58c7932df2e0da83ea79be98d11e6546', 50, 1, 'token', '[]', 0, '2021-12-13 10:42:54', '2021-12-13 10:42:54', '2022-12-13 10:42:54'),
('2f7e0ba4abac06aae3ba7bf7f7e7c08b60d679f8b181542c72733dc6a2883ec635b774276c4b796b', 80, 1, 'token', '[]', 0, '2021-12-03 14:33:35', '2021-12-03 14:33:35', '2022-12-03 14:33:35'),
('2f9fed9ecab9367b0a142d1592904c6aaeeb2bdace4b19b5252fc234482685bbed85f19a1e3bcf1a', 2, 1, 'token', '[]', 0, '2021-11-30 17:11:25', '2021-11-30 17:11:25', '2022-11-30 17:11:25'),
('2fb37474b9b140f5bb6db71a3878a2e6b6b3d785c7b271d73a96791bc8535bf0f6b20cf80a98121f', 50, 1, 'token', '[]', 0, '2021-12-13 17:47:03', '2021-12-13 17:47:03', '2022-12-13 17:47:03'),
('2fce4f4384b8c85c554514107bf6d34c61cd230f9ea6979237088dfef7f58156b746f471c115f30e', 2, 1, 'token', '[]', 0, '2021-06-23 03:38:43', '2021-06-23 03:38:43', '2022-06-23 03:38:43'),
('3007ca5f8b1a3565df9472f01766b48b630d30ec52150d72ce7b2204f38c443be1ec9ffabc8c4d41', 2, 1, 'token', '[]', 0, '2021-12-10 13:55:38', '2021-12-10 13:55:38', '2022-12-10 13:55:38'),
('301f55ac7916fa76694678df97d5c43d723706f344f1d442ade938b4046f8e9ab3626c22b467a935', 2, 1, 'token', '[]', 0, '2021-06-22 13:20:17', '2021-06-22 13:20:17', '2022-06-22 13:20:17'),
('307723bbf832dddda287391de76432e6b6206d498d2bc6808a38f6e03241d0c799aba65d0592b6df', 2, 1, 'token', '[]', 0, '2021-11-13 11:07:28', '2021-11-13 11:07:28', '2022-11-13 11:07:28'),
('30d6d2ef41cb29ac19310e885bd83050f3469adb8a49ffe85961fa968ce67067cd6b550de4074fd2', 2, 1, 'token', '[]', 0, '2021-12-14 11:17:45', '2021-12-14 11:17:45', '2022-12-14 11:17:45'),
('310c3a21633ede4ca411bf89c8e1b32a0619f88d2b7f06e8ed51c7f105a15b108ed1c1b789096ad4', 37, 1, 'token', '[]', 0, '2021-11-13 16:13:36', '2021-11-13 16:13:36', '2022-11-13 16:13:36'),
('3136d323718ccb125b8dd1fa2c97f76fbcf1e669a673c7cdbfbdf13c7ca1eaa359a3bab989e69ed6', 58, 1, 'token', '[]', 0, '2021-11-30 22:20:57', '2021-11-30 22:20:57', '2022-11-30 22:20:57'),
('31895bbe2d6d71d21bbf806e6799060ec9da70d35d60fb5917717c1d26f69ca804df23c34b67d63f', 50, 1, 'token', '[]', 0, '2021-11-24 16:52:25', '2021-11-24 16:52:25', '2022-11-24 16:52:25'),
('318ec4a4b34995d5c9a6c302349e22f11e7599cbb26ac54120f79a182e7e9399e0122ad0da73d6fb', 80, 1, 'token', '[]', 0, '2021-12-07 10:36:47', '2021-12-07 10:36:47', '2022-12-07 10:36:47'),
('31a759f3bae7b3f83cded09a54c5372521190ef1b9ea7e254da01a034a487c3bb469772032df91e4', 50, 1, 'token', '[]', 0, '2021-12-02 17:56:29', '2021-12-02 17:56:29', '2022-12-02 17:56:29'),
('320f945fe1949eb90c2116c409bc83201ef3c877f506b2282f153dc59ece1b5aab30684a5c62e563', 37, 1, 'token', '[]', 0, '2021-11-13 11:44:17', '2021-11-13 11:44:17', '2022-11-13 11:44:17'),
('321fdce5884dc11e73d08093e4d900e97695948ec83e7773495686d2398a4d2ae101e24696f8c552', 2, 1, 'token', '[]', 0, '2021-12-09 11:20:18', '2021-12-09 11:20:18', '2022-12-09 11:20:18'),
('3225111693dc73b4aea516ee29ff33911099639b61f7ed2bfa4c92696b2976b92f9ed5b74ad570c7', 2, 1, 'token', '[]', 0, '2021-12-04 16:24:24', '2021-12-04 16:24:24', '2022-12-04 16:24:24'),
('32808b4d48dfe189faa18351d5d06f92bf447ba3931c24060219510c6072c5acd1ef34188b093919', 50, 1, 'token', '[]', 0, '2021-12-14 15:33:08', '2021-12-14 15:33:08', '2022-12-14 15:33:08'),
('329ffb52eacf958642a7c07c035d5322986c4dd3d125bf3a3b9e13510dff584994f4bac45805cf4c', 2, 1, 'token', '[]', 0, '2021-12-16 17:09:40', '2021-12-16 17:09:40', '2022-12-16 17:09:40'),
('32d06ee699008c8940cf06dbc25cbbaf5eabc2ee14c540630b27cd03797763e55c4b69c91b191dac', 37, 1, 'token', '[]', 0, '2021-11-17 18:21:35', '2021-11-17 18:21:35', '2022-11-17 18:21:35'),
('32e6c60187e64f62584334be3e5c7e29916a5c87df690cfd67cbdba4a9e3c9f5d7ad2c8d3c5ca206', 48, 1, 'token', '[]', 0, '2021-11-18 18:23:26', '2021-11-18 18:23:26', '2022-11-18 18:23:26'),
('33385a118880e232b8bb6939a83b1865d72a1d7aa5c00b8e6720dbc3e67962498b3a1da9a690e95b', 2, 1, 'token', '[]', 0, '2021-12-10 10:01:02', '2021-12-10 10:01:02', '2022-12-10 10:01:02'),
('33826697f1e504aa944ca800ffc843056d5a709c759c632636a2715c70462c96ee93becab32c0b03', 61, 1, 'token', '[]', 0, '2021-12-03 12:16:54', '2021-12-03 12:16:54', '2022-12-03 12:16:54'),
('33827799fda30980967a55b9e0102030df63b6017ea0d2157d0bd2437a63e5ac3a0e37f661066bcb', 2, 1, 'token', '[]', 0, '2021-11-29 14:53:03', '2021-11-29 14:53:03', '2022-11-29 14:53:03'),
('339ef87a80772018db9c176eb9a8102535b2fabc3f4052177f567cdca985a5f2cc4f87a2c1a71897', 37, 1, 'token', '[]', 0, '2021-11-18 11:25:06', '2021-11-18 11:25:06', '2022-11-18 11:25:06'),
('33ad83aa236b7a9cf0406beb31bc42001763a95a5f6ac33823cf2c1ffafea83954bfcbb861c01d1c', 67, 1, 'token', '[]', 0, '2021-12-01 12:33:56', '2021-12-01 12:33:56', '2022-12-01 12:33:56'),
('33b2e5074d73cbe643b04864ad08c13d6a0113ab7e5c67b61792f3512545108ed0edc5dd1276808a', 61, 1, 'token', '[]', 0, '2021-12-02 11:42:34', '2021-12-02 11:42:34', '2022-12-02 11:42:34'),
('33f6bd2e11956bf9f52838e25ed607df478ad5fce5b0c1c167338b5082f99fc2d1b31fbb25f0940e', 50, 1, 'token', '[]', 0, '2021-12-03 12:51:50', '2021-12-03 12:51:50', '2022-12-03 12:51:50'),
('3400de6207a6cedc92c21ae9c99cd4b37fb150cdc93861115a3efa9ed09c7eef321a15817e56c9c9', 2, 1, 'token', '[]', 0, '2021-11-17 10:38:38', '2021-11-17 10:38:38', '2022-11-17 10:38:38'),
('342e23bec962bfac1e7f7ab72da8b08676c15b9ca9d3ec7399a0384d84745b04be9668ee1d5e9587', 50, 1, 'token', '[]', 0, '2021-12-03 10:28:28', '2021-12-03 10:28:28', '2022-12-03 10:28:28'),
('343a0d1e3e41a257a45dd60cfc7af43afd456d3b04ba7c36c92139ac3305d765cdc4ac15db9f1315', 2, 1, 'token', '[]', 0, '2021-12-16 17:27:39', '2021-12-16 17:27:39', '2022-12-16 17:27:39'),
('3445d559d12582239b125e14eb09f0bf6048f90fb821fea41edda33c6f2d6cb0d7f9568491ace1c6', 50, 1, 'token', '[]', 0, '2021-11-30 11:56:11', '2021-11-30 11:56:11', '2022-11-30 11:56:11'),
('3475dd37adf81ae10c903c4a2618c9f73d58a6ada93cefc4341a4e907bc48df86fbf1cfbb4c15c2f', 50, 1, 'token', '[]', 0, '2021-12-21 15:19:27', '2021-12-21 15:19:27', '2022-12-21 15:19:27'),
('34d03220592bdd9b8d19804e640cf8b72f71bbe4b7f78c7d49b98392a53d8d47ae262887e8b6165a', 50, 1, 'token', '[]', 0, '2021-12-01 16:40:55', '2021-12-01 16:40:55', '2022-12-01 16:40:55'),
('34ddd0e47f74d7d23f5197bc720782309d58b1a6cd1ea6f7bea3e63867826eefd8453adce58a1a68', 69, 1, 'token', '[]', 0, '2021-12-02 16:32:43', '2021-12-02 16:32:43', '2022-12-02 16:32:43'),
('34eac49dacc9ff58d1f79c9165b29c16a99e48d18ee4ff9fa50486f92511eb71cf2ccc8d7c46bc3d', 37, 1, 'token', '[]', 0, '2021-11-18 16:05:20', '2021-11-18 16:05:20', '2022-11-18 16:05:20'),
('351df3b9952841817f557f1bb66fa7674e6bbceabc8cacab69879f96f1f3cbf28c80fdd114795b88', 50, 1, 'token', '[]', 0, '2021-11-30 18:48:04', '2021-11-30 18:48:04', '2022-11-30 18:48:04'),
('3547ddacacba8c7effa77de142d666e9b346fd94a69a8c37432b3be6c77d5df1118a945a3296ce20', 37, 1, 'token', '[]', 0, '2021-11-29 11:22:04', '2021-11-29 11:22:04', '2022-11-29 11:22:04'),
('357c88c3979b421a13a93b71950ed0fffe88fb697a05ebe253230f6560df434b7d260be4dbf8615b', 2, 1, 'token', '[]', 0, '2021-12-09 18:17:16', '2021-12-09 18:17:16', '2022-12-09 18:17:16'),
('362f213cf93fede8a22a487e0874af19a2b07918665b9e7509d1b0d377d94f4c08c29a8088338781', 50, 1, 'token', '[]', 0, '2021-11-19 11:07:59', '2021-11-19 11:07:59', '2022-11-19 11:07:59'),
('3702f651967a06950584a4046599787141536268a060c3191356c828a0f9bb158937ba4aa15bd91b', 50, 1, 'token', '[]', 0, '2021-12-02 17:05:23', '2021-12-02 17:05:23', '2022-12-02 17:05:23'),
('370cd49a02604b45f3393835a46ad9937bec7b666371b6cce52b3d778b4da55001af05ff8c46fbac', 37, 1, 'token', '[]', 0, '2021-11-15 13:59:12', '2021-11-15 13:59:12', '2022-11-15 13:59:12'),
('373c7c3a725df619f95add5334ed1f688e1eeb1a3bb944db077280ddda709849e683a46319d1c22d', 50, 1, 'token', '[]', 0, '2021-11-23 16:24:42', '2021-11-23 16:24:42', '2022-11-23 16:24:42'),
('3749a132f92e0a1c24c098c577250f99ebb19403339e548924558a1d412db2ac8141cb12f0e4a852', 2, 1, 'token', '[]', 0, '2021-11-27 18:27:37', '2021-11-27 18:27:37', '2022-11-27 18:27:37'),
('381febd4c0c8b800f0b962e5da35324d0cf301c1ff0c377f3785e970793cf729b3ecd1f99d9fe7a4', 2, 1, 'token', '[]', 0, '2021-11-30 14:27:26', '2021-11-30 14:27:26', '2022-11-30 14:27:26'),
('38707d8af2df52c08d1030744c65e88a3cfb1d73aaaf35c7c740b05e7ea02617d2a697052b2dc6b1', 2, 1, 'token', '[]', 0, '2021-06-21 11:01:36', '2021-06-21 11:01:36', '2022-06-21 11:01:36'),
('388e6a4876fe841cb0a9df27db84cc671603972ae01febf8861a918d33efe6d664e3d57e4abe4a81', 2, 1, 'token', '[]', 0, '2021-12-13 16:04:52', '2021-12-13 16:04:52', '2022-12-13 16:04:52'),
('38d07c92b819c2d745257dc1273103216f5982795a7d0dcb4880c320abe5ddd5f9030004f9436162', 2, 1, 'token', '[]', 0, '2021-11-15 18:39:18', '2021-11-15 18:39:18', '2022-11-15 18:39:18'),
('38f1476676489d1a239834fafaf235a364acfa4e33cfbec12ff37f16cf57450f644385114f337298', 61, 1, 'token', '[]', 0, '2021-12-01 10:42:00', '2021-12-01 10:42:00', '2022-12-01 10:42:00'),
('38fc606b6022350562eb4730c75e17a80c4c7911c56cb1ecb2f926ea765b77e5497d9edea221dbc4', 2, 1, 'token', '[]', 0, '2021-12-10 18:06:36', '2021-12-10 18:06:36', '2022-12-10 18:06:36'),
('39359465d556329e04f3f760d9cc047fef271e7c850cb41faeaa8ea6fd082f5c6ecc45483410a486', 37, 1, 'token', '[]', 0, '2021-11-17 18:19:12', '2021-11-17 18:19:12', '2022-11-17 18:19:12'),
('3955f01377ca761412320e919d791a79d67d8c8cefd14d068785654167ca0902fc5e5f0d97fcf250', 2, 1, 'token', '[]', 0, '2021-11-29 18:09:17', '2021-11-29 18:09:17', '2022-11-29 18:09:17'),
('39916976d8315a408a95eb8a7239fef23330971b0b94fbc55973be8e2fdb933718b423c6916d96cc', 61, 1, 'token', '[]', 0, '2021-12-03 11:38:15', '2021-12-03 11:38:15', '2022-12-03 11:38:15'),
('39963b27ac29c14428e9efe2b06364809467ffe601c3133227d8d63a478996a16d0d057f7bd56345', 80, 1, 'token', '[]', 0, '2021-12-06 18:43:59', '2021-12-06 18:43:59', '2022-12-06 18:43:59'),
('39d53afd3adc7a56222fc25f5f3af1c66a60066f54c2d25e7f88feeb1f245f2e0223fc22c78752e5', 2, 1, 'token', '[]', 0, '2021-12-10 15:01:49', '2021-12-10 15:01:49', '2022-12-10 15:01:49'),
('3a2bc335bfd54855945fb78c748a796acc4a409a8f94d49ecc6098a2a3237b021608480c79848231', 2, 1, 'token', '[]', 0, '2021-11-27 11:29:50', '2021-11-27 11:29:50', '2022-11-27 11:29:50'),
('3a2f4a8b62f733b7ae38548b1f4203015da6f5e38444916e601fe945717acd6337364eb29232422c', 50, 1, 'token', '[]', 0, '2021-11-30 11:22:11', '2021-11-30 11:22:11', '2022-11-30 11:22:11'),
('3a5a2b5d9af57b4ca6250f60462fe6b7ed1a2b3d3403c7cfb66789e70a3dfb5cd01afc58f569c4cd', 37, 1, 'token', '[]', 0, '2021-11-16 13:58:11', '2021-11-16 13:58:11', '2022-11-16 13:58:11'),
('3a979105c9ab12afe069c4ae7135a5424d300d51d4cb8a73c592afc41de8630c6e0f6f3e68e16d0c', 2, 1, 'token', '[]', 0, '2021-11-27 16:11:46', '2021-11-27 16:11:46', '2022-11-27 16:11:46'),
('3ade1c3138dd6fb5a0e470e3fb950d05d7671b77efb0ed02a2c641f8b899fb469183e88367f02bca', 61, 1, 'token', '[]', 0, '2021-12-01 10:23:26', '2021-12-01 10:23:26', '2022-12-01 10:23:26'),
('3ade4bbfd4bb30bfe87ddfafadeafc42cb378fad6374e075fafcf2a84548092b9d7bc92c986e8034', 50, 1, 'token', '[]', 0, '2021-11-24 16:03:27', '2021-11-24 16:03:27', '2022-11-24 16:03:27'),
('3aebb207dcbbbf93f1d14167768633beffda85238ab20d6b4f2c7ce9d2ee9bad1e864922e59c65d5', 50, 1, 'token', '[]', 0, '2021-12-13 14:26:37', '2021-12-13 14:26:37', '2022-12-13 14:26:37'),
('3b09bf0f751ce8a27f479a6d78c05b9343390ab3db73f89019424f6d90be9ffbbe9873907b223636', 50, 1, 'token', '[]', 0, '2021-11-29 16:04:52', '2021-11-29 16:04:52', '2022-11-29 16:04:52'),
('3b19a6ca39b8a36ddda19e8cb83aa7b84a28b206b51f29f21ca2ee9a9174d9c1719e4598da0249c6', 2, 1, 'token', '[]', 0, '2021-12-07 12:34:46', '2021-12-07 12:34:46', '2022-12-07 12:34:46'),
('3b4c9e5e7ff4aa944656dead5b8a80caa746194e9be965fd2dcd898182cda0d01e325a6b99f38855', 68, 1, 'token', '[]', 0, '2021-12-21 15:54:03', '2021-12-21 15:54:03', '2022-12-21 15:54:03'),
('3b6891e9887e7066708f53aa7533c0e1debabc303326e02333aca3b62cc522ca44cc15fd01796828', 50, 1, 'token', '[]', 0, '2021-11-29 12:49:48', '2021-11-29 12:49:48', '2022-11-29 12:49:48'),
('3b87b7a8110a986c3031517eb3ce757e53ad307d02a8634555cf37705df401c55bb2b1ed660bea9d', 50, 1, 'token', '[]', 0, '2021-11-30 11:51:36', '2021-11-30 11:51:36', '2022-11-30 11:51:36'),
('3ba99eee902291107672a88750814ef891881294dec33046924fcfe8dad8cbbc3d8ce393e4e8c46d', 2, 1, 'token', '[]', 0, '2021-12-06 18:23:43', '2021-12-06 18:23:43', '2022-12-06 18:23:43'),
('3bc08a4a3f6829b4b3dc7fcff56b8d94f2425f6a4fc7df7e72fcc6dd264e07f2e2cb087f19d99bba', 80, 1, 'token', '[]', 0, '2021-12-21 17:34:07', '2021-12-21 17:34:07', '2022-12-21 17:34:07'),
('3c09256bbce5452c9af74f23c92939f40433454ccb16ec1053c1610165df0280c73979818bcd42ee', 50, 1, 'token', '[]', 0, '2021-11-29 16:57:31', '2021-11-29 16:57:31', '2022-11-29 16:57:31'),
('3c2786832790e3374f06905a0d5e22351563618c3dceea941d501d351d658b718f91e592f2d3145f', 2, 1, 'token', '[]', 0, '2021-12-08 12:20:41', '2021-12-08 12:20:41', '2022-12-08 12:20:41'),
('3c306c3f64c57cfb29299ba664a1aa11011afbe58da40155186d5b7273a000cd9d4f771520a55041', 50, 1, 'token', '[]', 0, '2021-12-13 11:25:55', '2021-12-13 11:25:55', '2022-12-13 11:25:55'),
('3c594f9fb4234e78ba834a9a447698dd2916113a1c62f267f38177afed6f8a090945340aee5804ff', 50, 1, 'token', '[]', 0, '2021-11-22 10:02:34', '2021-11-22 10:02:34', '2022-11-22 10:02:34'),
('3c7f320e4da8ecfe8ca958b4afd903d836a08612a0e92717865328b8b2d0614e36623d5f643dfc2b', 2, 1, 'token', '[]', 0, '2021-06-22 18:14:28', '2021-06-22 18:14:28', '2022-06-22 18:14:28'),
('3c83ba82df1709a251c4bbeb98aeb904191773be76422315f18db3a943d6c838434ba5bb2cd9ba74', 80, 1, 'token', '[]', 0, '2021-12-08 12:00:28', '2021-12-08 12:00:28', '2022-12-08 12:00:28'),
('3cbe21838ca6366a36b3e92cf281ac755c7c2249b41d8f30f815f96f39ea3855ed7caf4abc6a1460', 2, 1, 'token', '[]', 0, '2021-06-22 09:43:47', '2021-06-22 09:43:47', '2022-06-22 09:43:47'),
('3d1cbcbb7566d706dbdc7dcfdb0c5ba5ef294a3041987050e812d205e611177562d83a8b3d9cfa1c', 37, 1, 'token', '[]', 0, '2021-11-13 15:36:19', '2021-11-13 15:36:19', '2022-11-13 15:36:19'),
('3d70db05be642ba6138e89c765128d0e5c67c20a4b3c4f20d7d922c387627a4b7dad1f820e948145', 2, 1, 'token', '[]', 0, '2021-11-27 11:29:45', '2021-11-27 11:29:45', '2022-11-27 11:29:45'),
('3db5a7722701a8162e6899308a0a0c4d83dba51d006e0dea7fb9ba2c089a49aaea81da1f52ad5e11', 1, 1, 'token', '[]', 0, '2021-11-26 16:58:10', '2021-11-26 16:58:10', '2022-11-26 16:58:10'),
('3dc909e43ce06bab42c79c2fc560c9080d8388f7fe7e437344141c9d503091142911353fe14e235a', 2, 1, 'token', '[]', 0, '2021-11-30 15:53:09', '2021-11-30 15:53:09', '2022-11-30 15:53:09'),
('3de3d0831b93650645759adee6162f180c83b48f8dda4a519de1ee9e522cb553df68eaf48cd102ca', 2, 1, 'token', '[]', 0, '2021-12-06 12:45:06', '2021-12-06 12:45:06', '2022-12-06 12:45:06'),
('3def2a9677520495dadde4be19b2f22143bd1d18bdbad4fe31707d4ac3e22ad6590208da784a5891', 37, 1, 'token', '[]', 0, '2021-11-17 17:21:57', '2021-11-17 17:21:57', '2022-11-17 17:21:57'),
('3e662a494347677cf616c2d567547071dc5aac3622984d36d986fe2dba51228979881e04fff8599b', 2, 1, 'token', '[]', 0, '2021-11-30 16:56:36', '2021-11-30 16:56:36', '2022-11-30 16:56:36'),
('3f166e5fda00e952c392a1f65e5e0cca283262c10c5570df9a6eae8801f77954326eab24b2ed351e', 2, 1, 'token', '[]', 0, '2021-11-30 18:30:03', '2021-11-30 18:30:03', '2022-11-30 18:30:03'),
('3f4ad7fd805e39fcfe82504f58d1e92e8d7d5330642dbd47319c68026c39797097e19f7678635ece', 2, 1, 'token', '[]', 0, '2021-12-09 11:53:27', '2021-12-09 11:53:27', '2022-12-09 11:53:27'),
('3f4cc4af051b45989970abb6ab887cc23f063c7168a58a69c0ddf0d9b1a3cfbe547d377f413e7485', 37, 1, 'token', '[]', 0, '2021-11-18 11:00:36', '2021-11-18 11:00:36', '2022-11-18 11:00:36'),
('3f8e1f175baa832f4a11c09afce993f3d3fc637a39616da790e36ba74b91f936ecb9459a1e00e21c', 50, 1, 'token', '[]', 0, '2021-12-02 12:09:53', '2021-12-02 12:09:53', '2022-12-02 12:09:53'),
('3f9317912a61cbd6be4cd504cc663bdf7a7b130bf78c9b1f8f4502376f67a7d802e4a0e8bff820cd', 50, 1, 'token', '[]', 0, '2021-11-18 17:55:39', '2021-11-18 17:55:39', '2022-11-18 17:55:39'),
('3f953f04e41fc518c425bbb24aa22dec8b3a343e99a1e8171a54768f248b3fd4146cddd1a9519eca', 2, 1, 'token', '[]', 0, '2021-11-23 15:23:55', '2021-11-23 15:23:55', '2022-11-23 15:23:55'),
('3f97dda630e7d0583d7d86c1e703bee8b517a5eb878f99c133700bb861331360724fc9e1be6e048d', 37, 1, 'token', '[]', 0, '2021-11-18 10:17:00', '2021-11-18 10:17:00', '2022-11-18 10:17:00'),
('3fb64bb5e412279a5f969239f6abc8b69a373d5bc3ea51b2c11b477a640f9754cbff6671acd1fad9', 37, 1, 'token', '[]', 0, '2021-11-16 16:11:26', '2021-11-16 16:11:26', '2022-11-16 16:11:26'),
('3fd24e86f6712fc358a4efb673f0bae176156938a06511fcc41cf265f6f0e16f6d47d87d956b479c', 1, 1, 'token', '[]', 0, '2021-10-28 12:45:17', '2021-10-28 12:45:17', '2022-10-28 12:45:17'),
('3fde2b7c16c08cc9479118214c2f14c159d11647fccf822a9727d38613dc15bcef25a09734f4089c', 76, 1, 'token', '[]', 0, '2021-12-03 12:25:40', '2021-12-03 12:25:40', '2022-12-03 12:25:40'),
('3ff464f543e246ac1392103dd9e3aa39ca5145c36c944b6f7ca24bdf4151fe56025739e3daeb0820', 50, 1, 'token', '[]', 0, '2021-12-01 16:03:32', '2021-12-01 16:03:32', '2022-12-01 16:03:32'),
('3ffdd95c60c26ff7ffd10cb675ba7310f6ad205afdc02173ab4bba9ee56ccac7ca0ac02f43e9ba1a', 51, 1, 'token', '[]', 0, '2021-11-30 18:23:46', '2021-11-30 18:23:46', '2022-11-30 18:23:46'),
('400a9524281d12fcaf56882caffc95e9d86d2b318ec8b45ff242c07e5e26178a06cb6a31a2c97c0d', 50, 1, 'token', '[]', 0, '2021-12-02 17:49:23', '2021-12-02 17:49:23', '2022-12-02 17:49:23'),
('40830ab28fa398fb16284f1132a825410ee76c625e7183459ccbe75401bc96d8c8f98476ec2b6e0d', 2, 1, 'token', '[]', 0, '2021-12-08 15:12:34', '2021-12-08 15:12:34', '2022-12-08 15:12:34'),
('40a27f5cdbb74fe923e4915f6b9874b5762eaa9c529a23341216bfa65e9afef84eaf7f6cdc568d1d', 50, 1, 'token', '[]', 0, '2021-11-30 14:46:11', '2021-11-30 14:46:11', '2022-11-30 14:46:11'),
('40cbbb8970bdafec80cb17bae2047292c91da24e9c6bc315dd4d47a8a364a41971803c27ece4f425', 2, 1, 'token', '[]', 0, '2021-11-26 16:36:59', '2021-11-26 16:36:59', '2022-11-26 16:36:59'),
('40d8e094f8dd7028ca1352af0526deb157b854262fcc3e8c39c5ef42e85f05be6daa19052525bb9b', 37, 1, 'token', '[]', 0, '2021-11-17 18:16:16', '2021-11-17 18:16:16', '2022-11-17 18:16:16'),
('41179f7f6e26f32bd1ff2841b8f62488e6375f5c6ff84a01f6bc93d2fa01b15269f155593ff0ea26', 2, 1, 'token', '[]', 0, '2021-12-14 10:27:01', '2021-12-14 10:27:01', '2022-12-14 10:27:01'),
('4118b159679e63ff479b3ec4520c5cbee5493312ab41c68c14cb51ac8c9f181b462f562ecc675723', 50, 1, 'token', '[]', 0, '2021-11-30 11:53:23', '2021-11-30 11:53:23', '2022-11-30 11:53:23'),
('413d6c287c2ab792b4a589507aac8fad5441ad753da148ae860ee29385efa91e7cb623f38e999ded', 50, 1, 'token', '[]', 0, '2021-11-19 11:05:01', '2021-11-19 11:05:01', '2022-11-19 11:05:01'),
('417216d01c156a632144619d89a2d7f9fa1c24ca328696717b1ea9118ed396b04a8cf23bdb69ab18', 48, 1, 'token', '[]', 0, '2021-11-29 11:11:15', '2021-11-29 11:11:15', '2022-11-29 11:11:15'),
('41777466eb3d33d3b08713cf13f9fd0e14fdffe526405e5d6f37ae7c5d797660bbeefe1cc06695fc', 51, 1, 'token', '[]', 0, '2021-11-19 14:55:23', '2021-11-19 14:55:23', '2022-11-19 14:55:23'),
('41d6e7828081fba130ba26f77c17e4349a8aebce35213aaf9027be37b928d4d30e4a2a35ca1dd8e3', 50, 1, 'token', '[]', 0, '2021-11-26 15:34:17', '2021-11-26 15:34:17', '2022-11-26 15:34:17'),
('422d4d001914602bb2bd2f066f52b10b31b5fe4c440a10c2732db7f40b3b09385e50ff62ab56d2ea', 61, 1, 'token', '[]', 0, '2021-12-01 09:52:58', '2021-12-01 09:52:58', '2022-12-01 09:52:58'),
('428e5de46f91ed9132ab131246fa2f9e4b44aed31aba23119e44f85e512103ba06282fb18d717860', 2, 1, 'token', '[]', 0, '2021-11-02 16:00:40', '2021-11-02 16:00:40', '2022-11-02 16:00:40'),
('42c937f26b971a7b6bf9ddf9c7e27bf32c382583a11552b2607d8cd7a785604c307ff27ac47a35a7', 51, 1, 'token', '[]', 0, '2021-11-30 18:26:50', '2021-11-30 18:26:50', '2022-11-30 18:26:50'),
('42d9a8605472118158b743d3dc33369b0c55f6a0e396a420813694679809c499fbc5ea263fdfeede', 37, 1, 'token', '[]', 0, '2021-11-18 10:57:59', '2021-11-18 10:57:59', '2022-11-18 10:57:59'),
('42e6d47543d7562230ff9c3b915f30e36cee328c97d4f9507ca7bd78e6593bcc33784da15e0dce2b', 78, 1, 'token', '[]', 0, '2021-12-03 12:28:08', '2021-12-03 12:28:08', '2022-12-03 12:28:08'),
('4371b44fe3e1683117bb76524d436b4c05aeb312711faec4bb6764bbb5cec839172ca28e1b007145', 50, 1, 'token', '[]', 0, '2021-12-02 16:31:59', '2021-12-02 16:31:59', '2022-12-02 16:31:59'),
('43aa3fadeddec0a4ac6c37df04719d1565247bac8dd6013bcec0f56ec23562039a740b40244ac883', 37, 1, 'token', '[]', 0, '2021-11-12 18:00:36', '2021-11-12 18:00:36', '2022-11-12 18:00:36'),
('43e22af0375b46c7fb8ac5cb9dcadd642b68786027a972f55b6e0130ae86ccda68ea9d1d0b08bdd9', 58, 1, 'token', '[]', 0, '2021-11-30 22:28:41', '2021-11-30 22:28:41', '2022-11-30 22:28:41'),
('43e7027ebec95b717f3ea5060fcda0c638efa93fa1072fb09f2a2c30f35acf996194db7a7750d037', 2, 1, 'token', '[]', 0, '2021-12-04 11:11:21', '2021-12-04 11:11:21', '2022-12-04 11:11:21'),
('447177717297a67dac632cc15d65e884af795bc3c28266307cff14a9b74a4f0b9950bc913e014a80', 3, 1, 'token', '[]', 0, '2021-05-25 04:36:15', '2021-05-25 04:36:15', '2022-05-25 10:06:15'),
('4498937ab27b464a74e7f586bfdf142bd1ff933b84bc4b530e65e38d5760b17d506fbe8c960f15bc', 50, 1, 'token', '[]', 0, '2021-11-27 15:53:10', '2021-11-27 15:53:10', '2022-11-27 15:53:10'),
('44a5b2804e19ce9e94ccf2351cc174bb564209cccb40e06b14891ef3977ba58e78fe6e285abac988', 2, 1, 'token', '[]', 0, '2021-12-04 11:14:04', '2021-12-04 11:14:04', '2022-12-04 11:14:04'),
('44d1bb7a3fa3e45bf40f8b25fbc0a822335cbb30aeb5f11e7de9a8895dd14e4cff8a403bbdc6cd78', 2, 1, 'token', '[]', 0, '2021-12-07 12:43:18', '2021-12-07 12:43:18', '2022-12-07 12:43:18'),
('44d2c193f3700d555f55c15723b8b1ac2648d5317ee2868e1773091d31ce574139471077cccb97de', 37, 1, 'token', '[]', 0, '2021-11-18 10:23:01', '2021-11-18 10:23:01', '2022-11-18 10:23:01'),
('44fd1865866650ce101486ca939c6a8befef7e950dec13edd5430121374f8d94944e5813c19421ca', 48, 1, 'token', '[]', 0, '2021-11-18 18:20:39', '2021-11-18 18:20:39', '2022-11-18 18:20:39'),
('44fe4408dfd71d1e61a0f318f5dc5e0aa106c984bcb1ba7ead31db839d2542610d3759e57bb41ca9', 51, 1, 'token', '[]', 0, '2021-11-30 17:27:44', '2021-11-30 17:27:44', '2022-11-30 17:27:44'),
('4541106baa38897026fcd4f7f05c1264c68e3fefd35af17ae5b4aba5191a50a3195a704985e09b50', 50, 1, 'token', '[]', 0, '2021-12-01 10:21:51', '2021-12-01 10:21:51', '2022-12-01 10:21:51'),
('4561578175215e12b83176900af3d6f606c826e2f319b44bf4d0abbaf90973e45276765ddbde5741', 48, 1, 'token', '[]', 0, '2021-11-20 09:39:42', '2021-11-20 09:39:42', '2022-11-20 09:39:42'),
('4562abb5c965eb3a10e142c41ea32124663427f769a23f3aa16f1fe9706fa76e9f0b904e10d0f803', 37, 1, 'token', '[]', 0, '2021-11-18 11:03:54', '2021-11-18 11:03:54', '2022-11-18 11:03:54'),
('456cfb9cf94544b1ff40af05a3bdd92474994b1c7aa7ea03b6d56efd2e8852be26a69003175fb92d', 2, 1, 'token', '[]', 0, '2021-06-21 15:09:26', '2021-06-21 15:09:26', '2022-06-21 15:09:26'),
('45a0ef915450de63e5fa3b1d0cfe5fb4c8624b74c4b3769f0fdc26f2cec829b921ff1efc37e6f4f1', 2, 1, 'token', '[]', 0, '2021-11-12 12:37:25', '2021-11-12 12:37:25', '2022-11-12 12:37:25'),
('45da678f40f2642f50382b7145e07f6cad091532e7c03b5a297c029c91eebaba857a95ced7d11b7a', 2, 1, 'token', '[]', 0, '2021-12-20 11:31:28', '2021-12-20 11:31:28', '2022-12-20 11:31:28'),
('45ee630551f2ef144179197d9eb58a26f2a0ae0d420054043350061b4d04a15825d89bd6fb27c508', 2, 1, 'token', '[]', 0, '2021-12-14 11:40:12', '2021-12-14 11:40:12', '2022-12-14 11:40:12'),
('45f39f180ff1b10f6e44741d09280e802398cbe923a0fb8fbbf2b16e7fa679ad355862ae5ee81aa9', 37, 1, 'token', '[]', 0, '2021-11-18 12:54:10', '2021-11-18 12:54:10', '2022-11-18 12:54:10'),
('45f5a67a02729dd8e10d45ec00ddfab25e576d704ba2a6042271aa3e0946869c997196073f2bfcb2', 2, 1, 'token', '[]', 0, '2021-06-10 08:54:26', '2021-06-10 08:54:26', '2022-06-10 08:54:26'),
('45f7d64199a655a804e01d8e604650abf0c029f2a43d44fdb58e4b1c78dd090e775e3ecbecd0963d', 37, 1, 'token', '[]', 0, '2021-11-18 10:44:38', '2021-11-18 10:44:38', '2022-11-18 10:44:38'),
('463b1da8210d3b32aa30b70e530377202e258672c880f39fd43adce6f0ae2965933f346538c9c4c1', 2, 1, 'token', '[]', 0, '2021-12-13 12:30:31', '2021-12-13 12:30:31', '2022-12-13 12:30:31'),
('464a8bd653886f1f93ddc8b3cda0aa544a6d8699db5cd8f181ec204779f19eeda3c8ef5c32b96e75', 37, 1, 'token', '[]', 0, '2021-11-18 10:40:02', '2021-11-18 10:40:02', '2022-11-18 10:40:02'),
('469b013f1f709bc86e44ea2a51b1438ca198701303dd27b53d532511f325e192d7031be254f92589', 89, 1, 'token', '[]', 0, '2021-12-07 10:40:08', '2021-12-07 10:40:08', '2022-12-07 10:40:08'),
('46bc0b1620e715afdadc46aa47321b0def7de5296ba73383056f442eb8692ccad8799f7c5692d160', 50, 1, 'token', '[]', 0, '2021-12-03 10:34:12', '2021-12-03 10:34:12', '2022-12-03 10:34:12'),
('46c393e04fbc0cd09d182e8096da6ac7efdb2ac34e51a96081bcccf2dea4e31570d41ae3150eebed', 37, 1, 'token', '[]', 0, '2021-11-13 10:31:15', '2021-11-13 10:31:15', '2022-11-13 10:31:15'),
('4758e4806b40c4e691c38d8b21d7fbd2495ba2737b57efb78adf03d837f384e6b145bff448ba2506', 80, 1, 'token', '[]', 0, '2021-12-07 10:33:18', '2021-12-07 10:33:18', '2022-12-07 10:33:18'),
('47c5de695902867583695e9f76fb1e7cd88809169778ea1b5fc371f37577de86cfd99db95a50641e', 2, 1, 'token', '[]', 0, '2021-11-11 11:24:47', '2021-11-11 11:24:47', '2022-11-11 11:24:47'),
('4811d814270c45c74cad3dadaa9529bbb1be2e51b39483544f7ee1b02c22456800921df2d42dac76', 50, 1, 'token', '[]', 0, '2021-12-13 14:46:15', '2021-12-13 14:46:15', '2022-12-13 14:46:15'),
('4817f52466fef1e0f49074142c78aa630d66df11fbdc849963dad0e46fc086d0d56a12bacdbf06b8', 2, 1, 'token', '[]', 0, '2021-12-16 16:53:18', '2021-12-16 16:53:18', '2022-12-16 16:53:18'),
('487983b189e46273c3810a6fd7482ab4abb4883939c2fd20dac32b164f3a36517276705b5429f427', 50, 1, 'token', '[]', 0, '2021-12-01 11:07:22', '2021-12-01 11:07:22', '2022-12-01 11:07:22'),
('4885f84cf4693b2e80f1343dd43e4118843d0707307179815c6339f3260e66f879988dbe3471b821', 61, 1, 'token', '[]', 0, '2021-12-02 19:24:38', '2021-12-02 19:24:38', '2022-12-02 19:24:38'),
('4888d7e0ab367e16d46f4c3e4d38b6c725e7983d4cec8833f463476aa9b809a3859e7847bd00ebbe', 80, 1, 'token', '[]', 0, '2021-12-21 13:34:32', '2021-12-21 13:34:32', '2022-12-21 13:34:32'),
('4894733e27d0f3d2e64a9144dd7a3cc549c8da16677fbb6fe368359f0962bb473755a8d99d13b146', 50, 1, 'token', '[]', 0, '2021-12-13 14:54:34', '2021-12-13 14:54:34', '2022-12-13 14:54:34'),
('48b82ea012f66d60bfa15de28ea764dc862f5531fd1df50f850b654245162845f4625daabbdd08bf', 50, 1, 'token', '[]', 0, '2021-11-24 17:09:01', '2021-11-24 17:09:01', '2022-11-24 17:09:01'),
('48bc1884ef9b3400a1cda200e95cc7fd7c613f90bf6e8ad57d9de12717f71124786d598324acac3a', 2, 1, 'token', '[]', 0, '2021-12-13 14:41:11', '2021-12-13 14:41:11', '2022-12-13 14:41:11'),
('48d655e07779afbd37ea0cafa58052b3efd549afe58715378a620713d89c2a4a714ce7a4021756fd', 2, 1, 'token', '[]', 0, '2021-11-30 11:00:36', '2021-11-30 11:00:36', '2022-11-30 11:00:36'),
('4920981b0f72809e88ed5d00c82e1fdfb18910b7c1694b86fd1e57da31fad7bfe873eb6dd3a74b13', 2, 1, 'token', '[]', 0, '2021-12-10 18:27:57', '2021-12-10 18:27:57', '2022-12-10 18:27:57'),
('492b989a748400ab571e6917708c82b0e60f05a19ba4aed460e946b4d81005c23b63fd00c43fb9a0', 37, 1, 'token', '[]', 0, '2021-11-18 10:19:36', '2021-11-18 10:19:36', '2022-11-18 10:19:36'),
('493299807f323cb42014597ef155c97d3c5ed9c614b3d0ec7a5edae096428dc8ea14c8e51e8c4c39', 80, 1, 'token', '[]', 0, '2021-12-21 14:48:30', '2021-12-21 14:48:30', '2022-12-21 14:48:30'),
('497fab0e469f5fb93d43acd0468a1b31cd9e2eed59bb6cff0e1bb1ffa01931a2d3d3d3ab959281be', 50, 1, 'token', '[]', 0, '2021-12-13 12:55:41', '2021-12-13 12:55:41', '2022-12-13 12:55:41'),
('49cd661ab85607b7274fd3cc580e1d1372ec0b2a1f45c88e0c286db90c048a3d8e95ae37a0288553', 50, 1, 'token', '[]', 0, '2021-12-02 12:06:35', '2021-12-02 12:06:35', '2022-12-02 12:06:35'),
('4a033c29ea6e81a2dfcb0ae36b3dda8f2d235758ca53a6950aee45dab4a4267dd8f4565fea57a53c', 50, 1, 'token', '[]', 0, '2021-11-22 12:06:10', '2021-11-22 12:06:10', '2022-11-22 12:06:10'),
('4a82f6f754e016c812e159bdcfe20138411bd3f4c58bfea0ec8341cc2f5a588e0f0972f439cae945', 68, 1, 'token', '[]', 0, '2021-12-03 13:50:51', '2021-12-03 13:50:51', '2022-12-03 13:50:51'),
('4a8fb180de153528079a4a362f9ba7c275fcf885fcc0c8dcec598634b77a7917e1c72b27b81d275c', 2, 1, 'token', '[]', 0, '2021-12-14 12:02:17', '2021-12-14 12:02:17', '2022-12-14 12:02:17'),
('4aa06794e40190009f055048e2ff7ada06bc0b1df1606d282a404c0289d1ce2ea902d9edaa0b73ff', 50, 1, 'token', '[]', 0, '2021-12-02 11:41:46', '2021-12-02 11:41:46', '2022-12-02 11:41:46'),
('4aaff1645f4df478bfcb03d42f93b866aa7eecde09289dbf2cdae7e449cb96902959e290866f7f5f', 2, 1, 'token', '[]', 0, '2021-11-19 17:43:28', '2021-11-19 17:43:28', '2022-11-19 17:43:28'),
('4b3c1986b329ade9e22b93bd373d2816298f3a55d2832733b87a07f4722a135c4d060e62312b49b0', 50, 1, 'token', '[]', 0, '2021-11-30 18:57:19', '2021-11-30 18:57:19', '2022-11-30 18:57:19'),
('4b6443251a7454c9e920918a9c063607f9ab8bec579f9e855d91c6affdfae799eee8dbde2f2534a4', 50, 1, 'token', '[]', 0, '2021-11-30 12:07:26', '2021-11-30 12:07:26', '2022-11-30 12:07:26'),
('4b757e5e4d8a1cbc473b59ebff7220a6c18e66cb8966be4cb90ea7b925f52ece551468c4a4cbf318', 50, 1, 'token', '[]', 0, '2021-11-30 11:49:41', '2021-11-30 11:49:41', '2022-11-30 11:49:41'),
('4b9ba52e42f12d5b6c7ecaca7590b0a467c1a415eb533552d078eb5597c12c078ba64760916bb902', 61, 1, 'token', '[]', 0, '2021-12-01 10:54:55', '2021-12-01 10:54:55', '2022-12-01 10:54:55'),
('4bae940fb6a421f857b3632e62fe3df0cee1ee6843e95504ee7da8c5a7a1e1c5b1e802a49646bf6e', 2, 1, 'token', '[]', 0, '2021-12-07 18:29:15', '2021-12-07 18:29:15', '2022-12-07 18:29:15'),
('4bc5f6b9d8a08eb03566837572ad6098eb52ddae7a2d7af5c3dd1240f0a4e801e65b081bb45be078', 37, 1, 'token', '[]', 0, '2021-11-17 16:29:38', '2021-11-17 16:29:38', '2022-11-17 16:29:38'),
('4bfdaacfe919ebace6929919bd48f81efd35108e9b6c467dc888f84369aa35ceef69f347db08b8b4', 50, 1, 'token', '[]', 0, '2021-12-01 16:25:30', '2021-12-01 16:25:30', '2022-12-01 16:25:30'),
('4c316100f8940f0920b9084240554769fa05934c0689214762cac3ad2283aaec3755e1b7e62d0f4d', 2, 1, 'token', '[]', 0, '2021-11-26 19:29:07', '2021-11-26 19:29:07', '2022-11-26 19:29:07'),
('4c728667e62f83955f4fbe45e4f96ca6506b0061cb3bbc3d070212f16907ab78ec9bcb2270ac6909', 50, 1, 'token', '[]', 0, '2021-12-02 14:48:10', '2021-12-02 14:48:10', '2022-12-02 14:48:10'),
('4c8a8d318aea47fa3496b09cdc57d6af263d667a09cd7297e3d0d1b5e85b91dad8418e786f9da002', 1, 1, 'token', '[]', 0, '2021-11-30 15:31:15', '2021-11-30 15:31:15', '2022-11-30 15:31:15'),
('4cd5db4e97e3de6921b4dd4dd736f026589fa23f813755ca947d972b1147bf3aefc9c88939be46af', 48, 1, 'token', '[]', 0, '2021-11-19 18:19:27', '2021-11-19 18:19:27', '2022-11-19 18:19:27'),
('4cf5a13ead2609bd047e671e8564852bd98cf6d1706cbfcfcbc0994608665e72068eeca1f7aa6248', 2, 1, 'token', '[]', 0, '2021-11-26 15:41:27', '2021-11-26 15:41:27', '2022-11-26 15:41:27'),
('4d109e86e61071837a8c6e0782f159dc85e1c0ead9739733379bdf7ef414625ccc89e74b9e9857b3', 2, 1, 'token', '[]', 0, '2021-12-14 10:38:35', '2021-12-14 10:38:35', '2022-12-14 10:38:35'),
('4d4d883e8ad2424d80babd3773cd6ae0ee4fb380eb15bf47358f1b948f24c58fd8d10a020b86bd75', 61, 1, 'token', '[]', 0, '2021-12-01 11:28:02', '2021-12-01 11:28:02', '2022-12-01 11:28:02'),
('4d4f8c4e09f4bb93454cbb7243c65a8963504baf4b857c61700b4e45d271c01bba34f46d67c38312', 2, 1, 'token', '[]', 0, '2021-12-04 11:11:41', '2021-12-04 11:11:41', '2022-12-04 11:11:41'),
('4d4f9a4d08d21c13b9ad90dc16c555aa6de63d55387c3bafd3256990a05fc6294b1f03b13ad39105', 37, 1, 'token', '[]', 0, '2021-11-16 15:48:56', '2021-11-16 15:48:56', '2022-11-16 15:48:56'),
('4d5213adeb36a0be234de59fc0b8fde97d0a6197a6ab752dc9b3e76888f601a3470468914d1a9447', 37, 1, 'token', '[]', 0, '2021-11-13 17:45:02', '2021-11-13 17:45:02', '2022-11-13 17:45:02'),
('4d665770b9faf8a570821319dfda33de1cd3a0cb7a4f9c6bddc34fe5574d435a3538c0014aff69d6', 50, 1, 'token', '[]', 0, '2021-12-03 12:27:12', '2021-12-03 12:27:12', '2022-12-03 12:27:12'),
('4d86bf489b482bec187215049bed572211285f83ab3beb9b62f2e79b68818ec3308899f64674d049', 50, 1, 'token', '[]', 0, '2021-12-13 12:49:07', '2021-12-13 12:49:07', '2022-12-13 12:49:07'),
('4d8cf14853cd20588345f71fc9617adba8d76b2185176d0b682686bcf68381d36a88972470399270', 37, 1, 'token', '[]', 0, '2021-11-16 10:22:29', '2021-11-16 10:22:29', '2022-11-16 10:22:29'),
('4dc5a3d8d40648bb91bc1cd6c9b370ddd6f1dbbfab661dd77d29c7df8ad132471de6c44b48e230ed', 2, 1, 'token', '[]', 0, '2021-06-10 09:10:08', '2021-06-10 09:10:08', '2022-06-10 09:10:08'),
('4dcbe8d8b4214a4bdf117262be632711c2a2751429d5829d710ab5e6318b7569eed119bcd725c081', 2, 1, 'token', '[]', 0, '2021-12-07 10:55:20', '2021-12-07 10:55:20', '2022-12-07 10:55:20'),
('4de996041e4ae16e328b7d2bfdd17701537dcf149fd6edafe2aadeae2b99467fbc222be1e6a83db7', 50, 1, 'token', '[]', 0, '2021-11-24 16:45:33', '2021-11-24 16:45:33', '2022-11-24 16:45:33'),
('4e33120d2d9bb00e8929ce75147e2e55c9835ded16ed65b537b28e02df526e6bbf4874b793fb1818', 2, 1, 'token', '[]', 0, '2021-12-07 16:01:38', '2021-12-07 16:01:38', '2022-12-07 16:01:38'),
('4e35e6e216dc91bcabf5a70e8fce8a24bebb0bce99d150a2e08488f7311c6558bb23b5d3578e8e3f', 50, 1, 'token', '[]', 0, '2021-11-26 15:34:22', '2021-11-26 15:34:22', '2022-11-26 15:34:22'),
('4e366d544fc7207c1728fa03d152d56a6cc3e6ca1f84c70fe163984e8eb347900db226bf6bb262c0', 50, 1, 'token', '[]', 0, '2021-11-24 16:05:50', '2021-11-24 16:05:50', '2022-11-24 16:05:50'),
('4e3741495bae493c6d3ac6b47755966174848d80f7690f166827c837f6a77cbf97744531a958c12d', 50, 1, 'token', '[]', 0, '2021-11-24 16:52:29', '2021-11-24 16:52:29', '2022-11-24 16:52:29'),
('4e6a0f76de538777cb34a4f33c5c41273bb23e775c465857644cd67c5df10fe1cba19de3f0614947', 37, 1, 'token', '[]', 0, '2021-11-17 18:36:05', '2021-11-17 18:36:05', '2022-11-17 18:36:05'),
('4e80a4171e22341ee7678f25d4515ef4949ca21fe81d1b4dd533bb9f4f7f5dcadbf129bee9742c31', 48, 1, 'token', '[]', 0, '2021-11-29 18:05:24', '2021-11-29 18:05:24', '2022-11-29 18:05:24'),
('4eb5807e53677eabf6d3da5af8c27a0d1bae66491d0634862af189a838b493f264c4ba1dbbdc9371', 2, 1, 'token', '[]', 0, '2021-06-17 10:08:20', '2021-06-17 10:08:20', '2022-06-17 10:08:20'),
('4ecb29d20ec6033f6b5094cb0b63442f6e8ed059b47fdeab0b7e70707db94c9139ea37c70b97dd93', 68, 1, 'token', '[]', 0, '2021-12-13 15:43:38', '2021-12-13 15:43:38', '2022-12-13 15:43:38'),
('4ece6d254156868f39aa268ecf3ce81ba51143745ec84034e3768483ef0d58d7ef3ce07c9319d3a9', 37, 1, 'token', '[]', 0, '2021-11-18 12:29:47', '2021-11-18 12:29:47', '2022-11-18 12:29:47'),
('4f006d545b47dad1c0c3868d2dd5665b069158e00407867632e5331a4d532e1697d508ff5ed6dc36', 50, 1, 'token', '[]', 0, '2021-11-29 12:49:50', '2021-11-29 12:49:50', '2022-11-29 12:49:50'),
('4f18915db0f2cfc13b21ea84a87b26017c02d993ecb16631b90592068495e4e8de254d9536b9a306', 2, 1, 'token', '[]', 0, '2021-11-30 15:32:28', '2021-11-30 15:32:28', '2022-11-30 15:32:28'),
('4f64365b5040a8175937ba315f1a92ced832ff23060c44f82c805a3fc52a9807283c5bc34d17c681', 50, 1, 'token', '[]', 0, '2021-11-30 13:01:35', '2021-11-30 13:01:35', '2022-11-30 13:01:35'),
('4fd21b507d6146456bb522b89857b40acec03f6031bef58a867fe780b795275915e3c8086b79417d', 50, 1, 'token', '[]', 0, '2021-11-27 18:00:27', '2021-11-27 18:00:27', '2022-11-27 18:00:27'),
('501d4a3fe811ec4d45f58fc0b5da005a7a77b2a87d74ddd577d55bab49e2e0a7176da87706d6d744', 50, 1, 'token', '[]', 0, '2021-12-03 13:11:37', '2021-12-03 13:11:37', '2022-12-03 13:11:37'),
('502578e76170aaf072257f5237f56a423ce4693a43298c42d31e2f25b39ba00bfeb0e84221537ec1', 2, 1, 'token', '[]', 0, '2021-11-30 15:32:23', '2021-11-30 15:32:23', '2022-11-30 15:32:23'),
('50292f38facf81d1960d6a11322bd24297759db8d8f54c27e4248dcce4c7542cd87bb16c7954cea3', 37, 1, 'token', '[]', 0, '2021-11-18 10:56:17', '2021-11-18 10:56:17', '2022-11-18 10:56:17'),
('5029754e022c4230420adae1e40ca96e860f5c9a23718ca4906bf6fc6a5eb4f099250ff52c3e8f6c', 37, 1, 'token', '[]', 0, '2021-11-18 10:46:03', '2021-11-18 10:46:03', '2022-11-18 10:46:03'),
('5062f6770488aeaffe85609def330d87e2b41917e022d7cd70aa366dc00fadd6989b385a3d509ae7', 68, 1, 'token', '[]', 0, '2021-12-21 15:36:12', '2021-12-21 15:36:12', '2022-12-21 15:36:12'),
('508477140c4a6e0fd6d740cb74442d5390f24909609aa47361fecc7abfdc2605f3f548cfafda78c4', 50, 1, 'token', '[]', 0, '2021-11-30 15:08:18', '2021-11-30 15:08:18', '2022-11-30 15:08:18'),
('5090bc761baa98d925385422cd264579b3da9cf127e740f8394675130f79e8e77bfc3a1f9aa429b1', 2, 1, 'token', '[]', 0, '2021-06-22 09:01:38', '2021-06-22 09:01:38', '2022-06-22 09:01:38'),
('5090fb139702b9d552e5f0fbe58853ecff92247e13549a200623dc178f6ae15b13ec40f2410d0711', 2, 1, 'token', '[]', 0, '2021-10-27 11:57:43', '2021-10-27 11:57:43', '2022-10-27 11:57:43'),
('50b2f413d81b9be0840258c2b051109582469a120791735c41a92cf7980d1debaa788b811405ef98', 2, 1, 'token', '[]', 0, '2021-11-13 12:34:55', '2021-11-13 12:34:55', '2022-11-13 12:34:55'),
('50b446a7e5806041322768d9ae926803f9f402675278e25a59ebdc1b3bd2e0ca8195d39e77318c48', 50, 1, 'token', '[]', 0, '2021-11-29 17:17:56', '2021-11-29 17:17:56', '2022-11-29 17:17:56'),
('50b830d6b3fa00b9e26cb05e7d17176eab4bc1099c13158ad3c5212fe901bbc6ba5a052e1910d649', 37, 1, 'token', '[]', 0, '2021-11-18 15:20:04', '2021-11-18 15:20:04', '2022-11-18 15:20:04'),
('50e25fe24fe1bea47b191a77f55958cc684ec1375d1fe73614633f3287b6624332691b756832392a', 2, 1, 'token', '[]', 0, '2021-06-16 19:46:52', '2021-06-16 19:46:52', '2022-06-16 19:46:52'),
('5116a1b50df606f243334f4d03bfd531b8e1b1d3bf0d1bf9a7e08dbf364aecd2276f64f8b08813b8', 50, 1, 'token', '[]', 0, '2021-11-24 17:14:38', '2021-11-24 17:14:38', '2022-11-24 17:14:38'),
('511e19c7bc8a6a9d3d85f8da5db49da50d852f35544a21b0f0ad289f70c4a684596c1b8bfe15bc85', 2, 1, 'token', '[]', 0, '2021-11-13 17:59:35', '2021-11-13 17:59:35', '2022-11-13 17:59:35'),
('515bcb731944544ad375e207fa3c0f8a5fda6690ad82b5a27dfd4a1b7b9e7cbcce9e9478a0b04240', 51, 1, 'token', '[]', 0, '2021-11-30 17:39:58', '2021-11-30 17:39:58', '2022-11-30 17:39:58'),
('518240eb9f3dc66785569ef2ec8df6b98f151eefe0e7dc3c7c51f5527cfbf8dbf361bdce45ae4089', 2, 1, 'token', '[]', 0, '2021-12-04 12:42:02', '2021-12-04 12:42:02', '2022-12-04 12:42:02'),
('51e8baf4946a159be48785cec8bd28d0ee411562cc02e966149a17dac6c33b641ce5f98655bf29c7', 2, 1, 'token', '[]', 0, '2021-11-26 14:50:59', '2021-11-26 14:50:59', '2022-11-26 14:50:59'),
('51f45cc64a4c0085cdf6b280091cc7faabf8c7e7511655ee08c56b9ee5f11a459dd2236e2f6bec58', 50, 1, 'token', '[]', 0, '2021-11-30 19:19:27', '2021-11-30 19:19:27', '2022-11-30 19:19:27'),
('52198eb67d3bb90e6098a565aaab94653c75ef921744322469b4a4598eee6f902f094917156597d6', 2, 1, 'token', '[]', 0, '2021-11-16 10:03:56', '2021-11-16 10:03:56', '2022-11-16 10:03:56'),
('522c21c1fc3e77a5a26f9d038b593afe582208ebc436d0b1fea678c09b7ef9702b1099f089cb07fd', 50, 1, 'token', '[]', 0, '2021-11-20 11:39:49', '2021-11-20 11:39:49', '2022-11-20 11:39:49'),
('523132b25b333a84967929ddee379acb173bc1c8f9d6d4d04f5d49aa6f4cad342cb3d816693dbb76', 58, 1, 'token', '[]', 0, '2021-11-30 22:34:28', '2021-11-30 22:34:28', '2022-11-30 22:34:28');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('52425d14a913ec236a76c498589acc040697d6be65a0f4031ce5f47c4e91c8a57d83f00be7c078fd', 2, 1, 'token', '[]', 0, '2021-12-08 15:55:42', '2021-12-08 15:55:42', '2022-12-08 15:55:42'),
('525fe4aa51e7526048d0d9f46d9f7dbed64d5f982a35f5d92efa9f3533586c260b10b8be1b846a10', 2, 1, 'token', '[]', 0, '2021-11-30 15:14:06', '2021-11-30 15:14:06', '2022-11-30 15:14:06'),
('52a4df9358bd9b5b71a358c9938a4df3eec470cfeb4fa0d4495a5db4a2f264905a92dc5131bc33ae', 2, 1, 'token', '[]', 0, '2021-12-03 18:01:08', '2021-12-03 18:01:08', '2022-12-03 18:01:08'),
('52bdc9ecb2087a79673c5b0b4ac0ae429a3040af5c89268604d2b4ceb73f607b69d5b77abb3c35de', 51, 1, 'token', '[]', 0, '2021-11-30 17:59:58', '2021-11-30 17:59:58', '2022-11-30 17:59:58'),
('53065a744acbd59f22dbc7f8f008d451c5bd9a01db5d791da416222f9d567f11ef9f565500ca8eb9', 50, 1, 'token', '[]', 0, '2021-11-24 17:51:50', '2021-11-24 17:51:50', '2022-11-24 17:51:50'),
('53473ea8ac6982e0830883fca91063814118d3cc02e4aedb73f13af8bbbe24ae962677e24cf8733f', 37, 1, 'token', '[]', 0, '2021-11-17 18:16:23', '2021-11-17 18:16:23', '2022-11-17 18:16:23'),
('5354ba2e8a1f7d81360b9f9683b87d3fd796b58c937025c0d058a4ad0feefa3897a510a0e1cd3387', 2, 1, 'token', '[]', 0, '2021-06-22 20:12:02', '2021-06-22 20:12:02', '2022-06-22 20:12:02'),
('5359d56a2cd2c4b7409550b87ad6887889fbbbebb1e694445b433ce27b44272adfd80178c73e29eb', 48, 1, 'token', '[]', 0, '2021-11-18 18:22:51', '2021-11-18 18:22:51', '2022-11-18 18:22:51'),
('53727d264b42694e5a33ef5acc7728192b89c5f3b5242084ac4ecbdf0b9184fcd3c039c848bbd134', 2, 1, 'token', '[]', 0, '2021-11-23 16:54:06', '2021-11-23 16:54:06', '2022-11-23 16:54:06'),
('537ef70ca2b58455b75025a5efb88857f18fd1b41aebffa14d88073706674feb0f9fac4e5cbe2dc3', 50, 1, 'token', '[]', 0, '2021-11-30 19:12:56', '2021-11-30 19:12:56', '2022-11-30 19:12:56'),
('5381f74be93e7211e0f12f36bdab1a5f9b3580fe08f3837ea1400a5ff2211ca7b011158ed812b170', 2, 1, 'token', '[]', 0, '2021-12-06 18:07:08', '2021-12-06 18:07:08', '2022-12-06 18:07:08'),
('538c34d937332add506bf1e01301c0304c9b2ef0fd3a57416e3ab01ffccb04415c34822deea74106', 2, 1, 'token', '[]', 0, '2021-12-09 09:52:02', '2021-12-09 09:52:02', '2022-12-09 09:52:02'),
('53aca3c79389a7d68398b3b069f9e851595d0f8a4a44a3809175a4939e23411ff0427789b668e612', 37, 1, 'token', '[]', 0, '2021-11-18 10:19:58', '2021-11-18 10:19:58', '2022-11-18 10:19:58'),
('53ef98db311156ec5ac71677d3f0464ed1245be75baa08394beb1ea621ffee44aec1fd0c1c45522e', 37, 1, 'token', '[]', 0, '2021-11-18 10:23:02', '2021-11-18 10:23:02', '2022-11-18 10:23:02'),
('540fb3c88519f7e0c698ad7279af945e1c689f4a3ecb758ba4a59a98e423108ca9e773a3690b3bdb', 2, 1, 'token', '[]', 0, '2021-12-04 17:38:14', '2021-12-04 17:38:14', '2022-12-04 17:38:14'),
('545f1ea6809ec1681adba27806eceaf3d377c09b261f7617ec235b4f84fe0e6aca802ef6417912b7', 2, 1, 'token', '[]', 0, '2021-12-07 11:33:44', '2021-12-07 11:33:44', '2022-12-07 11:33:44'),
('5466cce88d89758bdcfd155780bd68f70a29f3efa95d01cfb48cc40ac8157ee71d9cc9359207aefa', 1, 1, 'token', '[]', 0, '2021-10-21 15:14:24', '2021-10-21 15:14:24', '2022-10-21 15:14:24'),
('5468a4562771d2937d18b97c840a794128c40fed14ad84c467ed30791fa95301724a0b113e8efa88', 37, 1, 'token', '[]', 0, '2021-11-18 10:34:21', '2021-11-18 10:34:21', '2022-11-18 10:34:21'),
('54be7babf18118811a718dbbb5eefddfcd4967605e61793f2baf0a7df92cf461241d9cb2ba5c0885', 80, 1, 'token', '[]', 0, '2021-12-21 15:31:56', '2021-12-21 15:31:56', '2022-12-21 15:31:56'),
('54c0fafd7163723b0c09fd58948982efb12dd6e36246dbf8df09011152c682d9c0b88714babbbab0', 66, 1, 'token', '[]', 0, '2021-12-01 12:19:00', '2021-12-01 12:19:00', '2022-12-01 12:19:00'),
('54e152750c27f9cb85bc256c97ab9b9986bf1d01725ddb5e49ea9e4409fab40543be8dc0d6aca2df', 50, 1, 'token', '[]', 0, '2021-11-30 12:49:12', '2021-11-30 12:49:12', '2022-11-30 12:49:12'),
('54e9be3508ff76fffe840e53207d966f0e77ee6795d887102365e2ac7f5265b685d5c139e556aa4f', 48, 1, 'token', '[]', 0, '2021-11-29 12:03:02', '2021-11-29 12:03:02', '2022-11-29 12:03:02'),
('5505034e6376a76015ada39e71edc3a287431d0caf948b10a875e60641dbdae94fc66749f79d484d', 51, 1, 'token', '[]', 0, '2021-11-30 18:37:09', '2021-11-30 18:37:09', '2022-11-30 18:37:09'),
('552df7b9623918efd5eee97cb60f7e368c6d0f9062154c191a62918cac8d73645bafc696b2810e57', 2, 1, 'token', '[]', 0, '2021-11-29 11:14:45', '2021-11-29 11:14:45', '2022-11-29 11:14:45'),
('555bb66ce4e40a0ae163a4a8c0e718ab95b2be5a71187b734f067ea9d07132303175d878b97c9753', 50, 1, 'token', '[]', 0, '2021-11-30 15:30:12', '2021-11-30 15:30:12', '2022-11-30 15:30:12'),
('5592f3c930a5cec7e789ac9fc2e86f7f93f67919cc3822edbea90d15a20b1c6aa216f77d4dc3cf9c', 48, 1, 'token', '[]', 0, '2021-11-30 17:00:18', '2021-11-30 17:00:18', '2022-11-30 17:00:18'),
('55a439197971252eb3957bcdf04463aab0978d13c746d168c2d40abc7502c245a0ae1c8119c4a1b5', 50, 1, 'token', '[]', 0, '2021-11-30 12:33:08', '2021-11-30 12:33:08', '2022-11-30 12:33:08'),
('55abf47a68953be39a473a8509b771a145c7e9b2001ed6ed95f8a1b716c82032e681bfc21b191965', 80, 1, 'token', '[]', 0, '2021-12-07 10:32:52', '2021-12-07 10:32:52', '2022-12-07 10:32:52'),
('55fbbfe87f0bbfddc9d34543b26d1320b76237858b86debe810e167f87b110fd629bb71eb8cd3d78', 50, 1, 'token', '[]', 0, '2021-12-01 17:52:13', '2021-12-01 17:52:13', '2022-12-01 17:52:13'),
('56264d9427f23f71ea6862ab8156cce3a7d63fa8d7f66189eeaf27a2b422c1413d21f989ad6ec0c6', 2, 1, 'token', '[]', 0, '2021-12-08 12:48:37', '2021-12-08 12:48:37', '2022-12-08 12:48:37'),
('563bebe87a07164818d419e86e69e80f7c75e8ad07213a4ca063d9aebb83756ff18407b868198ddc', 80, 1, 'token', '[]', 0, '2021-12-10 17:41:28', '2021-12-10 17:41:28', '2022-12-10 17:41:28'),
('56544b1c0284b3e822e3d9d8b497169d707ae933d9cd53a006316b2e8588a905759a29fa04c3c3ae', 67, 1, 'token', '[]', 0, '2021-12-01 14:03:44', '2021-12-01 14:03:44', '2022-12-01 14:03:44'),
('569800ff26b8f5df9bdb7b9946cbe57934d59e90addeba687582181827d1abbe67ab0187b2e360a4', 50, 1, 'token', '[]', 0, '2021-12-03 11:20:46', '2021-12-03 11:20:46', '2022-12-03 11:20:46'),
('56df2f8b4bf75fe060d636a54fb3959723fd2119bc0ca0e8b3e1490b73eae48b683135dad940b124', 2, 1, 'token', '[]', 0, '2021-11-15 09:54:38', '2021-11-15 09:54:38', '2022-11-15 09:54:38'),
('56e9425e051c014b769afd868033a8adc43003bc10e15ad96cc12fb379cb475f5b0abd5fa715d139', 80, 1, 'token', '[]', 0, '2021-12-06 11:15:27', '2021-12-06 11:15:27', '2022-12-06 11:15:27'),
('571a70d00369de34fd5f6d24e11e57223e9be59519947fb19372fdfb217fad6d4b1faeef161cf3b2', 48, 1, 'token', '[]', 0, '2021-11-19 18:03:49', '2021-11-19 18:03:49', '2022-11-19 18:03:49'),
('57ff7e3ecc3fb84c9791acaad31e1985dc15a5d75ecaf9a33e6e200c0caf0c4162b471696b3b3d72', 2, 1, 'token', '[]', 0, '2021-11-26 17:11:06', '2021-11-26 17:11:06', '2022-11-26 17:11:06'),
('581256cbc21ae9677390c94597c47829a49b9593a88b228a32281c610e2c14eed90b6e809441f5ba', 80, 1, 'token', '[]', 0, '2021-12-16 18:39:42', '2021-12-16 18:39:42', '2022-12-16 18:39:42'),
('58168d32483325bb2e84f1f269f4a9fd66c0069522c555dda8df774a1fc418386cf406e1b965776f', 2, 1, 'token', '[]', 0, '2021-12-13 14:39:56', '2021-12-13 14:39:56', '2022-12-13 14:39:56'),
('5908d4fe71c5ccb86881dfb87f4acc5b7934cf7cca4b47df62818651b5e7c1bc6fec94dda3d0eb1d', 37, 1, 'token', '[]', 0, '2021-11-16 16:18:33', '2021-11-16 16:18:33', '2022-11-16 16:18:33'),
('591c23b5aef4554236aab5f8bb86ed725246dc2e42060e9544a401cfc530e0b8c0311c9afcda8d65', 2, 1, 'token', '[]', 0, '2021-11-29 18:14:02', '2021-11-29 18:14:02', '2022-11-29 18:14:02'),
('5955ae30be5068a8bbfa4bdd0deae13889eec16a343670dc4470d1286c201c697a624f093aabfc88', 51, 1, 'token', '[]', 0, '2021-11-30 18:00:06', '2021-11-30 18:00:06', '2022-11-30 18:00:06'),
('596a725087a218ae177fea7224b8dc819e41df61f3c8873c2586a5b29f5a924ca6eb9bbed7724ef4', 80, 1, 'token', '[]', 0, '2021-12-08 11:51:18', '2021-12-08 11:51:18', '2022-12-08 11:51:18'),
('59910f89f3f28484ecfeb16efac4fcead1124087a907e8c39def60702303ace6c889cdbe3ef12eb2', 48, 1, 'token', '[]', 0, '2021-11-19 15:23:30', '2021-11-19 15:23:30', '2022-11-19 15:23:30'),
('59ac657e02f658ed0e09b0f14bce0a0519c27583292acebd5ea0bfb8320c4c1022fb5c1ea9a7c47e', 50, 1, 'token', '[]', 0, '2021-11-24 11:44:13', '2021-11-24 11:44:13', '2022-11-24 11:44:13'),
('59c7f8c8117b35521c04fd7eeaeca3c1e11bfc39b6644f115a7b7483fce5da4b260894c932c90741', 80, 1, 'token', '[]', 0, '2021-12-03 13:47:08', '2021-12-03 13:47:08', '2022-12-03 13:47:08'),
('59c897e07de70bc2d09522e055e9007a6391f6bbd644d3793fa370379f964e75a2e83c730585039b', 37, 1, 'token', '[]', 0, '2021-11-18 12:11:07', '2021-11-18 12:11:07', '2022-11-18 12:11:07'),
('5a1e5e7104fbbc2d348925175f34932c3f3bb841184e9f980579548fc55baa7f4ec3490176eced1b', 50, 1, 'token', '[]', 0, '2021-12-01 10:14:01', '2021-12-01 10:14:01', '2022-12-01 10:14:01'),
('5a35aefefdb0824922769d3d4d7968f10966210c140b2eed2407954b95633fab390ba05b16a8a395', 2, 1, 'token', '[]', 0, '2021-12-14 10:37:59', '2021-12-14 10:37:59', '2022-12-14 10:37:59'),
('5a46fc75a4abdb9fc3203e96cc0eda0b08226747fa8bd2fa6223d1cf1386c0fc6368f1632556e6fa', 50, 1, 'token', '[]', 0, '2021-12-02 17:26:04', '2021-12-02 17:26:04', '2022-12-02 17:26:04'),
('5ab0529ec6d6dc259ae767d53c240364cfb936ca0f52463f1f54e18ec2a594cdf0ac33d3594c942a', 48, 1, 'token', '[]', 0, '2021-11-18 18:24:02', '2021-11-18 18:24:02', '2022-11-18 18:24:02'),
('5ac877baaccd09cbf7c6ddec94f0217ea0ec84f1f3c4031834d7c24ebb580e114d8c24d838a34e06', 2, 1, 'token', '[]', 0, '2021-12-04 10:21:37', '2021-12-04 10:21:37', '2022-12-04 10:21:37'),
('5ae1fe89705459b25ee8e4e2a6e9e69a8b3d4102050c7f0f08a00cc49e024adf8b46c23dd9e345d2', 2, 1, 'token', '[]', 0, '2021-06-22 09:18:38', '2021-06-22 09:18:38', '2022-06-22 09:18:38'),
('5afc45d63e00b00d3771d8788757a30c846f0aeb6f83cac70a96c2a7f84ba09a2b21129bc6552556', 61, 1, 'token', '[]', 0, '2021-12-01 10:44:16', '2021-12-01 10:44:16', '2022-12-01 10:44:16'),
('5b65152f270be2198e71c2303b5581df525fd69572ba9eb03f044ecfe3e73b76785c83e4e8e64bfe', 50, 1, 'token', '[]', 0, '2021-11-24 16:04:42', '2021-11-24 16:04:42', '2022-11-24 16:04:42'),
('5b92ebd1f4af90d9b0649d5e6a9e0dc0e8286825c9e29ba955e388d40126c348b74b74111850c871', 48, 1, 'token', '[]', 0, '2021-11-29 10:05:30', '2021-11-29 10:05:30', '2022-11-29 10:05:30'),
('5bad771b3570ee45589a7ffae1f7224d59908307b48f50493c5ba1d13e181de72166c1a0675eaa62', 2, 1, 'token', '[]', 0, '2021-12-08 11:34:46', '2021-12-08 11:34:46', '2022-12-08 11:34:46'),
('5bbb0f23933e95405e6e2546b13a87888a14d366f06c63ec60684a5a7db75edd4f41532af7f6d833', 80, 1, 'token', '[]', 0, '2021-12-16 16:59:50', '2021-12-16 16:59:50', '2022-12-16 16:59:50'),
('5bbe2ce97adce3c1d6765211d7a5074d9d7fb59432ec1b2e3a25099e7c5f78ca9dc56991f7a6caf2', 2, 1, 'token', '[]', 0, '2021-12-08 12:18:32', '2021-12-08 12:18:32', '2022-12-08 12:18:32'),
('5bc7dea1eae5270e27329032dd152e3140d0e83fd18ae81b5d0d625d1b14f636457a7b1cc24ef5e2', 2, 1, 'token', '[]', 0, '2021-06-09 10:49:57', '2021-06-09 10:49:57', '2022-06-09 10:49:57'),
('5bdabff3dff155831e8289db45abcfd5f953b1eeecfb53acbbf031e501511fa1de2fd5826452f3a3', 50, 1, 'token', '[]', 0, '2021-12-03 13:26:22', '2021-12-03 13:26:22', '2022-12-03 13:26:22'),
('5be47dd0ffe8939c23f8b6934de9977f8be53b17d3b23510fbeba2dd31ea03622802adbdaa8dea6f', 37, 1, 'token', '[]', 0, '2021-11-17 18:21:19', '2021-11-17 18:21:19', '2022-11-17 18:21:19'),
('5c1c6c26c9448ad0f0acfdeb7a197dfaa84a834c0d7a34a7ed636dc1de3570fd7c67d9be7fd8c1be', 2, 1, 'token', '[]', 0, '2021-11-26 18:08:46', '2021-11-26 18:08:46', '2022-11-26 18:08:46'),
('5c44d765dbf29351af53922758983b2743ba38268a05985d82f3cfa82c0e963735a33c52dce0f93f', 80, 1, 'token', '[]', 0, '2021-12-16 11:04:03', '2021-12-16 11:04:03', '2022-12-16 11:04:03'),
('5c503ba80ca8d6ea543f274d07f4cdae143fa44f170f2a1dc369d46e76bed32c1995ddadc2ce55e7', 37, 1, 'token', '[]', 0, '2021-11-18 10:45:02', '2021-11-18 10:45:02', '2022-11-18 10:45:02'),
('5c8d5fa04b0ee2270559264ea0bc9019b590c64cc0e37a77fa3cdc4b3a5cc8b5050823eeb0a82f97', 65, 1, 'token', '[]', 0, '2021-12-01 11:51:45', '2021-12-01 11:51:45', '2022-12-01 11:51:45'),
('5d25b5e5026c5e3496facafad1130c1d7ce170c732b5adf3a2186bf2327e5f33dc13d25289b3c71e', 37, 1, 'token', '[]', 0, '2021-11-17 17:00:18', '2021-11-17 17:00:18', '2022-11-17 17:00:18'),
('5d2d8420fa61ada902a655ee24e7d84d5d72eeea79b15f027329d3370f7021e6904c764ca3746636', 50, 1, 'token', '[]', 0, '2021-11-30 19:06:41', '2021-11-30 19:06:41', '2022-11-30 19:06:41'),
('5d5c1a4ee65fd8f063ac1605cb34e9a660c660397a438ff896a30a99aacd2fc1e32a8fbb04a18d5f', 2, 1, 'token', '[]', 0, '2021-12-08 15:23:10', '2021-12-08 15:23:10', '2022-12-08 15:23:10'),
('5d5fc2a6c8062c18d5b9bffe8bbed71d263a7533a85ea0085e371ed8323248b300fb5657678aa621', 2, 1, 'token', '[]', 0, '2021-11-29 15:27:02', '2021-11-29 15:27:02', '2022-11-29 15:27:02'),
('5d71d57d57ebc967c5f269fefba0e82008bc11eb1096d6aa89f168f133b33d9403c28a591f5a6333', 50, 1, 'token', '[]', 0, '2021-12-21 16:39:37', '2021-12-21 16:39:37', '2022-12-21 16:39:37'),
('5d96fbc511e8b9f8a790aeff5add4f42a870b0b9d04c91b0d3824847b69a5f3ad4bbe7ed77ae75d5', 37, 1, 'token', '[]', 0, '2021-11-16 09:38:38', '2021-11-16 09:38:38', '2022-11-16 09:38:38'),
('5dba33c4c34df50ce950e4e72bf87f66b9853bd7faeffea51bae55bf1f81dad9c16ce0aecf3d4466', 80, 1, 'token', '[]', 0, '2021-12-03 13:35:47', '2021-12-03 13:35:47', '2022-12-03 13:35:47'),
('5dcfaf4f7a069a8e30bb1facf5ca6922c6e5e2eb35b70a0ade938fbbb9610deb39f3df12225365a0', 2, 1, 'token', '[]', 0, '2021-11-26 16:16:18', '2021-11-26 16:16:18', '2022-11-26 16:16:18'),
('5ded5d5be861bd8a7629aaf0734c4895897edfbee03143a60e889069fc988b9272bec5e14e000683', 68, 1, 'token', '[]', 0, '2021-12-14 10:32:30', '2021-12-14 10:32:30', '2022-12-14 10:32:30'),
('5e40acff51fb3695c9199e45a96dd795f5e49825a2822e29b2daa8acd9cac35f04818aab12949af6', 81, 1, 'token', '[]', 0, '2021-12-10 11:41:58', '2021-12-10 11:41:58', '2022-12-10 11:41:58'),
('5e4683d4563d09df573227c22952c430b72f041257e3dc0d3a8351b0c4337023d1edf0587c1d5688', 37, 1, 'token', '[]', 0, '2021-11-16 11:21:32', '2021-11-16 11:21:32', '2022-11-16 11:21:32'),
('5e48fb96113eb7663cc760a3c6228e3d9c3e28207c0958e7d006bc9faf2affeb61bb1df2452fb594', 2, 1, 'token', '[]', 0, '2021-11-26 19:05:00', '2021-11-26 19:05:00', '2022-11-26 19:05:00'),
('5e5bfff18dffb7830be31f8a997cd9a5c4311b8385646ba1c69e20d170294fe46220bbe2680125fc', 2, 1, 'token', '[]', 0, '2021-12-08 14:59:40', '2021-12-08 14:59:40', '2022-12-08 14:59:40'),
('5e767c5aedd3704f556ab344dbc649e587f2e89e862125794460c1e0f77287ce8b85a9411943748f', 2, 1, 'token', '[]', 0, '2021-12-16 10:43:52', '2021-12-16 10:43:52', '2022-12-16 10:43:52'),
('5ed33db2f31256baed32b675b48b67625bf1c07391df7d9473c822fa45b4d58be5cd94ddfb240f89', 37, 1, 'token', '[]', 0, '2021-11-16 14:03:40', '2021-11-16 14:03:40', '2022-11-16 14:03:40'),
('5edfbe0e8ba8859ed872dbae2336ab28a7a89590b2ffd06e5b071ef4db86c6607165a30a1c12cde0', 50, 1, 'token', '[]', 0, '2021-11-20 14:44:44', '2021-11-20 14:44:44', '2022-11-20 14:44:44'),
('5ef9321684d8b94cb74714bfecdb4ffac4b93eb4fce36c89cf1c498258130627ba349d31b4abb639', 2, 1, 'token', '[]', 0, '2021-12-13 15:21:51', '2021-12-13 15:21:51', '2022-12-13 15:21:51'),
('5f0c769bd5edecba728e395e6f9ba13240b93def6e4e86a59b2e42e1a3c44291ef7e928c03441871', 50, 1, 'token', '[]', 0, '2021-11-30 12:34:06', '2021-11-30 12:34:06', '2022-11-30 12:34:06'),
('5f277e09b81dc054eb219b30224ee86b1e18c02ff03fcc2648b7da2444967140f13cd49cd377cc61', 50, 1, 'token', '[]', 0, '2021-11-24 16:46:07', '2021-11-24 16:46:07', '2022-11-24 16:46:07'),
('5f4315c94749d66005ebc5eb0bd7b6ee02e16d1f0cf8ebba396434125c7904cf90c6e15a4005a51c', 50, 1, 'token', '[]', 0, '2021-12-01 16:46:13', '2021-12-01 16:46:13', '2022-12-01 16:46:13'),
('5f449457947588d394be098da58faaa677f42e2f690cef5bce27f23eb06df0cf6121e8a5e60765cb', 2, 1, 'token', '[]', 0, '2021-12-04 18:03:25', '2021-12-04 18:03:25', '2022-12-04 18:03:25'),
('5f5b1ffd52a715bea82199dacd00755faa79eab1b5d282a4d4e6da13dd89ca19b5ab5ff081732af5', 2, 1, 'token', '[]', 0, '2021-12-06 11:10:05', '2021-12-06 11:10:05', '2022-12-06 11:10:05'),
('5f68a9e1e4ed42c92b109f78095345ab775e7cf1d411b3452e04745f53b37dd87fd5493c8868ef32', 37, 1, 'token', '[]', 0, '2021-11-13 15:52:34', '2021-11-13 15:52:34', '2022-11-13 15:52:34'),
('5fa664ca38e7b27c2016983e9d2ab6e2dd32dff301db3982a01f81d523a1238c2e4c208b40af9bc8', 37, 1, 'token', '[]', 0, '2021-11-18 14:08:33', '2021-11-18 14:08:33', '2022-11-18 14:08:33'),
('5fb5a1de991ae3271b8037b06ec081958147d87e206118cd68d909682ca5fab7d37920eab5bcd685', 58, 1, 'token', '[]', 0, '2021-11-30 22:21:03', '2021-11-30 22:21:03', '2022-11-30 22:21:03'),
('5ff79b952e811a279bdff81355067f1f5f44e8b5aa2dc3ab28391041a77791f6a90c6d98f86ccd23', 48, 1, 'token', '[]', 0, '2021-11-20 10:44:23', '2021-11-20 10:44:23', '2022-11-20 10:44:23'),
('603167004e31516692d2c8c668388d61ad2f7d6143abd626266eabfca8bc4882e5d0e8d20a10ba14', 66, 1, 'token', '[]', 0, '2021-12-01 17:39:57', '2021-12-01 17:39:57', '2022-12-01 17:39:57'),
('607946f76f1e56e8c65695853e1981262613067afa59d7dcf4cf4d715a84f5adef46c43585033e60', 80, 1, 'token', '[]', 0, '2021-12-21 11:15:45', '2021-12-21 11:15:45', '2022-12-21 11:15:45'),
('60853d2ba44b586882d794c851d58c3c03dfc5ad0d8c87aa8eb62b5c80ab289d11cd60b2a22c79cc', 2, 1, 'token', '[]', 0, '2021-06-20 16:43:31', '2021-06-20 16:43:31', '2022-06-20 16:43:31'),
('609f7d9bb7c0ff85d3d9dfbe8b01c282e0243925480813613c1d6aa1f983859e645e16f94657c16d', 2, 1, 'token', '[]', 0, '2021-12-02 10:00:37', '2021-12-02 10:00:37', '2022-12-02 10:00:37'),
('60a7e8a0bfcc3c81460c9a45f789f4891698f926a6cf69cf73283136bbc3407bb69dd9a79cc0ee2a', 2, 1, 'token', '[]', 0, '2021-11-29 18:36:10', '2021-11-29 18:36:10', '2022-11-29 18:36:10'),
('60c0534f48501d2c4f47d3517194fc3089bd884dfae1a41a90b1bb52191a519e296576f08d07eee4', 48, 1, 'token', '[]', 0, '2021-11-29 11:57:20', '2021-11-29 11:57:20', '2022-11-29 11:57:20'),
('60f5740c59c8effe6b68dbfa58bae462d4cb7c12fd00f01eb471e43d525f59d6f02139a9a36aec47', 50, 1, 'token', '[]', 0, '2021-12-03 10:54:03', '2021-12-03 10:54:03', '2022-12-03 10:54:03'),
('611a83421207cd8e40504cedc0dce8c619c9dd9974274ad96ed9fe257e4893bcbf10db4ddf4a743a', 37, 1, 'token', '[]', 0, '2021-11-18 10:42:09', '2021-11-18 10:42:09', '2022-11-18 10:42:09'),
('613cc786ea97916cf0ba6675d29b01e498446e626590eb5d3af9e4b43cc72d01dd00685210a3598a', 2, 1, 'token', '[]', 0, '2021-11-30 14:16:03', '2021-11-30 14:16:03', '2022-11-30 14:16:03'),
('613d2fda6873c072c125b658f5e4abd8c75cce3781f03f26d5c9258c67101b4ba2ab247f873d6000', 50, 1, 'token', '[]', 0, '2021-11-24 17:51:58', '2021-11-24 17:51:58', '2022-11-24 17:51:58'),
('614b35924324df15fcb0a4107a6e69ebebac2b597a58933129dd1de489103806bc506ec86110b875', 2, 1, 'token', '[]', 0, '2021-12-04 10:31:53', '2021-12-04 10:31:53', '2022-12-04 10:31:53'),
('6183faf81d498e71f6cb8fe571fe92bf46d0b88c85d63f82b0b5015b3f9b8dfdbf014fed78c052fc', 80, 1, 'token', '[]', 0, '2021-12-06 10:25:31', '2021-12-06 10:25:31', '2022-12-06 10:25:31'),
('61969815f49f53531241632f38f9d159223057a138cc6d607863150c55b8c2fab7befcd69d948167', 80, 1, 'token', '[]', 0, '2021-12-21 14:50:25', '2021-12-21 14:50:25', '2022-12-21 14:50:25'),
('61bc6c67a6ced0cd7c16b3535c86b7c4246bccf775db63fb2c16bb56618dae0a42532822d613bcfe', 50, 1, 'token', '[]', 0, '2021-12-13 14:54:22', '2021-12-13 14:54:22', '2022-12-13 14:54:22'),
('61d4638f9d9b0024e04f3937c5374aa954c8af605c02361e35314c03dbce58d52d9cb3ca3d89ed64', 58, 1, 'token', '[]', 0, '2021-11-30 22:24:46', '2021-11-30 22:24:46', '2022-11-30 22:24:46'),
('62116931c45bbc7b9e431ac897fffcbfac2e953102c22b17022e1f7c30cfb73a840173132a7ac090', 2, 1, 'token', '[]', 0, '2021-12-14 10:18:06', '2021-12-14 10:18:06', '2022-12-14 10:18:06'),
('623d664983626416d5a35d8562a45fc94a7a31aa4978c872efa43c0b05a9b8ac2921043fa4f7f440', 37, 1, 'token', '[]', 0, '2021-11-13 15:08:39', '2021-11-13 15:08:39', '2022-11-13 15:08:39'),
('625df654eb0ce505acb565d4df2e839fe68d8cb7d9225ee01af48f7fb6c6eaf59d40bb9059bebc31', 81, 1, 'token', '[]', 0, '2021-12-10 10:28:54', '2021-12-10 10:28:54', '2022-12-10 10:28:54'),
('626c7e844da47d2a2e81b9b02522fb5a11cfc6478705fa6359cfae391c37a838c2c1bc3acdf12ecb', 80, 1, 'token', '[]', 0, '2021-12-18 09:58:33', '2021-12-18 09:58:33', '2022-12-18 09:58:33'),
('6277bc152bdbe4c1ff0569670813c96c1e587f59f3d507a048464be31a9fd894c9b0ed626b94e642', 93, 1, 'token', '[]', 0, '2021-12-08 13:29:13', '2021-12-08 13:29:13', '2022-12-08 13:29:13'),
('627d36cd5e99bebd2db930f069f7db2da34a8c27d0dabbbf43eadde4a6254d150b2ca82d649074f9', 50, 1, 'token', '[]', 0, '2021-11-30 11:48:40', '2021-11-30 11:48:40', '2022-11-30 11:48:40'),
('627d48819168c21ae9ee178e6e598d495d869a0fe798b0f7a80bb4227e6d63790638a613e956f433', 50, 1, 'token', '[]', 0, '2021-11-30 12:25:12', '2021-11-30 12:25:12', '2022-11-30 12:25:12'),
('62d39683092212aefccb166a7457cbc428c9c0ec35cc342566594a8eb06284f5cd0682936fca36e8', 37, 1, 'token', '[]', 0, '2021-11-18 10:50:35', '2021-11-18 10:50:35', '2022-11-18 10:50:35'),
('6307e2db4a0f8057de8e5366955158518a21bd9fe242b45109677e1bd7eb4c42ede93eb11fb2f5a7', 61, 1, 'token', '[]', 0, '2021-12-01 11:34:50', '2021-12-01 11:34:50', '2022-12-01 11:34:50'),
('631cd6a9b5e1f7df7bd354ad59f527b2e657e085fc76e194073f9f17470d0e05732483fab9f682e1', 80, 1, 'token', '[]', 0, '2021-12-04 10:03:19', '2021-12-04 10:03:19', '2022-12-04 10:03:19'),
('6383e23246b9f5d7851135fc79109435a5361a2856a90653d6b7a1d7b4ccefa45808dbb1fec9bdf3', 50, 1, 'token', '[]', 0, '2021-11-20 12:52:35', '2021-11-20 12:52:35', '2022-11-20 12:52:35'),
('638f78a27b52a969e94edbbce98c6df83ccb84d56e3b807a28efcd3bfe7ff6f69c9ff1a33d836495', 2, 1, 'token', '[]', 0, '2021-11-29 17:52:33', '2021-11-29 17:52:33', '2022-11-29 17:52:33'),
('63b246c24c3014d86a6612a6e12e4195a19d3df5ff66ecf36a480bcf11aba42d9b1898a991d72488', 50, 1, 'token', '[]', 0, '2021-11-25 10:57:32', '2021-11-25 10:57:32', '2022-11-25 10:57:32'),
('640428806202a94b3def5697c4680e5ebd26cf3bf7bb14b40826ba9512ec1c87eec35e61eb766de4', 51, 1, 'token', '[]', 0, '2021-11-19 14:14:08', '2021-11-19 14:14:08', '2022-11-19 14:14:08'),
('641ea21c4d864e7d0a2cf8267291ee51d94292e2618056e1ebc61b230d6c8f43efb7fcc48350e05e', 2, 1, 'token', '[]', 0, '2021-12-13 18:35:47', '2021-12-13 18:35:47', '2022-12-13 18:35:47'),
('64347a0e414b0799b747baa77cbdf40469ab13ab7f0c263708cbf572402d18c2e64e684974f67330', 80, 1, 'token', '[]', 0, '2021-12-06 11:24:27', '2021-12-06 11:24:27', '2022-12-06 11:24:27'),
('644394c02722563a82d01e899f3b4ecb6ea696c3c1347ab72a0f6c18a1bfee85263c35659074d892', 68, 1, 'token', '[]', 0, '2021-12-14 10:56:44', '2021-12-14 10:56:44', '2022-12-14 10:56:44'),
('644ba7f05a751bdba890ff9c06ed04ee34c768ea75617db8a563c4f179dacfdb896d49200b56e4e9', 50, 1, 'token', '[]', 0, '2021-11-30 11:42:45', '2021-11-30 11:42:45', '2022-11-30 11:42:45'),
('645117ae89f8b16791f4913991dcd560b2a3d10f9a8acca9bc7a4ca0e449e675dc634569a0876af9', 2, 1, 'token', '[]', 0, '2021-12-04 11:03:30', '2021-12-04 11:03:30', '2022-12-04 11:03:30'),
('64584f56f9cf8f7f8797d3ddbbec93e6b08323e37a026734029e6507b73123dd50434171a030f377', 2, 1, 'token', '[]', 0, '2021-11-11 11:46:59', '2021-11-11 11:46:59', '2022-11-11 11:46:59'),
('64640e59367acb49040f4d6c11fbb26931ba2afd5d355ed14bbb166620c4fb65949c10d9dd21506c', 80, 1, 'token', '[]', 0, '2021-12-03 14:47:00', '2021-12-03 14:47:00', '2022-12-03 14:47:00'),
('64665123d798f819e0fea7c2e7615ed5eda35e99ba4230d78548b6d3501079d5a53a5303d5cabe36', 2, 1, 'token', '[]', 0, '2021-06-22 07:23:56', '2021-06-22 07:23:56', '2022-06-22 07:23:56'),
('648a6f1c6ec0e2c770a3e4c7c2c44e86a15490ce371c8e1f04c8f1f2d13232bff3a19590685b3e43', 50, 1, 'token', '[]', 0, '2021-11-29 17:23:11', '2021-11-29 17:23:11', '2022-11-29 17:23:11'),
('64a1bb15820f6ef0d27bbbd4dd4f630c3ce860c2644ae694025e6ed0c5a6d358dbaa486168079153', 2, 1, 'token', '[]', 0, '2021-11-30 16:06:00', '2021-11-30 16:06:00', '2022-11-30 16:06:00'),
('64ad0e7dff8b7c1833d22381be70b503733f82cd3f1ed010f570d07419e6b785dc8e446361a55c7e', 2, 1, 'token', '[]', 0, '2021-11-19 09:47:26', '2021-11-19 09:47:26', '2022-11-19 09:47:26'),
('64bdb2f847227ba715162080b9758beb9eb126aaacdffa41edb1d618289c2b3a0ee071139dcfc209', 37, 1, 'token', '[]', 0, '2021-11-17 17:09:10', '2021-11-17 17:09:10', '2022-11-17 17:09:10'),
('64d14f1c557c8c68028fb387b442e3c5f2cd0d5539fdc56e2e5490b794ffae9d5991af5a09f199e0', 50, 1, 'token', '[]', 0, '2021-12-02 17:56:32', '2021-12-02 17:56:32', '2022-12-02 17:56:32'),
('64d33f7004159c550f6ba756eba7fa2c6f5c18455c96a3ee404c517761d7acca8ecc2119b189cc6d', 37, 1, 'token', '[]', 0, '2021-11-18 12:45:59', '2021-11-18 12:45:59', '2022-11-18 12:45:59'),
('64ddd7f16216d79e7c412e38f1df34ee77d21c2b360e2a1df816af13cce4770a89cf981314a2e8db', 2, 1, 'token', '[]', 0, '2021-12-07 10:06:51', '2021-12-07 10:06:51', '2022-12-07 10:06:51'),
('64dfdd5afa3a3db86aba95e8478555d0c9fb87eb097928647596ae5618f8671bad7387f46ca2409c', 2, 1, 'token', '[]', 0, '2021-12-14 11:00:00', '2021-12-14 11:00:00', '2022-12-14 11:00:00'),
('64ea8fc6ac184287abf03c33dfbfc509fe6c041357ff27c5057999aa07e74aea68033c0373d8cffa', 37, 1, 'token', '[]', 0, '2021-11-18 10:20:57', '2021-11-18 10:20:57', '2022-11-18 10:20:57'),
('64f7688126d514be0a41369d09142108ef977b5b8dbf1e53e3577531d6b36cc94e9facbdff126a50', 2, 1, 'token', '[]', 0, '2021-12-07 09:22:04', '2021-12-07 09:22:04', '2022-12-07 09:22:04'),
('652cc3d19215bfee07ca1de19f2dfd836bfa399fae9da57f67acd84959dadb6740e31dd2fb14e644', 50, 1, 'token', '[]', 0, '2021-11-24 16:53:01', '2021-11-24 16:53:01', '2022-11-24 16:53:01'),
('652f3cca24103f41370255e3770b51242d10c53890c2db68cd702b6832a889d2b7128d7bbebd7905', 50, 1, 'token', '[]', 0, '2021-11-30 19:07:05', '2021-11-30 19:07:05', '2022-11-30 19:07:05'),
('65f787af95a82d00cf8b39a3fd6833e7ddc0a7036f53eba3778682c84a7e9a89d297f0038adfcfb7', 50, 1, 'token', '[]', 0, '2021-12-13 13:03:05', '2021-12-13 13:03:05', '2022-12-13 13:03:05'),
('6606c207ceb10b94249dc0f0e132e4216b1f95730536466cc778ab013d38c7b428724f33030c62a6', 1, 1, 'token', '[]', 0, '2021-10-29 10:09:51', '2021-10-29 10:09:51', '2022-10-29 10:09:51'),
('663ff0d3e9912c253417659e2e31996335072e4e686293f71f7191e4b1991a088b2c342434a7e7e4', 37, 1, 'token', '[]', 0, '2021-11-17 18:45:14', '2021-11-17 18:45:14', '2022-11-17 18:45:14'),
('666e91a7e31f3f534a22e24704b7cd60c876d9ca53a2b4a26c7813f0a1228148b0799b94bf1ac76f', 2, 1, 'token', '[]', 0, '2021-06-11 15:42:20', '2021-06-11 15:42:20', '2022-06-11 15:42:20'),
('6685d5292027de792eb2b0a94865e18de31a6dfa720d4abd03e1f93ee78c40b29a504c44966352a0', 37, 1, 'token', '[]', 0, '2021-11-18 09:40:42', '2021-11-18 09:40:42', '2022-11-18 09:40:42'),
('66af631a6dfd72609ca0f3afb513a95a8a8c9c511da53eb4d6574b5de8a5b06dadba9eba3eaae9c3', 51, 1, 'token', '[]', 0, '2021-11-30 18:00:21', '2021-11-30 18:00:21', '2022-11-30 18:00:21'),
('66f18189c54322a483f09d4acf99e1043379a5cddb5f95464e3921f0819be3a7aaf445b801fa626b', 80, 1, 'token', '[]', 0, '2021-12-21 17:34:41', '2021-12-21 17:34:41', '2022-12-21 17:34:41'),
('66fb17f62601a7c11e82d62889feceb55ee6f80b9b3837f8d464fd0301834ae4edb24484c011510d', 2, 1, 'token', '[]', 0, '2021-11-11 11:27:41', '2021-11-11 11:27:41', '2022-11-11 11:27:41'),
('670ee5c55348651dbee5e9328fafbb4923fd3ea4f8d95a8e00759917e659c3842759961f3c6386d5', 2, 1, 'token', '[]', 0, '2021-11-25 12:57:39', '2021-11-25 12:57:39', '2022-11-25 12:57:39'),
('6759de88d91f60dc76d89e1be6cf649a9c9ab71178b506c83c873cebb83f7bab1af7282c21fc12b7', 37, 1, 'token', '[]', 0, '2021-11-17 17:32:37', '2021-11-17 17:32:37', '2022-11-17 17:32:37'),
('677dd060f293c1b1c909b0b9817ddd5464fbfe9288fe87857369fa8dd5a94f21348a5cc0260095c9', 37, 1, 'token', '[]', 0, '2021-11-18 13:01:29', '2021-11-18 13:01:29', '2022-11-18 13:01:29'),
('6788b2ef847b3eb1e2908cdabd5365335b74b993782cd8824ccecfdb669131cd91c99d06a9ea3118', 81, 1, 'token', '[]', 0, '2021-12-08 10:36:16', '2021-12-08 10:36:16', '2022-12-08 10:36:16'),
('67f88497755dcfca0f93b4d22718d837dba7953444d11a4f0dc0f2271a475ddd5f7e2b0ac6c2d93b', 50, 1, 'token', '[]', 0, '2021-11-24 17:12:15', '2021-11-24 17:12:15', '2022-11-24 17:12:15'),
('6816f268e2cc30c6c3fb62fbd2d885abee4de874f0de41fa6af4b57ec87372eeafc8aa291c82051f', 67, 1, 'token', '[]', 0, '2021-12-01 14:39:54', '2021-12-01 14:39:54', '2022-12-01 14:39:54'),
('6831bd738b94efd1d3d49db732c96d92896d4c174152d5bac5c93bc328599783bf4df3f5ed814fd2', 50, 1, 'token', '[]', 0, '2021-11-29 17:01:48', '2021-11-29 17:01:48', '2022-11-29 17:01:48'),
('683d2556359adc036e52b32c70cc755afeaf5447635013d339f0d78c1be0b752b6d4852ec6203336', 80, 1, 'token', '[]', 0, '2021-12-03 16:43:01', '2021-12-03 16:43:01', '2022-12-03 16:43:01'),
('683db0b813c7190018ccb262a9abfbcce7e60f54fb1ad40671f05839a8f21382bbdac01e6e85127e', 50, 1, 'token', '[]', 0, '2021-11-30 12:43:33', '2021-11-30 12:43:33', '2022-11-30 12:43:33'),
('685c46c3d668a8684edda82eaa846446106b890491233e534372184e2dbbbaa4af685c73ae8707a7', 61, 1, 'token', '[]', 0, '2021-12-01 11:13:38', '2021-12-01 11:13:38', '2022-12-01 11:13:38'),
('6882cc60c30dc689847d6e3bda5c78a6f260b055a3f99c810c410e31250b2dea34149ba87f0cf3df', 68, 1, 'token', '[]', 0, '2021-12-14 11:35:58', '2021-12-14 11:35:58', '2022-12-14 11:35:58'),
('68a4c26951a76dc4fd740d4efb4e027dc6d70bdf3aef9de8e5bc0b98038ca75c2ccdaa5918402888', 50, 1, 'token', '[]', 0, '2021-12-02 15:20:31', '2021-12-02 15:20:31', '2022-12-02 15:20:31'),
('68c2816700aec654d07a4745f81ed4488a181624bef2ab7f886b7119ece848b0ef3bb828774ff475', 2, 1, 'token', '[]', 0, '2021-12-04 17:58:04', '2021-12-04 17:58:04', '2022-12-04 17:58:04'),
('692f24e30f14edf27930305c8e7b450f7cec38f95a433b873862c65daf82ad14c60259b916170c52', 68, 1, 'token', '[]', 0, '2021-12-21 15:23:26', '2021-12-21 15:23:26', '2022-12-21 15:23:26'),
('6986962c5146b244d1902119ae9a7c8d2abacef4d9be342e0d32a7ddb499a47a5520453c4d36f8fa', 37, 1, 'token', '[]', 0, '2021-11-18 10:20:27', '2021-11-18 10:20:27', '2022-11-18 10:20:27'),
('69e97f42a918736d549ee71113dd56a0ac80bc9ac477597badeee814606b2e64b2499888c170c9df', 2, 1, 'token', '[]', 0, '2021-12-02 15:34:28', '2021-12-02 15:34:28', '2022-12-02 15:34:28'),
('6a239da6dda5bd33592d3f2480212e1ca87a9c41d73c04ea450ada63a83b8e8e54269574d5282212', 80, 1, 'token', '[]', 0, '2021-12-03 14:07:35', '2021-12-03 14:07:35', '2022-12-03 14:07:35'),
('6a31083532ac80c155ffafc18c6f85f1fbca507a893e06c8b17173d9b69f1474576594aa7b90e3d6', 2, 1, 'token', '[]', 0, '2021-11-27 10:21:59', '2021-11-27 10:21:59', '2022-11-27 10:21:59'),
('6a676f785349941c8a71b5ec2625756cd8db8ce0e58a5cd243a88135e25ec8e5e247fe4b6d8b4231', 37, 1, 'token', '[]', 0, '2021-11-18 10:57:42', '2021-11-18 10:57:42', '2022-11-18 10:57:42'),
('6a9afdc143b0fc60d44f2a81a049571bb467d6baed94ec8b066599e3cd8121af80e325cde8cf1969', 2, 1, 'token', '[]', 0, '2021-11-26 16:36:26', '2021-11-26 16:36:26', '2022-11-26 16:36:26'),
('6a9c00513a948df574378085994b8cb056a044fa90b27f8fd4c6920a4f3464983023578119f49a68', 50, 1, 'token', '[]', 0, '2021-12-02 14:04:24', '2021-12-02 14:04:24', '2022-12-02 14:04:24'),
('6aa4481e4bb8af9ffde7fe70f76379bb0cd209f0027ec11aa04b557061333a2236b36797e5f89a7a', 50, 1, 'token', '[]', 0, '2021-12-14 15:33:20', '2021-12-14 15:33:20', '2022-12-14 15:33:20'),
('6b004ac553eb29cde11a788b1b741269c40a64e4ec3f5b273d9c7a4b885f49ab6b52252e615bc251', 80, 1, 'token', '[]', 0, '2021-12-21 12:00:36', '2021-12-21 12:00:36', '2022-12-21 12:00:36'),
('6b13736bb66dd61cb7b6ccc386dfa9d790503bd7b666da3efd89a960b1f7af85952174dd3bb66aef', 96, 1, 'token', '[]', 0, '2021-12-08 14:16:10', '2021-12-08 14:16:10', '2022-12-08 14:16:10'),
('6b3b391db55c6c4cf1fde3a1079ff507ae424437604e0e086b4a401adea9ee5a5947b46c35d18226', 37, 1, 'token', '[]', 0, '2021-11-18 10:17:55', '2021-11-18 10:17:55', '2022-11-18 10:17:55'),
('6bc59f6b988abfb9c9e54f084a187a33d20d0258d11af95c4c570b942d9a7ea76773fc946240e786', 50, 1, 'token', '[]', 0, '2021-12-13 14:33:05', '2021-12-13 14:33:05', '2022-12-13 14:33:05'),
('6cb0f5b16bae5d43822a922e43f67dfac9ebe289707e15ce4eb3680d4deff1ffe6ee536b5e627280', 61, 1, 'token', '[]', 0, '2021-12-02 19:30:10', '2021-12-02 19:30:10', '2022-12-02 19:30:10'),
('6d19014f6cfe752f0978a6bad35acb28000413eb5b9b78106a1da7a6a12d6c03e82617d9c5dfd1ed', 50, 1, 'token', '[]', 0, '2021-12-13 11:26:38', '2021-12-13 11:26:38', '2022-12-13 11:26:38'),
('6d2eeed31b6cc7023cfefb45ee77d971788894b3c88732031b0e728e6b3f666494ef9e7f673fafca', 2, 1, 'token', '[]', 0, '2021-11-26 17:50:59', '2021-11-26 17:50:59', '2022-11-26 17:50:59'),
('6d2fa7194763503c75f4d64da62ff447ac9919864eed85b478d9d608fdac4db1b012ec9941231609', 2, 1, 'token', '[]', 0, '2021-12-10 19:09:21', '2021-12-10 19:09:21', '2022-12-10 19:09:21'),
('6d79e8ed3e34104fc12e3a7af3f2c1b630fba3caa4d5cb5254ecba53db7088caa0c6f21cf713f499', 37, 1, 'token', '[]', 0, '2021-11-18 10:42:04', '2021-11-18 10:42:04', '2022-11-18 10:42:04'),
('6d7da92d89ab3f75a67806425abb39b70ddbd76fca227398bb109d3b474a36e87708dffa2f85dde7', 66, 1, 'token', '[]', 0, '2021-12-02 12:57:12', '2021-12-02 12:57:12', '2022-12-02 12:57:12'),
('6ddef54ce22d5c6c797c1f6c58b9e81d7c32b9d240cb610d3a52a85f350dae35fab5621ea64fd367', 37, 1, 'token', '[]', 0, '2021-11-18 12:55:33', '2021-11-18 12:55:33', '2022-11-18 12:55:33'),
('6dfde7ee9e4c1a3ffde222587a38f12729c1c86cfaa9d7c37011c6851c20336439d8c7829fed6933', 66, 1, 'token', '[]', 0, '2021-12-02 13:44:12', '2021-12-02 13:44:12', '2022-12-02 13:44:12'),
('6e130056b046e402d06ff965f8ea2e57c9a9f187d95a68a91882059daac033d2b00b08ebad3070c1', 81, 1, 'token', '[]', 0, '2021-12-10 14:04:09', '2021-12-10 14:04:09', '2022-12-10 14:04:09'),
('6e16bb486791c719254b7692cbd742bbd5a4c56f29567538d904c1dc262dc8f0e6d4aa9282ce2be4', 2, 1, 'token', '[]', 0, '2021-11-29 19:36:58', '2021-11-29 19:36:58', '2022-11-29 19:36:58'),
('6e19b5057b83fc33eae6088645b87ddd61e63e7d86f874f27ec8848536a1dbc4600cd450a354aa52', 50, 1, 'token', '[]', 0, '2021-11-19 09:54:22', '2021-11-19 09:54:22', '2022-11-19 09:54:22'),
('6e4ac5813bd761ec3614f7fad813b72b457cf78c8fab999e009546bf180105c6f24f2c9d099279be', 50, 1, 'token', '[]', 0, '2021-12-13 14:50:50', '2021-12-13 14:50:50', '2022-12-13 14:50:50'),
('6e573616d9f7a27ce45bd3edb034e657ecd307056557e5f44b2d68fac05a86701f2c7b5b61439215', 2, 1, 'token', '[]', 0, '2021-12-13 12:30:54', '2021-12-13 12:30:54', '2022-12-13 12:30:54'),
('6e7f9d8d5f27b2b20f356699f181635abaaa633b110fb5073d1398fb609b66b8c77c3cd8cfac9b7c', 37, 1, 'token', '[]', 0, '2021-11-18 10:46:29', '2021-11-18 10:46:29', '2022-11-18 10:46:29'),
('6ee08eaaba78064edff81af22c51a191b8ee182771b43854a3541bcb2ef879bf566cc241f90de963', 50, 1, 'token', '[]', 0, '2021-11-29 17:21:23', '2021-11-29 17:21:23', '2022-11-29 17:21:23'),
('6eed282cbf8cda3a8a9a6f7e3807e75eec74efb23e92969e791af695a0bcb1cbc7de1b5c8f25a3e9', 106, 1, 'token', '[]', 0, '2021-12-10 11:08:37', '2021-12-10 11:08:37', '2022-12-10 11:08:37'),
('6f44ea37537ea84ca6aa3af15c6620f5e05c72eb602f9ed921bae6ead21dd606f33f0abf01ac8e86', 80, 1, 'token', '[]', 0, '2021-12-18 09:59:34', '2021-12-18 09:59:34', '2022-12-18 09:59:34'),
('6f7e1f8dc13e66432156d21b8588979fd6806907e3821cb4bf8885714737352f7a5fad71a0554a50', 37, 1, 'token', '[]', 0, '2021-11-17 17:39:26', '2021-11-17 17:39:26', '2022-11-17 17:39:26'),
('6f81da4eeb41b1a0a445a73e0c7a2168c0a676b152aa5c59d34c3371b7bf4d4c2012c315b8103727', 37, 1, 'token', '[]', 0, '2021-11-29 11:18:32', '2021-11-29 11:18:32', '2022-11-29 11:18:32'),
('6fd285fbd3c7d6ad2931b363c1bb790f6b24ad46330c9fed71b2092e0e35765b86f3609651ad8649', 50, 1, 'token', '[]', 0, '2021-11-26 15:49:36', '2021-11-26 15:49:36', '2022-11-26 15:49:36'),
('700b6904c9285abed0f0a17a1997dd383d1f4eccf48d7e797a7167752edd2a5d40b7992eaabf2369', 37, 1, 'token', '[]', 0, '2021-11-18 14:09:16', '2021-11-18 14:09:16', '2022-11-18 14:09:16'),
('70449966305fe0cc65af468a6e9bcf0c4f262666edab968e4bc176e4f558c1a17b55dceeaf6f5560', 2, 1, 'token', '[]', 0, '2021-12-13 13:01:44', '2021-12-13 13:01:44', '2022-12-13 13:01:44'),
('7091e8fb290f0edbc7b0b0162d8ab22ba836ee5a83b4f8fe5d4a831bf1427143188d2e40f0de1970', 2, 1, 'token', '[]', 0, '2021-11-27 15:24:13', '2021-11-27 15:24:13', '2022-11-27 15:24:13'),
('7096848f76982849f5bd8b9683446ba7ce6428c3a06ce1924938167dbf8f619006ec8f59c88d2f6b', 1, 1, 'token', '[]', 0, '2021-10-27 16:40:09', '2021-10-27 16:40:09', '2022-10-27 16:40:09'),
('70c3b708fd3913c766700d94cb9381af7358ae6183a53cac193060136850b1e077f4c076321dd32c', 80, 1, 'token', '[]', 0, '2021-12-03 12:43:45', '2021-12-03 12:43:45', '2022-12-03 12:43:45'),
('70ddd43112f32c9d4447f9f084766478cbd7555805521864d8177165675c6d58b0ea260223fe3b35', 48, 1, 'token', '[]', 0, '2021-11-19 12:33:54', '2021-11-19 12:33:54', '2022-11-19 12:33:54'),
('71095ce13454fd9d21911fcd84679dc7bf423a284ce12bc37aabcf7106b8f528d4163ad10413341b', 50, 1, 'token', '[]', 0, '2021-12-02 16:50:41', '2021-12-02 16:50:41', '2022-12-02 16:50:41'),
('7131bad70cf627fbf703e8e40941eef587bcf0eec0ad9bbc566a1b122ddae2e6e13bbc95d4f4ca1a', 50, 1, 'token', '[]', 0, '2021-12-01 14:56:47', '2021-12-01 14:56:47', '2022-12-01 14:56:47'),
('716d692720249a8e6f4e3916912d4d96fe59483bb9bc1971aa9b61e8ece59d84f38bddaf66ad27ad', 80, 1, 'token', '[]', 0, '2021-12-04 18:13:27', '2021-12-04 18:13:27', '2022-12-04 18:13:27'),
('717fea3763066b6aa082f5b6fa03856bcc479aaf194b89514403e53fad5e1e90a1c714c98f858003', 80, 1, 'token', '[]', 0, '2021-12-10 17:57:13', '2021-12-10 17:57:13', '2022-12-10 17:57:13'),
('71fa865552ed4eb3d1ef7b36c5ebdf5a3c629c5090199c0c80c14db8176eda818713ec2cbf5a2d16', 50, 1, 'token', '[]', 0, '2021-11-26 15:27:19', '2021-11-26 15:27:19', '2022-11-26 15:27:19'),
('7245ac599f1f66445536de49cab52c2a5c48761cef7f497cebb983ac6cbd0c37eb0e56855549eda5', 2, 1, 'token', '[]', 0, '2021-12-17 15:33:39', '2021-12-17 15:33:39', '2022-12-17 15:33:39'),
('725b469f01d89258bfe6cd8758b5c00a23f11a2aed0068971e4776ede1202ced11b39ad524efb9e5', 50, 1, 'token', '[]', 0, '2021-12-14 10:57:44', '2021-12-14 10:57:44', '2022-12-14 10:57:44'),
('7299afc52c9fde1bc19c9fb75e87f08d2d91b68c972cf7dc73ce3bbfeb1e765c967a2ce42e12e644', 50, 1, 'token', '[]', 0, '2021-12-03 13:29:53', '2021-12-03 13:29:53', '2022-12-03 13:29:53'),
('729c4c1a9090ffc2b5da46e1aad987e899d963477a8f964bac150758441f612540346ef6dc8a6f56', 2, 1, 'token', '[]', 0, '2021-11-22 09:48:27', '2021-11-22 09:48:27', '2022-11-22 09:48:27'),
('72af8add1de597a07a10f584f48cc69df16556234d5da516c56089016cbbe5dea2e48925b1e23f82', 2, 1, 'token', '[]', 0, '2021-12-07 19:30:48', '2021-12-07 19:30:48', '2022-12-07 19:30:48'),
('72ce6bfcf3972229ce1944561c36370a7dbc4b7426bd65ced31393bebc67ff3d358ae4d768f9b790', 2, 1, 'token', '[]', 0, '2021-12-10 17:54:05', '2021-12-10 17:54:05', '2022-12-10 17:54:05'),
('72e69397adb050e900bda86e09989cdf9111c5a74ef9693f971c665620893b95b0542cdad493024d', 50, 1, 'token', '[]', 0, '2021-12-03 12:59:20', '2021-12-03 12:59:20', '2022-12-03 12:59:20'),
('730b7ad4ee2760b33753d1f0c94315ee7aa3038ee36592e598806d102bff35f16cb45f1fc699b7eb', 2, 1, 'token', '[]', 0, '2021-11-18 12:42:15', '2021-11-18 12:42:15', '2022-11-18 12:42:15'),
('731b423a164094cb3a4af5b5f968a4c9aecf3eacda3b16e9aebf8f8edfd072289d464fc1cdc58927', 80, 1, 'token', '[]', 0, '2021-12-03 15:50:23', '2021-12-03 15:50:23', '2022-12-03 15:50:23'),
('731e95d2138087cf4a249f9c8b269e817df45495159107fb4f37683820150690561dfa9a52cbca2c', 2, 1, 'token', '[]', 0, '2021-12-04 11:13:49', '2021-12-04 11:13:49', '2022-12-04 11:13:49'),
('73cf39584227c540904dcbf8a790f08f5089403c6ce8dad205137b55b8863dcc1cfd7016b753e292', 2, 1, 'token', '[]', 0, '2021-12-04 10:57:18', '2021-12-04 10:57:18', '2022-12-04 10:57:18'),
('73f96b8d84fef81923313dab7e8a930ca6c448dd2203216dbcd7c5f903f703b1529360ecb39571a5', 50, 1, 'token', '[]', 0, '2021-11-30 11:46:57', '2021-11-30 11:46:57', '2022-11-30 11:46:57'),
('7429fa6bc8c02d863f27dbd344927388c427cd03eaa66c861df8b0ecd13370ebd45dbeff86624dad', 37, 1, 'token', '[]', 0, '2021-11-17 09:48:23', '2021-11-17 09:48:23', '2022-11-17 09:48:23'),
('745367c25a75b09a98d01bd14b86ff8f07e0a81dec24dd3bc7c21d8c17c4c1cd5829acb335cac125', 50, 1, 'token', '[]', 0, '2021-11-30 11:58:50', '2021-11-30 11:58:50', '2022-11-30 11:58:50'),
('74566a92bd98f8f6fa68c5412d1e7ee401d9f73cdfd3fe5bfb75901e4537c821a3e95611a268d255', 50, 1, 'token', '[]', 0, '2021-11-26 15:28:19', '2021-11-26 15:28:19', '2022-11-26 15:28:19'),
('747140fa0c4f794cb76238bd08726b0af4d8a78e9a0043bf13b2d109ab03967e6466f29a6352fc75', 61, 1, 'token', '[]', 0, '2021-12-01 09:53:04', '2021-12-01 09:53:04', '2022-12-01 09:53:04'),
('7477d8c3fd31b94ba711fadc83e28f26f28890a468b814d74b9ebe4390d79a2a012761efed621028', 51, 1, 'token', '[]', 0, '2021-11-30 17:50:30', '2021-11-30 17:50:30', '2022-11-30 17:50:30'),
('747ae780e8da747f9ca60a179c24e375fd9c4e00d5d6b6a389249eaa67ccbd720234b3dcaa79a1a2', 2, 1, 'token', '[]', 0, '2021-06-22 16:22:32', '2021-06-22 16:22:32', '2022-06-22 16:22:32'),
('74938434bd730d41de7c94a3202403f078e1ce965c26a2644e385fd897bea526c60ad49f68f49b6e', 2, 1, 'token', '[]', 0, '2021-12-10 13:55:35', '2021-12-10 13:55:35', '2022-12-10 13:55:35'),
('74af31ae799a98a9bc4151ba8de0a80b08be90df5a7d62942ce9460c54c29b890effe42f1234b922', 2, 1, 'token', '[]', 0, '2021-06-22 18:41:47', '2021-06-22 18:41:47', '2022-06-22 18:41:47'),
('74d6e1be49e2c79b7f9af99b80236e951356152566bfa847ee22ad46a34b301b7b9671bc5c8e93d6', 50, 1, 'token', '[]', 0, '2021-12-13 17:07:59', '2021-12-13 17:07:59', '2022-12-13 17:07:59'),
('74fa912658333384a39d5193da2926a984f3385c9901b2b0bc75089a46e94481427387a74f09c3f8', 80, 1, 'token', '[]', 0, '2021-12-21 14:41:51', '2021-12-21 14:41:51', '2022-12-21 14:41:51'),
('7540564162231e1a3fb17ec3e7254aad1abe5b85723da0daae0c0fab4a51a2e15c095036fa67f35e', 50, 1, 'token', '[]', 0, '2021-12-03 10:22:04', '2021-12-03 10:22:04', '2022-12-03 10:22:04'),
('7556959acb5735ae3161a67d1e818375b857793b3273829ff49a4b9747b0f9110ea5d039d6648470', 2, 1, 'token', '[]', 0, '2021-12-06 17:24:03', '2021-12-06 17:24:03', '2022-12-06 17:24:03'),
('757ba480a47cb9a6c209d43c2aba840710442533ca86bfe63ffd3d37820ecdf561aeb377870d4f94', 2, 1, 'token', '[]', 0, '2021-11-12 09:35:14', '2021-11-12 09:35:14', '2022-11-12 09:35:14'),
('75905ebed5d7c3318ed87a8e50bdcbd2b3b31f591277638a0adb18f94027c7de8e471d2e312e9389', 108, 1, 'token', '[]', 0, '2021-12-10 11:43:15', '2021-12-10 11:43:15', '2022-12-10 11:43:15'),
('75abc31423d64491022bd0c51740403c480b25985b8dcb586f5f6d84b1d2f36bde1ef1c52c8b16f5', 37, 1, 'token', '[]', 0, '2021-11-18 10:54:57', '2021-11-18 10:54:57', '2022-11-18 10:54:57'),
('75b09a3282ee76083db8407701780ad9db13af3418e948f741df466a0b87f3ce02b7b894bbb3e340', 2, 1, 'token', '[]', 0, '2021-11-12 14:21:19', '2021-11-12 14:21:19', '2022-11-12 14:21:19'),
('75b48fbb3697b06e2d3cd22886edd461a7698df072e3177d25b075d75b894dc76f8c11150c267c2f', 2, 1, 'token', '[]', 0, '2021-06-09 10:56:06', '2021-06-09 10:56:06', '2022-06-09 10:56:06'),
('75ff54fbc2d4bccb612b9cadb639b0fe2088a8f85f79cef4ee419c96c0d36da74c1291fe83cad386', 2, 1, 'token', '[]', 0, '2021-11-30 12:27:15', '2021-11-30 12:27:15', '2022-11-30 12:27:15'),
('765634e910fc45b057047795b0e020d798800a27cb1e0cadc3072c72d34c77a9215a56b3fb39180f', 61, 1, 'token', '[]', 0, '2021-12-03 11:03:24', '2021-12-03 11:03:24', '2022-12-03 11:03:24'),
('765b48e45d482b57b36d665c76529d822d42add11611481dacd291b652cd8db3090f64d565d7b87e', 2, 1, 'token', '[]', 0, '2021-12-14 10:58:48', '2021-12-14 10:58:48', '2022-12-14 10:58:48'),
('765ebf86f2bfff0d60aa7786707535b0efb0d870ddad77924740e0f20f82303888da88a573702ae8', 50, 1, 'token', '[]', 0, '2021-12-01 15:15:15', '2021-12-01 15:15:15', '2022-12-01 15:15:15'),
('76665d2747640a75ecfc4ab1360cf051ad6305c52fdcc909c94d3632fc75e4491d21fd289657bfa6', 61, 1, 'token', '[]', 0, '2021-12-03 11:03:29', '2021-12-03 11:03:29', '2022-12-03 11:03:29'),
('76dc370c4eefd9a49a624245c3a4e82232c0217059ff1fd60305f34b23ba72efaa698ae396372507', 80, 1, 'token', '[]', 0, '2021-12-03 16:56:20', '2021-12-03 16:56:20', '2022-12-03 16:56:20'),
('76e11d7539ecf70d9e374b7c386fd2c4ed82210226b3fc1307b3e42ced1a2c75d35cf82d3d743dd6', 37, 1, 'token', '[]', 0, '2021-11-18 10:20:30', '2021-11-18 10:20:30', '2022-11-18 10:20:30'),
('76ea2a101297cc12d010f93e055b052fb6f21d7db2dae75fd2661c67cd63b93fbff570c3ce84a93e', 66, 1, 'token', '[]', 0, '2021-12-01 16:35:18', '2021-12-01 16:35:18', '2022-12-01 16:35:18'),
('77665d1556b4eb3e0b5aa339d771fdd3a1f63fa8680ad21afd981e26689b5c69daf7538d340c94c5', 2, 1, 'token', '[]', 0, '2021-12-11 22:52:55', '2021-12-11 22:52:55', '2022-12-11 22:52:55'),
('77be8cdcc5ee7cd48967bbebc65d440c26eb9a017de9afc49be69ea24d1fc72659255fa5dfcf1e32', 81, 1, 'token', '[]', 0, '2021-12-03 18:50:28', '2021-12-03 18:50:28', '2022-12-03 18:50:28'),
('77d566dc9a8f30069c2a189ee7183d0f3e5ae797df1fe833e8b38c07578ae1052ea8f507537eb65c', 50, 1, 'token', '[]', 0, '2021-12-13 11:06:54', '2021-12-13 11:06:54', '2022-12-13 11:06:54'),
('77de1f738fe92edd7bbe11c4fb01f20ec1b3114d5c0583cf5e7618629b907551447dd2d8d8e04dae', 2, 1, 'token', '[]', 0, '2021-11-13 14:22:09', '2021-11-13 14:22:09', '2022-11-13 14:22:09'),
('77eea7a6c7ab1f9722b5dfacd1dcba5658864c4510004c2b45788e2549a4e667c85eaa4bbd88c965', 50, 1, 'token', '[]', 0, '2021-12-13 14:25:54', '2021-12-13 14:25:54', '2022-12-13 14:25:54'),
('77fe83c9574716dd6ca80e4d3b38fdfa36d58ddd4de50ab0e550f1c29173a06506f30dbddf4f4949', 50, 1, 'token', '[]', 0, '2021-11-30 11:38:22', '2021-11-30 11:38:22', '2022-11-30 11:38:22'),
('784caefb0fc90db81b00e14d0c6179869f52ae5721e618282510fc4a1249368fd8e1c330c973bd53', 2, 1, 'token', '[]', 0, '2021-11-19 15:47:03', '2021-11-19 15:47:03', '2022-11-19 15:47:03'),
('7853efb2fc1a4717cb447aac046ddf4cb022efda683f25635040b7a9e930808a8b5cc22f7a8b8bdd', 37, 1, 'token', '[]', 0, '2021-11-29 11:22:07', '2021-11-29 11:22:07', '2022-11-29 11:22:07'),
('7868d551f2487c6164d5945be3770fa2d628d83d2ad775284146a3c4524f891d6a2ff420b07ad733', 2, 1, 'token', '[]', 0, '2021-12-10 15:48:15', '2021-12-10 15:48:15', '2022-12-10 15:48:15'),
('78c2f2f7466288a8f56807f564b29f43c9d6ae82f06a704f18f1bf549404e592bc125d9a3b3d9159', 2, 1, 'token', '[]', 0, '2021-12-14 11:19:33', '2021-12-14 11:19:33', '2022-12-14 11:19:33'),
('78cf9288fd769bcb74b7226f7793af90a88cdaf6686044da6ca2f4486821638c366f93bfd18dfbe6', 80, 1, 'token', '[]', 0, '2021-12-03 14:57:09', '2021-12-03 14:57:09', '2022-12-03 14:57:09'),
('78dec066fd839a4040ca9706c0b43bfe303573c80dcff0bb66844a9d91bcc473573f35c1d6146289', 2, 1, 'token', '[]', 0, '2021-12-04 12:41:54', '2021-12-04 12:41:54', '2022-12-04 12:41:54'),
('7911fdf07cf5f27fa7fcd6025aa5576cf94c131115a82c2ef6da34496063786152508f813607abd5', 2, 1, 'token', '[]', 0, '2021-11-19 14:47:31', '2021-11-19 14:47:31', '2022-11-19 14:47:31'),
('7943f7a5dac470c19d48f8273bcee2d586f43e1c440cd66afa74bcfddd1a9a7a02cb69142f947ea9', 2, 1, 'token', '[]', 0, '2021-12-16 17:06:22', '2021-12-16 17:06:22', '2022-12-16 17:06:22'),
('797eb3fa72db4e6808533cc27211ea97c29720d2f4f55a1e78bed51b0c4525d9d7875f92471f2786', 37, 1, 'token', '[]', 0, '2021-11-17 09:44:19', '2021-11-17 09:44:19', '2022-11-17 09:44:19'),
('7a8a106399030e6e4c1c0cde2f2ffc8cbfeb939929d7d3f2928e526f828722b29cffffb2cd29332f', 2, 1, 'token', '[]', 0, '2021-06-23 03:38:54', '2021-06-23 03:38:54', '2022-06-23 03:38:54'),
('7a96d629e65fdcd85f5781863b393447886f033754d976267d6ee8f5ece00a4152597e48c9b60ab8', 2, 1, 'token', '[]', 0, '2021-06-22 18:10:45', '2021-06-22 18:10:45', '2022-06-22 18:10:45'),
('7ace3f5b373c745985dbfc209346e18d741b05b1128400d0debdea863b1d2cc66bead1a4c3226632', 2, 1, 'token', '[]', 0, '2021-12-03 18:07:13', '2021-12-03 18:07:13', '2022-12-03 18:07:13'),
('7b02335d21dfd038540080f0cac80d57318c568c38cf9e1298ef715ee32cffcd2ab5871f4d26e811', 2, 1, 'token', '[]', 0, '2021-12-04 11:12:59', '2021-12-04 11:12:59', '2022-12-04 11:12:59'),
('7b54679ba0601f90cdd6c14ebc6de868abfa344a456463d2b27a59ee408117aa56cb08557c6cdbf5', 50, 1, 'token', '[]', 0, '2021-12-01 14:43:02', '2021-12-01 14:43:02', '2022-12-01 14:43:02'),
('7b7814f98a7021d3d00dc6281d54dcd37c7f9d6242f6e0c500fd7d793eb3fc8cbf099bea70c0d150', 37, 1, 'token', '[]', 0, '2021-11-13 10:02:52', '2021-11-13 10:02:52', '2022-11-13 10:02:52'),
('7bf5f043b0e720f653b07914dd4b92fb85416ff542463b5328d46095641674ea1931a8c5cbfc18e2', 50, 1, 'token', '[]', 0, '2021-12-13 14:24:36', '2021-12-13 14:24:36', '2022-12-13 14:24:36'),
('7c179910afef56cf2ee18d2f128d8b2900099a847fce6b617f35f86465f3998d26b9f398533b7709', 50, 1, 'token', '[]', 0, '2021-11-29 18:08:05', '2021-11-29 18:08:05', '2022-11-29 18:08:05'),
('7c1878c970d10da81ab78798bc32188888ddf0e6c21dddf51a3cc010f712ea65f2a757e7fd31d2ff', 37, 1, 'token', '[]', 0, '2021-11-18 10:44:40', '2021-11-18 10:44:40', '2022-11-18 10:44:40'),
('7c6c2c1438d887aa0cf491aa9119253477f4f62c19664eea8a8b0dfd679a6e4eb3aa260391a023aa', 37, 1, 'token', '[]', 0, '2021-11-13 15:14:56', '2021-11-13 15:14:56', '2022-11-13 15:14:56'),
('7c777496eaca11049d20ab798696f34e5bb3326bc8eb4d67ffa26b6b652753d763254ac6885aecf4', 37, 1, 'token', '[]', 0, '2021-11-18 10:15:01', '2021-11-18 10:15:01', '2022-11-18 10:15:01'),
('7ca521921912f1e7c21a4068cbe40212fa3286390f6ab90adf9e6df97a4ac249de4a219678c0b465', 2, 1, 'token', '[]', 0, '2021-11-30 18:12:37', '2021-11-30 18:12:37', '2022-11-30 18:12:37'),
('7cb16876a60f682ae84e5bcc55b3aa761febf7ef3611b9148e381a75330109150f58a6682fab513b', 50, 1, 'token', '[]', 0, '2021-11-24 16:54:03', '2021-11-24 16:54:03', '2022-11-24 16:54:03'),
('7cd6669c566926f362558b570e3946467cdd83921fa51dbfa100fbead8188c32565a648ec89aaf00', 37, 1, 'token', '[]', 0, '2021-11-18 14:50:33', '2021-11-18 14:50:33', '2022-11-18 14:50:33'),
('7cf5c439db61a3abcc044cab767cf0428b76695c8c09852ff108f87a3d4be22246ebc42cd9ec56b5', 2, 1, 'token', '[]', 0, '2021-11-19 17:48:42', '2021-11-19 17:48:42', '2022-11-19 17:48:42'),
('7cfe4f8fd9fc718d865c8a18877ab7f2d074c8f4fd98652b1d6ef3e595ed52d557ef6a21acbe2bb2', 2, 1, 'token', '[]', 0, '2021-11-19 10:14:36', '2021-11-19 10:14:36', '2022-11-19 10:14:36'),
('7d015b83bc0692e00eed32f0662edf3df2436d6f3061dd6f3d234d26a831a28ca468eff2d54a11d4', 2, 1, 'token', '[]', 0, '2021-06-22 13:43:16', '2021-06-22 13:43:16', '2022-06-22 13:43:16'),
('7d3d2483efce32015843162718bfb8418f7826c351267101993698a3ac9fc605ece42b5ff784de3f', 37, 1, 'token', '[]', 0, '2021-11-13 17:09:24', '2021-11-13 17:09:24', '2022-11-13 17:09:24'),
('7d9792b03fbdff047d54a7c0ae76c3ca3b06fed106e25f21da8c4dc3d7c6f9d52cf1af96f76060c6', 2, 1, 'token', '[]', 0, '2021-11-13 10:25:47', '2021-11-13 10:25:47', '2022-11-13 10:25:47'),
('7db9dd9c8e82e977f127d2596bcfb0b760dfbe4f2c9d2ae1696ca6c247a72ad321d574b31bd5310e', 50, 1, 'token', '[]', 0, '2021-11-29 15:12:42', '2021-11-29 15:12:42', '2022-11-29 15:12:42'),
('7dc658c2bac07b5a760863d133263f44a14c2b5b747cfaee6598bae7d9fb9d69ea5e4817c5aa474f', 80, 1, 'token', '[]', 0, '2021-12-06 10:08:13', '2021-12-06 10:08:13', '2022-12-06 10:08:13'),
('7e020229696a1f8588aa33a9b1da3309d78870318497bfb3758142d5c2a1b5d8c52376ff1fdcbad8', 61, 1, 'token', '[]', 0, '2021-12-01 11:58:34', '2021-12-01 11:58:34', '2022-12-01 11:58:34');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('7e16390c2cc2e40348ef8277240e8c45708593b3f486767af355f57f7ad363b6ab32eb4ea9e54f99', 2, 1, 'token', '[]', 0, '2021-12-16 10:44:00', '2021-12-16 10:44:00', '2022-12-16 10:44:00'),
('7e295ddba260c144e4a1a7a2e737011d2e12ff4527e6a5f644c3547237ace8d1e474033526a5b858', 2, 1, 'token', '[]', 0, '2021-12-13 14:16:17', '2021-12-13 14:16:17', '2022-12-13 14:16:17'),
('7e3a19e83efe5e81c73f62a8a2731e5e8ff71d8a0717d17665f726232c085413fcc80bbda83bdcb1', 50, 1, 'token', '[]', 0, '2021-12-13 14:18:14', '2021-12-13 14:18:14', '2022-12-13 14:18:14'),
('7e3dffcaf320580edaf8c9d49d33edc5714ef3cc81f14176c8a7529ee0f0d96b5c7b6f7be1b3acb6', 37, 1, 'token', '[]', 0, '2021-11-18 12:59:09', '2021-11-18 12:59:09', '2022-11-18 12:59:09'),
('7e48f69d2c3f8112cf84f043d7348dbc09b8180656b19bb33f1ce99d9e629126f84d9a221331a716', 2, 1, 'token', '[]', 0, '2021-12-06 17:52:59', '2021-12-06 17:52:59', '2022-12-06 17:52:59'),
('7e637b72d32d900784436e6a1da5bb294b39e5c102866949a3bf98d3c5f71ed41e0ba6972b673e14', 2, 1, 'token', '[]', 0, '2021-11-11 11:22:21', '2021-11-11 11:22:21', '2022-11-11 11:22:21'),
('7ecda3b962ed8c15416bdc4876fa7b6efe6da89e37c00492063a97593c100d1748114a9b7c173400', 37, 1, 'token', '[]', 0, '2021-11-15 11:05:19', '2021-11-15 11:05:19', '2022-11-15 11:05:19'),
('7ed2cdbe0b696a5de869d1906be12e1b53da3343ea01feda6822fc1128d3cf0832d2cfd9bf0f41e5', 2, 1, 'token', '[]', 0, '2021-12-16 17:16:53', '2021-12-16 17:16:53', '2022-12-16 17:16:53'),
('7f1c3d5d149e907bc5d0c65779439f1351f122017c75e38c9ca8e660a1f6c04a166f8fd0c801579b', 37, 1, 'token', '[]', 0, '2021-11-29 12:39:04', '2021-11-29 12:39:04', '2022-11-29 12:39:04'),
('7f247c58b0988b953e6cc9bd7de2450e11726f70c15f318a9a6c71fdc7d0e8197c5519ed0484e1cc', 50, 1, 'token', '[]', 0, '2021-11-30 12:22:10', '2021-11-30 12:22:10', '2022-11-30 12:22:10'),
('7f278dc2a84210afe440313d4391705adb9d40e419960647b7866fed27a60fa1a29084b6bfe8d7ba', 2, 1, 'token', '[]', 0, '2021-12-13 11:16:35', '2021-12-13 11:16:35', '2022-12-13 11:16:35'),
('7f2a948c71dd1895dbcba698ed6e33791974fae6165ec587ed5e653d6cddb2316f59943d618ca1f0', 2, 1, 'token', '[]', 0, '2021-12-20 11:53:19', '2021-12-20 11:53:19', '2022-12-20 11:53:19'),
('7f35f3215b59650c0b790b8ab50fde8243436de715041d4c846a67c6de6db0d852a0da472cde9fd0', 48, 1, 'token', '[]', 0, '2021-11-19 17:59:19', '2021-11-19 17:59:19', '2022-11-19 17:59:19'),
('7f3c68174d7bda61be3870b19b05c635fa8ff72c010932c9b6923cac927548d4c211f8eb68645240', 50, 1, 'token', '[]', 0, '2021-11-30 10:45:34', '2021-11-30 10:45:34', '2022-11-30 10:45:34'),
('7f4122e6b0b7738531b5b8445930ebc35e618d6b77cc0a3534b25a9a088c9fa44005e9efc0354706', 2, 1, 'token', '[]', 0, '2021-12-14 10:37:18', '2021-12-14 10:37:18', '2022-12-14 10:37:18'),
('7f67cac60a0889d3782372508384005430bbccc0eb97b80ace1d26e64fe5b9a9d1abd2a9f4d1f740', 2, 1, 'token', '[]', 0, '2021-11-26 17:10:48', '2021-11-26 17:10:48', '2022-11-26 17:10:48'),
('7fc0e94b1523b6c4992e2ae3193eed375ded4a4277f930192bf8609e300182dec0a45b290ed06f60', 50, 1, 'token', '[]', 0, '2021-11-22 11:57:28', '2021-11-22 11:57:28', '2022-11-22 11:57:28'),
('7fcb0a55204b0ee3467b23c5ffa6a59f150b2f49c362cec7de0e4498923a4e508e64cb210e834989', 50, 1, 'token', '[]', 0, '2021-11-30 19:11:47', '2021-11-30 19:11:47', '2022-11-30 19:11:47'),
('7fecdf0f0fc5777062f213ee56012ac22e1075fb46cdf91f4fe2684e834f25c34a394bf5087f398f', 50, 1, 'token', '[]', 0, '2021-11-24 16:52:57', '2021-11-24 16:52:57', '2022-11-24 16:52:57'),
('7ff585a264cd2d91abe54a202c363866f8d9e1f2082803ae3e7ee10137770f5c60db3c60a227503e', 48, 1, 'token', '[]', 0, '2021-11-19 12:42:44', '2021-11-19 12:42:44', '2022-11-19 12:42:44'),
('8018a7839ecea1918a146e146419c40efdc041cbb3aa4df37ce2ae3f96832f7823254124db791875', 50, 1, 'token', '[]', 0, '2021-12-03 14:21:09', '2021-12-03 14:21:09', '2022-12-03 14:21:09'),
('803fec2139759f0b34b39c061d0a237d8616129278799ccb68420bf1695de4a8c27f32384e26f6a2', 2, 1, 'token', '[]', 0, '2021-11-02 14:46:56', '2021-11-02 14:46:56', '2022-11-02 14:46:56'),
('80770a1e6e3486429deeaeeb882f86d2d62805b1a3de42c20c280272f20b140bfe7f3348ca2dac12', 37, 1, 'token', '[]', 0, '2021-11-17 18:45:19', '2021-11-17 18:45:19', '2022-11-17 18:45:19'),
('808b54631fe7dd336867aa6256af6797caa664336e6b453dfcd75b24ed0b91a77c7a091a433203c5', 50, 1, 'token', '[]', 0, '2021-12-01 17:17:53', '2021-12-01 17:17:53', '2022-12-01 17:17:53'),
('8098c8404e90f217bb692e2a3dc1a1b97b34ee7d3b7046ab21165056a7b93bf45df6e9d1ea6d47f8', 2, 1, 'token', '[]', 0, '2021-11-18 15:20:19', '2021-11-18 15:20:19', '2022-11-18 15:20:19'),
('80bab502d64ec4ccd3a4336bb0df2f8483e410414109275bc722a995b242037cf2de39a97670cbab', 2, 1, 'token', '[]', 0, '2021-12-07 10:07:28', '2021-12-07 10:07:28', '2022-12-07 10:07:28'),
('80d6ce8bdf45405da7c9628b1350784e2f8c51044b94741b70fdce553bcffc6736c4705eeb415950', 50, 1, 'token', '[]', 0, '2021-12-03 13:42:50', '2021-12-03 13:42:50', '2022-12-03 13:42:50'),
('80e66ca481aeab6253f6aec45ee1f42e4074747c2dadac4c776465718f9e351d6fbdc80696270fe0', 37, 1, 'token', '[]', 0, '2021-11-17 18:12:25', '2021-11-17 18:12:25', '2022-11-17 18:12:25'),
('80ed5bb33c76cf1858f605e9ce252746aca1e48875aa30bd4b45a6bf45a05dd90b69b4875f87a118', 80, 1, 'token', '[]', 0, '2021-12-21 17:33:37', '2021-12-21 17:33:37', '2022-12-21 17:33:37'),
('812897d9746eac45399bdcb8d2d97a5c3ca5addc4266e36229cd218c4ea9e209899edd297a1560db', 2, 1, 'token', '[]', 0, '2021-06-19 20:19:33', '2021-06-19 20:19:33', '2022-06-19 20:19:33'),
('812acd5be85a29cae851c54e8ea31735db60d412a88686472b54dc67a745dcd736a5e88b0e865340', 80, 1, 'token', '[]', 0, '2021-12-17 11:55:47', '2021-12-17 11:55:47', '2022-12-17 11:55:47'),
('8143868dd7320b5866220aaa11b791bd117a6489fb0c67ef47c428a767c218deff4e388f3615f897', 50, 1, 'token', '[]', 0, '2021-11-27 13:40:35', '2021-11-27 13:40:35', '2022-11-27 13:40:35'),
('8147bcc14d54271cb7a1846496dd577ce983f15c798d3bfbb89288cbc3b4d8889c6304cf7b03dbd4', 2, 1, 'token', '[]', 0, '2021-12-16 10:53:46', '2021-12-16 10:53:46', '2022-12-16 10:53:46'),
('814db05d06cce1d066f338d63ae93db1e62476f8108ca4a648da5c40170ab5318afe581d0767ce47', 2, 1, 'token', '[]', 0, '2021-12-14 10:20:13', '2021-12-14 10:20:13', '2022-12-14 10:20:13'),
('81dd42b8c795ebb9712ac52c6f22ceb8db87c26baeec4d7cc5f59a0c99976b98c0bba6703a2005f8', 50, 1, 'token', '[]', 0, '2021-11-30 15:32:45', '2021-11-30 15:32:45', '2022-11-30 15:32:45'),
('81e704758c6d53b4690d2c0bd5628e45a6dffa7c8f669404d65a9617733c656f7f7e8c2d096566f7', 2, 1, 'token', '[]', 0, '2021-06-15 20:24:13', '2021-06-15 20:24:13', '2022-06-15 20:24:13'),
('81f089c0417ddffec41b467939280ed267ba5784cb42242cd073021dfab84622edce04dc55b50ce5', 2, 1, 'token', '[]', 0, '2021-12-07 12:52:59', '2021-12-07 12:52:59', '2022-12-07 12:52:59'),
('820edc361985933c28858d7f97f7def309a5872eb3280c29d51bbb0a1a8c9a36e6d71b4e47c226af', 50, 1, 'token', '[]', 0, '2021-11-24 16:46:55', '2021-11-24 16:46:55', '2022-11-24 16:46:55'),
('8222d37e770161709d80ec5fa7e1c76be4a28865b68fe97914c475d79648cecea7151f8905bcfcb7', 2, 1, 'token', '[]', 0, '2021-12-04 09:24:28', '2021-12-04 09:24:28', '2022-12-04 09:24:28'),
('82602378b8ed6060c5caa0f22ecb4b3f354254a12348f88e8d1ea9570a805564b2453d23d3330fb6', 50, 1, 'token', '[]', 0, '2021-11-30 19:06:08', '2021-11-30 19:06:08', '2022-11-30 19:06:08'),
('82663e6646aca6431b675542f577955d093b38a9db7f6e3940409bc2e34e603085d39dc09ebc0819', 48, 1, 'token', '[]', 0, '2021-11-19 12:43:46', '2021-11-19 12:43:46', '2022-11-19 12:43:46'),
('82835bdbba35e1b34c50fea29d86351b48198ee797daebc9d07bb247d845408319e0251c5761fa5d', 48, 1, 'token', '[]', 0, '2021-11-19 12:50:39', '2021-11-19 12:50:39', '2022-11-19 12:50:39'),
('82a660891842c91732c022b7144e850f77ecd628a0b5da2bd22d298ceb94e7b590958816bdb4d98b', 50, 1, 'token', '[]', 0, '2021-11-29 14:16:26', '2021-11-29 14:16:26', '2022-11-29 14:16:26'),
('82bb11bf29436fc159f8d7193cf4724051e7ab6003c8e78824898e193ef7d18595e8a78cebd054bb', 37, 1, 'token', '[]', 0, '2021-11-17 18:19:10', '2021-11-17 18:19:10', '2022-11-17 18:19:10'),
('82cf6a847259385f0014224d714d58c9bdc7b06fe18019b9dcf8dd8f879343bf11f985a0367b6787', 2, 1, 'token', '[]', 0, '2021-11-29 15:31:59', '2021-11-29 15:31:59', '2022-11-29 15:31:59'),
('82cfc97b7ebd3fadeb71ee5d0eecdc526dd5c60caa632ca56793006c0bf1d4dc6baf0da0163122fa', 2, 1, 'token', '[]', 0, '2021-11-29 16:38:23', '2021-11-29 16:38:23', '2022-11-29 16:38:23'),
('82dfac102d253f7361d99a7013474c1629d286d23d8f466563a93b56d9789d1bf98d216fa8b814fe', 2, 1, 'token', '[]', 0, '2021-12-16 12:06:22', '2021-12-16 12:06:22', '2022-12-16 12:06:22'),
('82e683da2b1f48da0d3dab32015013ff375353fb2306fd9b50858565527463a6f06f07e7ef68f443', 50, 1, 'token', '[]', 0, '2021-12-03 13:11:57', '2021-12-03 13:11:57', '2022-12-03 13:11:57'),
('82f2c29e00c3aff2e84262a5d4afc09d1ea795092da7e9bc57f338f0eb7ec1a928477107d413ff19', 80, 1, 'token', '[]', 0, '2021-12-08 11:52:15', '2021-12-08 11:52:15', '2022-12-08 11:52:15'),
('82f6349769b812df2562a51bb4bf72e08f09e3d0338da792cdb6e5442f0f48cbb2aa28fb94102d86', 50, 1, 'token', '[]', 0, '2021-12-02 16:35:37', '2021-12-02 16:35:37', '2022-12-02 16:35:37'),
('83149530419b8a2ab3b545135d7031afc9826096b7069852571c3936b25f3ea8572cc158992368e0', 37, 1, 'token', '[]', 0, '2021-11-18 16:11:25', '2021-11-18 16:11:25', '2022-11-18 16:11:25'),
('8317d4212eb6519ceb56d8eb7ffa11824c19c04bac5728ae6351ef9907a9d1adc0ce9a178b348736', 37, 1, 'token', '[]', 0, '2021-11-18 11:01:13', '2021-11-18 11:01:13', '2022-11-18 11:01:13'),
('836b80c67da8fb0db0efb5d989926e57f14095b4d03791fb053ae33923a5f528c0c8089393a41d66', 51, 1, 'token', '[]', 0, '2021-11-30 17:35:54', '2021-11-30 17:35:54', '2022-11-30 17:35:54'),
('837a253f40adcb7b3607a5caeef7b75d27a4431aa8446aafdd96f1e898f9c1923f85f85d177cadc7', 50, 1, 'token', '[]', 0, '2021-12-02 16:06:34', '2021-12-02 16:06:34', '2022-12-02 16:06:34'),
('837b9b213b89ac2fbb536030c392bc9b70dc7e71cba3975e28ce708276173f2f0e343e3d1a65c202', 50, 1, 'token', '[]', 0, '2021-12-01 10:41:35', '2021-12-01 10:41:35', '2022-12-01 10:41:35'),
('8392f789ddea88e43e34a6cf162b9599095a1500968bc1397eb244bc73ff7b78f05bee4b88d842ba', 80, 1, 'token', '[]', 0, '2021-12-21 14:25:14', '2021-12-21 14:25:14', '2022-12-21 14:25:14'),
('83a1cb383203a6050c07e5e77c58ea67eefee20604e50599e6d01097fd7c13336d4bf3db15c674c5', 81, 1, 'token', '[]', 0, '2021-12-10 10:47:14', '2021-12-10 10:47:14', '2022-12-10 10:47:14'),
('83c1c5569d2cb769ddc3c20123e63ff7364e0d6582e39604f3916aa5bb49b44712406255bfe0601f', 50, 1, 'token', '[]', 0, '2021-11-30 12:09:29', '2021-11-30 12:09:29', '2022-11-30 12:09:29'),
('83dcc5b81dc1f37c2086f8a65ff15eb00f3fbbf93d1af4f88b8575468fa4f42cc13d5c1aab6e96d1', 37, 1, 'token', '[]', 0, '2021-11-15 16:41:16', '2021-11-15 16:41:16', '2022-11-15 16:41:16'),
('83fc7ceb0b864f134fb1e5e5bd31d845a9e988530d6bae58c9d96f1b08ae4db58ece064f693f8079', 37, 1, 'token', '[]', 0, '2021-11-18 09:45:52', '2021-11-18 09:45:52', '2022-11-18 09:45:52'),
('84356d05955b01a0e07667f2004340dfff1d95092702284fef9c01f80226f74bd703b871f2d63be6', 37, 1, 'token', '[]', 0, '2021-11-17 18:22:46', '2021-11-17 18:22:46', '2022-11-17 18:22:46'),
('843d77348239da8406a9906abf87a2d32fae42cf1e7d83efd7c3321aa99772bc413adc00d8ab283a', 37, 1, 'token', '[]', 0, '2021-11-18 10:21:01', '2021-11-18 10:21:01', '2022-11-18 10:21:01'),
('84407d67f0d484129fa2779cea6a5ea8fd74566a4a6d75d083e5be2d9d43752a7c54ac71be988b16', 68, 1, 'token', '[]', 0, '2021-12-03 13:46:51', '2021-12-03 13:46:51', '2022-12-03 13:46:51'),
('8457ed8b443c5473fa342840a045eb27abc25949274fc44935d78761919e96feb71343e3893d4be9', 37, 1, 'token', '[]', 0, '2021-11-17 18:46:17', '2021-11-17 18:46:17', '2022-11-17 18:46:17'),
('846059c795aa7dab1eb6b159bafb0feb05086943e57b9be59ec58d6b58bfd529719d5108872465e4', 2, 1, 'token', '[]', 0, '2021-11-29 19:01:20', '2021-11-29 19:01:20', '2022-11-29 19:01:20'),
('847375889d589f25bd6b1f13a7f24b263ec27a9a584ecadd528e06c7f38d99b9dce3c7b03e4f3bf1', 48, 1, 'token', '[]', 0, '2021-11-29 11:57:16', '2021-11-29 11:57:16', '2022-11-29 11:57:16'),
('84953591980fc761de7f08ce01c0f9d447d07633891a55df61c9b6254628a865b4c32cf343d22ab5', 37, 1, 'token', '[]', 0, '2021-11-18 09:37:09', '2021-11-18 09:37:09', '2022-11-18 09:37:09'),
('84a2d1198312194d2e676ea0a3a10e4a161e1f417ee51514b85e600e0913e543ab0fd8f9295f55f3', 89, 1, 'token', '[]', 0, '2021-12-08 12:10:24', '2021-12-08 12:10:24', '2022-12-08 12:10:24'),
('84c51b5185b51f27273bec96ad93984925d87f0f09832d684e2e3b38664fb5c4fd962d040813a683', 50, 1, 'token', '[]', 0, '2021-12-01 10:13:05', '2021-12-01 10:13:05', '2022-12-01 10:13:05'),
('84e6cb3708c91180958bb0b8da3eb92f16e9ace5819761c986eb02994397d4e16ff6b42b7c5397d7', 37, 1, 'token', '[]', 0, '2021-11-15 10:39:22', '2021-11-15 10:39:22', '2022-11-15 10:39:22'),
('85451d0a676cba02e4bdd9e0d8a24711762f122e37deb5cc64ad127307e503846cd86fbf6841984a', 50, 1, 'token', '[]', 0, '2021-11-19 12:57:08', '2021-11-19 12:57:08', '2022-11-19 12:57:08'),
('856d9935042564c69d0e75bee7134c82e7effe0f5ffb18d4bc4a34c35a35deed3d978cd48a52ea86', 37, 1, 'token', '[]', 0, '2021-11-18 14:54:04', '2021-11-18 14:54:04', '2022-11-18 14:54:04'),
('857a635b53cb95ed8d3346f8688d9d61085fc4b207d0f5c9258088c3494b1a41bd6f6814068b7ebf', 48, 1, 'token', '[]', 0, '2021-11-29 11:21:22', '2021-11-29 11:21:22', '2022-11-29 11:21:22'),
('8616f5f3767c04fb06a6f248bf02e7546c50edb58dd0ca9b25378a1b169458568167df071f4b2bb3', 2, 1, 'token', '[]', 0, '2021-11-30 17:11:50', '2021-11-30 17:11:50', '2022-11-30 17:11:50'),
('861f7792ef680fb0a9bce3d9399455843966c2ef46fa5807f54a0741a0c107a187288ad3fab675fa', 50, 1, 'token', '[]', 0, '2021-11-30 14:46:57', '2021-11-30 14:46:57', '2022-11-30 14:46:57'),
('862c95b56e5db06c1c76bbe038eb0665b4402b973ee35ca62c17297a9fd8a41669a62c5231b53b1b', 1, 1, 'token', '[]', 0, '2021-10-28 15:37:21', '2021-10-28 15:37:21', '2022-10-28 15:37:21'),
('862e0da210fa4b930dd30d237e9c6e74b1f3cc241575e6cf0a678ae0f4e6f68ab7900cad077bd31c', 68, 1, 'token', '[]', 0, '2021-12-21 15:32:16', '2021-12-21 15:32:16', '2022-12-21 15:32:16'),
('863560f4306e01455436811f561a4af19b2408344508207a0131c5bd99de40435508664ab1706dac', 78, 1, 'token', '[]', 0, '2021-12-03 12:28:11', '2021-12-03 12:28:11', '2022-12-03 12:28:11'),
('864b3a034e71e3ac0d1b7357b4019378e45623b3269cd3f0b7fb7db0aa575384aa94d0773e9f9869', 50, 1, 'token', '[]', 0, '2021-12-13 15:23:20', '2021-12-13 15:23:20', '2022-12-13 15:23:20'),
('86577490e45ff414f72779bf3170171c8623da1402d1082b9128aec98602b00d83b2f33decbdc77a', 37, 1, 'token', '[]', 0, '2021-11-18 10:49:38', '2021-11-18 10:49:38', '2022-11-18 10:49:38'),
('866faf7647c2e0961e3842fb9439559aaf1655cf3ef83409e8ace9cecf13982ea65620f681a5e236', 61, 1, 'token', '[]', 0, '2021-12-01 16:41:58', '2021-12-01 16:41:58', '2022-12-01 16:41:58'),
('868c91e7b415f289f3d4ae06da4be57bc6997f3227fe7b70b9327bb82e9ac7b7a122593be897c9e3', 37, 1, 'token', '[]', 0, '2021-11-19 12:18:30', '2021-11-19 12:18:30', '2022-11-19 12:18:30'),
('8693fb3478efc2701224b6389554da989a1060d7012b8b131cb971dbca43dc795f229cc8e528b1d7', 50, 1, 'token', '[]', 0, '2021-11-19 11:01:23', '2021-11-19 11:01:23', '2022-11-19 11:01:23'),
('86a0fefe6d1770ee84792c8045783cc10a90fadb9dae1f15bbaa36ce01588da2e986c02d31d091fa', 80, 1, 'token', '[]', 0, '2021-12-21 14:48:00', '2021-12-21 14:48:00', '2022-12-21 14:48:00'),
('86f5be8af79b854b4ec84438af70f721641e42d144c271c133f896419e41a1b1ced0d3708ea89d52', 78, 1, 'token', '[]', 0, '2021-12-03 14:56:20', '2021-12-03 14:56:20', '2022-12-03 14:56:20'),
('87116c953d2e479886bb230c4c85af8ced4632c5d52e4220f50787dfbcf8511b321ffbaab36008af', 50, 1, 'token', '[]', 0, '2021-11-27 18:07:12', '2021-11-27 18:07:12', '2022-11-27 18:07:12'),
('872d3d7b0902ce1b6cfaee22aac550b2a79f042199d18d22892ef9f84fb473ee4eb82e7edaf811ba', 37, 1, 'token', '[]', 0, '2021-11-18 10:57:44', '2021-11-18 10:57:44', '2022-11-18 10:57:44'),
('873047065cd29c68a4f86c0bbb455210529bc1bdb340e2467e4c81c0caab2ee4cabedb54c7fbfac0', 89, 1, 'token', '[]', 0, '2021-12-08 13:29:07', '2021-12-08 13:29:07', '2022-12-08 13:29:07'),
('875f9fbbd9e65f0043580d92c08ad75d2673843b063c49d5ca763241b7399324357462317561ebb4', 37, 1, 'token', '[]', 0, '2021-11-18 10:48:29', '2021-11-18 10:48:29', '2022-11-18 10:48:29'),
('8794ae6f6e94101adfe3bd6ddd1ca6c1fae5416db2945d5317e1f0a90fc8b8f4e46ac2f7265205d9', 2, 1, 'token', '[]', 0, '2021-11-26 16:14:08', '2021-11-26 16:14:08', '2022-11-26 16:14:08'),
('8795638404feb6bac883ab049bb9df9e8bc96779df42aeb9ef84522e87d53184c7502322314293b7', 2, 1, 'token', '[]', 0, '2021-12-04 11:25:53', '2021-12-04 11:25:53', '2022-12-04 11:25:53'),
('87e9fa1a5f72ca4468ffb29f9fd9dca2ac537d11e9ca1732b0df1cef11acfac9ea8e62447a3dfa43', 50, 1, 'token', '[]', 0, '2021-11-23 18:48:04', '2021-11-23 18:48:04', '2022-11-23 18:48:04'),
('87ef4d1bdccb94125deb90a5a8630c318e7b08469f6662fa8901898da312dce2fdef658983ea7d96', 1, 1, 'token', '[]', 0, '2021-12-01 11:48:05', '2021-12-01 11:48:05', '2022-12-01 11:48:05'),
('87f268d1b3c03f84e47adf5dca8a7e30810e4dc4e53f23fe376114ef87d892145bf60c719c680f73', 37, 1, 'token', '[]', 0, '2021-11-18 09:41:36', '2021-11-18 09:41:36', '2022-11-18 09:41:36'),
('882caa70b3c3e17e4d20ba8a01fd1f3342691b5c0ea95f019bc68eed2e61967959efede7f0fa7925', 50, 1, 'token', '[]', 0, '2021-12-03 10:19:28', '2021-12-03 10:19:28', '2022-12-03 10:19:28'),
('884feb55b125e17f08ef036df56aaaff48f875fbb7830421dc56f081b4e3845fbf26c89209090c2a', 2, 1, 'token', '[]', 0, '2021-11-24 14:08:01', '2021-11-24 14:08:01', '2022-11-24 14:08:01'),
('88b159f3cc36b030ac2544842a52528d94481c8b7db98d87d94cf5a9703f56fce738a6a60bc34ca2', 2, 1, 'token', '[]', 0, '2021-12-10 17:24:32', '2021-12-10 17:24:32', '2022-12-10 17:24:32'),
('88bf3775f8ac71074b44d3920119cc0c6fd4010c207f1dfa1e124a95a0d66d705391933adc572011', 2, 1, 'token', '[]', 0, '2021-11-13 10:31:54', '2021-11-13 10:31:54', '2022-11-13 10:31:54'),
('8929ffb6888fcce6e5809e4324bdab1a6ef98a5611c8d003e1bf0d70de8622c9f7902d720ec3448f', 50, 1, 'token', '[]', 0, '2021-12-01 09:48:48', '2021-12-01 09:48:48', '2022-12-01 09:48:48'),
('893a9f4ff1f9995dd2505446bd87c7b571434e442069caaff649ea57718dc421e2034536956b2b73', 2, 1, 'token', '[]', 0, '2021-12-14 10:45:07', '2021-12-14 10:45:07', '2022-12-14 10:45:07'),
('8977a7b4c174cc2a7b3a61df8dcd39184dacab6674a2b9a710b318c58e27cac82055c0c74d90a686', 68, 1, 'token', '[]', 0, '2021-12-03 13:47:02', '2021-12-03 13:47:02', '2022-12-03 13:47:02'),
('8982fb45a8705e8ad28a745696e148f34cdc74b0673ad3819053c21d03f888d70e551f313a598876', 2, 1, 'token', '[]', 0, '2021-12-08 15:23:34', '2021-12-08 15:23:34', '2022-12-08 15:23:34'),
('89f00664ef2b09ccbdeda0cee7506e30896d5b27d42b1bdd58c9a6937c0a1d0ca6a42a9ee3863338', 2, 1, 'token', '[]', 0, '2021-12-04 10:31:43', '2021-12-04 10:31:43', '2022-12-04 10:31:43'),
('8a3d97ff2545a5b6265801afb3f78d2eb745749f9ab4a2391d9951a0161feab2424ff64e7e598bc0', 68, 1, 'token', '[]', 0, '2021-12-14 15:02:04', '2021-12-14 15:02:04', '2022-12-14 15:02:04'),
('8a453741f32393c0febaf932085abbff24c9c221777c92e56de15a8c012340c2760a9b527099df9a', 2, 1, 'token', '[]', 0, '2021-12-10 13:52:16', '2021-12-10 13:52:16', '2022-12-10 13:52:16'),
('8a5711232f963b0fcb01d1d84a429627f3d4e2afdb1d7653af566da28a625e736f94a705d7647f65', 37, 1, 'token', '[]', 0, '2021-11-19 11:59:54', '2021-11-19 11:59:54', '2022-11-19 11:59:54'),
('8a7fec803f971b3f6da5833c653d64655a485afba26e17ecc5db4598da79b62330feee853cc5e2b4', 2, 1, 'token', '[]', 0, '2021-12-14 11:19:59', '2021-12-14 11:19:59', '2022-12-14 11:19:59'),
('8acd4cc2fc855bbd296795b20d7b916a8704c80b8693ce03789c5f50de4d5b3a12d8982d4b778ee6', 2, 1, 'token', '[]', 0, '2021-06-22 19:08:26', '2021-06-22 19:08:26', '2022-06-22 19:08:26'),
('8ae1bbfc96a5876c2e4a67d4e75e17e01380050985ebeddce4e67b49290114a6a9b0b942445a35ae', 2, 1, 'token', '[]', 0, '2021-12-17 16:59:46', '2021-12-17 16:59:46', '2022-12-17 16:59:46'),
('8b0cacef9fdf5970cb00c2d9f039729bd9c9b6b40ab7aa9035f0cd9a4d1657839ce4a550b17ee75a', 2, 1, 'token', '[]', 0, '2021-06-22 16:56:02', '2021-06-22 16:56:02', '2022-06-22 16:56:02'),
('8b7dbb5d4737b1aea42020720fa10003583da57035602f6d430e04ed3750d182219d687a43e0ae3f', 80, 1, 'token', '[]', 0, '2021-12-03 15:32:14', '2021-12-03 15:32:14', '2022-12-03 15:32:14'),
('8b7f9791f8caa3552555b18103b07c605b7efbc407a3d10d10a18d713e76a6bc6853e3fc46ce93ca', 50, 1, 'token', '[]', 0, '2021-11-18 16:54:32', '2021-11-18 16:54:32', '2022-11-18 16:54:32'),
('8bb0c2b213cb3c84d2a0b562fc1e5887b541eea64919d8b7dadff77e55c326040ae493b39e9a6043', 50, 1, 'token', '[]', 0, '2021-11-29 13:58:37', '2021-11-29 13:58:37', '2022-11-29 13:58:37'),
('8bc533a9bcb03cf095dd65762d34ed6529ab792a9dc881a7364818d15f5df1b6c72f54dd67e482f7', 2, 1, 'token', '[]', 0, '2021-11-26 17:39:29', '2021-11-26 17:39:29', '2022-11-26 17:39:29'),
('8bc73b1eb214a6ad661298f37c8623fa9e2e3da31dd6d3c77227e6b354d6270cca79dc3a5d1b6a42', 2, 1, 'token', '[]', 0, '2021-11-30 18:07:19', '2021-11-30 18:07:19', '2022-11-30 18:07:19'),
('8bd0c3def255e59477eaa2cf76be03e1d4fb236b7b68b18e2991d864ff03e29a8be8d24ba8fe8a53', 50, 1, 'token', '[]', 0, '2021-11-19 09:54:34', '2021-11-19 09:54:34', '2022-11-19 09:54:34'),
('8c0f47abd1b1cde8702662a533a9f742782732a1ae309b4c035ac44a6b45daafe9105cf5086f9b31', 37, 1, 'token', '[]', 0, '2021-11-17 18:44:33', '2021-11-17 18:44:33', '2022-11-17 18:44:33'),
('8c4f41b6e86a01e4ea8e15039ba002e256efdbbe71dd6c8fbb4752b67b010845d39cded6fd73fcb5', 37, 1, 'token', '[]', 0, '2021-11-19 11:57:32', '2021-11-19 11:57:32', '2022-11-19 11:57:32'),
('8c5032af66e06ff96781f2052c0f5bc9160fcf3192ab1bae6c4e11d04efc5de45f1e2b167a5ecfa6', 80, 1, 'token', '[]', 0, '2021-12-08 12:53:11', '2021-12-08 12:53:11', '2022-12-08 12:53:11'),
('8c81eeacefb72cb7248cb41435965a45fb18e7cbbf157e2f5b3ae0b4f4886b8109cf37da366546bb', 37, 1, 'token', '[]', 0, '2021-11-18 10:45:37', '2021-11-18 10:45:37', '2022-11-18 10:45:37'),
('8ca8643b7ab75cd30662d4a0a5de8964c05863b80c989b2b253afa4497cf8061b43e3345b6476575', 2, 1, 'token', '[]', 0, '2021-12-14 12:26:53', '2021-12-14 12:26:53', '2022-12-14 12:26:53'),
('8d1ef67af74e2662a42e68e077acdbb2bade02fe2b6d326415e3d5df7decb39a9c5788683bb4f367', 80, 1, 'token', '[]', 0, '2021-12-16 16:57:05', '2021-12-16 16:57:05', '2022-12-16 16:57:05'),
('8d874e999d2a7f014b95d0a936bb8fb85fd045f410088e8582f884b534ad9c99d9daf47ec44ac1fe', 37, 1, 'token', '[]', 0, '2021-11-18 14:08:16', '2021-11-18 14:08:16', '2022-11-18 14:08:16'),
('8d97634e7b1cae6d951849985a2e4b4a07629143e88544ef26dbdc0123cafc1e26b310cdb0feb37f', 2, 1, 'token', '[]', 0, '2021-11-12 14:09:12', '2021-11-12 14:09:12', '2022-11-12 14:09:12'),
('8dc2f2836cc12701b25e6fb03087d678843f14caf4ef6be6e501254a2b78ff23a0274a56f47f3577', 66, 1, 'token', '[]', 0, '2021-12-03 12:05:55', '2021-12-03 12:05:55', '2022-12-03 12:05:55'),
('8dc8dc4aba2d0ee4ff02425d5ad44e5106ccbeb0899f06a1afa7899c1bf074e50f848c544e9fb95e', 50, 1, 'token', '[]', 0, '2021-11-24 16:13:27', '2021-11-24 16:13:27', '2022-11-24 16:13:27'),
('8dc9e2d62c1ca794e900ded1ba43c2c1a7925236fadbdbf779ee3a8b9df9d736c334a6a51d60dc05', 61, 1, 'token', '[]', 0, '2021-12-01 10:23:16', '2021-12-01 10:23:16', '2022-12-01 10:23:16'),
('8dd6ae0bfbf3169a5e5c5478d0c3c6d8575aa81cd0d96fc046067319820ef06dbd5bc10640333902', 37, 1, 'token', '[]', 0, '2021-11-18 10:33:33', '2021-11-18 10:33:33', '2022-11-18 10:33:33'),
('8dec99ae960741f36dffe9584faea55a2cc4c6d02d375b81e67db289b05b41ad6b44a3d254f74735', 1, 1, 'token', '[]', 0, '2021-10-27 11:50:49', '2021-10-27 11:50:49', '2022-10-27 11:50:49'),
('8e067dac270009e5a89e29dc0ec3b48dba9bdb3d422b162333b4e5b99fa08ee7611a8746ef09f454', 37, 1, 'token', '[]', 0, '2021-11-17 18:33:11', '2021-11-17 18:33:11', '2022-11-17 18:33:11'),
('8e0ebac203725242ebd2a9bcf1a2a70e6cfcce41552251abb941320fde7db3a7fea8e8b264abf6a6', 50, 1, 'token', '[]', 0, '2021-11-29 17:17:54', '2021-11-29 17:17:54', '2022-11-29 17:17:54'),
('8e70c042dabed1fe3b4f2aec261665dc90d449dc494918e6e8801fcf14cd0c76149cf1aca852cdcb', 2, 1, 'token', '[]', 0, '2021-12-04 11:12:07', '2021-12-04 11:12:07', '2022-12-04 11:12:07'),
('8e76077a2bd28b09bdc805196597e964dd268985ed9d8367de9b6b7697244e1a8cf4617d6487ca80', 48, 1, 'token', '[]', 0, '2021-11-30 16:54:29', '2021-11-30 16:54:29', '2022-11-30 16:54:29'),
('8e91059fe58826f6281fafb98b00011258411425dd567b33dadef29236133bdfd26724cd1de3b645', 50, 1, 'token', '[]', 0, '2021-12-02 18:01:24', '2021-12-02 18:01:24', '2022-12-02 18:01:24'),
('8ebbfde7abbd45b646d75430fb7f6a082659adabab6c702fa8bf4179347c815438c75a734b2435e3', 2, 1, 'token', '[]', 0, '2021-12-08 13:00:43', '2021-12-08 13:00:43', '2022-12-08 13:00:43'),
('8f028259834fd725bf8592337cb6ea0f5067e0f03fd5365a9f4eb94b9c611c4642caeafac58779ed', 50, 1, 'token', '[]', 0, '2021-12-03 12:26:56', '2021-12-03 12:26:56', '2022-12-03 12:26:56'),
('8f253e86735602627ae49fb43db22f6238353565c14a21476808c72f4447506b53119f0ef0b2bcbf', 37, 1, 'token', '[]', 0, '2021-11-17 18:18:00', '2021-11-17 18:18:00', '2022-11-17 18:18:00'),
('8f27944f83f76649f822fdcbf8f745692e5845443e361c629f413dc89e84632c83698acbed3b6d02', 80, 1, 'token', '[]', 0, '2021-12-17 12:14:59', '2021-12-17 12:14:59', '2022-12-17 12:14:59'),
('8f440cbf80c3d0eca31e90f12bd7fd9bcc65fcee247be0f91089b9d84a48d3da4ceb8c8b945eaeac', 80, 1, 'token', '[]', 0, '2021-12-21 17:34:59', '2021-12-21 17:34:59', '2022-12-21 17:34:59'),
('8f5577291f51c33d9301f76651650e335960b373c257e963f473517ec2bd447b75c4f6e8b6c5ea7f', 37, 1, 'token', '[]', 0, '2021-11-17 10:45:38', '2021-11-17 10:45:38', '2022-11-17 10:45:38'),
('8f6473a1651567cd37ffdb01585a80dd0429fbf81638413524d0cde47c1bcc737b59dc5cad096d8e', 48, 1, 'token', '[]', 0, '2021-11-29 12:44:02', '2021-11-29 12:44:02', '2022-11-29 12:44:02'),
('8f9c75373634a169eaec85c5e697f568e7412c1f007b3bc5eed4b67b12782957fd68bd3c0c10b0fa', 80, 1, 'token', '[]', 0, '2021-12-10 19:23:51', '2021-12-10 19:23:51', '2022-12-10 19:23:51'),
('8fbe7d88675ed4d9aed4635cfb644c48a80e5b0a84b001d85c7857a40d99675c1ccb42e1abbc9d6e', 50, 1, 'token', '[]', 0, '2021-12-03 12:59:09', '2021-12-03 12:59:09', '2022-12-03 12:59:09'),
('8fcc707ffb80afa6c2044197a5dfbecbf52af6873759edf55a31450e8b18edb51cf61556904a220e', 37, 1, 'token', '[]', 0, '2021-11-13 15:19:36', '2021-11-13 15:19:36', '2022-11-13 15:19:36'),
('8feef1511a5848960a70deb618fc44b8cdae63dfee641de8217e8f16cbf38fd4ef76f94dc2685873', 50, 1, 'token', '[]', 0, '2021-11-20 14:45:54', '2021-11-20 14:45:54', '2022-11-20 14:45:54'),
('8ff4a137fbf958ef76071d6bc84618fbfbdc0e632f4262113824506c65e9ee86dadc2a9f15d8c7cf', 50, 1, 'token', '[]', 0, '2021-12-03 13:23:27', '2021-12-03 13:23:27', '2022-12-03 13:23:27'),
('8ffae451c16dc9ca7e1ef28ee7bc978007af1cb00b54f7963f0be1eb1755311668bc33c85b3e2bc4', 2, 1, 'token', '[]', 0, '2021-11-26 16:27:35', '2021-11-26 16:27:35', '2022-11-26 16:27:35'),
('902b5c19f27db0d5f5fa4f0a0b098297ad6670d11c274f91832cb249926f5b9e98c734e0d3b95836', 50, 1, 'token', '[]', 0, '2021-12-01 14:41:32', '2021-12-01 14:41:32', '2022-12-01 14:41:32'),
('90461e69d187554f3ec15cc212b44afcfa283bc6a985bab985011c0b3883fff01d2cf439d9bdc158', 80, 1, 'token', '[]', 0, '2021-12-09 09:59:08', '2021-12-09 09:59:08', '2022-12-09 09:59:08'),
('90659eb480e7610ff3aaf9f1944b73b9f4fafe0be2fd8381b46eb1c70b703a03f952e09cfe480aa9', 37, 1, 'token', '[]', 0, '2021-11-17 18:17:24', '2021-11-17 18:17:24', '2022-11-17 18:17:24'),
('9086045acfcdafd3a8f7866646a547b3b5c40bba2c8c1f13b96f2dd5860d004b9e815714666c4641', 50, 1, 'token', '[]', 0, '2021-11-24 16:03:43', '2021-11-24 16:03:43', '2022-11-24 16:03:43'),
('90aa2aee4f00baceb6f761d2680c2fbf4b4a11af3bc2a22949cb880bc45b546af5f249a3ccc465e3', 2, 1, 'token', '[]', 0, '2021-11-16 14:26:11', '2021-11-16 14:26:11', '2022-11-16 14:26:11'),
('90bc25532e253a4395adb690d874612a8fa3421796b75f566b561fdaa7eb22779f8820f278b683eb', 51, 1, 'token', '[]', 0, '2021-11-30 17:27:48', '2021-11-30 17:27:48', '2022-11-30 17:27:48'),
('90bc8d04b2ed7ef0570730124f53f338e3a9dc5f56d12cf154b901465cb9d5439f77bfb01436d32f', 2, 1, 'token', '[]', 0, '2021-06-10 08:52:13', '2021-06-10 08:52:13', '2022-06-10 08:52:13'),
('90ec8831837f479247f754985984045d38a79231af7bbf327727bce9fb9ae960e1526e5c859a74d5', 2, 1, 'token', '[]', 0, '2021-12-06 16:14:45', '2021-12-06 16:14:45', '2022-12-06 16:14:45'),
('9114ec758fcf1468effeec3c8d2321701e483baa62f006e91136847c90b1f8ef1db0dca3d8b209f8', 80, 1, 'token', '[]', 0, '2021-12-16 16:59:47', '2021-12-16 16:59:47', '2022-12-16 16:59:47'),
('9142d1b9a911be4cbfc71b311ab9216076eb54d2df561b094528ca14cfb098a02ceb887d6332eee5', 2, 1, 'token', '[]', 0, '2021-11-15 18:37:59', '2021-11-15 18:37:59', '2022-11-15 18:37:59'),
('9168e310a1d031d45e6d68464cd18560acee93b900082f084b6e4eb059a901daa2818c9dfa2397e0', 48, 1, 'token', '[]', 0, '2021-11-19 16:49:33', '2021-11-19 16:49:33', '2022-11-19 16:49:33'),
('917640048b97acaf5fd1b31168d1fd9cdee08cdf0bbc70d85245722c142146da7e4bc08669cbdde8', 37, 1, 'token', '[]', 0, '2021-11-18 11:12:10', '2021-11-18 11:12:10', '2022-11-18 11:12:10'),
('917898eebbd8b5c9ad0efed07d34316b8f01bfe541acef4d7b2c9dd87c28d97d1632ca60b97fe57c', 50, 1, 'token', '[]', 0, '2021-12-13 17:47:11', '2021-12-13 17:47:11', '2022-12-13 17:47:11'),
('91794cfc2e3fcc7f44edd4ff4eadda06a0e70561395b379720b6802540ee65930b2a894b2ef85640', 68, 1, 'token', '[]', 0, '2021-12-14 10:34:37', '2021-12-14 10:34:37', '2022-12-14 10:34:37'),
('91dd5869bf03cb2a0e43573b6003f761021041d901bce76613e976dc15eac370ecb094cffbe42597', 50, 1, 'token', '[]', 0, '2021-12-03 13:22:02', '2021-12-03 13:22:02', '2022-12-03 13:22:02'),
('922296bbbf1415beaf72b484c6142c640f22032ac68d687d934b6178b32e556ed106383853c43f66', 48, 1, 'token', '[]', 0, '2021-11-29 18:00:07', '2021-11-29 18:00:07', '2022-11-29 18:00:07'),
('9287ba36cf77165448730279a3d568b33991e0541d63f163b5924a2a356b9900b33f132311b99529', 2, 1, 'token', '[]', 0, '2021-12-04 11:10:44', '2021-12-04 11:10:44', '2022-12-04 11:10:44'),
('92938164ec0b0d268137eda4d32ce3d9153646ae492d525ffe4471a2c37421c07cc9bda6641627c5', 2, 1, 'token', '[]', 0, '2021-12-07 18:13:00', '2021-12-07 18:13:00', '2022-12-07 18:13:00'),
('9296cb7d771dc0a6c4cf3bc0426469c7271c0ea0aa79354aa67deb77160ffb63f26b28061a112be1', 50, 1, 'token', '[]', 0, '2021-11-30 11:59:08', '2021-11-30 11:59:08', '2022-11-30 11:59:08'),
('92bc9e1d59d68d9c8bcef9e2c7fa1f2ba2219dd68d1c5fc2393b53205593e868e9646b7252851b34', 61, 1, 'token', '[]', 0, '2021-12-01 11:27:42', '2021-12-01 11:27:42', '2022-12-01 11:27:42'),
('92c3bb7d6f6fe396ab90c7085907702edb2b4b5102b85e59074937c646f09541b06582b81a6063c3', 2, 1, 'token', '[]', 0, '2021-12-04 17:37:48', '2021-12-04 17:37:48', '2022-12-04 17:37:48'),
('92df686bedd1b02ba111c1f64169c2d269b7a0b1cecd5a13ee56e2e781cf13a153ca001b9b537792', 50, 1, 'token', '[]', 0, '2021-11-30 18:57:01', '2021-11-30 18:57:01', '2022-11-30 18:57:01'),
('937d598e32a221d29356c6cb6e423c48685bde6c8d674474022e28494438e9b852d14fefa6abd9d5', 80, 1, 'token', '[]', 0, '2021-12-21 17:33:31', '2021-12-21 17:33:31', '2022-12-21 17:33:31'),
('93ab75effe5479cc926f5351250ac94172ff4b0a6e00d19def6c487c6c2baed17bd923b1c5741a5e', 37, 1, 'token', '[]', 0, '2021-11-17 18:17:28', '2021-11-17 18:17:28', '2022-11-17 18:17:28'),
('943f6b8d4acecdb0e7e429761c73462946f961bcd1de9f68df6f9c99a26106e697e59c5dc42dd982', 2, 1, 'token', '[]', 0, '2021-12-14 11:28:09', '2021-12-14 11:28:09', '2022-12-14 11:28:09'),
('9458b4d5e44cbe4115651a017a64590203db0b565041b8fd06586bfbc52aab84c179e5b529012192', 2, 1, 'token', '[]', 0, '2021-06-22 11:02:20', '2021-06-22 11:02:20', '2022-06-22 11:02:20'),
('94f474e3c28dbc3b70d900e18e0d3e4da5a47890deea4feb394d2a743e6f838dcf203fa37fb7ed9c', 50, 1, 'token', '[]', 0, '2021-11-30 12:24:17', '2021-11-30 12:24:17', '2022-11-30 12:24:17'),
('9524bfba4e2e469c4e9fb2530046ab6cb4c0fecdd7ed8eb53e1b5fe04083a90005f52882d92294f2', 2, 1, 'token', '[]', 0, '2021-11-30 18:45:20', '2021-11-30 18:45:20', '2022-11-30 18:45:20'),
('956ad8fb21f9ad2b0ba09b4ca3d5e46994f92287303de0f52991cfabb71a4a00783808459694fbf3', 2, 1, 'token', '[]', 0, '2021-12-08 16:42:32', '2021-12-08 16:42:32', '2022-12-08 16:42:32'),
('9577bbc15e0bf61b352fff81f4e11112ee02632dd82eaae9388d1b5a2df1e3984a58acc88197b9f6', 80, 1, 'token', '[]', 0, '2021-12-04 10:09:47', '2021-12-04 10:09:47', '2022-12-04 10:09:47'),
('9599cd712c349ad93bddce027398d8ad43fd2f5f7ce4bb7bf8a4ebe5d6899166379e6eab964352ce', 80, 1, 'token', '[]', 0, '2021-12-03 13:16:31', '2021-12-03 13:16:31', '2022-12-03 13:16:31'),
('95b5321cc2b3a0c2de06ebe1e27fe247dc2ef98e62568a926a0df0fff8146461bcbda34dd420fda5', 50, 1, 'token', '[]', 0, '2021-11-30 11:51:33', '2021-11-30 11:51:33', '2022-11-30 11:51:33'),
('95ef47b0cbfb7da972c385d9538c902951feac4f999a70078fca8b4012681c69fe8168ccb910e202', 37, 1, 'token', '[]', 0, '2021-11-18 10:59:13', '2021-11-18 10:59:13', '2022-11-18 10:59:13'),
('95f09c93988ec5ac3e9e00ab667809f4a8f92393557a066f7c8fa8bc616a1d838271f20330b5dfdc', 2, 1, 'token', '[]', 0, '2021-12-16 17:04:10', '2021-12-16 17:04:10', '2022-12-16 17:04:10'),
('960f426ce45054ee4dc7fdd5eb33a72265df4ddf600611de3e7e611c6ac624a97ec51ca95ad177f2', 50, 1, 'token', '[]', 0, '2021-11-29 09:40:08', '2021-11-29 09:40:08', '2022-11-29 09:40:08'),
('963e6e6cc5c047eb2eb3e3d2b16ab1c05c724ce8f8dab9a7d7f02c84ab347ad6829a4f545a741fc0', 80, 1, 'token', '[]', 0, '2021-12-03 14:46:21', '2021-12-03 14:46:21', '2022-12-03 14:46:21'),
('966b2e170080d671da5d4164d69eb2e75cdc6e251862e8152e8592d54f86aaf7343ee7cae658fd8c', 2, 1, 'token', '[]', 0, '2021-12-04 11:24:44', '2021-12-04 11:24:44', '2022-12-04 11:24:44'),
('9691040965e2cca715ac416d9eab84148e2e613e1b9c2b24fda3a1d5a4ef53025feff1a121eb486b', 51, 1, 'token', '[]', 0, '2021-11-30 17:40:24', '2021-11-30 17:40:24', '2022-11-30 17:40:24'),
('96a05568540a966e88c3581b1d6afff307d0e54344f39ecd38f45c3964d6dcaff0b9028db010a6cb', 48, 1, 'token', '[]', 0, '2021-11-29 11:13:12', '2021-11-29 11:13:12', '2022-11-29 11:13:12'),
('96d5079a12366e3cf53b11f77404bcd572720385bed65dc22d2382214f778c913c7c2dba3df39f3a', 2, 1, 'token', '[]', 0, '2021-11-27 11:18:36', '2021-11-27 11:18:36', '2022-11-27 11:18:36'),
('96df0f1744fb544f09c576fa011e85455a58b4e22aa82b8140be4519d11a4122ac16c31c87664405', 50, 1, 'token', '[]', 0, '2021-12-14 15:28:48', '2021-12-14 15:28:48', '2022-12-14 15:28:48'),
('96e8efd88c1a71fb2da1aaac08906f0833968bd6ce33808f33161ba70aa6b7e325dda2db9037c678', 50, 1, 'token', '[]', 0, '2021-11-24 16:46:40', '2021-11-24 16:46:40', '2022-11-24 16:46:40'),
('9701fe36d8343df676108a2648f18b0f859f5c68ff04cb5c8e9c6e240a4fa4c34d0f05c4415f3b22', 2, 1, 'token', '[]', 0, '2021-12-08 14:42:43', '2021-12-08 14:42:43', '2022-12-08 14:42:43'),
('9749214163bfb998e12632029cc0c000a2df6a89dc2f33b9cdf517e6c67b496cc9d8b969af0c589c', 50, 1, 'token', '[]', 0, '2021-12-13 18:11:06', '2021-12-13 18:11:06', '2022-12-13 18:11:06'),
('974fd5d7bf7203087b0bb120f8cfe4f426020059a1b69caa08c9fc5a653581ba193b1d866eba2b7a', 37, 1, 'token', '[]', 0, '2021-11-17 18:21:50', '2021-11-17 18:21:50', '2022-11-17 18:21:50'),
('977f6aa1f966b74087dfe931041617469844cbd19792403217350216fde65f334cb4f401e881f55e', 2, 1, 'token', '[]', 0, '2021-11-26 17:55:38', '2021-11-26 17:55:38', '2022-11-26 17:55:38'),
('9796c03e74143e1be92e22af637f1bbd755883c364b9409427503ed6fe6a157a9343445d990775a4', 2, 1, 'token', '[]', 0, '2021-12-13 16:06:10', '2021-12-13 16:06:10', '2022-12-13 16:06:10'),
('97b08ec7edffe3b15f9042cf8e99bfbc2c6dd29ac62cf78877aaceed521ffbc7a7a375fec29d714a', 66, 1, 'token', '[]', 0, '2021-12-02 13:44:41', '2021-12-02 13:44:41', '2022-12-02 13:44:41'),
('97c4abbd7a435b7d9e1bb3bb96a37deab28eb7a1f10ec01a1a35abb5a778a75fa438954940ebc8e5', 37, 1, 'token', '[]', 0, '2021-11-29 11:22:12', '2021-11-29 11:22:12', '2022-11-29 11:22:12'),
('97d68e319ce4b0778a498d2ac37a772929111d33fa2745bf5c898af1557b7b37d566043b32fe8e4f', 50, 1, 'token', '[]', 0, '2021-11-30 12:08:12', '2021-11-30 12:08:12', '2022-11-30 12:08:12'),
('97d879da8bf827a75c6e3eed0081ee4fb88092804ea06c1bfcd2a0837afb858275bf1cb5f5dfffb4', 50, 1, 'token', '[]', 0, '2021-12-03 13:37:26', '2021-12-03 13:37:26', '2022-12-03 13:37:26'),
('9818ea389e1122953f9f7cf85c66332ab7cca0dd2f384982af7beda9763a941d1f7845c169c3f91c', 96, 1, 'token', '[]', 0, '2021-12-08 14:15:48', '2021-12-08 14:15:48', '2022-12-08 14:15:48'),
('9826f982fd4aa5298454051296d7b78630a4da15b7b42601d3786862b34f69c920a68f5e5fd802c9', 37, 1, 'token', '[]', 0, '2021-11-17 18:19:56', '2021-11-17 18:19:56', '2022-11-17 18:19:56'),
('982754fa2aeadf4bd5be7a9c6840574b92e6140c32d49b3f64f17437b7e5bfa3c00bab4f046bbf81', 68, 1, 'token', '[]', 0, '2021-12-03 13:54:59', '2021-12-03 13:54:59', '2022-12-03 13:54:59'),
('985e4cd8af4377c17d21f334221484fd85f33c0a0fa99ff90cfcfe87821e6f15f88709234a38aac5', 50, 1, 'token', '[]', 0, '2021-11-30 19:12:22', '2021-11-30 19:12:22', '2022-11-30 19:12:22'),
('987609718a27517034a5ac70d7fa83cd3b2caeab814a3b029d2afd6a361bf93e78b7ac750395fb39', 50, 1, 'token', '[]', 0, '2021-11-20 14:48:24', '2021-11-20 14:48:24', '2022-11-20 14:48:24'),
('9884bf25605075e05797bb749fa80c97a9205ecff0ca071c21e07f9c220873626e179b14802a88f5', 2, 1, 'token', '[]', 0, '2021-11-30 14:14:12', '2021-11-30 14:14:12', '2022-11-30 14:14:12'),
('98d2f0766dadad78aa48e697d79177797d338fd1b8f9b306819ddd020925b9db47d491d46d1f40eb', 2, 1, 'token', '[]', 0, '2021-11-16 16:08:20', '2021-11-16 16:08:20', '2022-11-16 16:08:20'),
('98e84a594845d38abc285433d63f54a80c51388ebb215919ef1cd6db5c981e800fecaa6f3cb25f34', 2, 1, 'token', '[]', 0, '2021-12-08 15:25:41', '2021-12-08 15:25:41', '2022-12-08 15:25:41'),
('994e8a1fdc488f4738ef2fb117347cd483b6eeac3d390f233630240f471eb86384aba39cd3ad6d7c', 2, 1, 'token', '[]', 0, '2021-06-22 17:35:12', '2021-06-22 17:35:12', '2022-06-22 17:35:12'),
('9974e26aa578374584d251ba1447bee3b975a50bc76795c375562a28605fc75dd1e9275afa29a496', 50, 1, 'token', '[]', 0, '2021-11-29 17:56:44', '2021-11-29 17:56:44', '2022-11-29 17:56:44'),
('9983abc6aeccfd4f658c21917cff4039adb9928c572ab33d7e5250d18fd4698a64e11032a6d48fbc', 37, 1, 'token', '[]', 0, '2021-11-19 11:39:21', '2021-11-19 11:39:21', '2022-11-19 11:39:21'),
('99ab894ae31306b014216f711439e26c7ee82c5bb39f0f4fc8afd58dcf316fea2f368892991aca9d', 50, 1, 'token', '[]', 0, '2021-11-30 12:43:03', '2021-11-30 12:43:03', '2022-11-30 12:43:03'),
('9a09befdab73fb25720c835bb9d59a89a49cff200b681c6f35a08fece7f963247c4d18fcc7e44f0b', 68, 1, 'token', '[]', 0, '2021-12-14 10:35:24', '2021-12-14 10:35:24', '2022-12-14 10:35:24'),
('9a0c0d9f5373b3a450caff59cbe568a80311a04e6d92fed1ddecc6a252014653f7ea6122b966fc92', 80, 1, 'token', '[]', 0, '2021-12-16 16:32:39', '2021-12-16 16:32:39', '2022-12-16 16:32:39'),
('9a0cfe4951796fd9635354bb445605ed080d50824afc33a4eb7beee20d5680d871ec41025956fd7e', 51, 1, 'token', '[]', 0, '2021-11-30 18:00:28', '2021-11-30 18:00:28', '2022-11-30 18:00:28'),
('9a7048de35156862305cb3f61ddbe83880ab37f247348ebab98c9602d52c014ebd27541bfadcea83', 50, 1, 'token', '[]', 0, '2021-11-30 15:24:36', '2021-11-30 15:24:36', '2022-11-30 15:24:36'),
('9a83b564da2d72d8b224deeea7dfbbaf02a0f2eb88c044924aca8a16855746fd1c87af0a651d0c86', 50, 1, 'token', '[]', 0, '2021-11-29 17:20:09', '2021-11-29 17:20:09', '2022-11-29 17:20:09'),
('9aaf9a5de3ce5fe5015ff85948b27866ca976f5a50ef1598e1673271772fecb1cab17a4b5e936cc8', 2, 1, 'token', '[]', 0, '2021-12-14 11:00:05', '2021-12-14 11:00:05', '2022-12-14 11:00:05'),
('9ab2a963623ee1807089d5901111b5f40777ce4b738208ccd3e5f0984cd4237e827f28fdf6bb73fe', 2, 1, 'token', '[]', 0, '2021-12-13 15:25:17', '2021-12-13 15:25:17', '2022-12-13 15:25:17'),
('9aed1010669273df459f1bde5cb54a9e54924c66aec83a5e785ad134d25e8d84e0847347f4458b91', 2, 1, 'token', '[]', 0, '2021-12-04 17:57:30', '2021-12-04 17:57:30', '2022-12-04 17:57:30'),
('9af468c2623f48429c744994c8345ee47f5542d2ce4a013c985b0b64b0af324867b828ce7ad6a1cb', 80, 1, 'token', '[]', 0, '2021-12-03 13:15:48', '2021-12-03 13:15:48', '2022-12-03 13:15:48'),
('9b05320373086a6ad634e96d234d0ed6b55015d8bb4d3f6cdf45c4478fab3dd21018af41a8deb532', 50, 1, 'token', '[]', 0, '2021-12-02 15:51:58', '2021-12-02 15:51:58', '2022-12-02 15:51:58'),
('9b17336b1f0a247133ab99669ed38b75f45adab5c6c4bc77c4fcb1c35de0d713b0c0f78b586a52da', 2, 1, 'token', '[]', 0, '2021-12-13 15:21:29', '2021-12-13 15:21:29', '2022-12-13 15:21:29'),
('9b1af713c8dc4eee8557191eb465b1260a0e09439aa4c18e80786d3e40e424477e92af2ee19c43b0', 50, 1, 'token', '[]', 0, '2021-12-02 16:47:17', '2021-12-02 16:47:17', '2022-12-02 16:47:17'),
('9b1ba2b43c1688934305bf1c7c327bd2a6f984654b056fbf1cf17790f1e87ef2840c1c22f4d538a0', 2, 1, 'token', '[]', 0, '2021-12-06 11:05:20', '2021-12-06 11:05:20', '2022-12-06 11:05:20'),
('9b400fcd3b8748d868e98ef0a9d2c9a54b66bf4a1698876c3bbb1d252fbd63d9e9343f689266cc91', 2, 1, 'token', '[]', 0, '2021-06-16 17:55:20', '2021-06-16 17:55:20', '2022-06-16 17:55:20'),
('9b43914d1476479202ea3f458f705580fe2ab75e4e37749abbf13e89a57937b08ea49b0fe8e2058f', 61, 1, 'token', '[]', 0, '2021-12-01 10:22:03', '2021-12-01 10:22:03', '2022-12-01 10:22:03'),
('9b7763d80b293dca32fca77cd5b09321c5b843647c8e5f8a206f0ea36173d1528bff64cbb8589dd1', 2, 1, 'token', '[]', 0, '2021-11-29 17:08:22', '2021-11-29 17:08:22', '2022-11-29 17:08:22'),
('9bcf1d96ba6e2d89462c5ce153c461580a6efa3852517e6e39609a00533ad89329072d653edefcf2', 48, 1, 'token', '[]', 0, '2021-11-19 12:42:54', '2021-11-19 12:42:54', '2022-11-19 12:42:54'),
('9bfeee08e65110b683034375ca602fcfa6e6ceba52ed2b0d04b250d3b8d98a816ef5081237adfbef', 2, 1, 'token', '[]', 0, '2021-11-30 12:33:05', '2021-11-30 12:33:05', '2022-11-30 12:33:05'),
('9c29a62159edbea2e4c1a325a045c31c43850bc80de1a6855fb4250b225042c9b31e141b1b1c5a57', 50, 1, 'token', '[]', 0, '2021-12-02 18:03:26', '2021-12-02 18:03:26', '2022-12-02 18:03:26'),
('9c2b53ccce768644dd5a8db8aa6481eb24b29d36ba687ceedec51e62ef36a880f5af9aeb69c3a9eb', 37, 1, 'token', '[]', 0, '2021-11-12 18:21:01', '2021-11-12 18:21:01', '2022-11-12 18:21:01'),
('9c3c46f4fd26f408480bf62e9f9dc965decf7276cf5d1fc543627d581d2323498f588848e2f78622', 80, 1, 'token', '[]', 0, '2021-12-08 12:00:10', '2021-12-08 12:00:10', '2022-12-08 12:00:10'),
('9c4607debf239e2fc4895365d5b1d9f2fe24d6d350094d8839572a22614dde8bceef1011c9f52c10', 50, 1, 'token', '[]', 0, '2021-11-30 11:29:21', '2021-11-30 11:29:21', '2022-11-30 11:29:21'),
('9c4789966d5c4822de9c80c3d33647f6bef0a1266f77b6b79f07230318aa1c0565ed09e70a28d61d', 1, 1, 'token', '[]', 0, '2021-10-21 15:05:24', '2021-10-21 15:05:24', '2022-10-21 15:05:24'),
('9c8c4e9b06bb3f2719ecde5d6fbd90495879ce9c6e4c088a613b7d59b81bf5976186df91ea062d12', 2, 1, 'token', '[]', 0, '2021-12-07 17:48:01', '2021-12-07 17:48:01', '2022-12-07 17:48:01'),
('9c94b29441f0c1175772b3e8a33c8dfc514b0d5c8adb6a84ce6280a9f7b984200a9699371733c62a', 68, 1, 'token', '[]', 0, '2021-12-13 10:35:14', '2021-12-13 10:35:14', '2022-12-13 10:35:14'),
('9cf6f28cb6e9dbd0117146e67a26c6f8689691a79e3483f708f6a770edee959a6e7ce9563030b590', 2, 1, 'token', '[]', 0, '2021-11-11 15:53:33', '2021-11-11 15:53:33', '2022-11-11 15:53:33'),
('9d377555573c6835ef949591f9580b34d60189940b408f1bfcd6ba17e180be59b9ee812b98ebb897', 2, 1, 'token', '[]', 0, '2021-12-03 17:14:29', '2021-12-03 17:14:29', '2022-12-03 17:14:29'),
('9d41e93875c25afb25573039ff56eefabf644e68fb6a8f6d1b851db034352eaf5a360a5f1feacfef', 2, 1, 'token', '[]', 0, '2021-06-22 07:16:39', '2021-06-22 07:16:39', '2022-06-22 07:16:39'),
('9d5b83afb1228bc6403491ec49e43aab874ddbbc78a53d776f718f32f9814a0b2b06930bf9076be9', 2, 1, 'token', '[]', 0, '2021-11-27 15:25:29', '2021-11-27 15:25:29', '2022-11-27 15:25:29'),
('9db1dbc0301551b35416ba9135734a30e00037deffab98b7d83378946a1d15df72ed7d0c4f28bbc9', 50, 1, 'token', '[]', 0, '2021-11-30 12:34:57', '2021-11-30 12:34:57', '2022-11-30 12:34:57'),
('9dcc7f2ac9bbc848d50a41afe7d634a02ffecf06ae197200362257687f1f27fe18dc2eb0457ea1c3', 48, 1, 'token', '[]', 0, '2021-11-30 16:57:37', '2021-11-30 16:57:37', '2022-11-30 16:57:37'),
('9dccaf0b4174ea2971fc96ac2bb36b5383555844ef84fc1a7dc509b80250ad5979d2801bff55c435', 2, 1, 'token', '[]', 0, '2021-11-30 10:04:32', '2021-11-30 10:04:32', '2022-11-30 10:04:32'),
('9df777b909bdd3ad6b37f29f8535d93e3830d334b36c2110a5cfe792716e440fdddad12b2d28a65b', 2, 1, 'token', '[]', 0, '2021-12-17 12:51:38', '2021-12-17 12:51:38', '2022-12-17 12:51:38'),
('9e0a9855b091426271cd9ded7dd5521b6d6e68fe96b536ac9010592c58b08c446030577efb1acca7', 2, 1, 'token', '[]', 0, '2021-11-01 16:59:38', '2021-11-01 16:59:38', '2022-11-01 16:59:38'),
('9e26d9a547038f674d993d8dfdea4e76498f77156c467e31926df2ae2cc4cadf3a7b931bcb6701e3', 2, 1, 'token', '[]', 0, '2021-12-07 12:52:49', '2021-12-07 12:52:49', '2022-12-07 12:52:49'),
('9e2b2da04f63bbf07581c52e2698058f19f9e55594ed483085e5858a26ef592adfb2a0dbd2cc1b17', 50, 1, 'token', '[]', 0, '2021-11-24 16:54:54', '2021-11-24 16:54:54', '2022-11-24 16:54:54'),
('9e3bd45c0b597f686e15cbe09bdefaae244b460f97974b6f98651cb5718276787b078786cd0874fa', 37, 1, 'token', '[]', 0, '2021-11-18 10:22:43', '2021-11-18 10:22:43', '2022-11-18 10:22:43'),
('9e4dacf47527709561b84c1e9c85543740ea89a85b84ca5a4d810dfe45da4d19b2582dca39e94a47', 50, 1, 'token', '[]', 0, '2021-11-30 18:50:46', '2021-11-30 18:50:46', '2022-11-30 18:50:46'),
('9eb5cc5bbf0515510b20de76852b43a44ae983b719fb13bcbba759990def282d53f59fee5f4795cb', 2, 1, 'token', '[]', 0, '2021-12-16 17:15:52', '2021-12-16 17:15:52', '2022-12-16 17:15:52'),
('9ec751d877c0d57945d3093abbddd26a5c90d07f5e125f7585b15d394673ffc2d7db6102b7451d01', 37, 1, 'token', '[]', 0, '2021-11-18 10:30:16', '2021-11-18 10:30:16', '2022-11-18 10:30:16'),
('9ef7cb66801f7ccf93f6d11007a434a636da09bb9dc2402d23846956149783f6bcaf631a8b02d980', 2, 1, 'token', '[]', 0, '2021-11-26 18:22:05', '2021-11-26 18:22:05', '2022-11-26 18:22:05'),
('9f13a9d21fae96d2f36601bcc270c06a6508be2b7c4a4c31750d2c2e6c8806ea8f72b90d2a37228c', 2, 1, 'token', '[]', 0, '2021-12-08 10:38:14', '2021-12-08 10:38:14', '2022-12-08 10:38:14'),
('9f421c9b33b93e9627f4e024d57a66cc00bc2d3c670d0425539d4ad2acc76d9ec8c798c1426a3e9c', 2, 1, 'token', '[]', 0, '2021-11-30 18:17:56', '2021-11-30 18:17:56', '2022-11-30 18:17:56'),
('9fb1468e8383518ab0c1cd3e0ee1e4b9d6aab3c24cfbcd19158ebae3043bd78467ffc9bc5c0eb1a7', 2, 1, 'token', '[]', 0, '2021-12-07 17:55:30', '2021-12-07 17:55:30', '2022-12-07 17:55:30'),
('9fb8077dc291d7f591778167ecd053fba188519e1c30d2f72457ec30b36862db10691dbe500212a3', 2, 1, 'token', '[]', 0, '2021-12-14 10:38:13', '2021-12-14 10:38:13', '2022-12-14 10:38:13'),
('9fbc555ac9da9eebd81c9fd2e41a6991d0e68b4ceba05fb798049050c937ed54907eee63ca493a7a', 48, 1, 'token', '[]', 0, '2021-11-19 12:48:59', '2021-11-19 12:48:59', '2022-11-19 12:48:59'),
('9ffbe039346272a4b2b94c57f23a090187a611d6c7f470d7a659393734349363914e89ef17ce6d12', 37, 1, 'token', '[]', 0, '2021-11-17 18:36:20', '2021-11-17 18:36:20', '2022-11-17 18:36:20'),
('a0125686c0de83ba68efd55d240031cbcc4a0215a8996b765d6a45cb271bd3c04ca6bbd623303d27', 50, 1, 'token', '[]', 0, '2021-11-26 15:28:08', '2021-11-26 15:28:08', '2022-11-26 15:28:08'),
('a03c5377104e019828e67789dd9917ddc075d6a768bb6af9377f76dccfa7c8b123953982ca0eb489', 37, 1, 'token', '[]', 0, '2021-11-18 18:27:02', '2021-11-18 18:27:02', '2022-11-18 18:27:02'),
('a078921e3d4bb2b12960090be0810ebf6b65f6485018f2f7d3a8188e717031730e641d918fcb05b7', 2, 1, 'token', '[]', 0, '2021-12-16 12:06:27', '2021-12-16 12:06:27', '2022-12-16 12:06:27'),
('a07a6782a93020a7a8b22539730a3528e723d2ae7e83ae098fbc4b921d3555202fde96c3537953b4', 50, 1, 'token', '[]', 0, '2021-11-26 15:28:56', '2021-11-26 15:28:56', '2022-11-26 15:28:56'),
('a0be64805654fc44f951c56708f9d0b9d861dc88f7d2f0cd27bbe564e49bebfddb08f100ddffc522', 37, 1, 'token', '[]', 0, '2021-11-17 18:09:24', '2021-11-17 18:09:24', '2022-11-17 18:09:24'),
('a0c333b1f2b75524f773c61b3a5fbf152b8c663b60591e3fed80dd845ae059a3d2958a15c34b282b', 2, 1, 'token', '[]', 0, '2021-11-13 17:42:37', '2021-11-13 17:42:37', '2022-11-13 17:42:37'),
('a0c69712219688db2e90ac2c8325fb4dfc0633b46fc1fc93faf3a372d08f1afe3641f951b7b9f819', 48, 1, 'token', '[]', 0, '2021-11-20 09:39:34', '2021-11-20 09:39:34', '2022-11-20 09:39:34'),
('a0fb6c21b6395339bd1990dac5a61cdb0f8df940f38b4de352bac89ad8b4c375c01b914ec4f14653', 37, 1, 'token', '[]', 0, '2021-11-17 18:10:21', '2021-11-17 18:10:21', '2022-11-17 18:10:21'),
('a1136591b05ec0ea561e51964d622e0f962e93cedcd2c840c10093e7a6e500b7fd6833352477ef1f', 2, 1, 'token', '[]', 0, '2021-12-02 16:12:36', '2021-12-02 16:12:36', '2022-12-02 16:12:36'),
('a116766b8542bd2819d611a7abe7fbba14622420aa36712d7fb961bd89dd3c641a2fff5071b48664', 2, 1, 'token', '[]', 0, '2021-12-14 12:07:51', '2021-12-14 12:07:51', '2022-12-14 12:07:51'),
('a11e13e8570624aaf4656e7df46b3c17df44258e8ce48c3db8409456fe49d8de3250c9a6f491350d', 2, 1, 'token', '[]', 0, '2021-12-13 11:13:23', '2021-12-13 11:13:23', '2022-12-13 11:13:23'),
('a1498dcd3b66d7036cc4326b7b1a10c4a8f93a35981dca21e12ebffb3dba759695c254c803b5a3fc', 37, 1, 'token', '[]', 0, '2021-11-18 10:45:00', '2021-11-18 10:45:00', '2022-11-18 10:45:00'),
('a1bf59295768dc1d0f4d16cf1c3a5a75f9b381613bff9a5dfd0e95afdecffdb5ca25e2d190a49c7a', 2, 1, 'token', '[]', 0, '2021-12-14 10:25:55', '2021-12-14 10:25:55', '2022-12-14 10:25:55'),
('a1bf80d2ec89fe7013b77c118cdc9b5bc300a28ee2760c6e4b4cce62d2828ada6e752dd15b2e1dcf', 37, 1, 'token', '[]', 0, '2021-11-18 10:38:12', '2021-11-18 10:38:12', '2022-11-18 10:38:12'),
('a1dee94b473e05cc801794e86a2fd0c90967ba2ce0fad5883c8e325743b39dbfedd5783261a76eb1', 2, 1, 'token', '[]', 0, '2021-12-08 10:06:39', '2021-12-08 10:06:39', '2022-12-08 10:06:39'),
('a2697e421b2e9ceaa99aebc34d8e9b0e94e3678794ab1f7c6d2ab1cf0afe581417859877e5a453fb', 50, 1, 'token', '[]', 0, '2021-11-27 18:50:42', '2021-11-27 18:50:42', '2022-11-27 18:50:42'),
('a2737d5a78053eb3d28d44bb8487972ff6bf0788b4e330199483e6a629c8f5433dfa1b0a7aca69e7', 2, 1, 'token', '[]', 0, '2021-05-25 04:34:57', '2021-05-25 04:34:57', '2022-05-25 10:04:57'),
('a29454a40adb607f928a5d774e985dc1bebda7758e88b52ba6f2fd2322b83161c3659a8808c3128d', 2, 1, 'token', '[]', 0, '2021-12-09 11:48:38', '2021-12-09 11:48:38', '2022-12-09 11:48:38'),
('a29a7398a6687eb7d07a382e527e480fec3051ca06c2aa6c6ec2e31ca9e46f2a29da8141b986bbf8', 37, 1, 'token', '[]', 0, '2021-11-18 10:36:31', '2021-11-18 10:36:31', '2022-11-18 10:36:31'),
('a29ecac5718b461e83f778b7c988f2081722101538290569fb0a53c758eee4165213701ed4b9406d', 2, 1, 'token', '[]', 0, '2021-11-30 16:35:11', '2021-11-30 16:35:11', '2022-11-30 16:35:11'),
('a3123f0b523eb78da45b5fa1608293321364e4ce7e7c84d1344f43ac65172fc8ad6855807a43829d', 2, 1, 'token', '[]', 0, '2021-12-10 15:45:39', '2021-12-10 15:45:39', '2022-12-10 15:45:39'),
('a334100e5dcdb26e5631af317e8950cb4dd44192d1cfeea12926469a2a693109e033ecd77a5920f9', 2, 1, 'token', '[]', 0, '2021-11-26 18:02:15', '2021-11-26 18:02:15', '2022-11-26 18:02:15'),
('a33618166f822a30fea8257eeaefa4a8e3df6202d298819c0a8f6c294a245bcd8427aee5e6cf6cd9', 50, 1, 'token', '[]', 0, '2021-12-02 13:57:41', '2021-12-02 13:57:41', '2022-12-02 13:57:41');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('a34466dcdd852d33896208d2af73c37bdc4341239ef30bba5de8e4218cad2c2b8a4e74f79c37daae', 37, 1, 'token', '[]', 0, '2021-11-17 18:16:50', '2021-11-17 18:16:50', '2022-11-17 18:16:50'),
('a3e1dbb6cfca71d2ce7c301e7175cd2787e35bb2bfc029e6f33934f54cd5aecc1098682a309d0819', 37, 1, 'token', '[]', 0, '2021-11-17 18:21:28', '2021-11-17 18:21:28', '2022-11-17 18:21:28'),
('a3eb98d11b01b3de2bfbd59c76ed96aee915b96f318e7312c82db037f8aac0cfc3b90ca20e5cbd02', 50, 1, 'token', '[]', 0, '2021-12-02 16:45:47', '2021-12-02 16:45:47', '2022-12-02 16:45:47'),
('a4187fdb69d31b9da5c306429c6311e8c9635d16901019f57315cfde0d7709a500176e107ccb91e5', 37, 1, 'token', '[]', 0, '2021-11-17 17:22:04', '2021-11-17 17:22:04', '2022-11-17 17:22:04'),
('a41ce57c1edbfd468d9fc64b8c4f43185414d733d85aa235516eedb250784de36bced061d1adc274', 2, 1, 'token', '[]', 0, '2021-06-11 14:04:32', '2021-06-11 14:04:32', '2022-06-11 14:04:32'),
('a43fd20468e74106a6eea4d3f27a28f224db0886df91fbe361af5b76a86b97929ad6d4e7ca354aab', 37, 1, 'token', '[]', 0, '2021-11-17 17:21:59', '2021-11-17 17:21:59', '2022-11-17 17:21:59'),
('a470e2c0607dd01f0483e2d38d7c75c40b0b14515029819cf807b733a88a3b1ced637fa27fbfbb6e', 37, 1, 'token', '[]', 0, '2021-11-18 09:41:59', '2021-11-18 09:41:59', '2022-11-18 09:41:59'),
('a47a6903288f9b04bbb291bdfc209472b4215c9f32eb8e6df12e4d9a236904ff649d30b0bb109fb4', 2, 1, 'token', '[]', 0, '2021-11-30 14:23:06', '2021-11-30 14:23:06', '2022-11-30 14:23:06'),
('a4b55a42541f548a9f6d9b6cc73c0bb0fe557fcd313845b858520ddf731c272df9c28940713a4f98', 37, 1, 'token', '[]', 0, '2021-11-13 09:41:36', '2021-11-13 09:41:36', '2022-11-13 09:41:36'),
('a4bdebd0b43feafdcd36b8bdf663112f497a2fe37350bbbd4e1cc3178e34762f51d2c57d2e96fee0', 2, 1, 'token', '[]', 0, '2021-12-09 09:53:57', '2021-12-09 09:53:57', '2022-12-09 09:53:57'),
('a56254a492bdf350dff0b30559b3c950a1ac36b2b7cb4e87b19c6a032aa70db800a296e454df6f87', 2, 1, 'token', '[]', 0, '2021-06-09 09:05:12', '2021-06-09 09:05:12', '2022-06-09 09:05:12'),
('a563f9d37e1cbff4f3fd97f0db13f29ef39892df7b025940b7a14d66c502f6a25f593744890bd9b6', 2, 1, 'token', '[]', 0, '2021-12-02 09:49:46', '2021-12-02 09:49:46', '2022-12-02 09:49:46'),
('a56578988f38703620a1499c6d0494bb9a8182862c7b6799d1df673d43d2a58b24b47617e497c7a7', 50, 1, 'token', '[]', 0, '2021-12-13 17:46:56', '2021-12-13 17:46:56', '2022-12-13 17:46:56'),
('a56c5bd8003cb72fe17755534cfccb0bc5ba42b2084e366b4364b566a6f4b7c78914daebe73ee708', 80, 1, 'token', '[]', 0, '2021-12-03 13:35:14', '2021-12-03 13:35:14', '2022-12-03 13:35:14'),
('a575203f751a440e5c7eb9ec143df515e46b35518b55091617aecb82949ebf3f2b459e9d66c66f77', 2, 1, 'token', '[]', 0, '2021-12-14 10:36:20', '2021-12-14 10:36:20', '2022-12-14 10:36:20'),
('a58d18068b6141475701723493e956f9ae7229c2fce74f3cf22cff7a81ac4d77c16570f13ce40e52', 2, 1, 'token', '[]', 0, '2021-06-22 17:40:53', '2021-06-22 17:40:53', '2022-06-22 17:40:53'),
('a5a84d68c44b9cfed4ac8d701aa71a5a1102d0613cd898281781122d350c6219938d2079674f6bd3', 48, 1, 'token', '[]', 0, '2021-11-19 12:42:40', '2021-11-19 12:42:40', '2022-11-19 12:42:40'),
('a5d00d15e9f8c35e62b1ff29452fa69010ce5f5678abcd43386b7311381ddb5657a0297aa208d564', 37, 1, 'token', '[]', 0, '2021-11-17 18:39:43', '2021-11-17 18:39:43', '2022-11-17 18:39:43'),
('a64655638409a3d4ed92c8c400f47d2e36b363c01d1da1cf6d78d6093cd574ef346f9dc5a4a8260b', 50, 1, 'token', '[]', 0, '2021-11-24 17:09:44', '2021-11-24 17:09:44', '2022-11-24 17:09:44'),
('a64fa90f4fb3f5df06f51a637a8e52d97412c3af6759580da44c40567422f2c31e20b8ddb2cbaa28', 2, 1, 'token', '[]', 0, '2021-12-06 12:51:52', '2021-12-06 12:51:52', '2022-12-06 12:51:52'),
('a6504558e3a1da747843554420160d863740d546dfa7294b526963315a86826b7665d4280d3ed3c7', 2, 1, 'token', '[]', 0, '2021-11-30 15:15:18', '2021-11-30 15:15:18', '2022-11-30 15:15:18'),
('a6f8979c2779490dc9bbdb66563e8cb89c3fe40672374062e914033f5fa703a5f5a9e58290ff4d90', 2, 1, 'token', '[]', 0, '2021-12-20 11:32:31', '2021-12-20 11:32:31', '2022-12-20 11:32:31'),
('a70aa6dd6dcb4e999be42aee69a535c2492339760311d68e74ad9b2c41957b98f4c6d35f29c6483c', 2, 1, 'token', '[]', 0, '2021-12-20 11:33:29', '2021-12-20 11:33:29', '2022-12-20 11:33:29'),
('a713ebcd7be88a2b427906f8af6fc35d897f958edf70e4c351f276ff84fa129d2f9cb5a7d861e183', 50, 1, 'token', '[]', 0, '2021-11-30 10:34:30', '2021-11-30 10:34:30', '2022-11-30 10:34:30'),
('a743d3df71c96a08dc5545e3ec74ceff5150f11b0f098375da5a3654b9a592c08b02febae9a832e8', 80, 1, 'token', '[]', 0, '2021-12-21 10:45:59', '2021-12-21 10:45:59', '2022-12-21 10:45:59'),
('a7441d25bb9cf94cb07439040a87a1e1e38ba4092075beeb7c2cc2bf6bc72ba530fc642d22ecb167', 2, 1, 'token', '[]', 0, '2021-12-13 14:22:55', '2021-12-13 14:22:55', '2022-12-13 14:22:55'),
('a74d7a22ccd39e323f165c17fda8a435789d1aa5b801614e834fbd630b9ffe9a49898cd38d8b499c', 2, 1, 'token', '[]', 0, '2021-11-26 18:32:08', '2021-11-26 18:32:08', '2022-11-26 18:32:08'),
('a74f44864fcb05cdc21b10c874f1baeeb5c0ba75be1f1adeed1e6255a108bdd0d8b6f5b47e0260c3', 50, 1, 'token', '[]', 0, '2021-12-03 12:54:15', '2021-12-03 12:54:15', '2022-12-03 12:54:15'),
('a7741025f22cb9a397d77807eb0390f1366012f3ae1ad725f306634b66d4511dd85cdf2f350d0a10', 2, 1, 'token', '[]', 0, '2021-12-08 14:28:14', '2021-12-08 14:28:14', '2022-12-08 14:28:14'),
('a7ae545b292ca6d41dc25649c8d39c8c10aae5b1514d133a814efebaa5b92e16c516c84a328f51ea', 2, 1, 'token', '[]', 0, '2021-11-20 14:39:29', '2021-11-20 14:39:29', '2022-11-20 14:39:29'),
('a903f9cfd3f994a5884aad7876b332813c375cf68a340487de38ffbe84f7894715a895d830311960', 2, 1, 'token', '[]', 0, '2021-11-22 15:43:51', '2021-11-22 15:43:51', '2022-11-22 15:43:51'),
('a90a0861fe91dded9f0d33aba8c13ab9e74dfd5197703f809e462ef4ebdd885620c23a426d4a9efb', 50, 1, 'token', '[]', 0, '2021-11-30 12:45:18', '2021-11-30 12:45:18', '2022-11-30 12:45:18'),
('a92823c696fc0a5ee1900405a106e836f413ff02d0bdb534f789085475fd9f84a8c5ff61d219bee8', 48, 1, 'token', '[]', 0, '2021-11-29 11:17:13', '2021-11-29 11:17:13', '2022-11-29 11:17:13'),
('a93f18841f8b7c969213ebce68c86def860827dc90b76c1021b27faffd3049d3679f238eda79bc4a', 80, 1, 'token', '[]', 0, '2021-12-17 17:52:05', '2021-12-17 17:52:05', '2022-12-17 17:52:05'),
('a9761611937f275d55b9647c54d12ef41fbeafec0ec17f513b37c81e8d2cc259e483fe565b6e8f62', 2, 1, 'token', '[]', 0, '2021-12-09 18:34:46', '2021-12-09 18:34:46', '2022-12-09 18:34:46'),
('a9a631f072f16e6deafed67dc61af3feabbfc17c3f4d28ffa45779117f03a89cdd90548eef02d9d7', 50, 1, 'token', '[]', 0, '2021-12-13 17:46:42', '2021-12-13 17:46:42', '2022-12-13 17:46:42'),
('a9aea390bd538fe05c77221af22b63c1c1443a1c6531af85c95abbfea81bc5dfb1e5177c9a41c648', 80, 1, 'token', '[]', 0, '2021-12-07 10:26:38', '2021-12-07 10:26:38', '2022-12-07 10:26:38'),
('a9badc8e47bb2675f08c8dfc29dd8b9be4c9bbfc5a2af2b47116d9eb613e1fdb9d098ff75db16db3', 37, 1, 'token', '[]', 0, '2021-11-17 18:44:30', '2021-11-17 18:44:30', '2022-11-17 18:44:30'),
('a9c6362ffe9b75926234d5a23baa88f7c1ae97a3135ee10f91fc20891baad07ea430b743acbb2c9d', 2, 1, 'token', '[]', 0, '2021-11-26 18:23:06', '2021-11-26 18:23:06', '2022-11-26 18:23:06'),
('aa02ed7cc66e92e74c1496e74e5631ed8ac3cc1b29712dd971cc949a25644f44c217382bb2d897ba', 50, 1, 'token', '[]', 0, '2021-12-01 12:14:41', '2021-12-01 12:14:41', '2022-12-01 12:14:41'),
('aafef52aca67541caf525c88690a7ff586bfe40cc45bee556807b9f501ef9f4ab267509f08afe92d', 2, 1, 'token', '[]', 0, '2021-11-26 18:03:04', '2021-11-26 18:03:04', '2022-11-26 18:03:04'),
('ab1b63b83b8a1b5fd93749f9262b02ad8ae2148337aa5a692cd00466cd2f2d6b602ca11a65cd0eaa', 48, 1, 'token', '[]', 0, '2021-11-19 16:42:12', '2021-11-19 16:42:12', '2022-11-19 16:42:12'),
('ab577a42851789df43c67d40bab06abc92e4dc4fcc73ad73036a8525702699411bd49e4869968548', 68, 1, 'token', '[]', 0, '2021-12-03 13:18:50', '2021-12-03 13:18:50', '2022-12-03 13:18:50'),
('ab63eb184da5ed96ada86f9a6f56f0a7b0de1cad4a6d78d98fe425fd441419fcabcbd9dddb8ff870', 2, 1, 'token', '[]', 0, '2021-06-22 19:43:59', '2021-06-22 19:43:59', '2022-06-22 19:43:59'),
('ab6487f1426f5c27ff4e26336c1028070c060a61340e9f3a3fd0eadba9b9dff5dc429facb1cae8d9', 37, 1, 'token', '[]', 0, '2021-11-16 14:01:53', '2021-11-16 14:01:53', '2022-11-16 14:01:53'),
('abafba470879e7bbd8b1107c17d539de07be84fdd33b39754d70be5ed10c9822d3d8bfeb74d76984', 50, 1, 'token', '[]', 0, '2021-11-30 11:46:24', '2021-11-30 11:46:24', '2022-11-30 11:46:24'),
('abb68d569b9c6906e4e96d9908ddb74839f79f5eb45e86e802a031ac0cb64840664a6137a70161d8', 61, 1, 'token', '[]', 0, '2021-12-01 10:45:08', '2021-12-01 10:45:08', '2022-12-01 10:45:08'),
('abcd8db0900b93ce5d31e0f84cff346b2d8bf032adcbc20b856651ac06d6138d3c8d631ac7f6b4a8', 2, 1, 'token', '[]', 0, '2021-06-22 05:28:06', '2021-06-22 05:28:06', '2022-06-22 05:28:06'),
('ac33e019edfcf82e33051398395b82bb1b3edf7981307b55b5a2bfe01a543ec99539cac96cc12ab5', 50, 1, 'token', '[]', 0, '2021-12-01 11:04:17', '2021-12-01 11:04:17', '2022-12-01 11:04:17'),
('ac36dae6e3a658a8a7fe5a1e7aa565a92762abe8a62a6711e17d649fbcf848a06d751574d153ffc7', 50, 1, 'token', '[]', 0, '2021-12-03 10:57:10', '2021-12-03 10:57:10', '2022-12-03 10:57:10'),
('ac391134a8d357f7c4b0f710eadc2af76842c741a43fc155c53b4eb82e060f3e6a06a65fb8a94cfc', 50, 1, 'token', '[]', 0, '2021-11-24 16:45:49', '2021-11-24 16:45:49', '2022-11-24 16:45:49'),
('ac5c1a553007a4f519a3003eba9875afbdbec915d13b76758042f0c36b68a9588066f76b7570c3f5', 50, 1, 'token', '[]', 0, '2021-12-03 13:29:47', '2021-12-03 13:29:47', '2022-12-03 13:29:47'),
('ac6a048fdf160ae653f8f1ad345591ff998d5c54c320e1dd23fd90b0b4800686f9920823b85b8988', 80, 1, 'token', '[]', 0, '2021-12-16 18:39:20', '2021-12-16 18:39:20', '2022-12-16 18:39:20'),
('aca42868afbb9703a678a949357704a02dc97d14809844484a0929f8ae0a422c9b8e8059495e08a2', 108, 1, 'token', '[]', 0, '2021-12-10 11:42:15', '2021-12-10 11:42:15', '2022-12-10 11:42:15'),
('acc3a7950f495e31b2d3c4e59d816ac6dee0bdc7722cfd235b1ec39fd7530e95ddbfbb602c542cdf', 61, 1, 'token', '[]', 0, '2021-12-03 12:13:35', '2021-12-03 12:13:35', '2022-12-03 12:13:35'),
('acc7184a045dd65eca4bb48e5de03e125531b2736ba04124929bd63d71d9f320355242850873e5a9', 37, 1, 'token', '[]', 0, '2021-11-19 11:30:25', '2021-11-19 11:30:25', '2022-11-19 11:30:25'),
('ace3195b26ef340ca9acce9533a2fc0fadf735b99df410c7394adcceaca6c8415f48664769e99d0f', 50, 1, 'token', '[]', 0, '2021-11-26 15:33:05', '2021-11-26 15:33:05', '2022-11-26 15:33:05'),
('acf49dc3721a075ab25d370adcbb34cc532ef6e16ce97d9cece74bcefa89b94c46244faea8af542a', 2, 1, 'token', '[]', 0, '2021-11-26 16:37:10', '2021-11-26 16:37:10', '2022-11-26 16:37:10'),
('ad20e6119628d0340ca554d68bda45b555ef95c073999c645e3e18b5e5d39e7cb466cff2961e23b6', 2, 1, 'token', '[]', 0, '2021-11-27 11:18:50', '2021-11-27 11:18:50', '2022-11-27 11:18:50'),
('ad84a0be26dd8a170cda69f0d0b22f3181d21fd59b08834874cc1baed764c147d624a68646cf0fc0', 2, 1, 'token', '[]', 0, '2021-12-08 14:42:17', '2021-12-08 14:42:17', '2022-12-08 14:42:17'),
('ada5f3496f0276dedb76a4c1e0cb046de486f4625e668fc4a37e71dd1427813227a5fa18a42035e2', 80, 1, 'token', '[]', 0, '2021-12-21 14:47:08', '2021-12-21 14:47:08', '2022-12-21 14:47:08'),
('adca89fb998ffe41a704dafd87c9c245588cd5eb5cf2a76fc7f1836ac30b24506145405c2adf2c5c', 2, 1, 'token', '[]', 0, '2021-12-06 15:42:23', '2021-12-06 15:42:23', '2022-12-06 15:42:23'),
('ae4faede0f5c06e970eab0c7a1aafaafb19684455b8e651d09df8b0523d74bef5c3d8b89d3f1e198', 2, 1, 'token', '[]', 0, '2021-12-16 10:58:55', '2021-12-16 10:58:55', '2022-12-16 10:58:55'),
('ae72d7b041e7f5ac12509c9e08cbf9ff2e22a603e3a26342ecec472aea545b503e8734751b228a96', 50, 1, 'token', '[]', 0, '2021-11-20 14:57:35', '2021-11-20 14:57:35', '2022-11-20 14:57:35'),
('aea84ed40a684126d4ed27081f3c0b73a220951d03b8cdd59453ac674dfc6d544b3310fa9168591e', 80, 1, 'token', '[]', 0, '2021-12-03 13:13:16', '2021-12-03 13:13:16', '2022-12-03 13:13:16'),
('aecc179568557f1c9b64f58b1fce46ad328b2b26e7f15d00606d0157a3b992ae8edce3881fa93c24', 50, 1, 'token', '[]', 0, '2021-12-03 10:34:44', '2021-12-03 10:34:44', '2022-12-03 10:34:44'),
('aed474778722c52b9a6f92ea25f28e0832a7c73d645ed96bf0ea426e524c082b6e16e7b10efeba3e', 50, 1, 'token', '[]', 0, '2021-11-30 12:52:46', '2021-11-30 12:52:46', '2022-11-30 12:52:46'),
('aef4d9f15ba90fd1afd83d2b38ecfb7c6e8d8e4aca8145300f4ded15eebfe6d8da09c8d75923031d', 2, 1, 'token', '[]', 0, '2021-11-26 16:57:11', '2021-11-26 16:57:11', '2022-11-26 16:57:11'),
('af20b112ea0d86d4553d7e4264424206c2cb2be2040920f15dd71e10b017ffc380221d6e28ede8cf', 61, 1, 'token', '[]', 0, '2021-12-01 10:45:20', '2021-12-01 10:45:20', '2022-12-01 10:45:20'),
('af22c384aee2794ce115fbda9880d8387ec43a7c57b07296bd870a62245f699756adcb4d4481ac4b', 37, 1, 'token', '[]', 0, '2021-11-17 18:09:18', '2021-11-17 18:09:18', '2022-11-17 18:09:18'),
('af2995f94b9f9f6f28f280ed82cd26941c09c53b19305a20febf0f95fe00f7f184d93ef78810b886', 2, 1, 'token', '[]', 0, '2021-12-10 19:07:28', '2021-12-10 19:07:28', '2022-12-10 19:07:28'),
('af34dfae913998c74ef47d10b94f65f6d5f0ed0e3735f8740151db9878a44174204e79db964ecb39', 2, 1, 'token', '[]', 0, '2021-11-29 15:29:54', '2021-11-29 15:29:54', '2022-11-29 15:29:54'),
('af45c602e13d5174ba474c9b999f14abb951125af330c89998ac004fccc980a2b1147508b749ceb4', 2, 1, 'token', '[]', 0, '2021-12-16 17:20:05', '2021-12-16 17:20:05', '2022-12-16 17:20:05'),
('af76c05cadd39bdf26ebb9993ad03e9a08538bd33c66dd29d9bd3a27ce93acb1483aeba7091d5aa6', 2, 1, 'token', '[]', 0, '2021-12-08 15:11:55', '2021-12-08 15:11:55', '2022-12-08 15:11:55'),
('afb4a76b9fcf705c52c5b562520c72bb5e242d059612b43e5f7b1d3aa618837ca7a13a904ebe5d28', 50, 1, 'token', '[]', 0, '2021-12-01 10:38:50', '2021-12-01 10:38:50', '2022-12-01 10:38:50'),
('afb9e5464c4bb3fde894adf9d56b187296e6f85d19b6dd93b9d67fb21570231d968e15f2a26790b5', 2, 1, 'token', '[]', 0, '2021-11-16 10:01:15', '2021-11-16 10:01:15', '2022-11-16 10:01:15'),
('aff083434a5268d07b5157397b9933043ead288bc6f15a0ea2045b5503d019df7c860e9a54ca05ce', 37, 1, 'token', '[]', 0, '2021-11-18 10:21:34', '2021-11-18 10:21:34', '2022-11-18 10:21:34'),
('aff47c982b0bc103ce1b75de5a296aee2c3b9a93ae4351a406259a774188686df8116f4c4111556e', 2, 1, 'token', '[]', 0, '2021-11-29 14:50:39', '2021-11-29 14:50:39', '2022-11-29 14:50:39'),
('b00864b2a87b2aba74eba7442aee4d3705f5ea9218206db587f69cddf10cb7267758a49f0b955401', 50, 1, 'token', '[]', 0, '2021-12-21 16:39:44', '2021-12-21 16:39:44', '2022-12-21 16:39:44'),
('b01dd753a5d10047a2c5f9c67de7f1b6448c7e21a2f1909b87ceb54906b7a6fa09a67407aaf9dc62', 50, 1, 'token', '[]', 0, '2021-11-30 12:50:03', '2021-11-30 12:50:03', '2022-11-30 12:50:03'),
('b03c6ba5ab3ddf693ec3ba6ba3cec0803844210a6db5f8c4800bb87089bce06fb1a215ba6f943457', 2, 1, 'token', '[]', 0, '2021-12-02 14:48:25', '2021-12-02 14:48:25', '2022-12-02 14:48:25'),
('b07fc5df1b193745034aa3e2adc9597c66525ae0ec7b2fcca2e574cc90ec9a6d617dd5fde246ad02', 61, 1, 'token', '[]', 0, '2021-12-01 10:43:30', '2021-12-01 10:43:30', '2022-12-01 10:43:30'),
('b0d1f74a1e6db7797c916416b014e01bb50f0537217ca2d61922db01a9d4803a07c9be74d7f0aa03', 80, 1, 'token', '[]', 0, '2021-12-08 11:50:58', '2021-12-08 11:50:58', '2022-12-08 11:50:58'),
('b0e080ed8557755047fc5c835ae8401d8f5b9d87cb26a4877dda86bdf8d584bbe0c0af9843202322', 89, 1, 'token', '[]', 0, '2021-12-08 12:20:47', '2021-12-08 12:20:47', '2022-12-08 12:20:47'),
('b0e2e462bbb4cd6ee43462ed905bad7b18769c84cb313acc80b64433dffdb43e62db0424e101e113', 37, 1, 'token', '[]', 0, '2021-11-18 09:56:43', '2021-11-18 09:56:43', '2022-11-18 09:56:43'),
('b10b9ebd326d64674fd2bcde852202bf81bb54a1f93860eb15a3452f85004d85aa3c288338893521', 2, 1, 'token', '[]', 0, '2021-11-26 17:55:06', '2021-11-26 17:55:06', '2022-11-26 17:55:06'),
('b12abc833e9e82a009f8adab63c3bdb61b2618c450d2f462710b2c9c9da8c90dba4fdbd30df6357c', 37, 1, 'token', '[]', 0, '2021-11-18 11:15:01', '2021-11-18 11:15:01', '2022-11-18 11:15:01'),
('b144475a177620da7642e3d3a3676c3b4570630ac15dd156eedaaf0dcf86305ad25aec1fa6c68266', 2, 1, 'token', '[]', 0, '2021-12-14 10:36:03', '2021-12-14 10:36:03', '2022-12-14 10:36:03'),
('b15da3d9df98568c4f82db8259d538e67f659f8d90d2e3be2be7614880bd570d1fc3057e836991c4', 2, 1, 'token', '[]', 0, '2021-12-14 11:25:07', '2021-12-14 11:25:07', '2022-12-14 11:25:07'),
('b174ecd32f47daa8dccd033626d1d20d8159a7eb15b5d8f108cf80983a02aa45e0852930e6bd4830', 2, 1, 'token', '[]', 0, '2021-11-30 14:14:28', '2021-11-30 14:14:28', '2022-11-30 14:14:28'),
('b1a1bedb4687b8d4d46a053b344dd787403b673785bd34440b32d10dda2de8bb9fce2bb2bd82b2c8', 50, 1, 'token', '[]', 0, '2021-11-24 17:49:44', '2021-11-24 17:49:44', '2022-11-24 17:49:44'),
('b1d0277ca2e1c7f5f9d6f19fef4c51f20c4c497165a0f8a8f802d4180ed06d4502c7b67cd990b7e7', 61, 1, 'token', '[]', 0, '2021-12-01 11:33:46', '2021-12-01 11:33:46', '2022-12-01 11:33:46'),
('b1f980bbbd3f1b50621603d3b6d466c496432d1d402b57e7dc722b44a5c7ae3c137e8f68dbdb1c39', 37, 1, 'token', '[]', 0, '2021-11-18 11:12:28', '2021-11-18 11:12:28', '2022-11-18 11:12:28'),
('b24f546b22473eb4232a7731d63f9b31e5a003c3d1770e1b4cab8d127278406aab76da7d64b31a75', 2, 1, 'token', '[]', 0, '2021-06-09 09:05:12', '2021-06-09 09:05:12', '2022-06-09 09:05:12'),
('b2d054e8fe5c6c9aeed827d1a60644e83e926abe25adb1ea280c24b1c20719bb5a1abca2d395427c', 37, 1, 'token', '[]', 0, '2021-11-16 10:30:28', '2021-11-16 10:30:28', '2022-11-16 10:30:28'),
('b2f62eef6a1e87a4d33fab8698164bb2e09c7f8fb78943285b586d137e76ea5fc3fb95036f89a94a', 2, 1, 'token', '[]', 0, '2021-12-17 16:08:04', '2021-12-17 16:08:04', '2022-12-17 16:08:04'),
('b319888466ef95dabeaf7ef10dfd169c9a82e87219be48673181ab9d239a35c3854aced278784c18', 2, 1, 'token', '[]', 0, '2021-06-22 07:36:01', '2021-06-22 07:36:01', '2022-06-22 07:36:01'),
('b31fd3666f5235f0af1db7416616d0468712a8f3beee8941ab9ec77b3bc05d12633b113f70541cc3', 68, 1, 'token', '[]', 0, '2021-12-13 10:32:52', '2021-12-13 10:32:52', '2022-12-13 10:32:52'),
('b33f58b2d4244a9579e68eea8972992b9651abda9acb80e7ce05f4930469dc61ebc4e10e8df65d9d', 37, 1, 'token', '[]', 0, '2021-11-18 10:11:34', '2021-11-18 10:11:34', '2022-11-18 10:11:34'),
('b3407064c6a774ed7a95a8c590b4be794512409e142c7ced45dcf636faba886f93e3083de0deb585', 51, 1, 'token', '[]', 0, '2021-11-30 18:27:59', '2021-11-30 18:27:59', '2022-11-30 18:27:59'),
('b36c4219d80d07c3a005b288ef570bc906c549a2681b8edbbc5226f071a4f7bd107594de2926d35a', 2, 1, 'token', '[]', 0, '2021-12-20 12:41:25', '2021-12-20 12:41:25', '2022-12-20 12:41:25'),
('b39f4d316cf3e6494653e89b0c7869dd41e505270147baa70712a2d2c579dc101f66cd43922e91f7', 37, 1, 'token', '[]', 0, '2021-11-18 10:22:52', '2021-11-18 10:22:52', '2022-11-18 10:22:52'),
('b3a99e1f831582f480bf122b2610f1d3dce5c21e670a7f2ea7eadefae4561380e1121a1120d0f3bc', 66, 1, 'token', '[]', 0, '2021-12-03 12:06:01', '2021-12-03 12:06:01', '2022-12-03 12:06:01'),
('b3b575a82b3b6fe0b9a96a7792126c43a499e439f3205c2b32411b617fae937fe2962db46c89967b', 37, 1, 'token', '[]', 0, '2021-11-18 14:34:14', '2021-11-18 14:34:14', '2022-11-18 14:34:14'),
('b3c6bc4359c2b87dce10ec56b6a494010d53bc9e8716a49107b5a27de24c3e3f151d2bfd8dc9a4ba', 2, 1, 'token', '[]', 0, '2021-11-27 10:11:38', '2021-11-27 10:11:38', '2022-11-27 10:11:38'),
('b3ccaa5ee8c90caa761c9847d5410ad6762770fae00eaa21f07f8d2375f1a828b488b932b738b95a', 2, 1, 'token', '[]', 0, '2021-12-10 17:04:46', '2021-12-10 17:04:46', '2022-12-10 17:04:46'),
('b3d27365dc485f5815fc4bb50c5cb6334179ad86de8e4b97edabadf7b6ecf1d2628fc770f35be541', 50, 1, 'token', '[]', 0, '2021-11-29 15:33:21', '2021-11-29 15:33:21', '2022-11-29 15:33:21'),
('b4165003bf93f812bf0a0253827182196302c8ab149f4ab61d4ce42ff01f53096c5f8abf8aaa17dd', 50, 1, 'token', '[]', 0, '2021-11-30 19:30:56', '2021-11-30 19:30:56', '2022-11-30 19:30:56'),
('b43c8ce71570b3e04a0c0cadd42cd36787df5acd98c51e5f924de956c6ae28c7f5f9f5f39b17dbde', 2, 1, 'token', '[]', 0, '2021-12-08 09:57:39', '2021-12-08 09:57:39', '2022-12-08 09:57:39'),
('b48771d5ac57034cf4e07be5530c9dc1d773e08b35b4fe3cc9b09733767bd344327f948052a1aa74', 66, 1, 'token', '[]', 0, '2021-12-01 11:54:14', '2021-12-01 11:54:14', '2022-12-01 11:54:14'),
('b496baccdc32a361976bb8f4812a68e1e3d427346a3e5ee15cb2b891e6a645315505ca84f2cf6b67', 37, 1, 'token', '[]', 0, '2021-11-19 11:59:38', '2021-11-19 11:59:38', '2022-11-19 11:59:38'),
('b568c8402d6bd4617d9547b3b0f954557be578780e8e258d506bd2dac086c393bd4d90c8e4882545', 50, 1, 'token', '[]', 0, '2021-11-24 16:46:35', '2021-11-24 16:46:35', '2022-11-24 16:46:35'),
('b5b2b42d39effbbef5ac8f10077542058d078e12417ae9c47f8bd321ebe4f294aa32a337f91fb527', 2, 1, 'token', '[]', 0, '2021-12-14 10:24:55', '2021-12-14 10:24:55', '2022-12-14 10:24:55'),
('b5d872fee371771b8e1704654bfd8241002c7ff199e9f5e4ccc7943f50b278438290ee9d9d7855a5', 37, 1, 'token', '[]', 0, '2021-11-12 18:18:47', '2021-11-12 18:18:47', '2022-11-12 18:18:47'),
('b5e3113334c376f9b7201bde9662e4392cfe208d500b0f8c7c5631330517dd82774bd5edd9b36302', 37, 1, 'token', '[]', 0, '2021-11-17 16:34:28', '2021-11-17 16:34:28', '2022-11-17 16:34:28'),
('b634cfc971b2a09d5d8e4850d13b468492514e8aefd3af9295b5d3c5ae591a7ba6f67ae0ffa193f3', 51, 1, 'token', '[]', 0, '2021-11-30 17:27:45', '2021-11-30 17:27:45', '2022-11-30 17:27:45'),
('b682575dd58b1683723116a7cf28db77fadcb3214c921810c2f5c8769ecf6ad5edcea8cefa72644d', 1, 1, 'token', '[]', 0, '2021-05-25 04:32:03', '2021-05-25 04:32:03', '2022-05-25 10:02:03'),
('b688c59c37dae31403ca99557711d2c005a9067054e10fd23fce521919f02e64d15ec358a4ba7d06', 2, 1, 'token', '[]', 0, '2021-12-10 17:14:52', '2021-12-10 17:14:52', '2022-12-10 17:14:52'),
('b6cbdb3031447519747285276d1d4b0587045ae4087bb17293fcdb1e4d35f733a0bedeb2aacaac67', 2, 1, 'token', '[]', 0, '2021-12-09 09:54:03', '2021-12-09 09:54:03', '2022-12-09 09:54:03'),
('b6d185a66c1ebbd88d4b55b6c5dca3c21d699ef7c20f073af3dcdd62b6098bd9956d128b15cee389', 2, 1, 'token', '[]', 0, '2021-11-18 14:23:32', '2021-11-18 14:23:32', '2022-11-18 14:23:32'),
('b71f5531dfc5de63b6c5d278e5fa779d6ca25ec5867ff33edf5a7b6599901fce871850759c09033f', 50, 1, 'token', '[]', 0, '2021-12-02 11:51:08', '2021-12-02 11:51:08', '2022-12-02 11:51:08'),
('b734396f27fe46c0fb83436ccc30d1acf3ecf996a6791bf798189844b7ebae17bf6187849e7aba46', 2, 1, 'token', '[]', 0, '2021-11-24 09:40:11', '2021-11-24 09:40:11', '2022-11-24 09:40:11'),
('b75848607fc7f9e06d5d70535aba953e0d4e4afd44efc59381bb470d086f4a3795148aff0cf34bf9', 2, 1, 'token', '[]', 0, '2021-12-08 16:38:51', '2021-12-08 16:38:51', '2022-12-08 16:38:51'),
('b7931845af2f610ac8c33ae53f8730a71367d7e09f1f7e82fedfb493c6cd70e91b035da861be0c4e', 50, 1, 'token', '[]', 0, '2021-11-22 12:05:15', '2021-11-22 12:05:15', '2022-11-22 12:05:15'),
('b797d73a0c3d12018d74c06fe51f7fabc627e695635762d5b21a8715e2d782033901eef44c46c246', 50, 1, 'token', '[]', 0, '2021-11-20 12:53:22', '2021-11-20 12:53:22', '2022-11-20 12:53:22'),
('b7ca2680af957f931e2a3ebc800dc03d813e497a44d7e8661a98fdeea787d96fe3756e5c81067753', 37, 1, 'token', '[]', 0, '2021-11-17 18:02:06', '2021-11-17 18:02:06', '2022-11-17 18:02:06'),
('b812285625a7a3792477dbd51898302e7e74a819a5464e13dd051bb7f1811f12691f28a9ce07db84', 2, 1, 'token', '[]', 0, '2021-12-04 11:11:55', '2021-12-04 11:11:55', '2022-12-04 11:11:55'),
('b81ca330394daaf1c9addfb3c71e06d93c64e625d58ed004be7313f84b889f6e6d5ab9135f6428af', 2, 1, 'token', '[]', 0, '2021-11-16 09:57:42', '2021-11-16 09:57:42', '2022-11-16 09:57:42'),
('b89c2c06ad253bfad3999fead5ea1cc998610a2fca57880a0af4dde61af519e3fdf73b4163567381', 51, 1, 'token', '[]', 0, '2021-11-30 18:07:32', '2021-11-30 18:07:32', '2022-11-30 18:07:32'),
('b912fe39b77b53b02c824e5c09300b6f36597f73c958e14d2a0ef2d2696da2682aae59f074ef37ac', 2, 1, 'token', '[]', 0, '2021-11-13 11:33:11', '2021-11-13 11:33:11', '2022-11-13 11:33:11'),
('b94283691d1cb0837d7a4168212a029cb9dab9764b712fc68a1db140de93388ea4746d0d56a60d93', 89, 1, 'token', '[]', 0, '2021-12-08 13:15:07', '2021-12-08 13:15:07', '2022-12-08 13:15:07'),
('b9435da436045c496ae9a5c2185071a5104d1d023de008c3fb80fff91d3b1285fd1964aeecda79f3', 2, 1, 'token', '[]', 0, '2021-11-29 16:27:01', '2021-11-29 16:27:01', '2022-11-29 16:27:01'),
('b9834da5df74701526e1c44e5e01292a3b90563f1cc31bbb0a2bb9d83a0b0ffcd1279a4a74d886c4', 50, 1, 'token', '[]', 0, '2021-11-30 11:41:33', '2021-11-30 11:41:33', '2022-11-30 11:41:33'),
('b99601ffe1b0d342a48c6d3b453ae92886963e6c10b36db007ebe35f0334334bbe1452866278be62', 37, 1, 'token', '[]', 0, '2021-11-17 18:32:10', '2021-11-17 18:32:10', '2022-11-17 18:32:10'),
('b9a0394c525ff5879712801a9b531ba028b73186153ae2622fe7a42a88aecf714cf37d30306c2849', 108, 1, 'token', '[]', 0, '2021-12-10 11:41:47', '2021-12-10 11:41:47', '2022-12-10 11:41:47'),
('b9e18cbdf7957e9796e87287a353ce43eb6db02b0ddbf921966c1e4e43e5f7144edd23af611fe3ce', 2, 1, 'token', '[]', 0, '2021-12-04 18:44:19', '2021-12-04 18:44:19', '2022-12-04 18:44:19'),
('ba1ffe45c8f4c91bc376f98005a11fd74f5271f374bf2455b659af1a935677fc995adebc0a2a419f', 2, 1, 'token', '[]', 0, '2021-12-02 16:05:36', '2021-12-02 16:05:36', '2022-12-02 16:05:36'),
('ba2456b84ffa9697f825c8245611d093bdeeee9da1fc0b2f61e317662fbb0ccd7f32ff673294d6b0', 61, 1, 'token', '[]', 0, '2021-12-01 16:36:32', '2021-12-01 16:36:32', '2022-12-01 16:36:32'),
('ba394ecaddf1b66393056106cbf655f39f0434d1ebfed6fb40b7b92637b1aae0cdedd64fce7a9b50', 80, 1, 'token', '[]', 0, '2021-12-06 18:47:39', '2021-12-06 18:47:39', '2022-12-06 18:47:39'),
('ba7dd973e44f290df4f1da7ddee0d6e45dbbeee2fc2f4fec6b26122202125be167eafccc53e43e22', 2, 1, 'token', '[]', 0, '2021-12-02 12:50:02', '2021-12-02 12:50:02', '2022-12-02 12:50:02'),
('ba8ff2783ac0a77b04998b4aadd176c6d700a6ff2e377766cd97b9516292e3f737a88d67ea0b01f9', 50, 1, 'token', '[]', 0, '2021-11-24 17:14:10', '2021-11-24 17:14:10', '2022-11-24 17:14:10'),
('ba9a2714a7392830740aec34f8ccb27ed8e26686cc018f4ab291e8fb004c02618ca80737bee08e23', 2, 1, 'token', '[]', 0, '2021-12-09 10:56:04', '2021-12-09 10:56:04', '2022-12-09 10:56:04'),
('bacfe601973f59649ab136002847829b776231a859caf072ec1dfcacdf7c05b9af5812c8eef5b6fd', 50, 1, 'token', '[]', 0, '2021-11-27 13:32:22', '2021-11-27 13:32:22', '2022-11-27 13:32:22'),
('bb084c0283aa6e5e8ed51ce6c6c323e6c0703219d0344de77c68859215f9f978da7c4664410c8f04', 2, 1, 'token', '[]', 0, '2021-12-13 18:35:52', '2021-12-13 18:35:52', '2022-12-13 18:35:52'),
('bb18b9bb20a0739197111b21f3075f400a7453e3b63fb4b98730c562a719acbe40249cb16ac5ceaa', 2, 1, 'token', '[]', 0, '2021-12-10 16:45:31', '2021-12-10 16:45:31', '2022-12-10 16:45:31'),
('bb5c765cf606bfccdfd92d72930db8b7dc89ba9df8c392bd638ad5993d140912eb829c1d2113f1ce', 2, 1, 'token', '[]', 0, '2021-12-16 16:54:00', '2021-12-16 16:54:00', '2022-12-16 16:54:00'),
('bb8419b3b03abb470805bf94e1730e401e2cf5043bc8e698ecb568571b2393db7672630c62848a13', 2, 1, 'token', '[]', 0, '2021-06-23 03:38:39', '2021-06-23 03:38:39', '2022-06-23 03:38:39'),
('bbadbee3748856fdaeeeb8ff340feb15b84be55d839842633c4ade48b2e3dc267cb62ffdac483c8b', 37, 1, 'token', '[]', 0, '2021-11-17 18:18:06', '2021-11-17 18:18:06', '2022-11-17 18:18:06'),
('bc0e008a53ced50a99c27d52d1321649d9bf7e6868d8327695bd57f67b1c0efd1d7793373e32df69', 50, 1, 'token', '[]', 0, '2021-11-29 17:05:36', '2021-11-29 17:05:36', '2022-11-29 17:05:36'),
('bc62d2fca68d7b71a32cb91c6bf5ab88038d30547323bfa8544b75544991b3f34f59a46971b4ebb0', 80, 1, 'token', '[]', 0, '2021-12-22 10:37:47', '2021-12-22 10:37:47', '2022-12-22 10:37:47'),
('bd18397aed52df037ac6f67334d79fdb9e948f6330a9add8d68e55109912dbee6985042e4984f8dd', 48, 1, 'token', '[]', 0, '2021-11-29 12:14:02', '2021-11-29 12:14:02', '2022-11-29 12:14:02'),
('bd4c0177ef6294fcbb1b357a6791ef7d1d786702524c0b5605246cf4ef61ec724042991b50f75c62', 67, 1, 'token', '[]', 0, '2021-12-01 12:33:54', '2021-12-01 12:33:54', '2022-12-01 12:33:54'),
('bd6b246d22b52051affdcc7619ce11059728a981843475ce04a17d11b0de4c96575dbce3c4a3488a', 80, 1, 'token', '[]', 0, '2021-12-04 19:09:02', '2021-12-04 19:09:02', '2022-12-04 19:09:02'),
('bd8fa7fa7279a24d179a84d92b5ea48932fe305bb8f7d6ef5c9b8ab6d79d8ad942c5d639b22ea64b', 2, 1, 'token', '[]', 0, '2021-12-16 17:19:03', '2021-12-16 17:19:03', '2022-12-16 17:19:03'),
('be44c33f92bdc8bb0f2970f821b35c108a69b5274710c31ed9ff42f25262f5d22cdd7a972654008b', 50, 1, 'token', '[]', 0, '2021-11-30 12:17:07', '2021-11-30 12:17:07', '2022-11-30 12:17:07'),
('be4c4efbad041cd205f5e44899bc5013c7f6aee49d470348e93076569a243abd06af22fe803088c6', 2, 1, 'token', '[]', 0, '2021-11-27 16:06:55', '2021-11-27 16:06:55', '2022-11-27 16:06:55'),
('be7a6d3c72187e8f729c383b947e6f3f09bbd212916960e8e9dea7401bd5c95c90ff005f7720be01', 58, 1, 'token', '[]', 0, '2021-11-30 22:30:09', '2021-11-30 22:30:09', '2022-11-30 22:30:09'),
('be9c05ed4cee343ecd815d879c722e0e7f85d4b87c1a24ec70118d05f317bffec27c6955cd255897', 48, 1, 'token', '[]', 0, '2021-11-19 14:39:04', '2021-11-19 14:39:04', '2022-11-19 14:39:04'),
('beac2fcf91640930421f1e4ea2fa7291a96bd6418137adedc8d023a07b50460f6ef9af098e963177', 2, 1, 'token', '[]', 0, '2021-12-07 17:57:55', '2021-12-07 17:57:55', '2022-12-07 17:57:55'),
('beb6ad8f5f68bb8c1a2fb9e59dc396c850839e5d1ffc305baa6b74fa12d1e85e9c4f3bd4a014ce40', 2, 1, 'token', '[]', 0, '2021-12-16 17:48:26', '2021-12-16 17:48:26', '2022-12-16 17:48:26'),
('bec6e986f1c66d8aa909fd359dec10d493e2e02bf498c0b0647e947739c91d669ec7cf0f8bcd4374', 37, 1, 'token', '[]', 0, '2021-11-17 18:40:04', '2021-11-17 18:40:04', '2022-11-17 18:40:04'),
('bee3528d7771a7bb2b48595b8ec004be272c1b9f15410f4c0b317a6ecf7aebe3f29482027e9096e5', 2, 1, 'token', '[]', 0, '2021-12-09 17:00:10', '2021-12-09 17:00:10', '2022-12-09 17:00:10'),
('bef91b0da2ad985c080f33d1ed6b4fc568b65568322c3aeeec8ac10e175aec8955eea176c6f5bd68', 2, 1, 'token', '[]', 0, '2021-12-10 16:21:45', '2021-12-10 16:21:45', '2022-12-10 16:21:45'),
('bf0626ec826b8056246b65b2811ea5844e361a2a5ff4bf1eed069c45c9e2f697f936c3c3d0e117b7', 2, 1, 'token', '[]', 0, '2021-11-30 16:29:45', '2021-11-30 16:29:45', '2022-11-30 16:29:45'),
('bf06e53a50fffee118966241fe93965aa8bfb7572db41aedaef313316abf5dd09308f21a28b15971', 2, 1, 'token', '[]', 0, '2021-12-13 12:30:50', '2021-12-13 12:30:50', '2022-12-13 12:30:50'),
('bf4bbbd0cc23abd8f5d044dc70c0f139f61b492aef79f75c57bf3c60a06eaf4a5ce2c6830e2a3f36', 50, 1, 'token', '[]', 0, '2021-11-22 11:09:54', '2021-11-22 11:09:54', '2022-11-22 11:09:54'),
('bf73630ee3b02486f1bcac148eb7a7b2d1b232b1169d64c6890cbff540b7cb39b761472faf8dc52d', 2, 1, 'token', '[]', 0, '2021-06-22 18:15:55', '2021-06-22 18:15:55', '2022-06-22 18:15:55'),
('bf79a531f0686f607edf9310fe402f61c072f61cd2763579224969e5fae5b9d34ecd9328f007335c', 2, 1, 'token', '[]', 0, '2021-06-22 18:49:12', '2021-06-22 18:49:12', '2022-06-22 18:49:12'),
('bf9474fe1b08ba2c13e9ac5db5f8002d5cd785e3b4624c0d0d19d59633045a954b53109dc71569cc', 1, 1, 'token', '[]', 0, '2021-12-01 09:40:42', '2021-12-01 09:40:42', '2022-12-01 09:40:42'),
('bfb435961262d813289d1102e3337bd07d1d20a6627a3f770c55ecbd73c76828d58352b884beefa4', 50, 1, 'token', '[]', 0, '2021-11-30 10:32:46', '2021-11-30 10:32:46', '2022-11-30 10:32:46'),
('c01eea4691e7d367d0efc6c81a3469892d8388e37c5fcf08b30f945f76bbbfa73e24b1f55064048c', 2, 1, 'token', '[]', 0, '2021-11-30 18:55:15', '2021-11-30 18:55:15', '2022-11-30 18:55:15'),
('c042984fd637dedaef78dcee11b0d967c8e9e816c981004a14fefab037c39252d644dc90093ef962', 37, 1, 'token', '[]', 0, '2021-11-18 10:23:25', '2021-11-18 10:23:25', '2022-11-18 10:23:25'),
('c0499258dbdaef9e1dbb23a015e6729a27dead5f042639251d4f8505e88e7d2e6aca984c3b4bd8d6', 37, 1, 'token', '[]', 0, '2021-11-17 18:34:29', '2021-11-17 18:34:29', '2022-11-17 18:34:29'),
('c0520f055228b82047af62a405a983e6f0d967b6d58aa9a1c7267ba4d6ec770e7ebfd9983b556a4c', 37, 1, 'token', '[]', 0, '2021-11-17 18:35:38', '2021-11-17 18:35:38', '2022-11-17 18:35:38'),
('c0861bb6958ba51a3549c39d508b0547eb95e4becd7cb8a26fb73c939c374f3871dd13930248805a', 37, 1, 'token', '[]', 0, '2021-11-18 10:11:41', '2021-11-18 10:11:41', '2022-11-18 10:11:41'),
('c0969e7318d669920286dfaffd47db185d101fc4e5ef28e69674a26413a92e67e0cb4181fd107e0a', 50, 1, 'token', '[]', 0, '2021-11-20 12:11:51', '2021-11-20 12:11:51', '2022-11-20 12:11:51'),
('c0b67e98693c7e0ca8116de4c986c8dd91990742b205997574715d7db97fa74665e7b4a54ce8204d', 50, 1, 'token', '[]', 0, '2021-11-30 11:11:04', '2021-11-30 11:11:04', '2022-11-30 11:11:04'),
('c0bc15e0a03e511a29ed8fb6cb4d9641c79a7d57f6775e9ef52cc16695e724ef6a4f5caf3461a367', 37, 1, 'token', '[]', 0, '2021-11-18 10:46:01', '2021-11-18 10:46:01', '2022-11-18 10:46:01'),
('c0c91ab6dbb847dad939098b2b8b564e0613bd21ed35b308289a2baded2148ea84d0f7eb22d403d2', 50, 1, 'token', '[]', 0, '2021-11-18 17:51:35', '2021-11-18 17:51:35', '2022-11-18 17:51:35'),
('c0db5e136562e9d817040a7379e2a70e7b427bcd3ddcb866c7be5be5d58689472a7c1a763fa5d7f9', 37, 1, 'token', '[]', 0, '2021-11-17 14:07:00', '2021-11-17 14:07:00', '2022-11-17 14:07:00'),
('c0df30c2cc83105f28343d36cc9c53e427a50cea0f8249b400288cba7246118cc3594d7e000e5946', 2, 1, 'token', '[]', 0, '2021-12-07 10:55:01', '2021-12-07 10:55:01', '2022-12-07 10:55:01'),
('c0fa0fcc038635f138ca6a3a8e152350b2b7a77957b20c090271e17fbd381db311613a70a7b6b49b', 80, 1, 'token', '[]', 0, '2021-12-09 18:36:25', '2021-12-09 18:36:25', '2022-12-09 18:36:25'),
('c137a0950f86c3f27772dd71c7b24cd2f74af94e1c95645576ea4d625502eb18c739a0fd909a02da', 2, 1, 'token', '[]', 0, '2021-11-02 14:48:26', '2021-11-02 14:48:26', '2022-11-02 14:48:26'),
('c137acab6f8f157953347d2613551306bc30ad0d9abf6d1a4b5e182916e909276dfe6fdfd48f9f2a', 50, 1, 'token', '[]', 0, '2021-11-20 11:39:20', '2021-11-20 11:39:20', '2022-11-20 11:39:20'),
('c166acc261aff78162f2cfdd995bed4b17c6ad00c8d3f72e3541cdbb5940179e2d093cd1ea8e7f50', 61, 1, 'token', '[]', 0, '2021-12-01 10:21:43', '2021-12-01 10:21:43', '2022-12-01 10:21:43'),
('c17f1af357bbc3bd46af8ea80fa31d8a0e8968654b736cac36a57aff811e4b911a5e34300b85b286', 2, 1, 'token', '[]', 0, '2021-12-08 15:23:15', '2021-12-08 15:23:15', '2022-12-08 15:23:15'),
('c1a0b53c31045bfa5e17514abd2c90150bdfc4f19fe7a20e0dc4ce66f59490fcf634194933f3d441', 2, 1, 'token', '[]', 0, '2021-11-13 10:20:13', '2021-11-13 10:20:13', '2022-11-13 10:20:13'),
('c1bb4f8ceeb96b077df58487550e418e5c9a1a63e6aa6018a0b35e8702491424195c6eb01b5eea64', 50, 1, 'token', '[]', 0, '2021-11-19 10:33:28', '2021-11-19 10:33:28', '2022-11-19 10:33:28'),
('c1dca4018ccdd8b8ef95109a7114675d4519b3d0654a49eb3f4a6907282e97328cf296f855ba45de', 50, 1, 'token', '[]', 0, '2021-11-26 15:20:24', '2021-11-26 15:20:24', '2022-11-26 15:20:24'),
('c1fdad340b98c0550491bded8215294d422398e562b39f4475b597048a99d380b4c081519f710c79', 61, 1, 'token', '[]', 0, '2021-12-01 11:36:37', '2021-12-01 11:36:37', '2022-12-01 11:36:37'),
('c2215298e4205cda3797217a1366f76c6d453c285e32248cd6c43bd55e7ece02d4ee72052ac91e6a', 80, 1, 'token', '[]', 0, '2021-12-16 16:29:50', '2021-12-16 16:29:50', '2022-12-16 16:29:50'),
('c25e10fb94cbd7b8bc01c74090526f5746fc40fd457c6afecde7f465b4fcab810fa751476a8f1d83', 2, 1, 'token', '[]', 0, '2021-12-16 17:10:17', '2021-12-16 17:10:17', '2022-12-16 17:10:17'),
('c2c25552aea291e252d7f591aca7d4654518efc2e4a117b814cfa3fff7a498899307610e99d08d9b', 37, 1, 'token', '[]', 0, '2021-11-19 18:23:22', '2021-11-19 18:23:22', '2022-11-19 18:23:22'),
('c2e4380768fb25be05c5697914544b84c7926c3fdbb91be71fed7af637106fbbccd65c337f7a9d5d', 2, 1, 'token', '[]', 0, '2021-11-26 16:58:20', '2021-11-26 16:58:20', '2022-11-26 16:58:20'),
('c31e7020d940702739e52ec5b399f9a188514d40b7fd3022d49ab0b5347f845293046b47145c22bc', 2, 1, 'token', '[]', 0, '2021-11-18 09:44:19', '2021-11-18 09:44:19', '2022-11-18 09:44:19'),
('c322e36c46a14dd30a9d8433421756855a042261130ee52ddec49d4fd89aa2cd609666f92bad3d64', 2, 1, 'token', '[]', 0, '2021-11-23 16:37:46', '2021-11-23 16:37:46', '2022-11-23 16:37:46'),
('c338bc0603a25617eeb9adff00b1f7a8904e917dc67ecaeacbb5c1cc9fb7b8e17a788ab1264d10d9', 2, 1, 'token', '[]', 0, '2021-12-03 17:14:21', '2021-12-03 17:14:21', '2022-12-03 17:14:21'),
('c36249670e1ec61a0bd3ec084fdad3e8c2fba0c62121a278c86032c758ea5e387bf106c59d0259c7', 50, 1, 'token', '[]', 0, '2021-11-30 14:57:40', '2021-11-30 14:57:40', '2022-11-30 14:57:40'),
('c3751f9cc24a2208ea12fe143771a43142a07d8af8628c84c8bd8b221af013b35dcf1cfad676f954', 68, 1, 'token', '[]', 0, '2021-12-13 10:38:16', '2021-12-13 10:38:16', '2022-12-13 10:38:16'),
('c3a571cc010dd8f9e8d08c5bdd900a8a16f3fd4b4611c723733c236e4842c37969c9be633e29d7d3', 2, 1, 'token', '[]', 0, '2021-12-07 11:50:22', '2021-12-07 11:50:22', '2022-12-07 11:50:22'),
('c3acbd01e9dbe14622c51167aef3a8aa0315725e4903a72dd87566907e3cf0e2ac5bd20d06bb521a', 50, 1, 'token', '[]', 0, '2021-11-20 12:19:46', '2021-11-20 12:19:46', '2022-11-20 12:19:46'),
('c3cf1ca6c81d8b8e1b735ce4b16c5ca4edb4229b39e1535d9da20bb7f96896c29e430a76068fd37b', 50, 1, 'token', '[]', 0, '2021-11-24 11:44:47', '2021-11-24 11:44:47', '2022-11-24 11:44:47'),
('c40a5f6b596eafed2e521854dec005c4779d03e2d68a727254ba9f7b98c986285770273b305a0c75', 2, 1, 'token', '[]', 0, '2021-11-27 15:42:49', '2021-11-27 15:42:49', '2022-11-27 15:42:49'),
('c40aee48a4ea7b002c8e9343373ac6d778377e61cc30a7ae7cbdd285cab51d3c82238a08bafbe282', 50, 1, 'token', '[]', 0, '2021-11-30 10:36:54', '2021-11-30 10:36:54', '2022-11-30 10:36:54'),
('c414d93f8dfc771b265479ee153a353c955af43a00df5afff8f96ac7f7e0d08b771e27623cc150a8', 50, 1, 'token', '[]', 0, '2021-11-20 14:47:33', '2021-11-20 14:47:33', '2022-11-20 14:47:33'),
('c43309eb0a0baf82d8b6f499f970d3bf38702603dbd7f5fdde249400761ee7db1871c25af20bd191', 50, 1, 'token', '[]', 0, '2021-11-18 17:30:03', '2021-11-18 17:30:03', '2022-11-18 17:30:03'),
('c478cc4f2f9b6f0245df03c294cdc6436c8f9e62ed57869e43f7284909e0e54404e4011430639b15', 66, 1, 'token', '[]', 0, '2021-12-01 17:23:34', '2021-12-01 17:23:34', '2022-12-01 17:23:34'),
('c48883730562fc42446061fc9b79a6470b42a4cbab444d978ec5a6f55873a4e4467f658d9102542f', 2, 1, 'token', '[]', 0, '2021-12-04 16:12:30', '2021-12-04 16:12:30', '2022-12-04 16:12:30'),
('c4c59dd96a46e6a30a6f7cf05372e47a998bd93f5d034329f5de3e9e19c996deb23bb2c67409a31a', 51, 1, 'token', '[]', 0, '2021-11-30 18:00:17', '2021-11-30 18:00:17', '2022-11-30 18:00:17'),
('c5332846b0c4396e786c2de9412f07dd83a691fe8f427eb3b194192e0de7fbb0b7bc22553d71d676', 2, 1, 'token', '[]', 0, '2021-12-08 15:42:31', '2021-12-08 15:42:31', '2022-12-08 15:42:31'),
('c55ff08718f3c15864a9a561f961d175b1eae3573ce292cad7569b27dd9143e4789131dcf1048c9f', 50, 1, 'token', '[]', 0, '2021-12-03 10:33:29', '2021-12-03 10:33:29', '2022-12-03 10:33:29'),
('c5859644fa15613ca4285ad8e3567e5d127fb6c3222ec485e7a408aa63af3ea82b2de06c0f449bda', 50, 1, 'token', '[]', 0, '2021-11-24 16:53:59', '2021-11-24 16:53:59', '2022-11-24 16:53:59'),
('c59ba28657b158bad9f0356b69a51651dcc27b2b7371f0be7960e4b8b27c8387675a8c6379a3d7a6', 2, 1, 'token', '[]', 0, '2021-12-13 14:59:27', '2021-12-13 14:59:27', '2022-12-13 14:59:27'),
('c5b5e64cb5a67e8f2b9ee3c0c7ef06a1cb5b9696c7873a57bac4c6563d55755b9c0a51c54951abb5', 37, 1, 'token', '[]', 0, '2021-11-18 13:00:56', '2021-11-18 13:00:56', '2022-11-18 13:00:56'),
('c5c369af9049c06465a83dc2f7aacddfe79a5b834e8cf07ccc6cff2702f62fe5eda842649641dcd2', 2, 1, 'token', '[]', 0, '2021-12-02 11:25:46', '2021-12-02 11:25:46', '2022-12-02 11:25:46'),
('c5d48e01ca9015adcd8105ed8c79d2ccc2ea1ce77013b26c5ed9bd21e7033d5021aa1937b1f93d03', 66, 1, 'token', '[]', 0, '2021-12-01 17:22:35', '2021-12-01 17:22:35', '2022-12-01 17:22:35'),
('c6828bb2f1601a1f305c8c06ae09f06b689b06d94aad2ed829506a44e22102887660dc4ce9e904f1', 68, 1, 'token', '[]', 0, '2021-12-14 10:56:40', '2021-12-14 10:56:40', '2022-12-14 10:56:40'),
('c6849f910ecf3243a6866c016ae6c12a91222bbe669d70f9b3c5ef72bd5b6af96c037e5305ea7243', 37, 1, 'token', '[]', 0, '2021-11-18 10:43:53', '2021-11-18 10:43:53', '2022-11-18 10:43:53'),
('c6a5e57c0ebd6592774970f9141e0c9c679edf3bf967348f138d6bda716ab2c3a5a6732a8ff8fde2', 2, 1, 'token', '[]', 0, '2021-12-16 11:05:14', '2021-12-16 11:05:14', '2022-12-16 11:05:14'),
('c6aed0f88dda3943e10efe015ddbd3a58fe0f69c8708de6ffd2b97cb9ecab0d9e3fb053e46b0c3fc', 37, 1, 'token', '[]', 0, '2021-11-18 10:58:10', '2021-11-18 10:58:10', '2022-11-18 10:58:10'),
('c6fef192690cf29727045a71e16648cbdede89ca77f324be0e8733d8140cc222df0a788d083bb508', 50, 1, 'token', '[]', 0, '2021-12-03 13:26:31', '2021-12-03 13:26:31', '2022-12-03 13:26:31'),
('c7457620752cb4cf75a49ba1a6017115a30563fbf51c0a6a95f46bbda45f2f523c4e60f762ae8095', 50, 1, 'token', '[]', 0, '2021-11-30 13:56:46', '2021-11-30 13:56:46', '2022-11-30 13:56:46'),
('c801fc58a53c696826b6774893d756c1396a723f656be0d531be2313b236442686719819817e7138', 37, 1, 'token', '[]', 0, '2021-11-18 10:48:53', '2021-11-18 10:48:53', '2022-11-18 10:48:53'),
('c80672320e4c6dc35f94611ab811021a4fbf5e176fe8fd9b4135ff0fc0a0195af1eec08756663103', 2, 1, 'token', '[]', 0, '2021-11-13 10:29:39', '2021-11-13 10:29:39', '2022-11-13 10:29:39'),
('c808058058a3d1ce6afbc3e4f7d770b0282731a3bb439a525e19da3750bc48d16e34964f104c99f9', 2, 1, 'token', '[]', 0, '2021-12-04 10:57:23', '2021-12-04 10:57:23', '2022-12-04 10:57:23'),
('c84d83a52ffe191f3fbfbf3d9275c8852c4d5275dfcba4125cb29811fba64c4909ef6506cf1146e0', 2, 1, 'token', '[]', 0, '2021-11-27 12:03:51', '2021-11-27 12:03:51', '2022-11-27 12:03:51'),
('c8646b9e47794378a6c12aea9c8b6377914be36c8550cbb13c90ae11f7dbb8772917999b7d65d642', 2, 1, 'token', '[]', 0, '2021-12-09 19:09:04', '2021-12-09 19:09:04', '2022-12-09 19:09:04'),
('c88496c8b3bfd70df39179f33776f55abff88df60d80bffd68c685090925604d751f091c8b86704c', 2, 1, 'token', '[]', 0, '2021-12-02 16:06:29', '2021-12-02 16:06:29', '2022-12-02 16:06:29'),
('c8d8491a290a98ee4ffbdb025682f2516dc393e70b92a80784bf45b17edf495a813add79b768f0dc', 2, 1, 'token', '[]', 0, '2021-06-09 08:12:03', '2021-06-09 08:12:03', '2022-06-09 08:12:03'),
('c8edde40352ffc2eb579b02467624eef6b500996ca66bf4602156958bb2cf7fa53b95a5ff6a2153a', 2, 1, 'token', '[]', 0, '2021-12-06 14:36:56', '2021-12-06 14:36:56', '2022-12-06 14:36:56'),
('c8f82481627438dd11024d67e02d2ec34f666f9741fdb6f7ab85d211023470729e7e0786d2b6e1b3', 2, 1, 'token', '[]', 0, '2021-12-06 18:01:01', '2021-12-06 18:01:01', '2022-12-06 18:01:01'),
('c9136ad6f4384f013429ccb91b5641e34998b950e72d78bc5f0b7fbb3e95ed89faa0d7e9fa9ea036', 37, 1, 'token', '[]', 0, '2021-11-18 11:42:35', '2021-11-18 11:42:35', '2022-11-18 11:42:35'),
('c9140d7955c2eeeea2b1e867f2e46d8525459108d92e3b1510f50a804b5ffbf68a9c1424196637ad', 81, 1, 'token', '[]', 0, '2021-12-10 14:06:52', '2021-12-10 14:06:52', '2022-12-10 14:06:52'),
('c92d97b6a996e34265e4fdb7bb94b1cdaf26a2713484d4d8181eeea00701129ba7736073562f550b', 37, 1, 'token', '[]', 0, '2021-11-15 15:07:36', '2021-11-15 15:07:36', '2022-11-15 15:07:36'),
('c93b821b2d3892c570890605bad3d789a90d809e5c78f73b5ad01870078145b2ce870bb1b37e6a62', 81, 1, 'token', '[]', 0, '2021-12-08 10:33:31', '2021-12-08 10:33:31', '2022-12-08 10:33:31'),
('c94f73da06fd2cbc6ec90251d0cf0249aae64dc781b77584d75f26d0b2cec6e788fa79837e05c33b', 2, 1, 'token', '[]', 0, '2021-12-04 17:23:13', '2021-12-04 17:23:13', '2022-12-04 17:23:13'),
('c987770f59d9e45dc2f3ea03d07618cccb9f14fa70d24e08fa7d774d92d557b570bfdea2f67df122', 2, 1, 'token', '[]', 0, '2021-06-22 10:10:45', '2021-06-22 10:10:45', '2022-06-22 10:10:45'),
('c9a2d5f0830ed0de5f28eebcd547362dc3765e888efb7c5acfdf9f1da7794754be82f091438f89d3', 51, 1, 'token', '[]', 0, '2021-11-30 18:25:06', '2021-11-30 18:25:06', '2022-11-30 18:25:06'),
('c9e17704e4cac91235c313eefdec2ee27365cf7a7982f78d03701d8d0210aad3e13ff13ffedd3edb', 2, 1, 'token', '[]', 0, '2021-12-13 09:39:02', '2021-12-13 09:39:02', '2022-12-13 09:39:02'),
('ca16f51ae5fd646e4de8f3d7e2e997df336568651b0e38845b463b5a1d0d391e7b3e41dd72635e13', 2, 1, 'token', '[]', 0, '2021-06-19 22:54:46', '2021-06-19 22:54:46', '2022-06-19 22:54:46'),
('ca290049567f0095b1bf5cbab938613ce3c24b0348691787e5d14c674137ae7c2052005a3b3fbfe8', 2, 1, 'token', '[]', 0, '2021-12-08 09:23:19', '2021-12-08 09:23:19', '2022-12-08 09:23:19'),
('ca4d4dbb861d9a4652940c7f6f70c5ee07486a44e9e470f8e6a512f8df9b81a5f0ef347691bab5fb', 50, 1, 'token', '[]', 0, '2021-11-30 12:40:49', '2021-11-30 12:40:49', '2022-11-30 12:40:49'),
('ca846d0ffbb6514f7e7087ea2fb15ffee0914c4313cf337edec193f8912ac8e7b4e173ae408e3b74', 2, 1, 'token', '[]', 0, '2021-11-18 16:10:37', '2021-11-18 16:10:37', '2022-11-18 16:10:37'),
('caaa66d886cf7f5f7c9ba3f9e63fddba562a785f1e0153cab335d1ab26115266e8048d7dfc468e3e', 50, 1, 'token', '[]', 0, '2021-11-30 11:53:46', '2021-11-30 11:53:46', '2022-11-30 11:53:46'),
('cab1d9df7d3cd8a87ecf79da6d0760fc675b1eed5e66ed9101b38ff882a365fe27e3a715e959769b', 50, 1, 'token', '[]', 0, '2021-11-18 16:39:27', '2021-11-18 16:39:27', '2022-11-18 16:39:27'),
('caecf0647d8ad7e69b85d1a206fda6278a45832d79849615989547d0b55c285b976374523345fb04', 48, 1, 'token', '[]', 0, '2021-11-29 11:21:31', '2021-11-29 11:21:31', '2022-11-29 11:21:31'),
('cb1d9792bb9fcaab8b0e4d51887656920c7e06f19f7a49abd02122a3f7239eaa4172912c1a621894', 2, 1, 'token', '[]', 0, '2021-11-02 18:13:04', '2021-11-02 18:13:04', '2022-11-02 18:13:04'),
('cb6fed7858066c3232d3643d59acd6055dd92f4454c59f30f5b21ad70a518f428428b5d8ba6a4ec3', 80, 1, 'token', '[]', 0, '2021-12-21 15:33:18', '2021-12-21 15:33:18', '2022-12-21 15:33:18'),
('cb86e599319edf3fcce15db2b37391da984d1c6d62e2bc7ae793c88cbc3cc6849a9a990cf3766d2d', 50, 1, 'token', '[]', 0, '2021-11-20 14:44:55', '2021-11-20 14:44:55', '2022-11-20 14:44:55'),
('cbb5610564c89cc0a0d626f35dc19151b833cdfc270cebf16c99c67e058d55e095e25344246c9c24', 61, 1, 'token', '[]', 0, '2021-12-01 16:38:26', '2021-12-01 16:38:26', '2022-12-01 16:38:26'),
('cc043e0fefead14e8dcb0b53fc97e2cfa23f0704d954fbf134af36afab8a1ff5e950400e8e1abffa', 37, 1, 'token', '[]', 0, '2021-11-18 10:58:39', '2021-11-18 10:58:39', '2022-11-18 10:58:39'),
('cc138d3a6c3acd0b1ab096e630fda894d0e134452077181807fc2b6d5e8ce5633caab733fc04ee9b', 50, 1, 'token', '[]', 0, '2021-11-18 16:42:18', '2021-11-18 16:42:18', '2022-11-18 16:42:18'),
('cc301cb91485d26f849c12de0de6b9267d63021e62ecc5e385650adc33cd4de0144c0811020bb242', 68, 1, 'token', '[]', 0, '2021-12-13 10:33:04', '2021-12-13 10:33:04', '2022-12-13 10:33:04'),
('cc3cdf13a6dcbc1ceff6d5e942540db4805fa2a9d72c309bb6ee38719af92efd4d8788f11d234de0', 2, 1, 'token', '[]', 0, '2021-12-10 17:04:39', '2021-12-10 17:04:39', '2022-12-10 17:04:39'),
('cc4b300009d4863336120eb904e38e1968367a7d55ebefc60a364641f7d685fdf58b1c689f2498db', 50, 1, 'token', '[]', 0, '2021-11-30 18:56:23', '2021-11-30 18:56:23', '2022-11-30 18:56:23'),
('cc5ae58adeff7a537516c400ef26c56c5e4704f373b31049eb15ae6e6b4f22aff42c83a40c9f08cb', 2, 1, 'token', '[]', 0, '2021-11-29 14:49:57', '2021-11-29 14:49:57', '2022-11-29 14:49:57'),
('cc9f61661c1e8207c5490bd69c1bf75b52aed9bc5ef301327aed1d4d6c610279b36867abc6e001c0', 37, 1, 'token', '[]', 0, '2021-11-18 10:53:25', '2021-11-18 10:53:25', '2022-11-18 10:53:25'),
('cca2d52c123e487ff7c3bdd7acbdcdf816a329da480dff29e562fef54999c913a694065ad478cab1', 37, 1, 'token', '[]', 0, '2021-11-13 16:45:44', '2021-11-13 16:45:44', '2022-11-13 16:45:44'),
('cd57076e0f8d975533b21fe5329cef885b48b8fbc1550f9465e9ce504daf471df08e07d7d11e4ba7', 50, 1, 'token', '[]', 0, '2021-11-30 12:18:30', '2021-11-30 12:18:30', '2022-11-30 12:18:30'),
('cd669815d711f5f2c1e270a0977e7a846a5a2de77d6613ebe1799ffb8fa6c180be6e2a0d3aced007', 2, 1, 'token', '[]', 0, '2021-11-27 17:47:43', '2021-11-27 17:47:43', '2022-11-27 17:47:43'),
('cd7ebdaa3e769eef5cb7098aa8712c9bbfa4818499e2fd7117ef2e654dcf511af7269e1c7d1343ff', 48, 1, 'token', '[]', 0, '2021-11-30 16:55:51', '2021-11-30 16:55:51', '2022-11-30 16:55:51'),
('cd820c26fe311611005e287b4bc339775405014f31a27765d03c0a5e1b1472c19a50942b36cfb132', 50, 1, 'token', '[]', 0, '2021-12-02 17:58:08', '2021-12-02 17:58:08', '2022-12-02 17:58:08'),
('ce39d2dc61552175cce781c3147b130779b15c021fb889fd86a7fb1b60658beb88f067457aae2943', 80, 1, 'token', '[]', 0, '2021-12-16 15:11:18', '2021-12-16 15:11:18', '2022-12-16 15:11:18'),
('ce3ab205be0cbf9266c0a5eb2750fa5ab2b42eda581e1aae44224593df3f67b79a4676e6f5147f6c', 72, 1, 'token', '[]', 0, '2021-12-03 10:06:32', '2021-12-03 10:06:32', '2022-12-03 10:06:32'),
('ce3b27b0d2c92d89a41df9ddea060380069e1b62310e24e7cf0d6d06ff354781a4e59bba36d4c7dc', 68, 1, 'token', '[]', 0, '2021-12-14 10:22:48', '2021-12-14 10:22:48', '2022-12-14 10:22:48'),
('ce3d850d7d0cb0e7f2e975c62fcd857a8df4a944ec17aa34bbd44d72e9a3a683696115a2df6d64fc', 50, 1, 'token', '[]', 0, '2021-11-29 16:11:27', '2021-11-29 16:11:27', '2022-11-29 16:11:27'),
('ce444af7330633a2fa78bec39f8888b4066c9ae2265db1f91778b48950e13641d320c97cb9e1c605', 37, 1, 'token', '[]', 0, '2021-11-18 10:50:28', '2021-11-18 10:50:28', '2022-11-18 10:50:28'),
('ce6547034fdc6b2775842fb9e8fa379a4085006a4c16a690a9d68807a9ac74b99d0fa224dde58c7b', 37, 1, 'token', '[]', 0, '2021-11-18 18:27:07', '2021-11-18 18:27:07', '2022-11-18 18:27:07'),
('ce69014a551de072b0a7f70376bb6d55cd696b24c12eb7cc584db20880ba611308627b87270ce121', 78, 1, 'token', '[]', 0, '2021-12-03 14:42:01', '2021-12-03 14:42:01', '2022-12-03 14:42:01'),
('ce80eb9b5616cc27c82e8d0a61a40f0038c8e83f8ba298d8b7b6fa1f780ea50fc9762d4dd7a7cfc7', 2, 1, 'token', '[]', 0, '2021-12-10 18:06:41', '2021-12-10 18:06:41', '2022-12-10 18:06:41'),
('ce9a7c48fdc6e20219f245e69b26430bcf710eac6dd280838beb241694ef27eaff8eb03fd6b0010b', 2, 1, 'token', '[]', 0, '2021-06-22 10:44:37', '2021-06-22 10:44:37', '2022-06-22 10:44:37'),
('ced5d3b951307b433b23863da412f6c02f423109ee1848abb91b94e53cba4391ee8ed05fe3169cd5', 50, 1, 'token', '[]', 0, '2021-11-30 19:11:35', '2021-11-30 19:11:35', '2022-11-30 19:11:35'),
('ceda97be6b2181c1778865fd4da0bd10e0381531816a4840cc59f1f204b6ac86c38b888508aa71bd', 50, 1, 'token', '[]', 0, '2021-12-13 17:08:04', '2021-12-13 17:08:04', '2022-12-13 17:08:04'),
('cf151a4e32c6e872b7f82aff1e53cfecabcaea6bd6367df689f9d7a5a9a63b45e81ecac895897741', 37, 1, 'token', '[]', 0, '2021-11-13 10:02:12', '2021-11-13 10:02:12', '2022-11-13 10:02:12'),
('cf1a9d04fd2eeebe861c9d1ef53301eb255f56d3a0d5e0c7446d83ce11852aed27f224c0777ce5b2', 80, 1, 'token', '[]', 0, '2021-12-21 14:42:16', '2021-12-21 14:42:16', '2022-12-21 14:42:16'),
('cfa116d8d4744cde4a82d8647863a48cecdcece54ac3bf7f0f8dc618b1b6aea3e99c0f1e7fed1f7d', 2, 1, 'token', '[]', 0, '2021-06-10 13:22:01', '2021-06-10 13:22:01', '2022-06-10 13:22:01'),
('cfb6a7ce4b51a25e17a956e281fa68e86b8a818ae8a30c14abf7ce6bd2d05bb912ee5955ac9319d3', 2, 1, 'token', '[]', 0, '2021-12-06 15:26:22', '2021-12-06 15:26:22', '2022-12-06 15:26:22'),
('cfd28d0f90573a533dbd57339683bed928c9307dfd2646bdf2e5a398901e124a4a28c2143f18144b', 37, 1, 'token', '[]', 0, '2021-11-18 13:00:50', '2021-11-18 13:00:50', '2022-11-18 13:00:50'),
('cff66c016f35a62277197fb02a8a35984074d14268f6b42fd175d602277ca2d7f3ad0b92ed3d02ae', 2, 1, 'token', '[]', 0, '2021-12-06 11:04:16', '2021-12-06 11:04:16', '2022-12-06 11:04:16'),
('cfff6230b84de30dfc3dbbd3cf388670f0dcec743af72c35e2984e1ab6410259c9abb536eb4344bc', 2, 1, 'token', '[]', 0, '2021-12-13 11:13:49', '2021-12-13 11:13:49', '2022-12-13 11:13:49');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('d011ec749372a056d60009cbb9b3f947d23747617d5e1cb72a8d4ffdd9c6deb629f9c2f0862246c7', 2, 1, 'token', '[]', 0, '2021-12-13 11:54:32', '2021-12-13 11:54:32', '2022-12-13 11:54:32'),
('d0239ccd16a697be10c4d7c46d8c29d2d4b5e44559c5e30813ab3933a1cb0b0fa25c93d493492e6e', 50, 1, 'token', '[]', 0, '2021-11-19 09:54:59', '2021-11-19 09:54:59', '2022-11-19 09:54:59'),
('d0ce8421c6651333dc519abaec375acebef49601813318d811477f4b1b0f543378a8e2386d688989', 2, 1, 'token', '[]', 0, '2021-11-26 14:44:40', '2021-11-26 14:44:40', '2022-11-26 14:44:40'),
('d0d664705bd52f37a12944218103acf40d897f85751a473511878f0b139202365c554d13f781a390', 80, 1, 'token', '[]', 0, '2021-12-17 12:14:36', '2021-12-17 12:14:36', '2022-12-17 12:14:36'),
('d0e7ccb4e066f617be1ec7c01cc51e16417d4de0610df80aae5c14945b7ce2ba47aede61fb4892a1', 50, 1, 'token', '[]', 0, '2021-12-03 10:16:02', '2021-12-03 10:16:02', '2022-12-03 10:16:02'),
('d0f691077ae0a61cb94ea15ffd48b72e480be389b572aa23983c234a379e7167d3cde23cd2825750', 37, 1, 'token', '[]', 0, '2021-11-17 18:33:53', '2021-11-17 18:33:53', '2022-11-17 18:33:53'),
('d1086bca6c90c2ff60b7e591c37828a031ad1f55f26e3acbdef7d8bddeee6112fdafeb4683c883b5', 2, 1, 'token', '[]', 0, '2021-11-30 15:36:51', '2021-11-30 15:36:51', '2022-11-30 15:36:51'),
('d1312f7ff81d829e87b99054832b8b728752278e66a5c32bd24460389f3e1cb1a8789378ffb78d26', 2, 1, 'token', '[]', 0, '2021-12-13 15:27:52', '2021-12-13 15:27:52', '2022-12-13 15:27:52'),
('d1514d07c8ce56dd846eb58259e46148c417a2a951e08315f0a6056dd68743d6f182cb2c78de36e8', 2, 1, 'token', '[]', 0, '2021-12-07 11:33:41', '2021-12-07 11:33:41', '2022-12-07 11:33:41'),
('d1c1cbdfd07cdc085ce07f0fca75e6d03cd5d391e66bcbbc0f10f188747dcf07d12a7c7ab837b3c1', 80, 1, 'token', '[]', 0, '2021-12-04 19:07:21', '2021-12-04 19:07:21', '2022-12-04 19:07:21'),
('d1ea7e5772ffef75a415abc9073c6babaf8a19eafcb3078c3e8aa2cc0a2b502f79bc3ab86feddeb9', 2, 1, 'token', '[]', 0, '2021-12-13 11:14:01', '2021-12-13 11:14:01', '2022-12-13 11:14:01'),
('d213f2fb461754e8e394fcbce679472d061928a6155189437716e6bde7e87e07fb1e86acad597aab', 37, 1, 'token', '[]', 0, '2021-11-18 09:37:58', '2021-11-18 09:37:58', '2022-11-18 09:37:58'),
('d24b9df7b0a182cf4f438484f1fb8f3beef7f58f818f8beb2a7babbc0c313c5da09fb82428dcb759', 50, 1, 'token', '[]', 0, '2021-11-30 15:34:14', '2021-11-30 15:34:14', '2022-11-30 15:34:14'),
('d26115e7600c7e076b151cfc616e432563b6e45e18cb6b8facce92f936fbaaf02946335254e87e6c', 2, 1, 'token', '[]', 0, '2021-12-06 14:37:08', '2021-12-06 14:37:08', '2022-12-06 14:37:08'),
('d28eba19105f0fd4bcda8622264bfb5219ce36b61b6c0d6ec5cdab0023da5a78ab27427fc0c0f911', 68, 1, 'token', '[]', 0, '2021-12-03 13:48:07', '2021-12-03 13:48:07', '2022-12-03 13:48:07'),
('d2ccbe95ec9f5e57ae462e64217cdf08651b9843e23a27cdc6be0acc7e3b3c4188ee1bd3fe2733ce', 2, 1, 'token', '[]', 0, '2021-12-14 10:59:01', '2021-12-14 10:59:01', '2022-12-14 10:59:01'),
('d2f5f04d1fc0073b9108912ad8299745e4fa59a25995eb4ef9f794d5e231ee116c0342e9ce91899e', 2, 1, 'token', '[]', 0, '2021-12-10 14:53:44', '2021-12-10 14:53:44', '2022-12-10 14:53:44'),
('d302654a5be85c51e168f2ed8b2a64baadd6a53f152381cf5cd2c98c8688ae5496e572c4aa6ca150', 50, 1, 'token', '[]', 0, '2021-12-14 15:26:10', '2021-12-14 15:26:10', '2022-12-14 15:26:10'),
('d330e272cdc01543d394e96052bd973020b8d2248d13cbf1c1791bb42089269a6cbfa460e305d054', 2, 1, 'token', '[]', 0, '2021-11-26 10:37:02', '2021-11-26 10:37:02', '2022-11-26 10:37:02'),
('d340af5a06f5f436699a28c745fd79efdfa7bb2e700d299c7734685b44aa6dc177a5513c484eff42', 50, 1, 'token', '[]', 0, '2021-11-18 16:51:04', '2021-11-18 16:51:04', '2022-11-18 16:51:04'),
('d35dceffc6412354fa4db71eec995ca2af716c7ddcababe9c07a170d8d68b2eb062e3aa246eb3451', 50, 1, 'token', '[]', 0, '2021-11-30 18:57:29', '2021-11-30 18:57:29', '2022-11-30 18:57:29'),
('d37cd307009c468712b8983a148976397aa90fe5d3fca08a2b2484f603d7302bdd0a114d794bfa52', 61, 1, 'token', '[]', 0, '2021-12-02 19:30:28', '2021-12-02 19:30:28', '2022-12-02 19:30:28'),
('d39482978661f34a61cb3564915fee68e88a37a0eaea8d7c7b7b07c78724b6fd312a889059efefd8', 50, 1, 'token', '[]', 0, '2021-12-03 12:55:25', '2021-12-03 12:55:25', '2022-12-03 12:55:25'),
('d3a5655cb82e9208a0f25ceb869fa38b3da909cc19dffa3fb223c96a1c4733e5a7d25b8a3d4ad732', 50, 1, 'token', '[]', 0, '2021-11-30 10:35:07', '2021-11-30 10:35:07', '2022-11-30 10:35:07'),
('d3b27f8a581d996d5974dc1213e8cfbad86d5a9486d586eef87ddf7653ad9b36fe6a39504a934fff', 80, 1, 'token', '[]', 0, '2021-12-21 15:01:35', '2021-12-21 15:01:35', '2022-12-21 15:01:35'),
('d3b42c4589a155846f44552e6a5827c1849dd8800df92b385129eb80372c77121f2591e6f1ad0e2f', 2, 1, 'token', '[]', 0, '2021-12-13 14:43:13', '2021-12-13 14:43:13', '2022-12-13 14:43:13'),
('d3b835ae84531832cc769269f9a638cf0b85f80276041118bb9d3107a79d833115fd4db28be3685d', 80, 1, 'token', '[]', 0, '2021-12-10 18:53:50', '2021-12-10 18:53:50', '2022-12-10 18:53:50'),
('d3c56668c9e72943fc4c2acb5d81370e5a2908227d20499d708bf64f80790a17ca0d7607022bf37e', 37, 1, 'token', '[]', 0, '2021-11-19 18:24:57', '2021-11-19 18:24:57', '2022-11-19 18:24:57'),
('d3d95189c1d14d4e87314a1304911fe03a664fff99596e76d63db39a7b2407dd44d582cd4a0b525a', 67, 1, 'token', '[]', 0, '2021-12-01 14:40:03', '2021-12-01 14:40:03', '2022-12-01 14:40:03'),
('d40406caaccc99f7ee01d3bcbcc6b38e2a2ea543e531e77ac91e351a3f6902cf60f96f5aba073dab', 37, 1, 'token', '[]', 0, '2021-11-17 17:38:53', '2021-11-17 17:38:53', '2022-11-17 17:38:53'),
('d40a6d1dec925d6b6942a8db30be535d6d6f3f8f1ab4f264a2a231bb97a7f9829f1edd2fe65fb429', 37, 1, 'token', '[]', 0, '2021-11-17 18:35:19', '2021-11-17 18:35:19', '2022-11-17 18:35:19'),
('d424c3e42e1cf392a515c9c48a81bbdf6877c89555ee313c87b16251661b9cf0afa71d6cc0ff1246', 50, 1, 'token', '[]', 0, '2021-11-30 11:48:51', '2021-11-30 11:48:51', '2022-11-30 11:48:51'),
('d4275bb3c54efd6832e169d2180df12969d88de9f2e2e1f3d33a4d11c1690d948c794724fe0136dc', 37, 1, 'token', '[]', 0, '2021-11-17 11:36:04', '2021-11-17 11:36:04', '2022-11-17 11:36:04'),
('d437f817a64f8b6a8446788c4b592d4d71eb551b9bd48a83f5e0375aed7e4302c6b8173c541fba09', 80, 1, 'token', '[]', 0, '2021-12-10 17:49:00', '2021-12-10 17:49:00', '2022-12-10 17:49:00'),
('d47aeaa8b21d2e2e4a3bfcc5e25d919f4e2005bae40e1057af4f978f3567d5df6e39fb7c173d96e2', 50, 1, 'token', '[]', 0, '2021-11-30 15:32:42', '2021-11-30 15:32:42', '2022-11-30 15:32:42'),
('d4bb3a21ab26048824572d1f197d79995d3966180e9b6e1bccd9f2be2b8b5d813f7b4946362829f4', 2, 1, 'token', '[]', 0, '2021-12-06 15:55:35', '2021-12-06 15:55:35', '2022-12-06 15:55:35'),
('d4e2acd4cf3d0acc9116fa2e2d8ab277f2f30eca320b72d599f27f80265248bba29aa1dc9012279d', 37, 1, 'token', '[]', 0, '2021-11-18 11:00:49', '2021-11-18 11:00:49', '2022-11-18 11:00:49'),
('d4e51545ea3456f9baf1644d816aa9945394e482a11e3aab61a88eee3cb886396a4e6db2bbc85078', 78, 1, 'token', '[]', 0, '2021-12-03 14:42:06', '2021-12-03 14:42:06', '2022-12-03 14:42:06'),
('d530881dbb83348ea8206578639e46bc636330c8f532f2cd64f7165bb54057530e2a8086218eef14', 66, 1, 'token', '[]', 0, '2021-12-01 11:54:27', '2021-12-01 11:54:27', '2022-12-01 11:54:27'),
('d53cfc30d34ba417dc75c99892b51c370e90303024ba7a80d9b0b889f06ddc412be190b547dc8dbb', 2, 1, 'token', '[]', 0, '2021-12-08 15:39:27', '2021-12-08 15:39:27', '2022-12-08 15:39:27'),
('d54c521d4c851f52aea6d6ebf92e7006a1eae23f4a4305798934c8423299bdf6fd46013f854fc4e0', 50, 1, 'token', '[]', 0, '2021-12-01 16:33:13', '2021-12-01 16:33:13', '2022-12-01 16:33:13'),
('d5c381fad0ffd4554ce3ec0c6c8c205d46abb59c8b4b1adbad21a16cc5143475f8163fd8f575d284', 2, 1, 'token', '[]', 0, '2021-12-08 13:00:34', '2021-12-08 13:00:34', '2022-12-08 13:00:34'),
('d5e5de606f456f5b2fef2174b1a0dba50941ce296c1c1ea1f5841ee84cd79423680caae993382a70', 50, 1, 'token', '[]', 0, '2021-11-29 16:50:05', '2021-11-29 16:50:05', '2022-11-29 16:50:05'),
('d606c9cd45e9eeec747d13c343df9237e954c6d39f238ffa9b503b693657f7aa78b9c5c770a5c10a', 2, 1, 'token', '[]', 0, '2021-12-06 11:06:13', '2021-12-06 11:06:13', '2022-12-06 11:06:13'),
('d60f620a2391fa8c900f9b7df1299c4177aa20f79742c19786424d335d7daa26ff3ed7628975238b', 48, 1, 'token', '[]', 0, '2021-11-19 12:33:17', '2021-11-19 12:33:17', '2022-11-19 12:33:17'),
('d615b9f375ee25323ce3a59f76392218f5455ac7be7f4c8663a50821fd1489cc49319ebd9552ea50', 80, 1, 'token', '[]', 0, '2021-12-16 10:49:47', '2021-12-16 10:49:47', '2022-12-16 10:49:47'),
('d666aa46adcadf953879da62edb903a0d1b861f1b2ad96780129c8ccc66ead49c6c0de49d9138f2d', 37, 1, 'token', '[]', 0, '2021-11-17 18:46:16', '2021-11-17 18:46:16', '2022-11-17 18:46:16'),
('d667098b636fcd76d065b19dc8db0d0ea4567661673e7d59b879566fc7ec37e8083d7b20d154ef61', 2, 1, 'token', '[]', 0, '2021-06-22 16:14:54', '2021-06-22 16:14:54', '2022-06-22 16:14:54'),
('d67bf1496eeb300de3fe675a157c9a86746943471a3caea918d27adc7d85b0ea9a4e3ab1c70d7e4d', 50, 1, 'token', '[]', 0, '2021-11-20 14:43:01', '2021-11-20 14:43:01', '2022-11-20 14:43:01'),
('d6c051dc79e4cd87cb3722dd84e8f57f9a56e966ff499b14ae9a575dc2f4ac7e732b78a0c1deb837', 61, 1, 'token', '[]', 0, '2021-12-02 19:30:46', '2021-12-02 19:30:46', '2022-12-02 19:30:46'),
('d6e99dbf17a0396420a08cd44e20e5837c11d2681834df8cf2a73050f30329a3d60ea5e51224be55', 50, 1, 'token', '[]', 0, '2021-11-29 11:18:21', '2021-11-29 11:18:21', '2022-11-29 11:18:21'),
('d70318865799a9bb23e2fa29fe89e8c5299977982f4e1eccd5caedf5e1e2bf6a75317f77e99556d1', 93, 1, 'token', '[]', 0, '2021-12-08 13:26:12', '2021-12-08 13:26:12', '2022-12-08 13:26:12'),
('d70b58473a6b0f5c8523e6aa31479a9f32c557ecf0b946da0fb11d1c7ce4c7498503a784e206942e', 61, 1, 'token', '[]', 0, '2021-12-01 11:29:48', '2021-12-01 11:29:48', '2022-12-01 11:29:48'),
('d7ade3d7b5194e2ee057618a671fa526e8fdea7d4ef2185d8dc681fe8704e3ea545d0b88955b2e95', 48, 1, 'token', '[]', 0, '2021-11-19 17:59:32', '2021-11-19 17:59:32', '2022-11-19 17:59:32'),
('d7ef86eaed9ebb0ef24970e28710a253c89a2ca5ff4cf0875528e976f16a5d4765dd36a9a3668c20', 50, 1, 'token', '[]', 0, '2021-11-30 11:58:34', '2021-11-30 11:58:34', '2022-11-30 11:58:34'),
('d806ccf34176a77273ff6c486e59b747de1ebebc190cb01f7ee54762ad794c5204756c5828cbcac5', 2, 1, 'token', '[]', 0, '2021-12-10 10:00:56', '2021-12-10 10:00:56', '2022-12-10 10:00:56'),
('d8119a92651f9471430e12bc8062b50f481f0972346ea491f809621a6f23d89ae87aa2de39600282', 37, 1, 'token', '[]', 0, '2021-11-17 18:15:23', '2021-11-17 18:15:23', '2022-11-17 18:15:23'),
('d81935c325f971c61654ebb272b529fd332bf4838614cc1033c493fd1dac7f5de2b330f71e217dba', 2, 1, 'token', '[]', 0, '2021-06-22 11:21:15', '2021-06-22 11:21:15', '2022-06-22 11:21:15'),
('d84baa95c7eb3b171329942c4b48d830e049f5f0a0ec7a3e6152a96ff27deaabe54a8feb38e268dc', 2, 1, 'token', '[]', 0, '2021-12-06 11:06:03', '2021-12-06 11:06:03', '2022-12-06 11:06:03'),
('d868bcc08d1dd492d4edcdba86adbdcb769162d5f40aaf7cae5d71ebc12efb286bd63d2522506987', 2, 1, 'token', '[]', 0, '2021-12-13 15:26:08', '2021-12-13 15:26:08', '2022-12-13 15:26:08'),
('d87a1ff3818169a639480ceb84e7e8373c8818ccd87c87c723d3b4c217bdeb40cff059b70d9ad139', 50, 1, 'token', '[]', 0, '2021-11-27 18:53:22', '2021-11-27 18:53:22', '2022-11-27 18:53:22'),
('d8a89305d6eafaaaaf06e1fe525be9524efca9068b7294b9ed4ffc7bd3748e72987409b222142af2', 2, 1, 'token', '[]', 0, '2021-12-04 11:12:54', '2021-12-04 11:12:54', '2022-12-04 11:12:54'),
('d924c42504b8dac06faab92920c71ac9334c4d5c4700f44059ec2eb75cceb9308d9fa21efa2d9277', 2, 1, 'token', '[]', 0, '2021-11-02 17:34:52', '2021-11-02 17:34:52', '2022-11-02 17:34:52'),
('d936b30bbeed97ac48d8bb2c24717dd831b81fd178d39db142b6d1670552ab79375bfc065b36138b', 2, 1, 'token', '[]', 0, '2021-11-13 11:21:27', '2021-11-13 11:21:27', '2022-11-13 11:21:27'),
('d942fcd11d388e893ddbbb5017acd9bfc4b4ff7bdf928183335d1ed8336bc5bc228ab125a1f34e01', 37, 1, 'token', '[]', 0, '2021-11-19 12:01:05', '2021-11-19 12:01:05', '2022-11-19 12:01:05'),
('d948f2c8092aec7e04e2df3b19ddd38f11cda8cb0100b277525a3aa813cda868671be185a7153472', 2, 1, 'token', '[]', 0, '2021-12-06 14:15:50', '2021-12-06 14:15:50', '2022-12-06 14:15:50'),
('d94985e9db34993e793f01a57f6c3e0681395f6b84c0e881bd0d4fe7228aa900dc9d892bb90f781e', 2, 1, 'token', '[]', 0, '2021-12-04 11:11:45', '2021-12-04 11:11:45', '2022-12-04 11:11:45'),
('d956b90109b28634b9cbf3df12912d7cf69b5e7fbfa377e7efbeaa8d27ee7b898f63ef65cf4c36e3', 80, 1, 'token', '[]', 0, '2021-12-06 11:53:38', '2021-12-06 11:53:38', '2022-12-06 11:53:38'),
('d96022f1aa407564716e493367d0d6272879567f23d6c4e0fea733a741ab0858872a66900dfef4d6', 80, 1, 'token', '[]', 0, '2021-12-10 17:45:47', '2021-12-10 17:45:47', '2022-12-10 17:45:47'),
('d96711c295d44602f0175038ea367a7509995657e7e85c680d79a3a5d8d1f155ed2a1dd1e699c1ce', 2, 1, 'token', '[]', 0, '2021-11-30 10:25:39', '2021-11-30 10:25:39', '2022-11-30 10:25:39'),
('d9ab1b142ee82e832326355d30bb2d70089b62f39589e3506861ef49fac076a946e837c69cf30399', 2, 1, 'token', '[]', 0, '2021-11-29 10:22:23', '2021-11-29 10:22:23', '2022-11-29 10:22:23'),
('d9bc92b46c9887f7d09ab152610ad1113b6bd65692e8981d352e274b3dc8e56c5bd6515ab33b12bf', 2, 1, 'token', '[]', 0, '2021-12-20 10:06:24', '2021-12-20 10:06:24', '2022-12-20 10:06:24'),
('d9df27527f288047e37c1f0e9d78882b03ee6fc6b8d0ca0be059fd6ab2d993a2d47e9e9957d9bff5', 80, 1, 'token', '[]', 0, '2021-12-21 14:49:08', '2021-12-21 14:49:08', '2022-12-21 14:49:08'),
('da7ba8b3d6c457918a1e9f035a92db89f870de1ac2ee27c2a016330746e7b87edbf3dc271aeefd54', 50, 1, 'token', '[]', 0, '2021-12-13 11:20:59', '2021-12-13 11:20:59', '2022-12-13 11:20:59'),
('dacbb76f5f39e9c29fe4c41efa40843af0a66ab4008bade4cd221c55b91e82836c981d181dd98c47', 2, 1, 'token', '[]', 0, '2021-12-07 11:15:53', '2021-12-07 11:15:53', '2022-12-07 11:15:53'),
('dae1c565849ac046781f8a3e487bf57d74fdb3ef8c60508acfdc7ff09f6e5eaa4587c15ff96eab02', 2, 1, 'token', '[]', 0, '2021-06-22 16:26:40', '2021-06-22 16:26:40', '2022-06-22 16:26:40'),
('db0eca9cc832a69749f2f63803f69ce59cf803165cd1839e9ec10321b3a1038ca8526d0bde13a1d4', 37, 1, 'token', '[]', 0, '2021-11-18 10:22:40', '2021-11-18 10:22:40', '2022-11-18 10:22:40'),
('db22d43aaa3643666213fcef2760c3f66d3627e3da1db29787023ce920edf7f3309859eb5c7739e0', 37, 1, 'token', '[]', 0, '2021-11-17 18:18:04', '2021-11-17 18:18:04', '2022-11-17 18:18:04'),
('db3506039f7fb6cb34c706e7318c5660613dafb4a0d53a11062a000011becf0b75c6ba69a313614e', 37, 1, 'token', '[]', 0, '2021-11-17 17:15:27', '2021-11-17 17:15:27', '2022-11-17 17:15:27'),
('db6e14a87f113f92a782cdb2a0a8328f7b6261ee400091276b7357cace36da44b54d3e6dbe394467', 2, 1, 'token', '[]', 0, '2021-12-09 11:20:38', '2021-12-09 11:20:38', '2022-12-09 11:20:38'),
('db9b0037c03efb9401b5f06e14718e7eede9c84423c79224e48eeb051112d0a757c365ba446561f4', 37, 1, 'token', '[]', 0, '2021-11-15 14:16:56', '2021-11-15 14:16:56', '2022-11-15 14:16:56'),
('dba230da2b1ea7e241ebe765729896d93a236de7628898e0e6cd725ec058d454b302444fd05231d1', 2, 1, 'token', '[]', 0, '2021-12-07 12:02:33', '2021-12-07 12:02:33', '2022-12-07 12:02:33'),
('dc0207195518fe32715f8b4c4e60cce925114914d15a8cc6437757b9e5ef8a852299ab03c12d2f74', 80, 1, 'token', '[]', 0, '2021-12-03 14:22:19', '2021-12-03 14:22:19', '2022-12-03 14:22:19'),
('dc1100a67bdf2a5ae3a04eaa68405a119af27516c9ed588ae255ce0575a34e60ac5112e9d5d9538d', 2, 1, 'token', '[]', 0, '2021-12-06 16:07:49', '2021-12-06 16:07:49', '2022-12-06 16:07:49'),
('dc3642d34a7ac2a2922b8d2d753d3eba7f4c1ded3eccdf9b3f51a9df0e71af4a4a019dda2d23e898', 50, 1, 'token', '[]', 0, '2021-12-01 14:40:53', '2021-12-01 14:40:53', '2022-12-01 14:40:53'),
('dc47461a3a3040508b83bc59c66a2a40faffaf53f317d7ccc58c5446c7d2e27f99029e0dc68818a2', 50, 1, 'token', '[]', 0, '2021-11-20 12:13:13', '2021-11-20 12:13:13', '2022-11-20 12:13:13'),
('dc5eb9632efb54e2b62148a09b9501e615e880dff242c8477a44dfdf1b8df9c164bd49a7bc680563', 2, 1, 'token', '[]', 0, '2021-12-04 16:13:00', '2021-12-04 16:13:00', '2022-12-04 16:13:00'),
('dc91ae949029d38222b260850e1b20d660cd0e42b9fc3480eb2970636e1385f271ab184907b0f6c0', 37, 1, 'token', '[]', 0, '2021-11-17 18:20:31', '2021-11-17 18:20:31', '2022-11-17 18:20:31'),
('dca73f6fb16b0d5db07109d1a723517191189b2e250e37de9d4fcc8510691d3a2c057d1ebadf9968', 37, 1, 'token', '[]', 0, '2021-11-18 10:23:31', '2021-11-18 10:23:31', '2022-11-18 10:23:31'),
('dcb1a35a48537d13e1b1e83cbe7469bc2cee5ec5f6daad23a14286fbea2eeb6e4a4258bceeee4ca7', 2, 1, 'token', '[]', 0, '2021-12-07 17:30:20', '2021-12-07 17:30:20', '2022-12-07 17:30:20'),
('dcb2e4eb9af31841b87da61f5e41717e0cc13c416421635a72181feda0b3858af04ed2c1520a44bd', 37, 1, 'token', '[]', 0, '2021-11-17 18:15:26', '2021-11-17 18:15:26', '2022-11-17 18:15:26'),
('dd2a0dc3c7dcbbdb28c09a459c15c48c72a7d30dc5f283476d11dd3753219164ba91f0d445301182', 50, 1, 'token', '[]', 0, '2021-12-03 13:21:51', '2021-12-03 13:21:51', '2022-12-03 13:21:51'),
('dd2f0b3cc7e12b173a9a68ecd8f87a42b862443eac44ad3d3bfccd1e3eee3d3fcd58c1f95707a044', 2, 1, 'token', '[]', 0, '2021-12-08 16:09:52', '2021-12-08 16:09:52', '2022-12-08 16:09:52'),
('de18702bec2f314cc98e68e75e8f24824f7e96600ffdfe7f9ed17089b60d16bfd82a901ec06c0c7c', 48, 1, 'token', '[]', 0, '2021-11-20 09:38:47', '2021-11-20 09:38:47', '2022-11-20 09:38:47'),
('de76de30509d99489b721751cd86672d88b2f0ee3e988c7854252d21f2fe1b284283f5c452c8dee5', 2, 1, 'token', '[]', 0, '2021-12-03 18:24:42', '2021-12-03 18:24:42', '2022-12-03 18:24:42'),
('de832cb373f73dc90fec577a70ac020691d07aadea3e180628ebbfeea431107c7c1a60b9227962a7', 37, 1, 'token', '[]', 0, '2021-11-18 12:30:05', '2021-11-18 12:30:05', '2022-11-18 12:30:05'),
('de8e4153dbd5ffbf17c55debf2faad67984b8104e669e9f0341505654cc0982b7dbaec09b42043b2', 2, 1, 'token', '[]', 0, '2021-12-08 09:57:08', '2021-12-08 09:57:08', '2022-12-08 09:57:08'),
('de939a2df9ae1abe7a6ce7b23a46ae41f8562aac69eb00bf44e4ef1471d02393219436e1ba6fdd9e', 2, 1, 'token', '[]', 0, '2021-12-07 19:30:52', '2021-12-07 19:30:52', '2022-12-07 19:30:52'),
('de988e4e96ff58d11b2cda77cab0681bf5bcec56d40bbcddfee47a9173ed3323ebc2090c325ba01d', 80, 1, 'token', '[]', 0, '2021-12-04 19:09:34', '2021-12-04 19:09:34', '2022-12-04 19:09:34'),
('deb627dc667d20b1e4fc5233666d5081af67f17145c5d2b5e93a96a78cd399f21306850c4567bd3a', 2, 1, 'token', '[]', 0, '2021-12-09 18:58:00', '2021-12-09 18:58:00', '2022-12-09 18:58:00'),
('debe58d7b3e4abf55ac5e682ad7c077c996704a43ecf368dda76bddab0d8f92a9d5f935892286ad8', 37, 1, 'token', '[]', 0, '2021-11-17 18:30:08', '2021-11-17 18:30:08', '2022-11-17 18:30:08'),
('decd493215b483fd0f7af5484310538ab587157534b2480f8f00f6c5a9f3e1ec4ced7c1894d247fa', 48, 1, 'token', '[]', 0, '2021-11-29 18:03:01', '2021-11-29 18:03:01', '2022-11-29 18:03:01'),
('deed6704c7a779ef891ce8d2a981e9e401134a7f6b697e8583f47f7fbd4a128b4d51e81ffb3f772a', 37, 1, 'token', '[]', 0, '2021-11-18 09:45:43', '2021-11-18 09:45:43', '2022-11-18 09:45:43'),
('df0555eb9cde1a999f80e379baf9d7c63429b3d2ab90ca01d458078ad165f3c0a5452b16376057ea', 50, 1, 'token', '[]', 0, '2021-12-13 17:58:55', '2021-12-13 17:58:55', '2022-12-13 17:58:55'),
('df08e8d8cd097d22d72781417c209383e0e89a663fc14af86bfeabfb4608fb51e1ecfa6b5f31d6bd', 61, 1, 'token', '[]', 0, '2021-12-01 10:44:08', '2021-12-01 10:44:08', '2022-12-01 10:44:08'),
('df098138fb5ae75b2284481557d4ec76f879abc3198c9ac697cec472e6221d63676a177855981835', 51, 1, 'token', '[]', 0, '2021-11-19 15:03:20', '2021-11-19 15:03:20', '2022-11-19 15:03:20'),
('df6e5ab883365b24bdb18d11d7d673b9d953844d5b19645efa1bde5652a870d3cada1fe2c5720cd5', 2, 1, 'token', '[]', 0, '2021-11-29 11:15:35', '2021-11-29 11:15:35', '2022-11-29 11:15:35'),
('df81f94dc9f51fd91204e48ed62321d1b060742fac40cecf478474e95f7cbef77126fe39ff934e98', 80, 1, 'token', '[]', 0, '2021-12-17 12:28:57', '2021-12-17 12:28:57', '2022-12-17 12:28:57'),
('df8f9ebbfee2bc77a093c80cd4613ebcbcf9f3518be833088b32901cb3ac08c6d16555eca6b68f28', 2, 1, 'token', '[]', 0, '2021-06-16 18:12:47', '2021-06-16 18:12:47', '2022-06-16 18:12:47'),
('df986ffaccd84e39df602ffb3b0c4450a067d4f0ac10804314ba4465bea5ac6e933d9451cdec3f57', 2, 1, 'token', '[]', 0, '2021-06-20 14:58:59', '2021-06-20 14:58:59', '2022-06-20 14:58:59'),
('df98969eed78d80f2719b1ee882cdf3fba5a9ab25dd36d339f6343b5cfb34ade2d362f244bc00c7d', 50, 1, 'token', '[]', 0, '2021-11-24 17:08:14', '2021-11-24 17:08:14', '2022-11-24 17:08:14'),
('dfe5eea2f7823a0fc8292a885ea9834dc2a07f5f65cf8006b5315342dfd07d0371da367601d4ca48', 50, 1, 'token', '[]', 0, '2021-11-24 16:38:29', '2021-11-24 16:38:29', '2022-11-24 16:38:29'),
('dff446fba3104891c4b64747e2fbae80807ff508360c59d939d51df9a9aabfc7d1f0719d457cb0f1', 80, 1, 'token', '[]', 0, '2021-12-17 17:52:00', '2021-12-17 17:52:00', '2022-12-17 17:52:00'),
('dff7ef138496aa93131a6aaa77496ce925702e67813e988f04ff2714bfe93045efd5af58220a6d12', 80, 1, 'token', '[]', 0, '2021-12-16 12:57:22', '2021-12-16 12:57:22', '2022-12-16 12:57:22'),
('e04f89c00d29f06e8c5b80a64ce5d1c3ecb0a57df909396eb9ea5e45653f3cce13b87b54c80dcf23', 2, 1, 'token', '[]', 0, '2021-12-16 10:50:14', '2021-12-16 10:50:14', '2022-12-16 10:50:14'),
('e099f10191e5f7d7828a0f34f7305c4d2b1f503274f637791bab5d5d2e35fd5fb1300f03034b6db1', 58, 1, 'token', '[]', 0, '2021-11-30 22:28:47', '2021-11-30 22:28:47', '2022-11-30 22:28:47'),
('e09b0dd81d4340dc858ce57aeac94e43d2ed538585aba993a089198248085ba3b17e9c64922f653d', 50, 1, 'token', '[]', 0, '2021-12-13 11:31:38', '2021-12-13 11:31:38', '2022-12-13 11:31:38'),
('e0d13211598daec5ded9bed234023485ea69824b5873aab32cc5f99de71ec1a75d39fceaf12d8fc5', 48, 1, 'token', '[]', 0, '2021-11-30 16:59:36', '2021-11-30 16:59:36', '2022-11-30 16:59:36'),
('e0d82a01e2c0704318abed659cbd3b8862dbc4b03d6842d1e9f0b9b5a80e80b7c575e73e24c2d3a3', 37, 1, 'token', '[]', 0, '2021-11-18 10:45:11', '2021-11-18 10:45:11', '2022-11-18 10:45:11'),
('e10b568b0083f3226bce1b554ebbca3ec1a989b9498a1883aa8bdddb5407436d0a509a34cdd61992', 2, 1, 'token', '[]', 0, '2021-12-13 15:20:19', '2021-12-13 15:20:19', '2022-12-13 15:20:19'),
('e10ddc4567318bdac5efafd45933e4275e1bc80c1955d7b3bc58beb8726c2640ab70e383b94025d3', 50, 1, 'token', '[]', 0, '2021-11-26 15:26:49', '2021-11-26 15:26:49', '2022-11-26 15:26:49'),
('e128423568f945a270c8fb5c341ad8648176f77bfc16664143610b917c9007c85198ec42d5fa9ab2', 37, 1, 'token', '[]', 0, '2021-11-18 09:40:37', '2021-11-18 09:40:37', '2022-11-18 09:40:37'),
('e1ef69a852ae0df4eea498542fd86d0b4e9cab4480cf163d33546e0aa60abdab3c35dcdbe84d9cd5', 50, 1, 'token', '[]', 0, '2021-11-20 11:39:11', '2021-11-20 11:39:11', '2022-11-20 11:39:11'),
('e1f2f471b55d9526634a2169790ab45951f92eb4a239be0494bb955d0005021f10bfc26a2a06bd73', 37, 1, 'token', '[]', 0, '2021-11-18 10:45:08', '2021-11-18 10:45:08', '2022-11-18 10:45:08'),
('e20a36d15da4a1ce9bb29e4b26bbc80f767dd0b335123f626f519eddc0d10d4372669bb38f58b938', 2, 1, 'token', '[]', 0, '2021-12-08 14:42:23', '2021-12-08 14:42:23', '2022-12-08 14:42:23'),
('e2136959bf8d976e1e63e0d9e52ca8e9270b3c4d56e5156d7feb8c5522485ebff9c81329b2d5d648', 2, 1, 'token', '[]', 0, '2021-12-08 10:53:40', '2021-12-08 10:53:40', '2022-12-08 10:53:40'),
('e25194ca3a76826559ce69739f36d057afe33c634acc6f5b11ad63c1c4aa8c6cc4cfba655a0454d0', 2, 1, 'token', '[]', 0, '2021-11-03 10:10:48', '2021-11-03 10:10:48', '2022-11-03 10:10:48'),
('e2cefcf2adc35b93c60790e1c04b3b2d284af7b170f0fb4fc4486184f1c59114ddb9474e8bbad542', 61, 1, 'token', '[]', 0, '2021-12-01 11:26:33', '2021-12-01 11:26:33', '2022-12-01 11:26:33'),
('e2f3c424ade105d66e950931f6df4a835a219dfedf33b5529159e47e4e228b6cfcd5afaa3f599924', 68, 1, 'token', '[]', 0, '2021-12-14 15:15:18', '2021-12-14 15:15:18', '2022-12-14 15:15:18'),
('e33b70515cc48603278ca7bebda17c76766be99e2da9297c9efe3c373e8fe3c104427f9c349534ea', 2, 1, 'token', '[]', 0, '2021-06-22 15:47:01', '2021-06-22 15:47:01', '2022-06-22 15:47:01'),
('e34ac12b090b79886962cbde070e1b4867078d6e87b621bbea62e1dc759025745e63c31b11d454f9', 50, 1, 'token', '[]', 0, '2021-12-02 12:05:06', '2021-12-02 12:05:06', '2022-12-02 12:05:06'),
('e34ce8d5f851232686d490d5c3cb9ffb66b31523d4d9ebf1bd2e79c62afa2ec3b169c9aab90c58cb', 2, 1, 'token', '[]', 0, '2021-12-14 10:38:02', '2021-12-14 10:38:02', '2022-12-14 10:38:02'),
('e356d11ce37b0a725f78e724aa518bc2f96d3a2a12f5857d4f61d13165308d7947b4eadfb6754192', 2, 1, 'token', '[]', 0, '2021-11-20 12:46:14', '2021-11-20 12:46:14', '2022-11-20 12:46:14'),
('e357e6b3371005b2a4ed7b100f1b7076847bbed314017b3ffb91e011606798f95910e8ad11d1fcf9', 2, 1, 'token', '[]', 0, '2021-11-02 18:11:59', '2021-11-02 18:11:59', '2022-11-02 18:11:59'),
('e362b96686cbb9fe3257bcfa3bf9ed8918480b4ad9f1e0ce4a12b6092cb955288d71fa2afcb50464', 50, 1, 'token', '[]', 0, '2021-11-30 11:42:39', '2021-11-30 11:42:39', '2022-11-30 11:42:39'),
('e372d61ed1379c86abeac2ddd1e78ee5ba6d191d78a3eace54929d9cbb11a9b8fd94c43eb6493b3f', 37, 1, 'token', '[]', 0, '2021-11-17 18:41:26', '2021-11-17 18:41:26', '2022-11-17 18:41:26'),
('e3822cc56d16eb7e0c57a8447805b3ed390a197e00e9299a60b613eb91c95b17b4d6426540182801', 2, 1, 'token', '[]', 0, '2021-12-10 15:45:35', '2021-12-10 15:45:35', '2022-12-10 15:45:35'),
('e38c9aec9c1d088090098b389036942a05bea5eafed7a29efef271b8d05233cb75eab1fc1e356b05', 37, 1, 'token', '[]', 0, '2021-11-18 10:14:28', '2021-11-18 10:14:28', '2022-11-18 10:14:28'),
('e3c547435992398b6770051146c0ae09629cf523904cc937324aa8f0a74f4cc59fd418b7125a4074', 2, 1, 'token', '[]', 0, '2021-12-10 14:07:59', '2021-12-10 14:07:59', '2022-12-10 14:07:59'),
('e3d62d114956c6b1454c48abc3cb184b7a0ed8bbe00559a0f4d5bdb8fb2235c5bc53a9a8370ab7b2', 80, 1, 'token', '[]', 0, '2021-12-10 18:05:17', '2021-12-10 18:05:17', '2022-12-10 18:05:17'),
('e3da0865296c8838cad31d7366c883272786c4b15162b792ee5e10304b24d5dc41cd03fbe40231fa', 67, 1, 'token', '[]', 0, '2021-12-01 13:52:54', '2021-12-01 13:52:54', '2022-12-01 13:52:54'),
('e42053f3c86f641c81eed9238b81d09cbb2ec6412dc81a8b56bb44e1aef3707262a3fd9be548fff5', 51, 1, 'token', '[]', 0, '2021-11-30 17:35:58', '2021-11-30 17:35:58', '2022-11-30 17:35:58'),
('e44772127d265f3de70b0cdfddd531ff79afb04aa90b51f2e759e706663865d806dae15c61718b8d', 2, 1, 'token', '[]', 0, '2021-11-26 17:58:00', '2021-11-26 17:58:00', '2022-11-26 17:58:00'),
('e47f3365caf616aab3b79937c9133e624d242cb3c092e698926d44a0cf9dab13430dc1838a12c640', 80, 1, 'token', '[]', 0, '2021-12-08 12:20:20', '2021-12-08 12:20:20', '2022-12-08 12:20:20'),
('e4cd3d3d7c0d0be9a8a94b127e8a11f250cdf3707affa29e3fbe4e8396616abca25bfc10b222066c', 37, 1, 'token', '[]', 0, '2021-11-13 15:26:48', '2021-11-13 15:26:48', '2022-11-13 15:26:48'),
('e4dbf8756e003cdc1dd40d811c34521399f17da37c3a2a02f1eb1330804978111abb8dac6893031d', 37, 1, 'token', '[]', 0, '2021-11-13 12:24:05', '2021-11-13 12:24:05', '2022-11-13 12:24:05'),
('e4fdfff0dc9c1a094107bb12319386768a1ce1fd2f7f33d4ed9656b3bbf786c37112c59881e46fbb', 37, 1, 'token', '[]', 0, '2021-11-17 18:46:12', '2021-11-17 18:46:12', '2022-11-17 18:46:12'),
('e507f29f0bd0ece84f4cb36f91b3d9d89f4475170cb083fe6654dc45253672d4dc63893f550c1dbf', 2, 1, 'token', '[]', 0, '2021-11-27 11:18:29', '2021-11-27 11:18:29', '2022-11-27 11:18:29'),
('e51301c72d9fb7159ef3a645467719af80ea4875cc9c0e4ba3ffd2c9ba75e60cecc4a40f0c0bea4f', 2, 1, 'token', '[]', 0, '2021-12-16 17:10:26', '2021-12-16 17:10:26', '2022-12-16 17:10:26'),
('e53cbac3f9b3be51cfa9fae6f9b2679017b83ae46b827820edaa2aa141ac35f1c9c2b04b06f8c956', 37, 1, 'token', '[]', 0, '2021-11-17 18:38:56', '2021-11-17 18:38:56', '2022-11-17 18:38:56'),
('e54642b89d37a2fa811a3b2d9ae83a99af954d378f29afccd3697ba31b0a20494b033082de27b879', 37, 1, 'token', '[]', 0, '2021-11-12 18:10:56', '2021-11-12 18:10:56', '2022-11-12 18:10:56'),
('e548816bfad4579342a2ff739fbe5a480d044eec9b9515092a4719598189604cfdfbf9e72386f0d4', 37, 1, 'token', '[]', 0, '2021-11-19 11:41:09', '2021-11-19 11:41:09', '2022-11-19 11:41:09'),
('e56ccded6dd4f9d39830ef59cf4875334511cb51a657b577441d4158a2c2cf91c009ccd5796828ec', 50, 1, 'token', '[]', 0, '2021-11-30 10:31:48', '2021-11-30 10:31:48', '2022-11-30 10:31:48'),
('e57368845389735a3e2f27dc4aa2f4fc0b3bccc562d4e6a8fe4702bbfbaad222f7d498fe9ec3bd25', 2, 1, 'token', '[]', 0, '2021-12-13 16:04:57', '2021-12-13 16:04:57', '2022-12-13 16:04:57'),
('e573ce6f74b9693e654b61c85b43c5efd65b51cf2f4c1c543b6ce73f8618879a390efb3e50ea3ae9', 80, 1, 'token', '[]', 0, '2021-12-10 11:42:57', '2021-12-10 11:42:57', '2022-12-10 11:42:57'),
('e579e7048801b0ae8cc04e58a451998030b1716b4c937193d521de019104452dd789a31f5d0d3e09', 37, 1, 'token', '[]', 0, '2021-11-17 18:22:51', '2021-11-17 18:22:51', '2022-11-17 18:22:51'),
('e597e37cabb4fcd8c94123edc7172cbb7de5096ec10271fc3d38f31a730cc913d989d8c8e489ef22', 2, 1, 'token', '[]', 0, '2021-11-29 17:29:18', '2021-11-29 17:29:18', '2022-11-29 17:29:18'),
('e59fbb3bd06cafbd724eebb8f856ba926f10d938f54efadbbea2a0d7a5d1dfec714b6904b46688e2', 2, 1, 'token', '[]', 0, '2021-11-20 10:10:03', '2021-11-20 10:10:03', '2022-11-20 10:10:03'),
('e5d5630483b54beca0d73950159ee84c2cf94279f204907ff64a3b9f47bc82c8583a3b5536ebd2e2', 50, 1, 'token', '[]', 0, '2021-12-01 16:26:03', '2021-12-01 16:26:03', '2022-12-01 16:26:03'),
('e5e171fb724ca4210e19818bdbd127abd831687ec1eb1ba4ebe699ebe9bdf40f6c4b7b50a669028c', 2, 1, 'token', '[]', 0, '2021-11-15 17:18:29', '2021-11-15 17:18:29', '2022-11-15 17:18:29'),
('e61c7cf7bf7efd1dd793e3ab090dea494e46efc3c95d87ca8eae9ba3b749e5e00e6e6ff5089d496b', 80, 1, 'token', '[]', 0, '2021-12-10 18:05:06', '2021-12-10 18:05:06', '2022-12-10 18:05:06'),
('e62afab8a3805c82faa106576b8a969c4b7568ed167bd984bcfb86b09e93697a58cbc04fa00a74f4', 2, 1, 'token', '[]', 0, '2021-11-26 18:06:15', '2021-11-26 18:06:15', '2022-11-26 18:06:15'),
('e66e94d34762091b1b2fcb7b8cacfc79741c60ca6e7f1ca55018920ec900fd9f4dc53d45337ff365', 50, 1, 'token', '[]', 0, '2021-12-02 17:35:11', '2021-12-02 17:35:11', '2022-12-02 17:35:11'),
('e680338b27a4df4f0b45b664d21528739269a26626dbcd588cef60a5a73ecc2e51f3b0582c95cce7', 37, 1, 'token', '[]', 0, '2021-11-15 11:11:58', '2021-11-15 11:11:58', '2022-11-15 11:11:58'),
('e6906899d400f7abedb2d3379153a35f10b3bcba4257997b00d9d968ca9aa9f14c33ee5309a5c91d', 37, 1, 'token', '[]', 0, '2021-11-18 12:59:05', '2021-11-18 12:59:05', '2022-11-18 12:59:05'),
('e6b6a1650b3724e661b6faa0efc19fc22215304d1ef6c2208798226b6ce6ece8b93274d3cfe20f52', 2, 1, 'token', '[]', 0, '2021-11-11 16:46:40', '2021-11-11 16:46:40', '2022-11-11 16:46:40'),
('e6d205879c6ba537c271300145bba1391276a8a93251b76c72ad75d7b37df5dda32e831f266f55ba', 2, 1, 'token', '[]', 0, '2021-12-04 13:00:50', '2021-12-04 13:00:50', '2022-12-04 13:00:50'),
('e6d49c2df54ca25722efb0bc48e6a5344c1def423cb11171482f500ea0b0a0c7ce4040fd1820383d', 50, 1, 'token', '[]', 0, '2021-12-13 14:41:56', '2021-12-13 14:41:56', '2022-12-13 14:41:56'),
('e703a386378d8c5b4484b5d27a4e6cc9885383871995c835884fc8101743f4b4a2c7474ba62b81e4', 48, 1, 'token', '[]', 0, '2021-11-19 12:48:14', '2021-11-19 12:48:14', '2022-11-19 12:48:14'),
('e736d4be653f6fef42052dc6caeddb3a3d1a6f8d5cdae85c69e3eaf2c319e467464f1bd110cf0877', 2, 1, 'token', '[]', 0, '2021-12-06 16:11:16', '2021-12-06 16:11:16', '2022-12-06 16:11:16'),
('e754f2c1decd2994553d8bc32a13eea0ca3cabc579c75ed64e22801296ce4b7da554bdb2b06e814a', 2, 1, 'token', '[]', 0, '2021-12-07 09:34:07', '2021-12-07 09:34:07', '2022-12-07 09:34:07'),
('e77d796f7331c6d4c20d0404921b8a088690521c2f21913c0e521b303b0f00ed2f98d8de0bedfbf0', 2, 1, 'token', '[]', 0, '2021-11-27 10:22:46', '2021-11-27 10:22:46', '2022-11-27 10:22:46'),
('e78561552b888eb164e1120c5ab954a00ac04660f33badbbea1a898335e151475796dacb8967c424', 2, 1, 'token', '[]', 0, '2021-12-09 11:23:54', '2021-12-09 11:23:54', '2022-12-09 11:23:54'),
('e7dc456610da91e339b549cd5b0b4360b73ffd64664bf3150bf38f9b7e2a810af125725583e04bbe', 48, 1, 'token', '[]', 0, '2021-11-30 17:04:24', '2021-11-30 17:04:24', '2022-11-30 17:04:24'),
('e7fbd0ba6980867376c4263c5f5c931aa0edf329fa3ba55498e919ce0aa7bfaddf3776e99ed3861f', 80, 1, 'token', '[]', 0, '2021-12-21 14:42:45', '2021-12-21 14:42:45', '2022-12-21 14:42:45'),
('e8448c96508a39ffe2a61f30eac220ddb58e131b4058adeab1c22290bd537b9f641ded3bdf9260af', 2, 1, 'token', '[]', 0, '2021-11-30 14:14:43', '2021-11-30 14:14:43', '2022-11-30 14:14:43'),
('e8561fd53a4664ffa861aa0a7beafbbc07fc840148de77d9a9ce30cb95726e53d405b19d1e2e3328', 48, 1, 'token', '[]', 0, '2021-11-20 10:19:11', '2021-11-20 10:19:11', '2022-11-20 10:19:11'),
('e87f5265548b53d631ccebf0b998acfe216672c8ed864fe000d934bedf4edfca031ef3982c828be0', 31, 1, 'token', '[]', 0, '2021-11-03 10:07:14', '2021-11-03 10:07:14', '2022-11-03 10:07:14'),
('e88d7e8a0b4c4a7804fc67cb83ee2f0f8523ebf9bd34dbe46962fb75498513757a981a36b9a946e9', 80, 1, 'token', '[]', 0, '2021-12-09 18:38:50', '2021-12-09 18:38:50', '2022-12-09 18:38:50'),
('e88ea18d00478cbef746e7f0333c1628c784bb3b711c96ce141525d0ab3949f59e2924ac8424e960', 2, 1, 'token', '[]', 0, '2021-11-17 14:33:10', '2021-11-17 14:33:10', '2022-11-17 14:33:10'),
('e8dc868a8c45d78c95082b3e0bad142bbf037da680100a5e9950a474fafdca577f1fcc72fd579656', 50, 1, 'token', '[]', 0, '2021-11-24 16:43:08', '2021-11-24 16:43:08', '2022-11-24 16:43:08'),
('e8e2c4669bd09bc9f968cd0e51ad70b5726369b5f3c39bd3eb89080c4af90eaf1a4126e8ed95d3ec', 50, 1, 'token', '[]', 0, '2021-11-19 11:03:20', '2021-11-19 11:03:20', '2022-11-19 11:03:20'),
('e9269dfefab8f754035f2b8bf7cf537253c9b1b20ba307e85095e9879c3a73e023052a256be3eefd', 68, 1, 'token', '[]', 0, '2021-12-14 10:23:00', '2021-12-14 10:23:00', '2022-12-14 10:23:00'),
('e9493e71d8bf2b41145e6ace4d681b4c2fecd7f335f41f670f0ba0c3678a765f6a4b3ceac2649029', 2, 1, 'token', '[]', 0, '2021-12-04 10:21:30', '2021-12-04 10:21:30', '2022-12-04 10:21:30'),
('e953881925ae1edd459fc4324c6e83588c302ccad24c764f3deeee4abebb7b1b76c36022a71ceb1b', 51, 1, 'token', '[]', 0, '2021-11-30 18:29:42', '2021-11-30 18:29:42', '2022-11-30 18:29:42'),
('e9f61f7fe426796a3f7ca89b3a9a52edb9003084b1270d2e886fba498bd036b3216c1d56afb40241', 50, 1, 'token', '[]', 0, '2021-11-30 12:00:51', '2021-11-30 12:00:51', '2022-11-30 12:00:51'),
('ea3595c2f7df63fef573a5b211e0e69321aa145a75a0e63a67b189cd31091fa3235a0899f16af4ff', 2, 1, 'token', '[]', 0, '2021-12-08 11:34:34', '2021-12-08 11:34:34', '2022-12-08 11:34:34'),
('ea493b9038acb400eaef07c2693e32955845074e155cffebf0e7c9de4177e06e750d91b91818e9f5', 68, 1, 'token', '[]', 0, '2021-12-21 15:53:27', '2021-12-21 15:53:27', '2022-12-21 15:53:27'),
('eafa78cf218510cbc894064cb07fa47ae0bfc4e11432eb123b1e1b23cfd1323f6d22bf4640a3299e', 37, 1, 'token', '[]', 0, '2021-11-17 18:19:04', '2021-11-17 18:19:04', '2022-11-17 18:19:04'),
('eb0f33128623d9e4bf3e5500b0247df2134daea6801ff818ea065133695e4785969f4cfbb2f27677', 2, 1, 'token', '[]', 0, '2021-12-02 14:48:20', '2021-12-02 14:48:20', '2022-12-02 14:48:20'),
('eb798e4dda263959f28aed4cb51f57b425f0d8a6b63c325c0d90aacadd5e9a942aa09fd405f39e28', 50, 1, 'token', '[]', 0, '2021-12-02 17:48:01', '2021-12-02 17:48:01', '2022-12-02 17:48:01'),
('ebe161886805515d507ce7bbef60d54969cf664e4f2ed889ecc2c9a3b1ada9d7a770db4ab5f9e11b', 2, 1, 'token', '[]', 0, '2021-12-08 12:34:44', '2021-12-08 12:34:44', '2022-12-08 12:34:44'),
('ebf42495701c910ca44898e669077ace4afa87d68e52dd94957c34360357d0bc4ff02e5f96cd2bcf', 2, 1, 'token', '[]', 0, '2021-11-30 10:04:42', '2021-11-30 10:04:42', '2022-11-30 10:04:42'),
('ec45fb330bfc684c942461e17de2195163435e0645be28bac1d2101478b3928439784a00401a9324', 2, 1, 'token', '[]', 0, '2021-12-06 16:08:55', '2021-12-06 16:08:55', '2022-12-06 16:08:55'),
('ec47810849d5b9d0e90f35465e5024dcdcd2388ae9aa8714f88bfbf44f001321b9340dc9e720c094', 48, 1, 'token', '[]', 0, '2021-11-29 12:39:28', '2021-11-29 12:39:28', '2022-11-29 12:39:28'),
('ec7848e26b15d3e08f6f8d1dd1609b03ee1a48fec649fc63193252099c3ca36bc8850e815586aa50', 2, 1, 'token', '[]', 0, '2021-11-13 11:43:15', '2021-11-13 11:43:15', '2022-11-13 11:43:15'),
('ecb5f427556509917c98baa763fd3245d5b8bf66f798ec80341af214ba009bb96bd6c84110ba579e', 2, 1, 'token', '[]', 0, '2021-11-29 15:28:26', '2021-11-29 15:28:26', '2022-11-29 15:28:26'),
('ecd37c5f25fa1839090f0552e06f4aeb3641030074c899dfcdc202617d354e059c699c2c75b3168c', 37, 1, 'token', '[]', 0, '2021-11-18 10:39:56', '2021-11-18 10:39:56', '2022-11-18 10:39:56'),
('ed107d831debd240b83c88ea2b0c25e4a18f934ebbea0d898958c9b72404709f3bcc40b62151c59f', 50, 1, 'token', '[]', 0, '2021-12-01 09:58:18', '2021-12-01 09:58:18', '2022-12-01 09:58:18'),
('ed7f8a1ce3e95f7aa15191698e4b6b09d8d891019b1eb2e9bffd9146c27766d03fdfd0030ad6d4e8', 2, 1, 'token', '[]', 0, '2021-12-14 11:28:05', '2021-12-14 11:28:05', '2022-12-14 11:28:05'),
('ed8e593f26d2280486128b1afe40fdfc89c410a6de6f54b97f6ee6fe08b4e4926150c4be19182d4b', 50, 1, 'token', '[]', 0, '2021-11-18 17:01:53', '2021-11-18 17:01:53', '2022-11-18 17:01:53'),
('edaf0e16d0adcc08a25b6a592018052cfa146833b0b14cb66515c433fc9b15eeedceaaa0f2cdd7b8', 2, 1, 'token', '[]', 0, '2021-11-26 16:14:47', '2021-11-26 16:14:47', '2022-11-26 16:14:47'),
('edb61a704edbf1f0afb2f82cfaa16ca9a8ce39b6f6805b847ef0bf13d37da63748ea7c888227a0ce', 50, 1, 'token', '[]', 0, '2021-12-13 11:37:27', '2021-12-13 11:37:27', '2022-12-13 11:37:27'),
('ee1207ce215dfdf7ed1e4b71625612f1ce4835df10092efc5f3954ea8a1c49e0eb6b8b0200be63a3', 2, 1, 'token', '[]', 0, '2021-11-23 11:51:37', '2021-11-23 11:51:37', '2022-11-23 11:51:37'),
('ee4d6e9ac100e60d5658f014d0c6fecfb41750ed9cbb17aecc2728b81f784b050b93751391b136ba', 2, 1, 'token', '[]', 0, '2021-12-08 10:14:39', '2021-12-08 10:14:39', '2022-12-08 10:14:39'),
('ee62f1d1d098204725dd74039a2b94093db21903864737ceb8421483360234bd5ddfe3a5bd1e9df0', 37, 1, 'token', '[]', 0, '2021-11-17 18:18:10', '2021-11-17 18:18:10', '2022-11-17 18:18:10'),
('ee6ed0b6dfd3e23af014204d429c464102fb1c1e658e26da879dca07092a5086982ca7a7ce882dce', 50, 1, 'token', '[]', 0, '2021-12-13 12:32:16', '2021-12-13 12:32:16', '2022-12-13 12:32:16'),
('ee7752e65ab416a402a41c1cd205914dc06e9757acc80dd42a079d1f3a3e3ebdea047fcdd4b12ec7', 2, 1, 'token', '[]', 0, '2021-12-06 11:02:10', '2021-12-06 11:02:10', '2022-12-06 11:02:10'),
('ee886a2deaac7ad099f31bec1fbf23964b8245e1a8af46a75814a81e3853acb1fc38763aee4d0049', 80, 1, 'token', '[]', 0, '2021-12-17 18:02:03', '2021-12-17 18:02:03', '2022-12-17 18:02:03'),
('eeea6a1dc38cc3b708d774c0dff4e1da0c811afcf213db9b50318a1ed1b99b9b57c0a22d83306fde', 80, 1, 'token', '[]', 0, '2021-12-16 16:57:38', '2021-12-16 16:57:38', '2022-12-16 16:57:38'),
('ef2adf6198a28287d444479dbee5986a66f661b28d79d05338f106cf747a2c395f2326099ef8c829', 50, 1, 'token', '[]', 0, '2021-11-29 17:27:34', '2021-11-29 17:27:34', '2022-11-29 17:27:34'),
('ef4d333afdbe8880f8b3b77bb666078b277627f898ccec9d0cf1372be94fdb8d33cb21e9ff7cc61c', 2, 1, 'token', '[]', 0, '2021-12-14 10:36:28', '2021-12-14 10:36:28', '2022-12-14 10:36:28'),
('ef96078d1b935b3293a8755ef9f8e43274e202acf40083ffeb88b8d380e6873b00d810c256a43209', 2, 1, 'token', '[]', 0, '2021-11-24 16:11:38', '2021-11-24 16:11:38', '2022-11-24 16:11:38'),
('efb2c3192d27fe5d2db5954ff6fab08a567c5e4129ab5905c0e702cb23e50dfe95bad66ddc9c77be', 48, 1, 'token', '[]', 0, '2021-11-20 10:19:06', '2021-11-20 10:19:06', '2022-11-20 10:19:06'),
('efd646d5f30d50e0835487944fdddd9901786db859978cd093b88caa2d269c32d2e12f76570dc833', 2, 1, 'token', '[]', 0, '2021-11-29 10:17:30', '2021-11-29 10:17:30', '2022-11-29 10:17:30'),
('f0550cab61854b72d7d11d677542ff5848dc21de67938b61c7af8f339c49a0d1ac45c1b45193a49a', 61, 1, 'token', '[]', 0, '2021-12-01 10:26:12', '2021-12-01 10:26:12', '2022-12-01 10:26:12'),
('f0768a8990007c8d51d916c53fb8ee8adfce5d78dd4c3d767879212af57043ae8226adc3334de778', 50, 1, 'token', '[]', 0, '2021-11-24 17:58:00', '2021-11-24 17:58:00', '2022-11-24 17:58:00'),
('f0b9f99588b8ddbfefba8df450152102d9ebe35d1c5dbe4a361728f6f6f329717361f5ee5c0960d3', 2, 1, 'token', '[]', 0, '2021-12-14 12:16:38', '2021-12-14 12:16:38', '2022-12-14 12:16:38'),
('f0d5533c9a018c590477f5edf99889606787b0ddc86767701f75e7a328792e4912645c82b2356bf0', 80, 1, 'token', '[]', 0, '2021-12-07 10:24:28', '2021-12-07 10:24:28', '2022-12-07 10:24:28'),
('f0f23960369f410419c645864a9a39ad9b1de5afbfe9188524a13aea50ca2263c18f0333900b648a', 2, 1, 'token', '[]', 0, '2021-12-07 17:06:40', '2021-12-07 17:06:40', '2022-12-07 17:06:40'),
('f1670a9c88df39dc4869422cbad0418d9f8aff381594746861bdd1e499fadd88494e211bc8287ce8', 2, 1, 'token', '[]', 0, '2021-11-16 10:03:35', '2021-11-16 10:03:35', '2022-11-16 10:03:35'),
('f1c55d474dd33f34aa3f904ee72c21641d6a12a9183c55b8301705c288bee261fec1ae83610a32d6', 37, 1, 'token', '[]', 0, '2021-11-18 10:34:15', '2021-11-18 10:34:15', '2022-11-18 10:34:15'),
('f23d2980f03652aec5625c6d966293c2ded4a8f2fe31114a09ed2d5ea39d6ed18cb27e04338f5ab2', 2, 1, 'token', '[]', 0, '2021-12-08 15:03:39', '2021-12-08 15:03:39', '2022-12-08 15:03:39'),
('f2ccfd466e103c4df05944cb239e6ae6b59d30192e6214724daf7c5950e54c9bce0bb11e638b587e', 80, 1, 'token', '[]', 0, '2021-12-10 11:06:50', '2021-12-10 11:06:50', '2022-12-10 11:06:50'),
('f2ef1813ffc0ad8ebe31f2e51dbcc5b97d65934da3e2a7d366dba0cb99e6cbfb73d483e17a131ed8', 2, 1, 'token', '[]', 0, '2021-11-19 17:47:30', '2021-11-19 17:47:30', '2022-11-19 17:47:30'),
('f2fdda0184c0a528aab6bf179f09cdc7638557c188bd5d9bfda707b21972a23fabfb38a1574701f6', 50, 1, 'token', '[]', 0, '2021-11-22 11:25:16', '2021-11-22 11:25:16', '2022-11-22 11:25:16'),
('f31451e86468c96e1ac4e789ac708fcdfac9017d1162522b39968026d594605d59ea0f16055d80a2', 2, 1, 'token', '[]', 0, '2021-11-26 18:56:53', '2021-11-26 18:56:53', '2022-11-26 18:56:53'),
('f314d2fc8010253c3aae22dc8fa35c68267ce17840e19352281048a6579a5eed9cabe8f908ad0839', 37, 1, 'token', '[]', 0, '2021-11-18 14:57:41', '2021-11-18 14:57:41', '2022-11-18 14:57:41'),
('f36fa55007ba4e05bdb121849b2ff31d0a451dc3da0fbbedbf99679632bb1711576018766dc012a3', 50, 1, 'token', '[]', 0, '2021-12-01 14:40:52', '2021-12-01 14:40:52', '2022-12-01 14:40:52'),
('f3a2f81f5e9190328431ce542df9c4c7017a994ade630319f4df249a205aa6fa90c2b35811f8fc82', 50, 1, 'token', '[]', 0, '2021-12-13 14:55:04', '2021-12-13 14:55:04', '2022-12-13 14:55:04'),
('f3b134b3f53281fe87553c209e770b7b24efb76a92979b7848159405e64d78c1ac0d097f54fa8b3c', 68, 1, 'token', '[]', 0, '2021-12-14 15:19:39', '2021-12-14 15:19:39', '2022-12-14 15:19:39'),
('f3baee595df755776ebfd73e5e25786b01ab9abfb6440768378e034fbefe7963032333b5c260b4a8', 2, 1, 'token', '[]', 0, '2021-12-08 13:53:40', '2021-12-08 13:53:40', '2022-12-08 13:53:40'),
('f3d7c4fec9944b3ad1af59e7c588b819bc30c5a758e94d4d115331e7a6ced3fdcb91dd5370099d55', 2, 1, 'token', '[]', 0, '2021-12-07 09:21:54', '2021-12-07 09:21:54', '2022-12-07 09:21:54'),
('f3e2434324346cc911301beccd280f1d1e0f14f08f3f595f55dd45a5459f0395c55e81c47a9973e9', 37, 1, 'token', '[]', 0, '2021-11-16 10:53:13', '2021-11-16 10:53:13', '2022-11-16 10:53:13'),
('f3e471b8876fb25ced2e81f0dcadef65d285921d84b67b8ade9cc9d53971f27f9f8d3aed4ce8b6d3', 80, 1, 'token', '[]', 0, '2021-12-10 18:20:15', '2021-12-10 18:20:15', '2022-12-10 18:20:15'),
('f40a665aef4cdaee76fe022e4325a16935d7ee1e8cc2b6f8a83ba385944de036883bad660528f1f3', 2, 1, 'token', '[]', 0, '2021-12-10 16:24:10', '2021-12-10 16:24:10', '2022-12-10 16:24:10'),
('f436092a6bd3d803f95d10543de54d0ecff6b473a4d9548a69ee633f8664580da841cbe65a61e99d', 2, 1, 'token', '[]', 0, '2021-12-14 11:18:32', '2021-12-14 11:18:32', '2022-12-14 11:18:32'),
('f44b17fd591b8c4be41b07edc812607c3f8d56e17485303909a2d47815a80d23c2d624db5993a6fa', 80, 1, 'token', '[]', 0, '2021-12-16 12:57:50', '2021-12-16 12:57:50', '2022-12-16 12:57:50'),
('f482aaf665b185f8aa69f78d9756467b6d3e76561af7f3e772ff586df28ccef83e1debf4348ad784', 37, 1, 'token', '[]', 0, '2021-11-18 10:48:56', '2021-11-18 10:48:56', '2022-11-18 10:48:56'),
('f484220bc0188c70530729cc3aa735a375ec1869f30e98f9738bb312f35a5d5086fbefd23e528e59', 48, 1, 'token', '[]', 0, '2021-11-20 10:50:01', '2021-11-20 10:50:01', '2022-11-20 10:50:01'),
('f4c3193be5dd07af92d6e7f8fd5c22e207aed2934039770d8094cc2b6c47d3226ac19b9d06bb3970', 37, 1, 'token', '[]', 0, '2021-11-18 16:02:27', '2021-11-18 16:02:27', '2022-11-18 16:02:27'),
('f4cba83861996cc774bc7446e196d63ad51ba3790392016be9e4c40ce5d36b058372046bf9ce9043', 2, 1, 'token', '[]', 0, '2021-12-09 11:20:11', '2021-12-09 11:20:11', '2022-12-09 11:20:11'),
('f4ead957f1fe9c98886018904af9c81bf2cdf67bfe46d0d668bb80c044507ced0ab52ac65b6a6483', 50, 1, 'token', '[]', 0, '2021-11-23 17:27:23', '2021-11-23 17:27:23', '2022-11-23 17:27:23'),
('f50b6056d103645ec079878cb33ad11d30a25999dffa3eb3143fa3fa4c75b3e0bcf35b9c8543afdc', 2, 1, 'token', '[]', 0, '2021-11-26 17:55:04', '2021-11-26 17:55:04', '2022-11-26 17:55:04'),
('f50de4cfb7168db41024dcf41ac4172f6f010556c41e19e15f50688f2ccc0b5b797f485dadfdadb9', 2, 1, 'token', '[]', 0, '2021-11-29 14:28:14', '2021-11-29 14:28:14', '2022-11-29 14:28:14'),
('f521eece7cd015bba975f20da97415385c67e649966437bf8f4d130f32fddcf0b59cfa4e12daac24', 2, 1, 'token', '[]', 0, '2021-06-19 18:55:30', '2021-06-19 18:55:30', '2022-06-19 18:55:30'),
('f52a89f30c03fc6ce0d449f7e17eec7568df3492b6f542c19a01bc5784d8b8698a32adf6d6cf7278', 50, 1, 'token', '[]', 0, '2021-12-01 16:08:18', '2021-12-01 16:08:18', '2022-12-01 16:08:18'),
('f543e249ef2a2eee9550309efd7165d45690b289c8f526edf25989e275c7eaefc14fec7b774113ad', 2, 1, 'token', '[]', 0, '2021-11-11 16:12:48', '2021-11-11 16:12:48', '2022-11-11 16:12:48'),
('f58644f823888cb49e0b906a78ca2c26937b2cc8d48e9014004102a024d333604a0bfb68069d2135', 2, 1, 'token', '[]', 0, '2021-11-23 17:55:32', '2021-11-23 17:55:32', '2022-11-23 17:55:32'),
('f5b5184a94cf0d7346d43443f574b7ac716f3e1ec3498d1b363a7af03e9688f34e0d989be9e8fafd', 2, 1, 'token', '[]', 0, '2021-12-13 15:25:05', '2021-12-13 15:25:05', '2022-12-13 15:25:05'),
('f5bc287eb4cc79b3aab1e842a98b963960756035d6386f02e74135c26483725b45b540bc299727c7', 50, 1, 'token', '[]', 0, '2021-11-30 13:01:06', '2021-11-30 13:01:06', '2022-11-30 13:01:06'),
('f5c9ad329efff2421e4b2295279bfa32f85a736577475da5a77897093189f3833e13117bf4628ee7', 2, 1, 'token', '[]', 0, '2021-12-13 14:52:19', '2021-12-13 14:52:19', '2022-12-13 14:52:19'),
('f5e0bb58cd80361373659598a38f91f2211a7ab7aaa47e00e1d5b7762d3ff39f0406c622457a64ac', 50, 1, 'token', '[]', 0, '2021-12-13 11:37:24', '2021-12-13 11:37:24', '2022-12-13 11:37:24'),
('f5f993bab06a3b3acab78bf474aed816a0abc2ab883b5d2381e8a4a8ecf7c427608b5b48decbb881', 37, 1, 'token', '[]', 0, '2021-11-17 18:09:22', '2021-11-17 18:09:22', '2022-11-17 18:09:22'),
('f5fa2733a6cdc7994306433da7050e9c3c5035599c1eb40fe7b001587a03fb89ab3d2dee59af92c4', 50, 1, 'token', '[]', 0, '2021-11-24 16:53:35', '2021-11-24 16:53:35', '2022-11-24 16:53:35'),
('f6372f7cd077b396745ddf08fcf5b6e6f670820ff924bd7eb0f73bea107fc289c8744ecc6fa2cdaa', 50, 1, 'token', '[]', 0, '2021-11-30 15:30:15', '2021-11-30 15:30:15', '2022-11-30 15:30:15'),
('f6783e57fc70d3621c9231d6b7419301607dc6663c63eb9d6e07d03a189adc060f8902974b8ca5b3', 2, 1, 'token', '[]', 0, '2021-12-06 16:11:39', '2021-12-06 16:11:39', '2022-12-06 16:11:39'),
('f67905ba48b5521a0d60cf8428615b15e77ca59b2d682245217ffad398b15c11222c8a0eb90f6f01', 37, 1, 'token', '[]', 0, '2021-11-17 18:25:18', '2021-11-17 18:25:18', '2022-11-17 18:25:18'),
('f6921e08f2b9b76f8710f8a42f10d32cd10febfb8de0257ef1c15abee84d8b4ed207a1c98b8adf03', 80, 1, 'token', '[]', 0, '2021-12-06 18:49:26', '2021-12-06 18:49:26', '2022-12-06 18:49:26'),
('f69d5b927c6d7a5783cb72321d94fdcf77713f1aa2816a14842e9f85541a400c0e6c8873cf50de02', 50, 1, 'token', '[]', 0, '2021-11-30 10:41:50', '2021-11-30 10:41:50', '2022-11-30 10:41:50'),
('f6a20df850e16d17179bac26adaf4a7e61f070637291738abdb6b1370fbc51226a2d63568aadfe19', 48, 1, 'token', '[]', 0, '2021-11-18 18:26:29', '2021-11-18 18:26:29', '2022-11-18 18:26:29'),
('f705c633a5ebad17340b6d1a36ab12855c3347b6e832b2d20f964a11c2db99d609f0f1bc92fd0c83', 37, 1, 'token', '[]', 0, '2021-11-17 15:44:02', '2021-11-17 15:44:02', '2022-11-17 15:44:02'),
('f7372dc521c562b39ecec85d8eb54c232f8922dbe88cf535faf4e926ee37b5a1b2ab9b7ee9283a6f', 50, 1, 'token', '[]', 0, '2021-11-26 15:38:40', '2021-11-26 15:38:40', '2022-11-26 15:38:40'),
('f7408e4a02c7f0eba661accaeb3b7dd5e9c8bd17685961196aefac2e6ee594ce84c966df47855199', 2, 1, 'token', '[]', 0, '2021-12-13 12:57:40', '2021-12-13 12:57:40', '2022-12-13 12:57:40'),
('f77c7282033760e1c812777be22f2cc44ad74c351fdac4fd93e25eb4d8e6ad6bc94b5f4c5f53862e', 50, 1, 'token', '[]', 0, '2021-11-22 12:06:05', '2021-11-22 12:06:05', '2022-11-22 12:06:05'),
('f7bbb6b3ea33448ca9b30d9b2f8b45c2e0b83302506b5a64b0c5b09353524b9b473f7ae07a06948c', 1, 1, 'token', '[]', 0, '2021-12-01 09:40:09', '2021-12-01 09:40:09', '2022-12-01 09:40:09'),
('f8335eaac12c3313b3211e4730026461b48c988f570f315bb1e8acff3fbbb40592a1fca6a90d7575', 51, 1, 'token', '[]', 0, '2021-11-30 17:36:10', '2021-11-30 17:36:10', '2022-11-30 17:36:10'),
('f83f7683dc804d4eb6b3b22999fc5f71e4dbe7d64fefb048a0fee145903b304ee5f441b5da6edeb7', 50, 1, 'token', '[]', 0, '2021-11-30 12:24:25', '2021-11-30 12:24:25', '2022-11-30 12:24:25'),
('f88704f85ba274c5392228e06c951f04d1633191a6e355e3af4b47d2813d9adae869943d49df15fc', 2, 1, 'token', '[]', 0, '2021-12-07 18:03:25', '2021-12-07 18:03:25', '2022-12-07 18:03:25'),
('f8a3c858c3c11220fbdac3df615b9d197fbafb50edddd20f121db94ed42daff7d90c142d67d92e0b', 72, 1, 'token', '[]', 0, '2021-12-03 10:06:19', '2021-12-03 10:06:19', '2022-12-03 10:06:19'),
('f8b2df0607302dcf85d0f0b3ae442cec6ab0f3432d5a974309720cc8831739023e7b525180de87c0', 2, 1, 'token', '[]', 0, '2021-12-10 10:46:06', '2021-12-10 10:46:06', '2022-12-10 10:46:06'),
('f8c2d2c837bb46d16aae2c76e1d15e036892b183e0549d2d34a90d7676dea09cd086bb30633e57f3', 2, 1, 'token', '[]', 0, '2021-11-26 19:25:27', '2021-11-26 19:25:27', '2022-11-26 19:25:27'),
('f8d5a963fe6343dc6bb996ab65feca6e60dff13a337cd42ce5fbbf128961039b2baed26e0d1e931e', 48, 1, 'token', '[]', 0, '2021-11-30 17:04:57', '2021-11-30 17:04:57', '2022-11-30 17:04:57'),
('f9dbf6dbc48ee6496652dd4b33dcbdb96f72282bdf2ed4753f6fbf42c6e6563012ac0c546c00251a', 68, 1, 'token', '[]', 0, '2021-12-14 15:07:18', '2021-12-14 15:07:18', '2022-12-14 15:07:18'),
('f9e4f238cd69da3ed94585fe8da9762e789cceeca641844cc484bb91a3058804de1d525620633c43', 80, 1, 'token', '[]', 0, '2021-12-21 14:40:35', '2021-12-21 14:40:35', '2022-12-21 14:40:35'),
('f9f28daf07138a90e185b87d0ba7334f8cb38f358a6e3528ba75c5b0257ee99996e9de339a94c490', 2, 1, 'token', '[]', 0, '2021-12-10 16:20:52', '2021-12-10 16:20:52', '2022-12-10 16:20:52'),
('f9faae46acb2fe3b45495432c0ecdd3405aa6687e48fe79836eed1a7f9f88e922df0fd96dc0635dd', 80, 1, 'token', '[]', 0, '2021-12-21 14:04:31', '2021-12-21 14:04:31', '2022-12-21 14:04:31'),
('fa1c25703e15dbbd685a1c4de68241db2bff8070775168712cca077338e3ce68133d5be74ba17304', 80, 1, 'token', '[]', 0, '2021-12-07 10:35:57', '2021-12-07 10:35:57', '2022-12-07 10:35:57'),
('fa412d382d128c09649a79fbf82d708c46e2a9c187250fedb580007bbccc3b56d6af4dbefeeb7883', 50, 1, 'token', '[]', 0, '2021-11-20 12:08:11', '2021-11-20 12:08:11', '2022-11-20 12:08:11'),
('fa4a02ba78dfefbafb58cb968b42ca020de30a70d15e2846e80cbc036de3225a50b20b331c382a01', 48, 1, 'token', '[]', 0, '2021-11-20 09:37:29', '2021-11-20 09:37:29', '2022-11-20 09:37:29');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('fa98f7b0663b8760f30d1db975e3573ca34e66755131e9c89a7c0cf87ebec0704cd05ea3387b9edd', 61, 1, 'token', '[]', 0, '2021-12-03 12:03:52', '2021-12-03 12:03:52', '2022-12-03 12:03:52'),
('fad15c9406da52237beabb808fca3a3cf3163b529e0b736c7ce800e45decd89b8a3fa0945d7b4b1e', 50, 1, 'token', '[]', 0, '2021-11-29 18:08:01', '2021-11-29 18:08:01', '2022-11-29 18:08:01'),
('fae622873f3aa72b055f0c1c86437014f8b4462484c2a62570588a617259d1936b55e836bedc65d0', 2, 1, 'token', '[]', 0, '2021-12-08 10:20:40', '2021-12-08 10:20:40', '2022-12-08 10:20:40'),
('faf5c255fe86f6f586271aef119b7d733f9b6fe67ec459a00b9dc94ef0a686e04eae3fa96e033a6e', 51, 1, 'token', '[]', 0, '2021-11-30 17:59:55', '2021-11-30 17:59:55', '2022-11-30 17:59:55'),
('fb05650cf004949fed101e2663b91d4b9491f6f137946417c7e040b9f219baac917737babb7cee72', 80, 1, 'token', '[]', 0, '2021-12-21 14:04:24', '2021-12-21 14:04:24', '2022-12-21 14:04:24'),
('fb06f11be81e8be754866522ed2930b058e3480ce112d5b3a1b6cad067add9b70791c1703156d91d', 2, 1, 'token', '[]', 0, '2021-11-29 12:47:29', '2021-11-29 12:47:29', '2022-11-29 12:47:29'),
('fb2f8e0f9aa5c91debf7e3f18d9b73f6c72da75035c65c40f678d7cafbb928b6ae3c5bc8ba9bbad0', 2, 1, 'token', '[]', 0, '2021-12-09 18:58:03', '2021-12-09 18:58:03', '2022-12-09 18:58:03'),
('fb3d5b91f33fdd440f223eb2ad5696149ae526f03b995b8496d393cb1600ac8722993368dcdc103a', 50, 1, 'token', '[]', 0, '2021-11-20 14:03:10', '2021-11-20 14:03:10', '2022-11-20 14:03:10'),
('fbac6e7fbd7e0dc34fc1b53302b19b5f692c675a1217325ca4ac81814bfd4ea4a8ec478f5a557d37', 50, 1, 'token', '[]', 0, '2021-11-30 11:58:40', '2021-11-30 11:58:40', '2022-11-30 11:58:40'),
('fbbd0722df211f926e68848cb1c113125871ca005adb389164456095e0a63e673bc6711a6703326b', 80, 1, 'token', '[]', 0, '2021-12-03 14:57:02', '2021-12-03 14:57:02', '2022-12-03 14:57:02'),
('fbc4a1510a62b82cfed45f5645f9c9c5c67119157f630d9b8a9501c037b0bdaa8c2c0b6c1724b644', 50, 1, 'token', '[]', 0, '2021-12-02 17:51:10', '2021-12-02 17:51:10', '2022-12-02 17:51:10'),
('fbf0f3bed6eb5fadbe37163f4002fd9fd1baeac7e55d346663e114561a8e06c43b693b069ee09ba1', 2, 1, 'token', '[]', 0, '2021-12-06 12:47:46', '2021-12-06 12:47:46', '2022-12-06 12:47:46'),
('fbf9b875eb28e58607c7428694113e184092c93a23c7a90a6d895b3f65f206481632171e6821120c', 68, 1, 'token', '[]', 0, '2021-12-21 15:23:20', '2021-12-21 15:23:20', '2022-12-21 15:23:20'),
('fc40e11db833e2a47586ab567585dcd7c2946ba08da2c354ae12213dfcebf94357de2afb6621dc88', 61, 1, 'token', '[]', 0, '2021-12-01 11:58:32', '2021-12-01 11:58:32', '2022-12-01 11:58:32'),
('fc493d8bdb8861a92d634c1ef6e87cffe0de0b957b8291b3031ef809d7c750d7ac8a813032379c3f', 68, 1, 'token', '[]', 0, '2021-12-03 13:52:12', '2021-12-03 13:52:12', '2022-12-03 13:52:12'),
('fc7983afeb12409b4def85b8d8768de8c43110b2896145b3cd78fca4efd16164df49825b6bbac90a', 48, 1, 'token', '[]', 0, '2021-11-29 11:21:20', '2021-11-29 11:21:20', '2022-11-29 11:21:20'),
('fc9f9fb2757a646204fdc746a7105a52dffc84e02af22d0fbb4a1dd9eb47358f23a13ceb24d18a1c', 50, 1, 'token', '[]', 0, '2021-11-27 18:54:59', '2021-11-27 18:54:59', '2022-11-27 18:54:59'),
('fcbb640ef32c9240fbf1a6193055131f01e6c60ac58e732fc9bc23d4f7697ffb8b611cefd02ebda3', 1, 1, 'token', '[]', 0, '2021-11-19 18:45:44', '2021-11-19 18:45:44', '2022-11-19 18:45:44'),
('fcbee3772554bc5d5fab29d9a830a71862f2f4e1ef1435e0b97012f0b982a038b1d2aeaa64706425', 48, 1, 'token', '[]', 0, '2021-11-18 18:24:12', '2021-11-18 18:24:12', '2022-11-18 18:24:12'),
('fcc2d944d986169c86243ec444ce65b5bdd8a0bcdcff5bac1d5c64e76a1601df66099c25a6722473', 2, 1, 'token', '[]', 0, '2021-11-30 12:38:06', '2021-11-30 12:38:06', '2022-11-30 12:38:06'),
('fcdf937b66379cec9fa62d2cd1d9accaabfb1d2963e8e9a2ad21275cb149839b0349c09edc9f6504', 2, 1, 'token', '[]', 0, '2021-12-10 16:23:45', '2021-12-10 16:23:45', '2022-12-10 16:23:45'),
('fcebff8e26fca402cb5b87b5472852efe6545a898c0930d6ed452bfe98148f4b27b32dd0c2460fec', 37, 1, 'token', '[]', 0, '2021-11-18 10:50:27', '2021-11-18 10:50:27', '2022-11-18 10:50:27'),
('fcfafb59add6e039707f648c4e119c7c75c54d71ca123a36bf2c4cee1ad4135d2225666708e852d8', 37, 1, 'token', '[]', 0, '2021-11-17 12:33:51', '2021-11-17 12:33:51', '2022-11-17 12:33:51'),
('fd02ad53736d5243c1581ad6d74b1baafab942b98cd1b8ca4c605f92c87234d0478bf3ad820af3fa', 2, 1, 'token', '[]', 0, '2021-11-12 12:28:02', '2021-11-12 12:28:02', '2022-11-12 12:28:02'),
('fd1bfbf8c2c4f8452a37a3f1c7e018341528255c79391f3ecdfd5b39ee1c43fb4029c2e103c266a9', 50, 1, 'token', '[]', 0, '2021-11-30 19:11:40', '2021-11-30 19:11:40', '2022-11-30 19:11:40'),
('fdcafff7955a0c8d1ca386316b3c39b486e49e4a6ba14a56ad3f676bd96f7f7b2390dd99e9b5d3cc', 37, 1, 'token', '[]', 0, '2021-11-18 10:58:04', '2021-11-18 10:58:04', '2022-11-18 10:58:04'),
('fddde74beab72d1ece140186147180699aea66dbe78d606f219eb717761aba6b317bac1aceea13bc', 37, 1, 'token', '[]', 0, '2021-11-13 16:31:59', '2021-11-13 16:31:59', '2022-11-13 16:31:59'),
('fddf1cca18698fe3de8aaa218fc3ee628fe861bbbec858104811334c1c5e7ce6d74219280821738d', 80, 1, 'token', '[]', 0, '2021-12-06 18:56:43', '2021-12-06 18:56:43', '2022-12-06 18:56:43'),
('fddf870f62536ee5ba56daa50a9e062d49ef005d6a9c2352116c656b5cf80bd2f57214896849a421', 72, 1, 'token', '[]', 0, '2021-12-03 10:06:13', '2021-12-03 10:06:13', '2022-12-03 10:06:13'),
('fdf7c8c01aae4819c56228bddd10991a8e27043211d38acbcdcaa92a221ccd252b9f45fd6741b6f0', 2, 1, 'token', '[]', 0, '2021-12-07 18:04:48', '2021-12-07 18:04:48', '2022-12-07 18:04:48'),
('fe3e5fd5e3c3fb65354809e5a5adf58c8371cd9f1ac256201a461c60b67d4f8cb13fd240086fd02b', 48, 1, 'token', '[]', 0, '2021-11-20 10:49:54', '2021-11-20 10:49:54', '2022-11-20 10:49:54'),
('fe64b78bf915c393a8e8deb79cff760a0b9c65c7290cdc10e257cc4dee3069465d8666b33d29c581', 80, 1, 'token', '[]', 0, '2021-12-10 17:08:46', '2021-12-10 17:08:46', '2022-12-10 17:08:46'),
('fee4d68b2e64703868f15a8f4ff0f0d22162111b5428f23bc544fee8202eb0826e596fa31cb11d71', 2, 1, 'token', '[]', 0, '2021-12-08 15:55:48', '2021-12-08 15:55:48', '2022-12-08 15:55:48'),
('fefea3b3b89d2e063e256a896f1ce4e0358d164d2b8c327befa2cdd0c6a61ad4d82fdb74cb7dde0b', 2, 1, 'token', '[]', 0, '2021-11-02 18:07:33', '2021-11-02 18:07:33', '2022-11-02 18:07:33'),
('ff128cf6cf77ae04aebae8dd472fc5ecfbd72714ec6aef7e54f574aea39e2be4022fea0b9dc0d79c', 80, 1, 'token', '[]', 0, '2021-12-10 18:03:13', '2021-12-10 18:03:13', '2022-12-10 18:03:13'),
('ff285667d14319d57a0a3bc2cbc6798c14177e0d5dde4b4ae2f577967a422bfaa60407e40912a30d', 2, 1, 'token', '[]', 0, '2021-12-08 15:12:43', '2021-12-08 15:12:43', '2022-12-08 15:12:43'),
('ff4b3870089f019dc719e4137085c8f2697da5b956e97415fcf4f65d593d80353ede08d5213f0918', 68, 1, 'token', '[]', 0, '2021-12-03 13:18:27', '2021-12-03 13:18:27', '2022-12-03 13:18:27'),
('ff86896888ffc190fca83d2249a382fc2285d8d97245afa5401fd3a759671e1fa51bec4a0f4a8365', 2, 1, 'token', '[]', 0, '2021-12-06 15:52:22', '2021-12-06 15:52:22', '2022-12-06 15:52:22'),
('ffb29964ba22a9c7f042c8aa3a0a42ede18d615462926ccaf6159b0e736d4d3f24df1f8bafa441a8', 50, 1, 'token', '[]', 0, '2021-11-30 10:27:17', '2021-11-30 10:27:17', '2022-11-30 10:27:17');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'KM0Ibsw47XWFhuBxsBdLUSuDY97epilSaZlqU72D', NULL, 'http://localhost', 1, 0, 0, '2021-05-25 02:14:22', '2021-05-25 02:14:22'),
(2, NULL, 'Laravel Password Grant Client', 'qAtMRgb4oCqL5U1E5Z43MpBYa2RSI6Pp40HMabYT', 'users', 'http://localhost', 0, 1, 0, '2021-05-25 02:14:22', '2021-05-25 02:14:22');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(11) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2021-05-25 02:14:22', '2021-05-25 02:14:22');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `cart_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_price` float NOT NULL,
  `price_without_delivery` float NOT NULL,
  `total_products_mrp` float NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paid_by_wallet` float NOT NULL DEFAULT 0,
  `rem_price` float NOT NULL DEFAULT 0,
  `avg_tax_per` float DEFAULT NULL,
  `total_tax_price` float DEFAULT NULL,
  `order_date` date NOT NULL,
  `delivery_date` date NOT NULL,
  `delivery_charge` float NOT NULL DEFAULT 0,
  `time_slot` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dboy_id` int(11) NOT NULL DEFAULT 0,
  `order_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending',
  `user_signature` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelling_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_id` int(11) NOT NULL DEFAULT 0,
  `coupon_discount` float NOT NULL DEFAULT 0,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancel_by_store` int(11) NOT NULL DEFAULT 0,
  `dboy_incentive` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_by_photo`
--

CREATE TABLE `order_by_photo` (
  `ord_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `list_photo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `delivery_date` date NOT NULL,
  `processed` int(11) NOT NULL DEFAULT 0,
  `reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payout_requests`
--

CREATE TABLE `payout_requests` (
  `req_id` int(11) NOT NULL,
  `store_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payout_amt` float NOT NULL,
  `req_date` date NOT NULL,
  `complete` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payout_req_valid`
--

CREATE TABLE `payout_req_valid` (
  `val_id` int(11) NOT NULL,
  `min_amt` int(11) NOT NULL,
  `min_days` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payout_req_valid`
--

INSERT INTO `payout_req_valid` (`val_id`, `min_amt`, `min_days`) VALUES
(1, 100, 10);

-- --------------------------------------------------------

--
-- Table structure for table `plan_buy_history`
--

CREATE TABLE `plan_buy_history` (
  `wallet_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` date NOT NULL,
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `before_recharge` int(11) DEFAULT NULL,
  `after_recharge` int(11) DEFAULT NULL,
  `payment_gateway` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Regular',
  `hide` int(11) NOT NULL DEFAULT 0,
  `added_by` int(11) NOT NULL DEFAULT 0,
  `approved` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `image_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `product_rating`
--

CREATE TABLE `product_rating` (
  `rate_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `varient_id` int(11) NOT NULL,
  `rating` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_varient`
--

CREATE TABLE `product_varient` (
  `varient_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_mrp` float DEFAULT NULL,
  `base_price` float NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `varient_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ean` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approved` int(11) NOT NULL DEFAULT 1,
  `added_by` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `razorpay_key`
--

CREATE TABLE `razorpay_key` (
  `key_id` int(11) NOT NULL,
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `razorpay_key`
--

INSERT INTO `razorpay_key` (`key_id`, `api_key`) VALUES
(1, 'rzp_test_K4YMcaRBxfhthfgh');

-- --------------------------------------------------------

--
-- Table structure for table `recent_search`
--

CREATE TABLE `recent_search` (
  `id` int(11) NOT NULL,
  `keyword` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reedem_values`
--

CREATE TABLE `reedem_values` (
  `reedem_id` int(11) NOT NULL,
  `reward_point` int(100) NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reedem_values`
--

INSERT INTO `reedem_values` (`reedem_id`, `reward_point`, `value`) VALUES
(1, 2, '0.50');

-- --------------------------------------------------------

--
-- Table structure for table `referral_points`
--

CREATE TABLE `referral_points` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `points` varchar(255) NOT NULL,
  `created_at` varchar(255) NOT NULL,
  `updated_at` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `referral_points`
--

INSERT INTO `referral_points` (`id`, `name`, `points`, `created_at`, `updated_at`) VALUES
(5, 'Registration Referral', '{\"min\":\"1\",\"max\":\"15\"}', '2021-12-17 09:50:21', '2021-01-25 13:17:36');

-- --------------------------------------------------------

--
-- Table structure for table `reward_points`
--

CREATE TABLE `reward_points` (
  `reward_id` int(11) NOT NULL,
  `min_cart_value` int(100) NOT NULL,
  `reward_point` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reward_points`
--

INSERT INTO `reward_points` (`reward_id`, `min_cart_value`, `reward_point`) VALUES
(3, 10, 1),
(4, 1000, 450);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dashboard` int(11) NOT NULL DEFAULT 0,
  `tax` int(11) NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL DEFAULT 0,
  `membership` int(11) NOT NULL DEFAULT 0,
  `reports` int(11) NOT NULL DEFAULT 0,
  `notification` int(11) NOT NULL DEFAULT 0,
  `users` int(11) NOT NULL DEFAULT 0,
  `category` int(11) NOT NULL DEFAULT 0,
  `product` int(11) NOT NULL DEFAULT 0,
  `area` int(11) NOT NULL DEFAULT 0,
  `store` int(11) NOT NULL DEFAULT 0,
  `orders` int(11) NOT NULL DEFAULT 0,
  `payout` int(11) NOT NULL DEFAULT 0,
  `rewards` int(11) NOT NULL DEFAULT 0,
  `delivery_boy` int(11) NOT NULL DEFAULT 0,
  `pages` int(11) NOT NULL DEFAULT 0,
  `feedback` int(11) NOT NULL DEFAULT 0,
  `callback` int(11) NOT NULL DEFAULT 0,
  `settings` int(11) NOT NULL DEFAULT 0,
  `reason` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `dashboard`, `tax`, `id`, `membership`, `reports`, `notification`, `users`, `category`, `product`, `area`, `store`, `orders`, `payout`, `rewards`, `delivery_boy`, `pages`, `feedback`, `callback`, `settings`, `reason`) VALUES
(1, 'sub admin', 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sec_banner`
--

CREATE TABLE `sec_banner` (
  `banner_id` int(11) NOT NULL,
  `banner_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `varient_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL,
  `qty_unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_area`
--

CREATE TABLE `service_area` (
  `ser_id` int(11) NOT NULL,
  `society_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `society_id` int(11) NOT NULL,
  `delivery_charge` float NOT NULL DEFAULT 0,
  `store_id` int(11) NOT NULL,
  `added_by` int(11) NOT NULL DEFAULT 0,
  `enabled` int(11) NOT NULL DEFAULT 1,
  `city_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(31, 'paypal_active', 'No', '2020-11-18 13:56:42', '2021-02-15 16:32:58'),
(32, 'paypal_email', 'deekhati63@gmail.com', '2020-11-18 13:56:42', '2021-02-08 15:59:27'),
(34, 'stripe_active', 'No', '2020-11-18 13:56:42', '2021-02-15 16:32:58'),
(35, 'stripe_secret_key', 'sk_test_AsWOqM4QzNC5kiiuhVaMr1mH00JC9bmg6A', '2020-11-18 13:56:42', '2021-11-19 16:47:13'),
(36, 'stripe_publishable_key', 'pk_test_c0oc159sTDjBAxK4JOCpPElA00WOC6sWJq', '2020-11-18 13:56:42', '2021-11-19 16:47:13'),
(38, 'razorpay_active', 'Yes', '2020-11-18 13:56:42', '2021-02-15 16:32:58'),
(39, 'razorpay_key_id', 'rzp_test_5eJgxBiQclifFX', '2020-11-18 13:56:42', '2021-11-19 16:47:13'),
(40, 'razorpay_secret_key', 'JmgJ4PmkG2TqCG4fBcsk15A9', '2020-11-18 13:56:42', '2021-11-19 16:47:13'),
(42, 'paystack_active', 'No', '2020-11-18 13:56:42', '2021-02-15 16:32:58'),
(43, 'paystack_public_key', 'dg', '2020-11-18 13:56:42', '2021-11-19 16:47:13'),
(44, 'paystack_secret_key', 'sdgdgdsg', '2020-11-18 13:56:42', '2021-11-19 16:47:13'),
(61, 'paypal_client_id', 'efsdgfdhdfhf', '2021-02-15 16:32:58', '2021-11-19 16:47:13'),
(62, 'paypal_secret_key', 'sdgdhfdhsfhhsf', '2021-02-15 16:32:58', '2021-11-19 16:47:13'),
(63, 'stripe_merchant_id', 'acct_1HzzheJi3WFPjQpE', '2021-03-11 15:44:01', '2021-11-19 16:47:13');

-- --------------------------------------------------------

--
-- Table structure for table `smsby`
--

CREATE TABLE `smsby` (
  `by_id` int(11) NOT NULL,
  `msg91` int(11) NOT NULL DEFAULT 1,
  `twilio` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `smsby`
--

INSERT INTO `smsby` (`by_id`, `msg91`, `twilio`, `status`) VALUES
(1, 1, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `society`
--

CREATE TABLE `society` (
  `society_id` int(11) NOT NULL,
  `society_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_id` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spotlight`
--

CREATE TABLE `spotlight` (
  `sp_id` int(11) NOT NULL,
  `p_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `id` int(11) NOT NULL,
  `store_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `employee_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N/A',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_id` int(11) NOT NULL,
  `admin_share` float NOT NULL DEFAULT 0,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `del_range` float NOT NULL,
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_approval` int(11) NOT NULL DEFAULT 1,
  `orders` int(11) NOT NULL DEFAULT 1,
  `store_status` int(11) NOT NULL DEFAULT 1,
  `store_opening_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_closing_time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_interval` int(11) NOT NULL,
  `inactive_reason` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_assign_homecat`
--

CREATE TABLE `store_assign_homecat` (
  `assign_id` int(11) NOT NULL,
  `homecat_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cat_id` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_bank`
--

CREATE TABLE `store_bank` (
  `ac_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `ac_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ifsc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `holder_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `upi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_banner`
--

CREATE TABLE `store_banner` (
  `banner_id` int(100) NOT NULL,
  `banner_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'H'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_callback_req`
--

CREATE TABLE `store_callback_req` (
  `callback_req_id` int(11) NOT NULL,
  `store_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `store_phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `processed` int(11) NOT NULL DEFAULT 0,
  `date` date NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_delivery_boy`
--

CREATE TABLE `store_delivery_boy` (
  `dboy_id` int(11) NOT NULL,
  `boy_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `boy_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `boy_city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `boy_loc` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lng` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `store_id` int(11) NOT NULL,
  `added_by` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'store',
  `ad_dboy_id` int(11) NOT NULL DEFAULT 0,
  `rem_by_admin` int(11) NOT NULL DEFAULT 0,
  `id_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_doc`
--

CREATE TABLE `store_doc` (
  `doc_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `document` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_driver_incentive`
--

CREATE TABLE `store_driver_incentive` (
  `id` int(11) NOT NULL,
  `incentive` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_earning`
--

CREATE TABLE `store_earning` (
  `id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `paid` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_homecat`
--

CREATE TABLE `store_homecat` (
  `homecat_id` int(200) NOT NULL,
  `homecat_name` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `homecat_status` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_notification`
--

CREATE TABLE `store_notification` (
  `not_id` int(11) NOT NULL,
  `not_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `not_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL,
  `read_by_store` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_orders`
--

CREATE TABLE `store_orders` (
  `store_order_id` int(11) NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `varient_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` float NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `varient_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` float NOT NULL,
  `total_mrp` float NOT NULL,
  `order_cart_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_date` datetime NOT NULL,
  `store_approval` int(11) NOT NULL DEFAULT 1,
  `store_id` int(11) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `tx_per` int(11) DEFAULT NULL,
  `price_without_tax` float DEFAULT NULL,
  `tx_price` float DEFAULT NULL,
  `tx_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Regular'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_products`
--

CREATE TABLE `store_products` (
  `p_id` int(11) NOT NULL,
  `varient_id` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `mrp` float NOT NULL,
  `price` float NOT NULL,
  `min_ord_qty` int(11) NOT NULL DEFAULT 1,
  `max_ord_qty` int(11) NOT NULL DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `store_society`
--

CREATE TABLE `store_society` (
  `store_society_id` int(11) NOT NULL,
  `society_id` int(100) NOT NULL,
  `store_id` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `tag_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `tag` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tax_types`
--

CREATE TABLE `tax_types` (
  `tax_id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tax_types`
--

INSERT INTO `tax_types` (`tax_id`, `name`) VALUES
(3, 'GST');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_referral`
--

CREATE TABLE `tbl_referral` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `referral_by` int(11) NOT NULL,
  `created_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_top_cat`
--

CREATE TABLE `tbl_top_cat` (
  `id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `cat_rank` int(11) NOT NULL,
  `created_at` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_web_setting`
--

CREATE TABLE `tbl_web_setting` (
  `set_id` int(11) NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `favicon` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_limit` int(11) NOT NULL,
  `last_loc` int(11) NOT NULL DEFAULT 0,
  `footer_text` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `live_chat` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tbl_web_setting`
--

INSERT INTO `tbl_web_setting` (`set_id`, `icon`, `name`, `favicon`, `number_limit`, `last_loc`, `footer_text`, `live_chat`) VALUES
(1, '/images/app_logo/app_icon/22-12-2021/gogrocer-new.png', 'GoGrocer', '/images/app_logo/favicon/22-12-2021/gogrocer-new.png', 10, 1, '© 2021, made with  by Tecmanic', 1);

-- --------------------------------------------------------

--
-- Table structure for table `termspage`
--

CREATE TABLE `termspage` (
  `terms_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `termspage`
--

INSERT INTO `termspage` (`terms_id`, `title`, `description`) VALUES
(1, 'Terms & Condition', '<table cellspacing=\"0\" id=\"datatables\" style=\"width:100%\">\r\n	<tbody>\r\n		<tr>\r\n			<td>&nbsp;</td>\r\n			<td>\r\n			<p><strong>Terms and Conditions</strong></p>\r\n\r\n			<p>Last Updated: 05&nbsp;May 2021</p>\r\n\r\n			<p>&nbsp;</p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>');

-- --------------------------------------------------------

--
-- Table structure for table `time_slot`
--

CREATE TABLE `time_slot` (
  `time_slot_id` int(11) NOT NULL,
  `open_hour` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `close_hour` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_slot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trending_search`
--

CREATE TABLE `trending_search` (
  `trend_id` int(11) NOT NULL,
  `varient_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `twilio`
--

CREATE TABLE `twilio` (
  `twilio_id` int(11) NOT NULL,
  `twilio_sid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `twilio_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `twilio_phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `twilio`
--

INSERT INTO `twilio` (`twilio_id`, `twilio_sid`, `twilio_token`, `twilio_phone`, `active`) VALUES
(1, 'AC3eb584f35ee74e27383ccb2', 'b47641f04f129ba6bbc2fefda269d7a8', '+1334 402 4974', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'N/A',
  `user_city` int(11) DEFAULT NULL,
  `user_area` int(11) DEFAULT NULL,
  `otp_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `wallet` float NOT NULL DEFAULT 0,
  `rewards` int(11) NOT NULL DEFAULT 0,
  `is_verified` int(11) NOT NULL DEFAULT 0,
  `block` int(11) NOT NULL DEFAULT 2,
  `reg_date` date NOT NULL,
  `app_update` int(11) NOT NULL DEFAULT 1,
  `facebook_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referral_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `membership` int(11) NOT NULL DEFAULT 0,
  `mem_plan_start` date DEFAULT NULL,
  `mem_plan_expiry` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_notification`
--

CREATE TABLE `user_notification` (
  `noti_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `noti_title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `noti_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_by_user` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_support`
--

CREATE TABLE `user_support` (
  `supp_id` int(11) NOT NULL,
  `query` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int(11) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_recharge_history`
--

CREATE TABLE `wallet_recharge_history` (
  `wallet_recharge_history` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `recharge_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` float NOT NULL,
  `payment_gateway` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_of_recharge` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `wish_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `varient_id` int(11) NOT NULL,
  `quantity` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mrp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `varient_image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `store_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aboutuspage`
--
ALTER TABLE `aboutuspage`
  ADD PRIMARY KEY (`about_id`);

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_driver_incentive`
--
ALTER TABLE `admin_driver_incentive`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_payouts`
--
ALTER TABLE `admin_payouts`
  ADD PRIMARY KEY (`payout_id`);

--
-- Indexes for table `app_link`
--
ALTER TABLE `app_link`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `app_notice`
--
ALTER TABLE `app_notice`
  ADD PRIMARY KEY (`app_notice_id`);

--
-- Indexes for table `callback_req`
--
ALTER TABLE `callback_req`
  ADD PRIMARY KEY (`callback_req_id`);

--
-- Indexes for table `cancel_for`
--
ALTER TABLE `cancel_for`
  ADD PRIMARY KEY (`res_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `varient_id` (`varient_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `cart_payments`
--
ALTER TABLE `cart_payments`
  ADD PRIMARY KEY (`py_id`);

--
-- Indexes for table `cart_rewards`
--
ALTER TABLE `cart_rewards`
  ADD PRIMARY KEY (`cart_rewards_id`);

--
-- Indexes for table `cart_status`
--
ALTER TABLE `cart_status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `city`
--
ALTER TABLE `city`
  ADD PRIMARY KEY (`city_id`);

--
-- Indexes for table `country_code`
--
ALTER TABLE `country_code`
  ADD PRIMARY KEY (`code_id`);

--
-- Indexes for table `coupon`
--
ALTER TABLE `coupon`
  ADD PRIMARY KEY (`coupon_id`);

--
-- Indexes for table `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deal_product`
--
ALTER TABLE `deal_product`
  ADD PRIMARY KEY (`deal_id`);

--
-- Indexes for table `delivery_boy`
--
ALTER TABLE `delivery_boy`
  ADD PRIMARY KEY (`dboy_id`);

--
-- Indexes for table `delivery_rating`
--
ALTER TABLE `delivery_rating`
  ADD PRIMARY KEY (`rating_id`);

--
-- Indexes for table `driver_bank`
--
ALTER TABLE `driver_bank`
  ADD PRIMARY KEY (`ac_id`);

--
-- Indexes for table `driver_callback_req`
--
ALTER TABLE `driver_callback_req`
  ADD PRIMARY KEY (`callback_req_id`);

--
-- Indexes for table `driver_incentive`
--
ALTER TABLE `driver_incentive`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_notification`
--
ALTER TABLE `driver_notification`
  ADD PRIMARY KEY (`not_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fcm`
--
ALTER TABLE `fcm`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `firebase`
--
ALTER TABLE `firebase`
  ADD PRIMARY KEY (`f_id`);

--
-- Indexes for table `firebase_iso`
--
ALTER TABLE `firebase_iso`
  ADD PRIMARY KEY (`iso_id`);

--
-- Indexes for table `freedeliverycart`
--
ALTER TABLE `freedeliverycart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `id_types`
--
ALTER TABLE `id_types`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `image_space`
--
ALTER TABLE `image_space`
  ADD PRIMARY KEY (`space_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`(191));

--
-- Indexes for table `licensebox`
--
ALTER TABLE `licensebox`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `list_cart`
--
ALTER TABLE `list_cart`
  ADD PRIMARY KEY (`l_cid`);

--
-- Indexes for table `mapbox`
--
ALTER TABLE `mapbox`
  ADD PRIMARY KEY (`map_id`);

--
-- Indexes for table `map_api`
--
ALTER TABLE `map_api`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `map_settings`
--
ALTER TABLE `map_settings`
  ADD PRIMARY KEY (`map_id`);

--
-- Indexes for table `membership_bought`
--
ALTER TABLE `membership_bought`
  ADD PRIMARY KEY (`buy_id`);

--
-- Indexes for table `membership_plan`
--
ALTER TABLE `membership_plan`
  ADD PRIMARY KEY (`plan_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `minimum_maximum_order_value`
--
ALTER TABLE `minimum_maximum_order_value`
  ADD PRIMARY KEY (`min_max_id`);

--
-- Indexes for table `msg91`
--
ALTER TABLE `msg91`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notificationby`
--
ALTER TABLE `notificationby`
  ADD PRIMARY KEY (`noti_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `cart_id` (`cart_id`(191));

--
-- Indexes for table `order_by_photo`
--
ALTER TABLE `order_by_photo`
  ADD PRIMARY KEY (`ord_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`(191));

--
-- Indexes for table `payout_requests`
--
ALTER TABLE `payout_requests`
  ADD PRIMARY KEY (`req_id`);

--
-- Indexes for table `payout_req_valid`
--
ALTER TABLE `payout_req_valid`
  ADD PRIMARY KEY (`val_id`);

--
-- Indexes for table `plan_buy_history`
--
ALTER TABLE `plan_buy_history`
  ADD PRIMARY KEY (`wallet_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `product_rating`
--
ALTER TABLE `product_rating`
  ADD PRIMARY KEY (`rate_id`);

--
-- Indexes for table `product_varient`
--
ALTER TABLE `product_varient`
  ADD PRIMARY KEY (`varient_id`);

--
-- Indexes for table `razorpay_key`
--
ALTER TABLE `razorpay_key`
  ADD PRIMARY KEY (`key_id`);

--
-- Indexes for table `recent_search`
--
ALTER TABLE `recent_search`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reedem_values`
--
ALTER TABLE `reedem_values`
  ADD PRIMARY KEY (`reedem_id`);

--
-- Indexes for table `referral_points`
--
ALTER TABLE `referral_points`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_points`
--
ALTER TABLE `reward_points`
  ADD PRIMARY KEY (`reward_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `sec_banner`
--
ALTER TABLE `sec_banner`
  ADD PRIMARY KEY (`banner_id`);

--
-- Indexes for table `service_area`
--
ALTER TABLE `service_area`
  ADD PRIMARY KEY (`ser_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `smsby`
--
ALTER TABLE `smsby`
  ADD PRIMARY KEY (`by_id`);

--
-- Indexes for table `society`
--
ALTER TABLE `society`
  ADD PRIMARY KEY (`society_id`);

--
-- Indexes for table `spotlight`
--
ALTER TABLE `spotlight`
  ADD PRIMARY KEY (`sp_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store_assign_homecat`
--
ALTER TABLE `store_assign_homecat`
  ADD PRIMARY KEY (`assign_id`);

--
-- Indexes for table `store_bank`
--
ALTER TABLE `store_bank`
  ADD PRIMARY KEY (`ac_id`);

--
-- Indexes for table `store_banner`
--
ALTER TABLE `store_banner`
  ADD PRIMARY KEY (`banner_id`);

--
-- Indexes for table `store_callback_req`
--
ALTER TABLE `store_callback_req`
  ADD PRIMARY KEY (`callback_req_id`);

--
-- Indexes for table `store_delivery_boy`
--
ALTER TABLE `store_delivery_boy`
  ADD PRIMARY KEY (`dboy_id`);

--
-- Indexes for table `store_doc`
--
ALTER TABLE `store_doc`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indexes for table `store_driver_incentive`
--
ALTER TABLE `store_driver_incentive`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store_earning`
--
ALTER TABLE `store_earning`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `store_homecat`
--
ALTER TABLE `store_homecat`
  ADD PRIMARY KEY (`homecat_id`);

--
-- Indexes for table `store_notification`
--
ALTER TABLE `store_notification`
  ADD PRIMARY KEY (`not_id`);

--
-- Indexes for table `store_orders`
--
ALTER TABLE `store_orders`
  ADD PRIMARY KEY (`store_order_id`);

--
-- Indexes for table `store_products`
--
ALTER TABLE `store_products`
  ADD PRIMARY KEY (`p_id`),
  ADD KEY `varient_id` (`varient_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `store_society`
--
ALTER TABLE `store_society`
  ADD PRIMARY KEY (`store_society_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`tag_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `tax_types`
--
ALTER TABLE `tax_types`
  ADD PRIMARY KEY (`tax_id`);

--
-- Indexes for table `tbl_referral`
--
ALTER TABLE `tbl_referral`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_top_cat`
--
ALTER TABLE `tbl_top_cat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_web_setting`
--
ALTER TABLE `tbl_web_setting`
  ADD PRIMARY KEY (`set_id`);

--
-- Indexes for table `termspage`
--
ALTER TABLE `termspage`
  ADD PRIMARY KEY (`terms_id`);

--
-- Indexes for table `time_slot`
--
ALTER TABLE `time_slot`
  ADD PRIMARY KEY (`time_slot_id`);

--
-- Indexes for table `trending_search`
--
ALTER TABLE `trending_search`
  ADD PRIMARY KEY (`trend_id`);

--
-- Indexes for table `twilio`
--
ALTER TABLE `twilio`
  ADD PRIMARY KEY (`twilio_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_notification`
--
ALTER TABLE `user_notification`
  ADD PRIMARY KEY (`noti_id`);

--
-- Indexes for table `user_support`
--
ALTER TABLE `user_support`
  ADD PRIMARY KEY (`supp_id`);

--
-- Indexes for table `wallet_recharge_history`
--
ALTER TABLE `wallet_recharge_history`
  ADD PRIMARY KEY (`wallet_recharge_history`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`wish_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aboutuspage`
--
ALTER TABLE `aboutuspage`
  MODIFY `about_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admin_driver_incentive`
--
ALTER TABLE `admin_driver_incentive`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_payouts`
--
ALTER TABLE `admin_payouts`
  MODIFY `payout_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_link`
--
ALTER TABLE `app_link`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `app_notice`
--
ALTER TABLE `app_notice`
  MODIFY `app_notice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `callback_req`
--
ALTER TABLE `callback_req`
  MODIFY `callback_req_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cancel_for`
--
ALTER TABLE `cancel_for`
  MODIFY `res_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_payments`
--
ALTER TABLE `cart_payments`
  MODIFY `py_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_rewards`
--
ALTER TABLE `cart_rewards`
  MODIFY `cart_rewards_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_status`
--
ALTER TABLE `cart_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `city`
--
ALTER TABLE `city`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `country_code`
--
ALTER TABLE `country_code`
  MODIFY `code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `coupon`
--
ALTER TABLE `coupon`
  MODIFY `coupon_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currency`
--
ALTER TABLE `currency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `deal_product`
--
ALTER TABLE `deal_product`
  MODIFY `deal_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_boy`
--
ALTER TABLE `delivery_boy`
  MODIFY `dboy_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_rating`
--
ALTER TABLE `delivery_rating`
  MODIFY `rating_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_bank`
--
ALTER TABLE `driver_bank`
  MODIFY `ac_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_callback_req`
--
ALTER TABLE `driver_callback_req`
  MODIFY `callback_req_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_incentive`
--
ALTER TABLE `driver_incentive`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `driver_notification`
--
ALTER TABLE `driver_notification`
  MODIFY `not_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fcm`
--
ALTER TABLE `fcm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `firebase`
--
ALTER TABLE `firebase`
  MODIFY `f_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `firebase_iso`
--
ALTER TABLE `firebase_iso`
  MODIFY `iso_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `freedeliverycart`
--
ALTER TABLE `freedeliverycart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `id_types`
--
ALTER TABLE `id_types`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `image_space`
--
ALTER TABLE `image_space`
  MODIFY `space_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `licensebox`
--
ALTER TABLE `licensebox`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `list_cart`
--
ALTER TABLE `list_cart`
  MODIFY `l_cid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mapbox`
--
ALTER TABLE `mapbox`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `map_api`
--
ALTER TABLE `map_api`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `map_settings`
--
ALTER TABLE `map_settings`
  MODIFY `map_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `membership_bought`
--
ALTER TABLE `membership_bought`
  MODIFY `buy_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `membership_plan`
--
ALTER TABLE `membership_plan`
  MODIFY `plan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `minimum_maximum_order_value`
--
ALTER TABLE `minimum_maximum_order_value`
  MODIFY `min_max_id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `msg91`
--
ALTER TABLE `msg91`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `notificationby`
--
ALTER TABLE `notificationby`
  MODIFY `noti_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_by_photo`
--
ALTER TABLE `order_by_photo`
  MODIFY `ord_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payout_requests`
--
ALTER TABLE `payout_requests`
  MODIFY `req_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payout_req_valid`
--
ALTER TABLE `payout_req_valid`
  MODIFY `val_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `plan_buy_history`
--
ALTER TABLE `plan_buy_history`
  MODIFY `wallet_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_rating`
--
ALTER TABLE `product_rating`
  MODIFY `rate_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_varient`
--
ALTER TABLE `product_varient`
  MODIFY `varient_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `razorpay_key`
--
ALTER TABLE `razorpay_key`
  MODIFY `key_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `recent_search`
--
ALTER TABLE `recent_search`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reedem_values`
--
ALTER TABLE `reedem_values`
  MODIFY `reedem_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `referral_points`
--
ALTER TABLE `referral_points`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reward_points`
--
ALTER TABLE `reward_points`
  MODIFY `reward_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sec_banner`
--
ALTER TABLE `sec_banner`
  MODIFY `banner_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_area`
--
ALTER TABLE `service_area`
  MODIFY `ser_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `smsby`
--
ALTER TABLE `smsby`
  MODIFY `by_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `society`
--
ALTER TABLE `society`
  MODIFY `society_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `spotlight`
--
ALTER TABLE `spotlight`
  MODIFY `sp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_assign_homecat`
--
ALTER TABLE `store_assign_homecat`
  MODIFY `assign_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_bank`
--
ALTER TABLE `store_bank`
  MODIFY `ac_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_banner`
--
ALTER TABLE `store_banner`
  MODIFY `banner_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_callback_req`
--
ALTER TABLE `store_callback_req`
  MODIFY `callback_req_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_delivery_boy`
--
ALTER TABLE `store_delivery_boy`
  MODIFY `dboy_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_driver_incentive`
--
ALTER TABLE `store_driver_incentive`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_earning`
--
ALTER TABLE `store_earning`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_notification`
--
ALTER TABLE `store_notification`
  MODIFY `not_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_orders`
--
ALTER TABLE `store_orders`
  MODIFY `store_order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_products`
--
ALTER TABLE `store_products`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `store_society`
--
ALTER TABLE `store_society`
  MODIFY `store_society_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_types`
--
ALTER TABLE `tax_types`
  MODIFY `tax_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_referral`
--
ALTER TABLE `tbl_referral`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_top_cat`
--
ALTER TABLE `tbl_top_cat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_web_setting`
--
ALTER TABLE `tbl_web_setting`
  MODIFY `set_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `termspage`
--
ALTER TABLE `termspage`
  MODIFY `terms_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `time_slot`
--
ALTER TABLE `time_slot`
  MODIFY `time_slot_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trending_search`
--
ALTER TABLE `trending_search`
  MODIFY `trend_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `twilio`
--
ALTER TABLE `twilio`
  MODIFY `twilio_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_notification`
--
ALTER TABLE `user_notification`
  MODIFY `noti_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_support`
--
ALTER TABLE `user_support`
  MODIFY `supp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallet_recharge_history`
--
ALTER TABLE `wallet_recharge_history`
  MODIFY `wallet_recharge_history` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `wish_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

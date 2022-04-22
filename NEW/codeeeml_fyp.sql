-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 11, 2022 at 09:11 AM
-- Server version: 10.3.34-MariaDB-cll-lve
-- PHP Version: 7.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codeeeml_fyp`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `email`, `password`) VALUES
(2, 'admin', 'admin@panalysis.com', '123456');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT 1,
  `payment_status` tinyint(1) DEFAULT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `duration` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` int(11) NOT NULL,
  `total_amount` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `user_id`, `active_status`, `payment_status`, `date`, `duration`, `plan_id`, `total_amount`) VALUES
(129, 119, 1, 0, '2021-12-16 11:52:00', '30', 27, 100);

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(11) NOT NULL,
  `name` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `description` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `num_searches` int(11) NOT NULL DEFAULT 0,
  `discount` float NOT NULL,
  `limits` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `price`, `description`, `num_searches`, `discount`, `limits`, `active_status`) VALUES
(25, 'Basic', 5, 'Basic plans with 10 searches per month', 10, 0, NULL, 1),
(26, 'Standard', 50, 'Standard Package to analyze 50 profiles per month', 50, 10, NULL, 1),
(27, 'Premium', 100, 'Premium package to analyze 100 profiles per month', 100, 10, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `query`
--

CREATE TABLE `query` (
  `id` int(11) NOT NULL,
  `Date` datetime DEFAULT NULL,
  `keyword` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `query`
--

INSERT INTO `query` (`id`, `Date`, `keyword`, `status`, `user_id`) VALUES
(257, '2021-12-16 17:19:47', 'haris__manzoor', 1, 119),
(258, '2021-12-18 14:35:06', 'elonmusk', 1, 119),
(259, '2021-12-18 14:36:11', 'kevinABD17', 1, 119),
(260, '2021-12-18 14:37:18', 'ABdeVilliers17', 1, 119);

-- --------------------------------------------------------

--
-- Table structure for table `reset`
--

CREATE TABLE `reset` (
  `id` int(11) NOT NULL,
  `secret` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` date NOT NULL,
  `admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `id` int(11) NOT NULL,
  `filename` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `result` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `query_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `script_result`
--

CREATE TABLE `script_result` (
  `id` int(11) NOT NULL,
  `title` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Phone` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Website` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `street` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `No_of_Photos` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `query_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `designation` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE `tweets` (
  `id` int(11) NOT NULL,
  `tweetID` varchar(500) CHARACTER SET latin1 DEFAULT NULL,
  `content` varchar(5000) CHARACTER SET latin1 NOT NULL,
  `tweetTS` varchar(200) CHARACTER SET latin1 NOT NULL,
  `username` varchar(100) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tweets`
--

INSERT INTO `tweets` (`id`, `tweetID`, `content`, `tweetTS`, `username`) VALUES
(1, '1466882988914925575', 'https://t.co/v6lO6ouyKu\n #Sialkot', '2021-12-03 21:32:12', 'Haris__Manzoor'),
(2, '1466720872316735489', '@jzyhehe Read the above tweet again ', '2021-12-03 10:48:00', 'Haris__Manzoor'),
(3, '1466690424865792006', '@jzyhehe If you think theres more productive something, ofc, I even sometimes dont think that islamic studies should be taught the way it is taught, but any how, you ever seen any western country holding any bayaan or something, thats not their culture fullstop', '2021-12-03 08:47:01', 'Haris__Manzoor'),
(4, '1466538996117360647', '@jzyhehe Tiny concert within the premises of a top notch institute, would, it literally would, it would start a chain of trends being followed by other institutes, so peace out, enjoy in a private dedicated space ', '2021-12-02 22:45:18', 'Haris__Manzoor'),
(5, '1466538326924546051', '@jzyhehe With the affordability, I didnt mean monetarily but morally. To be clear by humans I meant humans by heart excepting humans by specie**', '2021-12-02 22:42:38', 'Haris__Manzoor'),
(6, '1466537904910462977', '@jzyhehe Moreover, COMSATS is one of the top universities of Pakistan, among the top 5 I guess, in countries like Pakistan, we cant afford activities like that, as long as enjoyment is concern, start a community service program with the budget of a concert and lets seewherehumansfindjoy', '2021-12-02 22:40:58', 'Haris__Manzoor'),
(7, '1466537131204124678', '@jzyhehe Yeah ofc, again if islam is not a concern then why not, as far as institutional standards are concerned, these institutions work for the welfare to Islamic Republic of Pakistan and must adhere to the its dignity.', '2021-12-02 22:37:53', 'Haris__Manzoor'),
(8, '1466533223320604672', '@jzyhehe You got a point, but in my opinion(if you wanna hear), all that stuff should be kept outside of institutional premises. Thoughts?', '2021-12-02 22:22:21', 'Haris__Manzoor'),
(9, '1466532190355742723', '@jzyhehe As I said there should be boundaries, BTW I havent seen any Naat programs in any university but International Islamic University, and Qawallis hahhh the qawalli programs institutes hold are not religious at all( if your concern is regard halaal haraam)', '2021-12-02 22:18:15', 'Haris__Manzoor'),
(10, '1466505170695688196', 'This isnt a favourable conditions for a developing country but against. #Ban_Obscenity_in_ComsatsAtd', '2021-12-02 20:30:53', 'Haris__Manzoor'),
(11, '1466504751072358401', 'Thats where we lag,having fun is alright but boundaries should be observed. Everyone answers for own imaan but converting prestigious institutes that are supposed to produce nation builders and scholar.. #Ban_Obscenity_in_ComsatsAtd\n#Ban_obsencity_in_educational_institutes', '2021-12-02 20:29:13', 'Haris__Manzoor'),
(12, '1471599702818889735', '@nichegamer Add some tats -&gt; hipster xenomorph', '2021-12-16 21:54:44', 'elonmusk'),
(13, '1471590093471326215', '@robbystarbuck @briannalyman2 ', '2021-12-16 21:16:33', 'elonmusk'),
(14, '1471583489824808972', '@BTC_Archive @SenSanders Is there anything more tragic than unrequited love?', '2021-12-16 20:50:19', 'elonmusk'),
(15, '1471582809512939527', '@JohnnaCrider1 Yeah, I mean seriously wth!!', '2021-12-16 20:47:37', 'elonmusk'),
(16, '1471581040426860549', '@SenSanders [ahem]', '2021-12-16 20:40:35', 'elonmusk'),
(17, '1471580241537732608', '@briannalyman2 (Lack of) Joy Reid is a lobbyist for Sen Karen', '2021-12-16 20:37:24', 'elonmusk'),
(18, '1471563333841137664', 'Old school shell game', '2021-12-16 19:30:13', 'elonmusk'),
(19, '1471562586286174217', '@TheBabylonBee ', '2021-12-16 19:27:15', 'elonmusk'),
(20, '1471556384667979777', '@MrManderly @SawyerMerritt Giga Texas is a $10B+ investment over time, generating at least 20k direct &amp; 100k indirect jobs', '2021-12-16 19:02:36', 'elonmusk'),
(21, '1471555887387058184', '@MrManderly @SawyerMerritt Literally', '2021-12-16 19:00:38', 'elonmusk'),
(22, '1471555649205157892', '@BillyM2k ', '2021-12-16 18:59:41', 'elonmusk'),
(23, '1472289354429054977', 'Abd is on https://t.co/PtOxo2Bo8I', '2021-12-18 19:35:10', 'kevinABD17'),
(24, '1472288820557070342', '@ABdeVilliers17 @NFT_ATH ', '2021-12-18 19:33:03', 'kevinABD17'),
(25, '1472288733785247748', ' https://t.co/Ql2wOPa697', '2021-12-18 19:32:42', 'kevinABD17'),
(26, '1472288544823541761', 'Words cannot describe my happiness https://t.co/xun1L6hG4d', '2021-12-18 19:31:57', 'kevinABD17'),
(27, '1472284802732625921', '@Madurakaranda3 @Chiragparmar149 @79off47 @Rezaahm20162243 @SoumyajitKar20 @ABDvillers18 @Abdevilloirs @ABDFan18 @Delhi43of297 @AbdeDevilliers @im_ayush_ @_dreamer__neha @Amitver17 @90in39 @Qwerty89566753 @Johannesburg149 @71stcentury @One3threee @DeathWiishh take care ', '2021-12-18 19:17:05', 'kevinABD17'),
(28, '1472284799863721991', 'Im leaving Twitter for a while I dont know if Ill b back or so! Its not because I dont like it here \n@ABdeVilliers17 take care  https://t.co/Mg37q31umH', '2021-12-18 19:17:04', 'kevinABD17'),
(29, '1472277474465619970', ' https://t.co/AFacCUQEau', '2021-12-18 18:47:58', 'kevinABD17'),
(30, '1472277343624302593', '@Delhi43of297 @CKevinc02 @CricCrazyJohns @Madurakaranda3 @mufaddal_vohra @Johannesburg149 @Puneite_ @imjsk27 @chaitu_20_ Super ', '2021-12-18 18:47:26', 'kevinABD17'),
(31, '1472203235909767171', 'day 79 of tweeting @ABdeVilliers17 until he replies \n@ABdeVilliers17 today is my birthday please wish me  https://t.co/DPZuk8QcTX', '2021-12-18 13:52:58', 'kevinABD17'),
(32, '1472201408011116550', '@Amitver17 @ABdeVilliers17 @Puneite_ @Qwerty89566753 @KrishLalwani8 @Chiragparmar149 @ABDvillers18 @ABDFan18 @YashSRK17 @71stcentury @TheCricketPanda @90in39 @Delhi43of297 @Madurakaranda3 watch this ', '2021-12-18 13:45:42', 'kevinABD17'),
(33, '1472199834824105986', '@ABDvillers18 @ABdeVilliers17 @Abdevilloirs @ABdeVilliers17 please  ', '2021-12-18 13:39:27', 'kevinABD17'),
(34, '1472288699387895815', '@NFT_ATH @kevinABD17 No youre not', '2021-12-18 19:32:34', 'ABdeVilliers17'),
(35, '1472287055073927170', '@kevinABD17 happy happy', '2021-12-18 19:26:02', 'ABdeVilliers17'),
(36, '1472286244528926721', '@kevinABD17 No need to leave. Happy festive season to u', '2021-12-18 19:22:49', 'ABdeVilliers17'),
(37, '1472141144989515777', 'You only ever needed one reason to Get off your Ass!\nRun to the Fun @Myntra End of Reason Sale, from 18th to 23rd December, for WROGN kinda Deals!\nhttps://t.co/m76l57f1yc\n.\n.\n@staywrogn #StayMad #StayWrogn #MyntraEndOfReasonSale #WrognActive #MyntraEORS2021 https://t.co/AyIFsCKy3N', '2021-12-18 09:46:14', 'ABdeVilliers17'),
(38, '1471849402608328706', '@DERCArmy @DeRaceNFT @Jeff_Quaderi @WinanCrypto @DeRaceNFTFan @Avstn21 @egle_derace @KootzyDeRacing @FRUCKET @adelaida_derace Excited!', '2021-12-17 14:26:57', 'ABdeVilliers17'),
(39, '1471153345838649347', '@RassieRugby Gesondheid', '2021-12-15 16:21:05', 'ABdeVilliers17'),
(40, '1471082279476899845', 'I support the aims of CSAs Social Justice and Nation Building process, to ensure equal opportunities in cricket. However, in my career, I expressed honest cricketing opinions only ever based on what I believed was best for the team, never based on anyones race. Thats the fact. https://t.co/Be0eb1hNBR', '2021-12-15 11:38:41', 'ABdeVilliers17'),
(41, '1470858233694752768', 'When in doubt, light it up with @megamaster_sa this summer\n#familytime \n#braai @ South Africa https://t.co/APpU65D5sZ', '2021-12-14 20:48:24', 'ABdeVilliers17'),
(42, '1470355767727476739', '@DERCArmy ', '2021-12-13 11:31:47', 'ABdeVilliers17'),
(43, '1470355089890189316', '@DERCArmy ', '2021-12-13 11:29:05', 'ABdeVilliers17'),
(44, '1468995588935061504', '@genopets Love this!! Thanks guys @genopets', '2021-12-09 17:26:55', 'ABdeVilliers17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_invoice` int(11) DEFAULT NULL,
  `active_status` tinyint(1) NOT NULL DEFAULT 1,
  `date_joined` datetime NOT NULL DEFAULT current_timestamp(),
  `u_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_email_verified` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `firstname`, `lastname`, `email`, `password`, `current_invoice`, `active_status`, `date_joined`, `u_key`, `is_email_verified`) VALUES
(119, 'hhaarriiss', 'Haris', 'Manzoor', 'harrissmanzoor22@gmail.com', '$5$rounds=535000$s0eserCAFc9N.xn4$fnBxbWw.nDrE8erKHZZzOPj4N9tISr2ucXFpWt2lXp5', 129, 1, '2021-12-16 11:52:00', '-3386103260633850523', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users_profile`
--

CREATE TABLE `users_profile` (
  `username` varchar(100) CHARACTER SET latin1 NOT NULL,
  `profileURL` varchar(500) CHARACTER SET latin1 NOT NULL,
  `profileImage` varchar(500) CHARACTER SET latin1 NOT NULL,
  `name` varchar(64) CHARACTER SET latin1 NOT NULL,
  `description` varchar(5000) CHARACTER SET latin1 NOT NULL,
  `location` varchar(64) CHARACTER SET latin1 NOT NULL,
  `followersCount` varchar(64) CHARACTER SET latin1 NOT NULL,
  `isVerified` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users_profile`
--

INSERT INTO `users_profile` (`username`, `profileURL`, `profileImage`, `name`, `description`, `location`, `followersCount`, `isVerified`) VALUES
('ABdeVilliers17', 'https://twitter.com/ABdeVilliers17', 'https://pbs.twimg.com/profile_images/1463465499413651456/iR1oIBe2_normal.jpg', 'AB de Villiers', 'Professional Cricket player.. Proudly South African', 'South Africa, Pretoria', '8247487', 1),
('elonmusk', 'https://twitter.com/elonmusk', 'https://pbs.twimg.com/profile_images/1442634650703237120/mXIcYtIs_normal.jpg', 'Elon Musk', '', '', '66715827', 1),
('haris__manzoor', 'https://twitter.com/haris__manzoor', 'https://pbs.twimg.com/profile_images/1456213641716453380/KvepENG5_normal.jpg', 'H A R I S????????', 'Computer Scientist to be..! ????????\nCampus Expert @github\nFAST NU, ISLAMABAD!\n@fdc_fast\nPRESIDENT,  FAST DEVELOPER\'S COMMUNITY', 'Punjab, Pakistan', '53', 0),
('kevinABD17', 'https://twitter.com/kevinABD17', 'https://pbs.twimg.com/profile_images/1471147550363185152/cK-Ba-uJ_normal.jpg', 'kevin de Villiers????', 'Abdian since 2013\n@abdeVilliers17 forever?? \nsouth Africa ???????? Abdian forever till my last breath', 'Chennai, India', '1372', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plan_id` (`plan_id`),
  ADD KEY `user_has_invoice` (`user_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `query`
--
ALTER TABLE `query`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reset`
--
ALTER TABLE `reset`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `query_id` (`query_id`);

--
-- Indexes for table `script_result`
--
ALTER TABLE `script_result`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `query_id` (`query_id`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tweets`
--
ALTER TABLE `tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username_2` (`username`),
  ADD UNIQUE KEY `username_4` (`username`,`email`),
  ADD UNIQUE KEY `noTwoUsersCanHaveSameInvoice` (`current_invoice`),
  ADD UNIQUE KEY `u_key` (`u_key`),
  ADD KEY `username_3` (`username`,`email`);

--
-- Indexes for table `users_profile`
--
ALTER TABLE `users_profile`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `query`
--
ALTER TABLE `query`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT for table `reset`
--
ALTER TABLE `reset`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `result`
--
ALTER TABLE `result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `script_result`
--
ALTER TABLE `script_result`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=718;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tweets`
--
ALTER TABLE `tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `plan_id` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_has_invoice` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `query`
--
ALTER TABLE `query`
  ADD CONSTRAINT `query_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `reset`
--
ALTER TABLE `reset`
  ADD CONSTRAINT `admin_id` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `script_result`
--
ALTER TABLE `script_result`
  ADD CONSTRAINT `script_result_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `script_result_ibfk_2` FOREIGN KEY (`query_id`) REFERENCES `query` (`id`);

--
-- Constraints for table `tweets`
--
ALTER TABLE `tweets`
  ADD CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users_profile` (`username`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `user_has_current_invoice` FOREIGN KEY (`current_invoice`) REFERENCES `invoices` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

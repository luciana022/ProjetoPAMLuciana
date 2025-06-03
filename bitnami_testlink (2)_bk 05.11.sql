-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3307
-- Tempo de geração: 05-Nov-2024 às 15:33
-- Versão do servidor: 10.4.19-MariaDB
-- versão do PHP: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bitnami_testlink`
--
CREATE DATABASE IF NOT EXISTS `bitnami_testlink` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `bitnami_testlink`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `assignment_status`
--

DROP TABLE IF EXISTS `assignment_status`;
CREATE TABLE `assignment_status` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `assignment_status`
--

INSERT INTO `assignment_status` (`id`, `description`) VALUES
(1, 'open'),
(2, 'closed'),
(3, 'completed'),
(4, 'todo_urgent'),
(5, 'todo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `assignment_types`
--

DROP TABLE IF EXISTS `assignment_types`;
CREATE TABLE `assignment_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_table` varchar(30) DEFAULT '',
  `description` varchar(100) NOT NULL DEFAULT 'unknown'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `assignment_types`
--

INSERT INTO `assignment_types` (`id`, `fk_table`, `description`) VALUES
(1, 'testplan_tcversions', 'testcase_execution'),
(2, 'tcversions', 'testcase_review');

-- --------------------------------------------------------

--
-- Estrutura da tabela `attachments`
--

DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fk_table` varchar(250) DEFAULT '',
  `title` varchar(250) DEFAULT '',
  `description` varchar(250) DEFAULT '',
  `file_name` varchar(250) NOT NULL DEFAULT '',
  `file_path` varchar(250) DEFAULT '',
  `file_size` int(11) NOT NULL DEFAULT 0,
  `file_type` varchar(250) NOT NULL DEFAULT '',
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `content` longblob DEFAULT NULL,
  `compression_type` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `baseline_l1l2_context`
--

DROP TABLE IF EXISTS `baseline_l1l2_context`;
CREATE TABLE `baseline_l1l2_context` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `begin_exec_ts` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_exec_ts` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `baseline_l1l2_details`
--

DROP TABLE IF EXISTS `baseline_l1l2_details`;
CREATE TABLE `baseline_l1l2_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `context_id` int(10) UNSIGNED NOT NULL,
  `top_tsuite_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `child_tsuite_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` char(1) DEFAULT NULL,
  `qty` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `total_tc` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `builds`
--

DROP TABLE IF EXISTS `builds`;
CREATE TABLE `builds` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'undefined',
  `notes` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `release_date` date DEFAULT NULL,
  `closed_on_date` date DEFAULT NULL,
  `commit_id` varchar(64) DEFAULT NULL,
  `tag` varchar(64) DEFAULT NULL,
  `branch` varchar(64) DEFAULT NULL,
  `release_candidate` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Available builds';

--
-- Extraindo dados da tabela `builds`
--

INSERT INTO `builds` (`id`, `testplan_id`, `name`, `notes`, `active`, `is_open`, `author_id`, `creation_ts`, `release_date`, `closed_on_date`, `commit_id`, `tag`, `branch`, `release_candidate`) VALUES
(2, 6, 'Baseline 2', '', 1, 1, NULL, '2024-11-05 16:15:55', NULL, NULL, '', '', '', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cfield_build_design_values`
--

DROP TABLE IF EXISTS `cfield_build_design_values`;
CREATE TABLE `cfield_build_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cfield_design_values`
--

DROP TABLE IF EXISTS `cfield_design_values`;
CREATE TABLE `cfield_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cfield_execution_values`
--

DROP TABLE IF EXISTS `cfield_execution_values`;
CREATE TABLE `cfield_execution_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `execution_id` int(10) NOT NULL DEFAULT 0,
  `testplan_id` int(10) NOT NULL DEFAULT 0,
  `tcversion_id` int(10) NOT NULL DEFAULT 0,
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cfield_node_types`
--

DROP TABLE IF EXISTS `cfield_node_types`;
CREATE TABLE `cfield_node_types` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `node_type_id` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cfield_testplan_design_values`
--

DROP TABLE IF EXISTS `cfield_testplan_design_values`;
CREATE TABLE `cfield_testplan_design_values` (
  `field_id` int(10) NOT NULL DEFAULT 0,
  `link_id` int(10) NOT NULL DEFAULT 0 COMMENT 'point to testplan_tcversion id',
  `value` varchar(4000) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cfield_testprojects`
--

DROP TABLE IF EXISTS `cfield_testprojects`;
CREATE TABLE `cfield_testprojects` (
  `field_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `display_order` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `location` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `required_on_design` tinyint(1) NOT NULL DEFAULT 0,
  `required_on_execution` tinyint(1) NOT NULL DEFAULT 0,
  `monitorable` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `codetrackers`
--

DROP TABLE IF EXISTS `codetrackers`;
CREATE TABLE `codetrackers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `custom_fields`
--

DROP TABLE IF EXISTS `custom_fields`;
CREATE TABLE `custom_fields` (
  `id` int(10) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `label` varchar(64) NOT NULL DEFAULT '' COMMENT 'label to display on user interface',
  `type` smallint(6) NOT NULL DEFAULT 0,
  `possible_values` varchar(4000) NOT NULL DEFAULT '',
  `default_value` varchar(4000) NOT NULL DEFAULT '',
  `valid_regexp` varchar(255) NOT NULL DEFAULT '',
  `length_min` int(10) NOT NULL DEFAULT 0,
  `length_max` int(10) NOT NULL DEFAULT 0,
  `show_on_design` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1=> show it during specification design',
  `enable_on_design` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1=> user can write/manage it during specification design',
  `show_on_execution` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1=> show it during test case execution',
  `enable_on_execution` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1=> user can write/manage it during test case execution',
  `show_on_testplan_design` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `enable_on_testplan_design` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `db_version`
--

DROP TABLE IF EXISTS `db_version`;
CREATE TABLE `db_version` (
  `version` varchar(50) NOT NULL DEFAULT 'unknown',
  `upgrade_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `db_version`
--

INSERT INTO `db_version` (`version`, `upgrade_ts`, `notes`) VALUES
('DB 1.9.20', '2022-12-14 13:37:15', 'TestLink 1.9.20 Raijin');

-- --------------------------------------------------------

--
-- Estrutura da tabela `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int(10) UNSIGNED NOT NULL,
  `transaction_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `log_level` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `source` varchar(45) DEFAULT NULL,
  `description` text NOT NULL,
  `fired_at` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `activity` varchar(45) DEFAULT NULL,
  `object_id` int(10) UNSIGNED DEFAULT NULL,
  `object_type` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `events`
--

INSERT INTO `events` (`id`, `transaction_id`, `log_level`, `source`, `description`, `fired_at`, `activity`, `object_id`, `object_type`) VALUES
(92, 52, 16, 'GUI - Projeto de Teste ID : 7', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:4:\"root\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1730733022, 'LOGIN', 1, 'users'),
(93, 53, 16, 'GUI - Projeto de Teste ID : 7', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:4:\"root\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1730806630, 'LOGIN', 1, 'users'),
(94, 54, 32, 'GUI - Projeto de Teste ID : 5', 'string \'file_upload_ko\' is not localized for locale \'pt_BR\'  - using en_GB', 1730807511, 'LOCALIZATION', 0, NULL),
(95, 54, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\81ee926c395ee857293361fcc5be895639097b0f_0.file.planEdit.tpl.php - Line 130', 1730807511, 'PHP', 0, NULL),
(96, 54, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$itemID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\81ee926c395ee857293361fcc5be895639097b0f_0.file.planEdit.tpl.php - Line 152', 1730807511, 'PHP', 0, NULL),
(97, 54, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index:  - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\81ee926c395ee857293361fcc5be895639097b0f_0.file.planEdit.tpl.php - Line 302', 1730807511, 'PHP', 0, NULL),
(98, 54, 32, 'GUI - Projeto de Teste ID : 5', 'string \'allowed_files\' is not localized for locale \'pt_BR\'  - using en_GB', 1730807511, 'LOCALIZATION', 0, NULL),
(99, 54, 32, 'GUI - Projeto de Teste ID : 5', 'string \'allowed_filenames_regexp\' is not localized for locale \'pt_BR\'  - using en_GB', 1730807511, 'LOCALIZATION', 0, NULL),
(100, 55, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\81ee926c395ee857293361fcc5be895639097b0f_0.file.planEdit.tpl.php - Line 130', 1730808395, 'PHP', 0, NULL),
(101, 55, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$itemID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\81ee926c395ee857293361fcc5be895639097b0f_0.file.planEdit.tpl.php - Line 152', 1730808395, 'PHP', 0, NULL),
(102, 55, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index:  - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\81ee926c395ee857293361fcc5be895639097b0f_0.file.planEdit.tpl.php - Line 302', 1730808395, 'PHP', 0, NULL),
(103, 56, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: testproject_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\plan\\buildView.php - Line 50', 1730808450, 'PHP', 0, NULL),
(104, 56, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: tproject - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlUser.class.php - Line 860', 1730808450, 'PHP', 0, NULL),
(105, 57, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\nA non-numeric value encountered - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\common.php - Line 2120', 1730808453, 'PHP', 0, NULL),
(106, 57, 32, 'GUI - Projeto de Teste ID : 5', 'string \'commit_id\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808453, 'LOCALIZATION', 0, NULL),
(107, 57, 32, 'GUI - Projeto de Teste ID : 5', 'string \'branch\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808453, 'LOCALIZATION', 0, NULL),
(108, 57, 32, 'GUI - Projeto de Teste ID : 5', 'string \'tag\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808453, 'LOCALIZATION', 0, NULL),
(109, 57, 32, 'GUI - Projeto de Teste ID : 5', 'string \'release_candidate\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808453, 'LOCALIZATION', 0, NULL),
(110, 58, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\nA non-numeric value encountered - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\common.php - Line 2120', 1730808477, 'PHP', 0, NULL),
(111, 58, 16, 'GUI - Projeto de Teste ID : 5', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:18:\"ProjetoLojaVirtual\";i:1;s:13:\"PlanoLVirtual\";i:2;s:10:\"BaseLine 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1730808477, 'CREATE', 1, 'builds'),
(112, 59, 32, 'GUI - Projeto de Teste ID : 5', 'string \'on_design\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808542, 'LOCALIZATION', 0, NULL),
(113, 59, 32, 'GUI - Projeto de Teste ID : 5', 'string \'on_exec\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808542, 'LOCALIZATION', 0, NULL),
(114, 60, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$platformID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 61', 1730808549, 'PHP', 0, NULL),
(115, 60, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_design - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 100', 1730808549, 'PHP', 0, NULL),
(116, 60, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 108', 1730808549, 'PHP', 0, NULL),
(117, 61, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730808590, 'PHP', 0, NULL),
(118, 61, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730808590, 'PHP', 0, NULL),
(119, 61, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730808590, 'PHP', 0, NULL),
(120, 61, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730808590, 'PHP', 0, NULL),
(121, 61, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730808590, 'PHP', 0, NULL),
(122, 62, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730808791, 'PHP', 0, NULL),
(123, 62, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730808791, 'PHP', 0, NULL),
(124, 62, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730808791, 'PHP', 0, NULL),
(125, 62, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730808791, 'PHP', 0, NULL),
(126, 62, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730808791, 'PHP', 0, NULL),
(127, 63, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730808843, 'PHP', 0, NULL),
(128, 63, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730808843, 'PHP', 0, NULL),
(129, 63, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730808843, 'PHP', 0, NULL),
(130, 63, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730808843, 'PHP', 0, NULL),
(131, 63, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730808843, 'PHP', 0, NULL),
(132, 64, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730808861, 'PHP', 0, NULL),
(133, 64, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730808861, 'PHP', 0, NULL),
(134, 64, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730808861, 'PHP', 0, NULL),
(135, 64, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730808861, 'PHP', 0, NULL),
(136, 64, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730808861, 'PHP', 0, NULL),
(137, 65, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlPlatform.class.php - Line 107', 1730808863, 'PHP', 0, NULL),
(138, 65, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$platformID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 61', 1730808863, 'PHP', 0, NULL),
(139, 66, 32, 'GUI - Projeto de Teste ID : 5', 'string \'without_platforms\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808961, 'LOCALIZATION', 0, NULL),
(140, 66, 32, 'GUI - Projeto de Teste ID : 5', 'string \'exec_tree_counters_logic\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808963, 'LOCALIZATION', 0, NULL),
(141, 66, 32, 'GUI - Projeto de Teste ID : 5', 'string \'platforms\' is not localized for locale \'pt_BR\'  - using en_GB', 1730808963, 'LOCALIZATION', 0, NULL),
(142, 66, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730808963, 'PHP', 0, NULL),
(143, 67, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730809021, 'PHP', 0, NULL),
(144, 67, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730809021, 'PHP', 0, NULL),
(145, 68, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730809021, 'PHP', 0, NULL),
(146, 69, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\testcase.class.php - Line 5364', 1730809172, 'PHP', 0, NULL),
(147, 70, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\testcase.class.php - Line 5364', 1730809279, 'PHP', 0, NULL),
(148, 70, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730809279, 'PHP', 0, NULL),
(149, 70, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730809279, 'PHP', 0, NULL),
(150, 70, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\testcases\\testcaseCommands.class.php - Line 1163', 1730809279, 'PHP', 0, NULL),
(151, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'updateLinkToThisTCVersion\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809281, 'LOCALIZATION', 0, NULL),
(152, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'btn_new_version_from_latest\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809281, 'LOCALIZATION', 0, NULL),
(153, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'createKW\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809282, 'LOCALIZATION', 0, NULL),
(154, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'btn_create_and_link\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809282, 'LOCALIZATION', 0, NULL),
(155, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'img_title_remove_platform\' is not localized for locale \'pt_BR\' ', 1730809282, 'LOCALIZATION', 0, NULL),
(156, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'select_platforms\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809282, 'LOCALIZATION', 0, NULL),
(157, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'remove_plat_msgbox_msg\' is not localized for locale \'pt_BR\' ', 1730809282, 'LOCALIZATION', 0, NULL),
(158, 70, 32, 'GUI - Projeto de Teste ID : 5', 'string \'remove_plat_msgbox_title\' is not localized for locale \'pt_BR\' ', 1730809282, 'LOCALIZATION', 0, NULL),
(159, 71, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730809282, 'PHP', 0, NULL),
(160, 72, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\testcases\\testcaseCommands.class.php - Line 1163', 1730809761, 'PHP', 0, NULL),
(161, 73, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730809824, 'PHP', 0, NULL),
(162, 74, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730809845, 'PHP', 0, NULL),
(163, 75, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 703', 1730809848, 'PHP', 0, NULL),
(164, 75, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 708', 1730809848, 'PHP', 0, NULL),
(165, 75, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 745', 1730809848, 'PHP', 0, NULL),
(166, 75, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 1169', 1730809848, 'PHP', 0, NULL),
(167, 75, 32, 'GUI - Projeto de Teste ID : 5', 'string \'note_platform_filter\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809849, 'LOCALIZATION', 0, NULL),
(168, 76, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730809873, 'PHP', 0, NULL),
(169, 77, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 703', 1730809875, 'PHP', 0, NULL),
(170, 77, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 708', 1730809875, 'PHP', 0, NULL),
(171, 77, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 745', 1730809875, 'PHP', 0, NULL),
(172, 77, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 1169', 1730809875, 'PHP', 0, NULL),
(173, 78, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 703', 1730809875, 'PHP', 0, NULL),
(174, 78, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 708', 1730809875, 'PHP', 0, NULL),
(175, 78, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 745', 1730809875, 'PHP', 0, NULL),
(176, 78, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 1169', 1730809875, 'PHP', 0, NULL),
(177, 79, 16, 'GUI - Projeto de Teste ID : 5', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:26:\"audit_tc_added_to_testplan\";s:6:\"params\";a:3:{i:0;s:39:\"PrLVirt-1 : Validar cadastro de cliente\";i:1;s:1:\"1\";i:2;s:38:\"PlanoLVirtual - Plataforma:SISTEMA WEB\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1730809892, 'ASSIGN', 6, 'testplans'),
(178, 79, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 703', 1730809892, 'PHP', 0, NULL),
(179, 79, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 708', 1730809892, 'PHP', 0, NULL),
(180, 79, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 745', 1730809892, 'PHP', 0, NULL),
(181, 79, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\specview.php - Line 1169', 1730809892, 'PHP', 0, NULL),
(182, 80, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730809892, 'PHP', 0, NULL),
(183, 81, 32, 'GUI - Projeto de Teste ID : 5', 'string \'use_latest_exec_on_contex_for_counters\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809910, 'LOCALIZATION', 0, NULL),
(184, 81, 32, 'GUI - Projeto de Teste ID : 5', 'string \'use_latest_exec_on_testplan_for_counters\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809910, 'LOCALIZATION', 0, NULL),
(185, 81, 32, 'GUI - Projeto de Teste ID : 5', 'string \'use_latest_exec_on_testplan_plat_for_counters\' is not localized for locale \'pt_BR\'  - using en_GB', 1730809910, 'LOCALIZATION', 0, NULL),
(186, 82, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlPlatform.class.php - Line 107', 1730809910, 'PHP', 0, NULL),
(187, 83, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlPlatform.class.php - Line 107', 1730809911, 'PHP', 0, NULL),
(188, 84, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730810007, 'PHP', 0, NULL),
(189, 85, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730810046, 'PHP', 0, NULL),
(190, 86, 16, 'GUI - Projeto de Teste ID : 7', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:21:\"audit_login_succeeded\";s:6:\"params\";a:2:{i:0;s:4:\"root\";i:1;s:3:\"::1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1730810630, 'LOGIN', 1, 'users'),
(191, 87, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: testproject_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\plan\\buildView.php - Line 50', 1730812530, 'PHP', 0, NULL),
(192, 87, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: tproject - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlUser.class.php - Line 860', 1730812530, 'PHP', 0, NULL),
(193, 88, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\nA non-numeric value encountered - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\common.php - Line 2120', 1730812540, 'PHP', 0, NULL),
(194, 88, 32, 'GUI - Projeto de Teste ID : 5', 'string \'commit_id\' is not localized for locale \'pt_BR\'  - using en_GB', 1730812540, 'LOCALIZATION', 0, NULL),
(195, 88, 32, 'GUI - Projeto de Teste ID : 5', 'string \'branch\' is not localized for locale \'pt_BR\'  - using en_GB', 1730812540, 'LOCALIZATION', 0, NULL),
(196, 88, 32, 'GUI - Projeto de Teste ID : 5', 'string \'tag\' is not localized for locale \'pt_BR\'  - using en_GB', 1730812540, 'LOCALIZATION', 0, NULL),
(197, 88, 32, 'GUI - Projeto de Teste ID : 5', 'string \'release_candidate\' is not localized for locale \'pt_BR\'  - using en_GB', 1730812540, 'LOCALIZATION', 0, NULL),
(198, 89, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\nA non-numeric value encountered - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\common.php - Line 2120', 1730812555, 'PHP', 0, NULL),
(199, 89, 16, 'GUI - Projeto de Teste ID : 5', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_created\";s:6:\"params\";a:3:{i:0;s:18:\"ProjetoLojaVirtual\";i:1;s:13:\"PlanoLVirtual\";i:2;s:10:\"Baseline 2\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1730812555, 'CREATE', 2, 'builds'),
(200, 90, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\nA non-numeric value encountered - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\common.php - Line 2120', 1730812557, 'PHP', 0, NULL),
(201, 91, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: testproject_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\plan\\buildView.php - Line 50', 1730812564, 'PHP', 0, NULL),
(202, 91, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: tproject - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlUser.class.php - Line 860', 1730812565, 'PHP', 0, NULL),
(203, 92, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\nA non-numeric value encountered - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\common.php - Line 2120', 1730812568, 'PHP', 0, NULL),
(204, 92, 16, 'GUI - Projeto de Teste ID : 5', 'O:18:\"tlMetaStringHelper\":4:{s:5:\"label\";s:19:\"audit_build_deleted\";s:6:\"params\";a:3:{i:0;s:18:\"ProjetoLojaVirtual\";i:1;s:13:\"PlanoLVirtual\";i:2;s:10:\"BaseLine 1\";}s:13:\"bDontLocalize\";b:0;s:14:\"bDontFireEvent\";b:0;}', 1730812568, 'DELETE', 1, 'builds'),
(205, 93, 32, 'GUI - Projeto de Teste ID : 5', 'string \'on_design\' is not localized for locale \'pt_BR\'  - using en_GB', 1730812661, 'LOCALIZATION', 0, NULL),
(206, 93, 32, 'GUI - Projeto de Teste ID : 5', 'string \'on_exec\' is not localized for locale \'pt_BR\'  - using en_GB', 1730812661, 'LOCALIZATION', 0, NULL),
(207, 93, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730812661, 'PHP', 0, NULL),
(208, 93, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730812661, 'PHP', 0, NULL),
(209, 93, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730812661, 'PHP', 0, NULL),
(210, 93, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730812661, 'PHP', 0, NULL),
(211, 93, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730812661, 'PHP', 0, NULL),
(212, 94, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$platformID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 61', 1730812675, 'PHP', 0, NULL),
(213, 94, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_design - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 100', 1730812675, 'PHP', 0, NULL),
(214, 94, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 108', 1730812675, 'PHP', 0, NULL),
(215, 95, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$platformID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 61', 1730812706, 'PHP', 0, NULL),
(216, 95, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_design - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 100', 1730812706, 'PHP', 0, NULL),
(217, 95, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 108', 1730812706, 'PHP', 0, NULL),
(218, 96, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730813168, 'PHP', 0, NULL),
(219, 96, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730813168, 'PHP', 0, NULL),
(220, 96, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730813168, 'PHP', 0, NULL),
(221, 96, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730813168, 'PHP', 0, NULL),
(222, 96, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730813168, 'PHP', 0, NULL),
(223, 97, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlPlatform.class.php - Line 107', 1730813173, 'PHP', 0, NULL),
(224, 97, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$platformID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 61', 1730813173, 'PHP', 0, NULL),
(225, 98, 2, 'GUI - Projeto de Teste ID : 5', 'E_WARNING\ncount(): Parameter must be an array or an object that implements Countable - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tlPlatform.class.php - Line 107', 1730813185, 'PHP', 0, NULL),
(226, 98, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730813185, 'PHP', 0, NULL),
(227, 98, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730813185, 'PHP', 0, NULL),
(228, 98, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730813185, 'PHP', 0, NULL),
(229, 98, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730813185, 'PHP', 0, NULL),
(230, 98, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730813185, 'PHP', 0, NULL),
(231, 99, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730813205, 'PHP', 0, NULL),
(232, 99, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730813205, 'PHP', 0, NULL),
(233, 99, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730813205, 'PHP', 0, NULL),
(234, 99, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730813205, 'PHP', 0, NULL),
(235, 99, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730813205, 'PHP', 0, NULL),
(236, 100, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$platformID - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 61', 1730813225, 'PHP', 0, NULL),
(237, 100, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_design - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 100', 1730813225, 'PHP', 0, NULL),
(238, 100, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$enable_on_execution - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\8e5f31897e5a22e6477e20164e2b471a7a17089e_0.file.platformsEdit.tpl.php - Line 108', 1730813225, 'PHP', 0, NULL),
(239, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$tplan_id - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 100', 1730813244, 'PHP', 0, NULL),
(240, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730813244, 'PHP', 0, NULL),
(241, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730813244, 'PHP', 0, NULL),
(242, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730813244, 'PHP', 0, NULL),
(243, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730813244, 'PHP', 0, NULL),
(244, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 159', 1730813244, 'PHP', 0, NULL),
(245, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 160', 1730813244, 'PHP', 0, NULL),
(246, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 185', 1730813244, 'PHP', 0, NULL),
(247, 101, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: active_click_to_change - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\f725525b864bca3d12badfbe86cc4064c1a368d5_0.file.platformsView.tpl.php - Line 186', 1730813244, 'PHP', 0, NULL),
(248, 102, 32, 'GUI - Projeto de Teste ID : 5', 'string \'without_platforms\' is not localized for locale \'pt_BR\'  - using en_GB', 1730813489, 'LOCALIZATION', 0, NULL),
(249, 102, 32, 'GUI - Projeto de Teste ID : 5', 'string \'exec_tree_counters_logic\' is not localized for locale \'pt_BR\'  - using en_GB', 1730813489, 'LOCALIZATION', 0, NULL),
(250, 102, 32, 'GUI - Projeto de Teste ID : 5', 'string \'platforms\' is not localized for locale \'pt_BR\'  - using en_GB', 1730813489, 'LOCALIZATION', 0, NULL),
(251, 102, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730813489, 'PHP', 0, NULL),
(252, 103, 32, 'GUI - Projeto de Teste ID : 5', 'string \'file_upload_ko\' is not localized for locale \'pt_BR\'  - using en_GB', 1730813489, 'LOCALIZATION', 0, NULL),
(253, 103, 32, 'GUI - Projeto de Teste ID : 5', 'string \'allowed_files\' is not localized for locale \'pt_BR\'  - using en_GB', 1730813489, 'LOCALIZATION', 0, NULL),
(254, 103, 32, 'GUI - Projeto de Teste ID : 5', 'string \'allowed_filenames_regexp\' is not localized for locale \'pt_BR\'  - using en_GB', 1730813489, 'LOCALIZATION', 0, NULL),
(255, 104, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730813498, 'PHP', 0, NULL),
(256, 105, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730813768, 'PHP', 0, NULL),
(257, 106, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730813786, 'PHP', 0, NULL),
(258, 107, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730813822, 'PHP', 0, NULL),
(259, 108, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730813847, 'PHP', 0, NULL),
(260, 108, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730813847, 'PHP', 0, NULL),
(261, 109, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730813847, 'PHP', 0, NULL),
(262, 110, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\testcase.class.php - Line 5364', 1730813999, 'PHP', 0, NULL),
(263, 111, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\testcase.class.php - Line 5364', 1730814038, 'PHP', 0, NULL),
(264, 111, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730814038, 'PHP', 0, NULL),
(265, 111, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nTrying to access array offset on value of type null - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\functions\\tree.class.php - Line 733', 1730814038, 'PHP', 0, NULL),
(266, 111, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\testcases\\testcaseCommands.class.php - Line 1163', 1730814038, 'PHP', 0, NULL),
(267, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'updateLinkToThisTCVersion\' is not localized for locale \'pt_BR\'  - using en_GB', 1730814038, 'LOCALIZATION', 0, NULL),
(268, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'btn_new_version_from_latest\' is not localized for locale \'pt_BR\'  - using en_GB', 1730814038, 'LOCALIZATION', 0, NULL),
(269, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'createKW\' is not localized for locale \'pt_BR\'  - using en_GB', 1730814038, 'LOCALIZATION', 0, NULL),
(270, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'btn_create_and_link\' is not localized for locale \'pt_BR\'  - using en_GB', 1730814038, 'LOCALIZATION', 0, NULL),
(271, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'img_title_remove_platform\' is not localized for locale \'pt_BR\' ', 1730814038, 'LOCALIZATION', 0, NULL),
(272, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'select_platforms\' is not localized for locale \'pt_BR\'  - using en_GB', 1730814038, 'LOCALIZATION', 0, NULL),
(273, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'remove_plat_msgbox_msg\' is not localized for locale \'pt_BR\' ', 1730814038, 'LOCALIZATION', 0, NULL),
(274, 111, 32, 'GUI - Projeto de Teste ID : 5', 'string \'remove_plat_msgbox_title\' is not localized for locale \'pt_BR\' ', 1730814038, 'LOCALIZATION', 0, NULL),
(275, 112, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined index: size - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\gui\\templates_c\\760998d1c8f11baa9ee81fc2655b3b62181ae1b5_0.file.inc_filter_panel.tpl.php - Line 351', 1730814038, 'PHP', 0, NULL),
(276, 113, 2, 'GUI - Projeto de Teste ID : 5', 'E_NOTICE\nUndefined property: stdClass::$uploadOp - in C:\\Bitnami\\testlink-1.9.20-15\\apps\\testlink\\htdocs\\lib\\testcases\\testcaseCommands.class.php - Line 1163', 1730814142, 'PHP', 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `executions`
--

DROP TABLE IF EXISTS `executions`;
CREATE TABLE `executions` (
  `id` int(10) UNSIGNED NOT NULL,
  `build_id` int(10) NOT NULL DEFAULT 0,
  `tester_id` int(10) UNSIGNED DEFAULT NULL,
  `execution_ts` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tcversion_number` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  `execution_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `execution_bugs`
--

DROP TABLE IF EXISTS `execution_bugs`;
CREATE TABLE `execution_bugs` (
  `execution_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `bug_id` varchar(64) NOT NULL DEFAULT '0',
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `execution_tcsteps`
--

DROP TABLE IF EXISTS `execution_tcsteps`;
CREATE TABLE `execution_tcsteps` (
  `id` int(10) UNSIGNED NOT NULL,
  `execution_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `execution_tcsteps_wip`
--

DROP TABLE IF EXISTS `execution_tcsteps_wip`;
CREATE TABLE `execution_tcsteps_wip` (
  `id` int(10) UNSIGNED NOT NULL,
  `tcstep_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `build_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tester_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `exec_by_date_time`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `exec_by_date_time`;
CREATE TABLE `exec_by_date_time` (
`testplan_name` varchar(100)
,`yyyy_mm_dd` varchar(10)
,`yyyy_mm` varchar(7)
,`hh` varchar(7)
,`hour` varchar(7)
,`id` int(10) unsigned
,`build_id` int(10)
,`tester_id` int(10) unsigned
,`execution_ts` datetime
,`status` char(1)
,`testplan_id` int(10) unsigned
,`tcversion_id` int(10) unsigned
,`tcversion_number` smallint(5) unsigned
,`platform_id` int(10) unsigned
,`execution_type` tinyint(1)
,`execution_duration` decimal(6,2)
,`notes` text
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `inventory`
--

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `ipaddress` varchar(255) NOT NULL,
  `content` text DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modification_ts` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `issuetrackers`
--

DROP TABLE IF EXISTS `issuetrackers`;
CREATE TABLE `issuetrackers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `keywords`
--

DROP TABLE IF EXISTS `keywords`;
CREATE TABLE `keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_exec_by_context`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_exec_by_context`;
CREATE TABLE `latest_exec_by_context` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`build_id` int(10)
,`platform_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_exec_by_testplan`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_exec_by_testplan`;
CREATE TABLE `latest_exec_by_testplan` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_exec_by_testplan_plat`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`;
CREATE TABLE `latest_exec_by_testplan_plat` (
`tcversion_id` int(10) unsigned
,`testplan_id` int(10) unsigned
,`platform_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_req_version`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_req_version`;
CREATE TABLE `latest_req_version` (
`req_id` int(10) unsigned
,`version` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_req_version_id`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_req_version_id`;
CREATE TABLE `latest_req_version_id` (
`req_id` int(10) unsigned
,`version` smallint(5) unsigned
,`req_version_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_rspec_revision`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_rspec_revision`;
CREATE TABLE `latest_rspec_revision` (
`req_spec_id` int(10) unsigned
,`testproject_id` int(10) unsigned
,`revision` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_tcase_version_id`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_tcase_version_id`;
CREATE TABLE `latest_tcase_version_id` (
`testcase_id` int(10) unsigned
,`version` smallint(5) unsigned
,`tcversion_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `latest_tcase_version_number`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `latest_tcase_version_number`;
CREATE TABLE `latest_tcase_version_number` (
`testcase_id` int(10) unsigned
,`version` smallint(5) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `milestones`
--

DROP TABLE IF EXISTS `milestones`;
CREATE TABLE `milestones` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `target_date` date NOT NULL,
  `start_date` date DEFAULT NULL,
  `a` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `b` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `c` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT 'undefined'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `nodes_hierarchy`
--

DROP TABLE IF EXISTS `nodes_hierarchy`;
CREATE TABLE `nodes_hierarchy` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `node_type_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `node_order` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `nodes_hierarchy`
--

INSERT INTO `nodes_hierarchy` (`id`, `name`, `parent_id`, `node_type_id`, `node_order`) VALUES
(1, 'ProjetoEscola', NULL, 1, 1),
(2, 'PlanoEscola', 1, 5, 0),
(3, 'ProjetoRH', NULL, 1, 1),
(4, 'PlanoFolhaRH', 3, 5, 0),
(5, 'ProjetoLojaVirtual', NULL, 1, 1),
(6, 'PlanoLVirtual', 5, 5, 0),
(7, 'ProjetoAppdelivery', NULL, 1, 1),
(8, 'PlanoDelivery', 7, 5, 0),
(9, 'ProjetoClinVet', NULL, 1, 1),
(10, 'PlanoVetShop', 9, 5, 0),
(19, 'Cadastro de clientes', 5, 2, 1),
(20, 'Validar cadastro de cliente', 19, 3, 1000),
(21, '', 20, 4, 0),
(22, '', 21, 9, 0),
(23, '', 21, 9, 0),
(24, '', 21, 9, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `node_types`
--

DROP TABLE IF EXISTS `node_types`;
CREATE TABLE `node_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT 'testproject'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `node_types`
--

INSERT INTO `node_types` (`id`, `description`) VALUES
(1, 'testproject'),
(2, 'testsuite'),
(3, 'testcase'),
(4, 'testcase_version'),
(5, 'testplan'),
(6, 'requirement_spec'),
(7, 'requirement'),
(8, 'requirement_version'),
(9, 'testcase_step'),
(10, 'requirement_revision'),
(11, 'requirement_spec_revision'),
(12, 'build'),
(13, 'platform'),
(14, 'user');

-- --------------------------------------------------------

--
-- Estrutura da tabela `object_keywords`
--

DROP TABLE IF EXISTS `object_keywords`;
CREATE TABLE `object_keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `fk_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `fk_table` varchar(30) DEFAULT '',
  `keyword_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `platforms`
--

DROP TABLE IF EXISTS `platforms`;
CREATE TABLE `platforms` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `notes` text NOT NULL,
  `enable_on_design` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `enable_on_execution` tinyint(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `platforms`
--

INSERT INTO `platforms` (`id`, `name`, `testproject_id`, `notes`, `enable_on_design`, `enable_on_execution`) VALUES
(1, 'SISTEMA WEB 1.1', 5, '<p>sISTEMA DEVER&Aacute; FUNCIONAR ON LINE</p>', 1, 1),
(2, 'sistema web2', 5, '<p>Sistema para gerenciamento de sistema web</p>', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `plugins`
--

DROP TABLE IF EXISTS `plugins`;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL,
  `basename` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `plugins_configuration`
--

DROP TABLE IF EXISTS `plugins_configuration`;
CREATE TABLE `plugins_configuration` (
  `id` int(11) NOT NULL,
  `testproject_id` int(11) NOT NULL,
  `config_key` varchar(255) NOT NULL,
  `config_type` int(11) NOT NULL,
  `config_value` varchar(255) NOT NULL,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `reqmgrsystems`
--

DROP TABLE IF EXISTS `reqmgrsystems`;
CREATE TABLE `reqmgrsystems` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` int(10) DEFAULT 0,
  `cfg` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `requirements`
--

DROP TABLE IF EXISTS `requirements`;
CREATE TABLE `requirements` (
  `id` int(10) UNSIGNED NOT NULL,
  `srs_id` int(10) UNSIGNED NOT NULL,
  `req_doc_id` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `req_coverage`
--

DROP TABLE IF EXISTS `req_coverage`;
CREATE TABLE `req_coverage` (
  `id` int(10) UNSIGNED NOT NULL,
  `req_id` int(10) NOT NULL,
  `req_version_id` int(10) NOT NULL,
  `testcase_id` int(10) NOT NULL,
  `tcversion_id` int(10) NOT NULL,
  `link_status` int(11) NOT NULL DEFAULT 1,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `review_requester_id` int(10) UNSIGNED DEFAULT NULL,
  `review_request_ts` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='relation test case version ** requirement version';

-- --------------------------------------------------------

--
-- Estrutura da tabela `req_monitor`
--

DROP TABLE IF EXISTS `req_monitor`;
CREATE TABLE `req_monitor` (
  `req_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `testproject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `req_relations`
--

DROP TABLE IF EXISTS `req_relations`;
CREATE TABLE `req_relations` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_id` int(10) UNSIGNED NOT NULL,
  `destination_id` int(10) UNSIGNED NOT NULL,
  `relation_type` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `req_revisions`
--

DROP TABLE IF EXISTS `req_revisions`;
CREATE TABLE `req_revisions` (
  `parent_id` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `req_doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `expected_coverage` int(10) NOT NULL DEFAULT 1,
  `log_message` text DEFAULT NULL,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `req_specs`
--

DROP TABLE IF EXISTS `req_specs`;
CREATE TABLE `req_specs` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `doc_id` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dev. Documents (e.g. System Requirements Specification)';

-- --------------------------------------------------------

--
-- Estrutura da tabela `req_specs_revisions`
--

DROP TABLE IF EXISTS `req_specs_revisions`;
CREATE TABLE `req_specs_revisions` (
  `parent_id` int(10) UNSIGNED NOT NULL,
  `id` int(10) UNSIGNED NOT NULL,
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `doc_id` varchar(64) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `total_req` int(10) NOT NULL DEFAULT 0,
  `status` int(10) UNSIGNED DEFAULT 1,
  `type` char(1) DEFAULT NULL,
  `log_message` text DEFAULT NULL,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `req_versions`
--

DROP TABLE IF EXISTS `req_versions`;
CREATE TABLE `req_versions` (
  `id` int(10) UNSIGNED NOT NULL,
  `version` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `revision` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `scope` text DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'V',
  `type` char(1) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `expected_coverage` int(10) NOT NULL DEFAULT 1,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `modifier_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  `log_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `rights`
--

DROP TABLE IF EXISTS `rights`;
CREATE TABLE `rights` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `rights`
--

INSERT INTO `rights` (`id`, `description`) VALUES
(53, 'cfield_assignment'),
(18, 'cfield_management'),
(17, 'cfield_view'),
(51, 'codetracker_management'),
(52, 'codetracker_view'),
(56, 'delete_frozen_tcversion'),
(22, 'events_mgt'),
(54, 'exec_assign_testcases'),
(36, 'exec_delete'),
(35, 'exec_edit_notes'),
(49, 'exec_ro_access'),
(41, 'exec_testcases_assigned_to_me'),
(31, 'issuetracker_management'),
(32, 'issuetracker_view'),
(29, 'keyword_assignment'),
(9, 'mgt_modify_key'),
(12, 'mgt_modify_product'),
(11, 'mgt_modify_req'),
(7, 'mgt_modify_tc'),
(48, 'mgt_plugins'),
(16, 'mgt_testplan_create'),
(30, 'mgt_unfreeze_req'),
(13, 'mgt_users'),
(20, 'mgt_view_events'),
(8, 'mgt_view_key'),
(10, 'mgt_view_req'),
(6, 'mgt_view_tc'),
(21, 'mgt_view_usergroups'),
(50, 'monitor_requirement'),
(24, 'platform_management'),
(25, 'platform_view'),
(26, 'project_inventory_management'),
(27, 'project_inventory_view'),
(33, 'reqmgrsystem_management'),
(34, 'reqmgrsystem_view'),
(28, 'req_tcase_link_management'),
(14, 'role_management'),
(19, 'system_configuration'),
(47, 'testcase_freeze'),
(43, 'testplan_add_remove_platforms'),
(2, 'testplan_create_build'),
(1, 'testplan_execute'),
(3, 'testplan_metrics'),
(40, 'testplan_milestone_overview'),
(4, 'testplan_planning'),
(45, 'testplan_set_urgent_testcases'),
(46, 'testplan_show_testcases_newest_versions'),
(37, 'testplan_unlink_executed_testcases'),
(44, 'testplan_update_linked_testcase_versions'),
(5, 'testplan_user_role_assignment'),
(55, 'testproject_add_remove_keywords_executed_tcversions'),
(38, 'testproject_delete_executed_testcases'),
(39, 'testproject_edit_executed_testcases'),
(42, 'testproject_metrics_dashboard'),
(23, 'testproject_user_role_assignment'),
(15, 'user_role_assignment');

-- --------------------------------------------------------

--
-- Estrutura da tabela `risk_assignments`
--

DROP TABLE IF EXISTS `risk_assignments`;
CREATE TABLE `risk_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `node_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `risk` char(1) NOT NULL DEFAULT '2',
  `importance` char(1) NOT NULL DEFAULT 'M'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(100) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `roles`
--

INSERT INTO `roles` (`id`, `description`, `notes`) VALUES
(1, '<reserved system role 1>', NULL),
(2, '<reserved system role 2>', NULL),
(3, '<no rights>', NULL),
(4, 'test designer', NULL),
(5, 'guest', NULL),
(6, 'senior tester', NULL),
(7, 'tester', NULL),
(8, 'admin', NULL),
(9, 'leader', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `role_rights`
--

DROP TABLE IF EXISTS `role_rights`;
CREATE TABLE `role_rights` (
  `role_id` int(10) NOT NULL DEFAULT 0,
  `right_id` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `role_rights`
--

INSERT INTO `role_rights` (`role_id`, `right_id`) VALUES
(4, 3),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(4, 11),
(4, 28),
(4, 29),
(4, 30),
(4, 50),
(5, 3),
(5, 6),
(5, 8),
(6, 1),
(6, 2),
(6, 3),
(6, 6),
(6, 7),
(6, 8),
(6, 9),
(6, 11),
(6, 25),
(6, 27),
(6, 28),
(6, 29),
(6, 30),
(6, 50),
(7, 1),
(7, 3),
(7, 6),
(7, 8),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 8),
(8, 9),
(8, 10),
(8, 11),
(8, 12),
(8, 13),
(8, 14),
(8, 15),
(8, 16),
(8, 17),
(8, 18),
(8, 19),
(8, 20),
(8, 21),
(8, 22),
(8, 23),
(8, 24),
(8, 25),
(8, 26),
(8, 27),
(8, 28),
(8, 29),
(8, 30),
(8, 31),
(8, 32),
(8, 33),
(8, 34),
(8, 35),
(8, 36),
(8, 37),
(8, 38),
(8, 39),
(8, 40),
(8, 41),
(8, 42),
(8, 43),
(8, 44),
(8, 45),
(8, 46),
(8, 47),
(8, 48),
(8, 50),
(8, 51),
(8, 52),
(8, 53),
(8, 54),
(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 5),
(9, 6),
(9, 7),
(9, 8),
(9, 9),
(9, 10),
(9, 11),
(9, 15),
(9, 16),
(9, 24),
(9, 25),
(9, 26),
(9, 27),
(9, 28),
(9, 29),
(9, 30),
(9, 47),
(9, 50);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tcsteps`
--

DROP TABLE IF EXISTS `tcsteps`;
CREATE TABLE `tcsteps` (
  `id` int(10) UNSIGNED NOT NULL,
  `step_number` int(11) NOT NULL DEFAULT 1,
  `actions` text DEFAULT NULL,
  `expected_results` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tcsteps`
--

INSERT INTO `tcsteps` (`id`, `step_number`, `actions`, `expected_results`, `active`, `execution_type`) VALUES
(22, 1, '<p>1- Acessar a tela de cadastro de cliente no<br />\r\nSite lojavirtual.com: P&aacute;gina Inicial&amp;gt;<br />\r\nClientes&amp;gt;Efetuar Cadastro;</p>\r\n', '<p>1- Sistema exibe a tela<br />\r\nde cadastro de clientes<br />\r\ncom os campos vazios;</p>\r\n', 1, 1),
(23, 2, '<p>2- Preencher os campos com dados v&aacute;lidos:<br />\r\n Nome<br />\r\n CPF<br />\r\n Telefone<br />\r\n Email</p>\r\n', '<p>2- Ap&oacute;s salvar o<br />\r\ncadastro exibe a<br />\r\nmensagem de sucesso<br />\r\n&rdquo;Cliente cadastrado&rdquo;</p>\r\n', 1, 1),
(24, 3, '', '', 1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `tcversions`
--

DROP TABLE IF EXISTS `tcversions`;
CREATE TABLE `tcversions` (
  `id` int(10) UNSIGNED NOT NULL,
  `tc_external_id` int(10) UNSIGNED DEFAULT NULL,
  `version` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `layout` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `status` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `summary` text DEFAULT NULL,
  `preconditions` text DEFAULT NULL,
  `importance` smallint(5) UNSIGNED NOT NULL DEFAULT 2,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `updater_id` int(10) UNSIGNED DEFAULT NULL,
  `modification_ts` datetime NOT NULL DEFAULT current_timestamp(),
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `execution_type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 -> manual, 2 -> automated',
  `estimated_exec_duration` decimal(6,2) DEFAULT NULL COMMENT 'NULL will be considered as NO DATA Provided by user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `tcversions`
--

INSERT INTO `tcversions` (`id`, `tc_external_id`, `version`, `layout`, `status`, `summary`, `preconditions`, `importance`, `author_id`, `creation_ts`, `updater_id`, `modification_ts`, `active`, `is_open`, `execution_type`, `estimated_exec_duration`) VALUES
(21, 2, 1, 1, 1, '', '<p>1- Usu&aacute;rio(administrador) cadastrado e autenticado no site</p>\r\n\r\n<p>lojavirtual.com<br />\r\n2- Usu&aacute;rio logado com perfil de administrador<br />\r\n3- Possuir CPF v&aacute;lido</p>\r\n', 3, 1, '2024-11-05 16:40:38', 1, '2024-11-05 13:42:22', 1, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `tcversions_without_keywords`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `tcversions_without_keywords`;
CREATE TABLE `tcversions_without_keywords` (
`testcase_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `tcversions_without_platforms`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `tcversions_without_platforms`;
CREATE TABLE `tcversions_without_platforms` (
`testcase_id` int(10) unsigned
,`id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `testcase_keywords`
--

DROP TABLE IF EXISTS `testcase_keywords`;
CREATE TABLE `testcase_keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `testcase_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `keyword_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testcase_platforms`
--

DROP TABLE IF EXISTS `testcase_platforms`;
CREATE TABLE `testcase_platforms` (
  `id` int(10) UNSIGNED NOT NULL,
  `testcase_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testcase_relations`
--

DROP TABLE IF EXISTS `testcase_relations`;
CREATE TABLE `testcase_relations` (
  `id` int(10) UNSIGNED NOT NULL,
  `source_id` int(10) UNSIGNED NOT NULL,
  `destination_id` int(10) UNSIGNED NOT NULL,
  `link_status` tinyint(1) NOT NULL DEFAULT 1,
  `relation_type` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testcase_script_links`
--

DROP TABLE IF EXISTS `testcase_script_links`;
CREATE TABLE `testcase_script_links` (
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `project_key` varchar(64) NOT NULL,
  `repository_name` varchar(64) NOT NULL,
  `code_path` varchar(255) NOT NULL,
  `branch_name` varchar(64) DEFAULT NULL,
  `commit_id` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testplans`
--

DROP TABLE IF EXISTS `testplans`;
CREATE TABLE `testplans` (
  `id` int(10) UNSIGNED NOT NULL,
  `testproject_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `is_open` tinyint(1) NOT NULL DEFAULT 1,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `api_key` varchar(64) NOT NULL DEFAULT '829a2ded3ed0829a2dedd8ab81dfa2c77e8235bc3ed0d8ab81dfa2c77e8235bc'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `testplans`
--

INSERT INTO `testplans` (`id`, `testproject_id`, `notes`, `active`, `is_open`, `is_public`, `api_key`) VALUES
(2, 1, '<p>O plano deve gerenciar cadastro de professores, alunos, matr&iacute;culas e cursos de uma escola de ensino fundamental</p>', 1, 1, 1, 'd8a4fc4df4f75425d572cc985eab62e8ce42201a6c09b40cb04b38b57c3180d6'),
(4, 3, '<p>O sistema deve ter funcion&aacute;rio cadastrado, usu&aacute;rios, cargos e ocorr&ecirc;ncias (aus&ecirc;ncias, horas extras) para efetuar o fechamento da foilha de pagamento.</p>', 1, 1, 1, '365df9dcf0b6913a92a19c2d406d57df022237a7cfe6b670e7d815226d2faba3'),
(6, 5, '<p>O sistema dever&aacute; gerenciar cadastro de clientes, produtos, vendas, pedidos e entregas.</p>\r\n\r\n<p>O sistema tem usu&aacute;rios com diferentes tipos de acesso para suas&nbsp;funcionalidades.</p>', 1, 1, 1, '0fadc7d83b868fb21c9cba36c1545d31341056eb6b831be2af48a7efcb66637d'),
(8, 7, '<p>O projeto precisa efetuar ter usu&aacute;rios com as seguintes funcionalidades:</p>\r\n\r\n<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n			<h3>&nbsp; &nbsp; &nbsp;ADMINISTRADOR</h3>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>GERENCIAR VENDA</td>\r\n		</tr>\r\n		<tr>\r\n			<td>GERENCIAR RELAT&Oacute;RIOS&nbsp;</td>\r\n		</tr>\r\n		<tr>\r\n			<td>GERENCIAR ENTREGAS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CADASTRAR ENTREGADOR</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\">\r\n	<tbody>\r\n		<tr>\r\n			<td><strong>CLIENTES</strong></td>\r\n		</tr>\r\n		<tr>\r\n			<td>EFETUAR COMPRAS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>MANUTE&Ccedil;&Atilde;O DE CADASTRO</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n			<p><strong>USU&Aacute;RIOS (PROPRIET&Aacute;RIOS DAS LOJAS</strong>)</p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td>CADASTRAR LOJAS</td>\r\n		</tr>\r\n		<tr>\r\n			<td>MANUTEN&Ccedil;&Atilde;O DE PRODUTOS</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>', 1, 1, 1, '9f5f148c3c7c72eac9c509be25e0b7e529ff95cf489c2569ffb2b8aeb34951d7'),
(10, 9, '<p>O sistema dever&aacute; gerenciar :</p>\r\n\r\n<p>- Manuten&ccedil;&atilde;o de veterin&aacute;rio;</p>\r\n\r\n<p>-Manuten&ccedil;&atilde;o de animais;</p>\r\n\r\n<p>-Cadastro&nbsp; de consultas;</p>\r\n\r\n<p>- Manuten&ccedil;&atilde;o de exames;</p>\r\n\r\n<p>- Manuten&ccedil;&atilde;o de clientes (respons&aacute;veis pelos animais)</p>', 1, 1, 1, '1810f745b0f00f4d71e38fa66ff1acecf89636f3956d84b7ca31d1d47d6669c8');

-- --------------------------------------------------------

--
-- Estrutura da tabela `testplan_platforms`
--

DROP TABLE IF EXISTS `testplan_platforms`;
CREATE TABLE `testplan_platforms` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL,
  `platform_id` int(10) UNSIGNED NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Connects a testplan with platforms';

--
-- Extraindo dados da tabela `testplan_platforms`
--

INSERT INTO `testplan_platforms` (`id`, `testplan_id`, `platform_id`, `active`) VALUES
(1, 6, 1, 1),
(2, 6, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `testplan_tcversions`
--

DROP TABLE IF EXISTS `testplan_tcversions`;
CREATE TABLE `testplan_tcversions` (
  `id` int(10) UNSIGNED NOT NULL,
  `testplan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `tcversion_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `node_order` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `urgency` smallint(5) NOT NULL DEFAULT 2,
  `platform_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testprojects`
--

DROP TABLE IF EXISTS `testprojects`;
CREATE TABLE `testprojects` (
  `id` int(10) UNSIGNED NOT NULL,
  `notes` text DEFAULT NULL,
  `color` varchar(12) NOT NULL DEFAULT '#9BD',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `option_reqs` tinyint(1) NOT NULL DEFAULT 0,
  `option_priority` tinyint(1) NOT NULL DEFAULT 0,
  `option_automation` tinyint(1) NOT NULL DEFAULT 0,
  `options` text DEFAULT NULL,
  `prefix` varchar(16) NOT NULL,
  `tc_counter` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1,
  `issue_tracker_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `code_tracker_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `reqmgr_integration_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `api_key` varchar(64) NOT NULL DEFAULT '0d8ab81dfa2c77e8235bc829a2ded3edfa2c78235bc829a27eded3ed0d8ab81d'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `testprojects`
--

INSERT INTO `testprojects` (`id`, `notes`, `color`, `active`, `option_reqs`, `option_priority`, `option_automation`, `options`, `prefix`, `tc_counter`, `is_public`, `issue_tracker_enabled`, `code_tracker_enabled`, `reqmgr_integration_enabled`, `api_key`) VALUES
(1, '<p>Projeto teste para gerenciamento de projeto escolar.</p>', '', 1, 0, 0, 0, 'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}', 'PrjEscola', 0, 1, 0, 0, 0, '420309723fa913ceacfc1a88f3eb426c4ec8a7b2e75af8178686259ae892c129'),
(3, '<p>O projeto tem como objetivo de gerenciar testes para folha de pagamento para um sistema de supermercado.<br />\r\nO sistema deve ter um cadastro de usu&aacute;rio, cargos, sal&aacute;rios, folha de pagamento e coorr&ecirc;ncias mensais.</p>', '', 1, 0, 0, 0, 'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}', 'PrRH', 0, 1, 0, 0, 0, 'dc31dd7ef62025dea5a1e3d7875227ba0045f00fadb5cd533705b71e6e1ff289'),
(5, '<p>O projeto tem como objetivo de gerenciar vendas e entregas para uma loja virtual de cosm&eacute;ticos.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>', '', 1, 0, 0, 0, 'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}', 'PrLVirt', 2, 1, 0, 0, 0, 'c3b5bd4279f746db38c3ba2f2afc2fa7ee5644ca05924ce8b4459a638cc02e21'),
(7, '<p>O projeto tem como objetivo gerenciar teste para um sistema de vendas e entrega de lanches utilizando aplica&ccedil;&otilde;es m&oacute;bile.</p>', '', 1, 0, 0, 0, 'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}', 'PDelivery', 0, 1, 0, 0, 0, 'a659c9084d6cf949b15d187336228d1a8bcda916d13a1610516b3d1cf71ac329'),
(9, '<p>O projeto dever&aacute; gerenciar testes para um clinica veterin&aacute;rio e petshop</p>', '', 1, 0, 0, 0, 'O:8:\"stdClass\":4:{s:19:\"requirementsEnabled\";i:0;s:19:\"testPriorityEnabled\";i:1;s:17:\"automationEnabled\";i:1;s:16:\"inventoryEnabled\";i:0;}', 'PVet', 0, 1, 0, 0, 0, '354508b0746eaa22c5e3459603c8b83fc2c6bd0ee8f0451948e5529313c9a44e');

-- --------------------------------------------------------

--
-- Estrutura da tabela `testproject_codetracker`
--

DROP TABLE IF EXISTS `testproject_codetracker`;
CREATE TABLE `testproject_codetracker` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `codetracker_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testproject_issuetracker`
--

DROP TABLE IF EXISTS `testproject_issuetracker`;
CREATE TABLE `testproject_issuetracker` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `issuetracker_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testproject_reqmgrsystem`
--

DROP TABLE IF EXISTS `testproject_reqmgrsystem`;
CREATE TABLE `testproject_reqmgrsystem` (
  `testproject_id` int(10) UNSIGNED NOT NULL,
  `reqmgrsystem_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `testsuites`
--

DROP TABLE IF EXISTS `testsuites`;
CREATE TABLE `testsuites` (
  `id` int(10) UNSIGNED NOT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `testsuites`
--

INSERT INTO `testsuites` (`id`, `details`) VALUES
(19, '<p>Suite para valida&ccedil;&atilde;o de clientes</p>\r\n');

-- --------------------------------------------------------

--
-- Estrutura da tabela `text_templates`
--

DROP TABLE IF EXISTS `text_templates`;
CREATE TABLE `text_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` smallint(5) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `template_data` text DEFAULT NULL,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_public` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Global Project Templates';

-- --------------------------------------------------------

--
-- Estrutura da tabela `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `entry_point` varchar(45) NOT NULL DEFAULT '',
  `start_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `end_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `session_id` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `transactions`
--

INSERT INTO `transactions` (`id`, `entry_point`, `start_time`, `end_time`, `user_id`, `session_id`) VALUES
(1, '/testlink/login.php', 1671025095, 1671025095, 1, 'cum21d9fakirmb791u24bnjkc8'),
(2, '/testlink/lib/project/projectEdit.php', 1671025095, 1671025095, 1, 'cum21d9fakirmb791u24bnjkc8'),
(3, '/testlink/login.php', 1671025327, 1671025327, 1, 'jsek9q81ojb6ihrcak6tg1hv7g'),
(4, '/testlink/lib/project/projectEdit.php', 1671025327, 1671025327, 1, 'jsek9q81ojb6ihrcak6tg1hv7g'),
(5, '/testlink/login.php', 1727963228, 1727963228, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(6, '/testlink/lib/project/projectEdit.php', 1727963229, 1727963230, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(7, '/testlink/lib/project/projectEdit.php', 1727963261, 1727963262, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(8, '/testlink/lib/general/mainPage.php', 1727963263, 1727963264, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(9, '/testlink/lib/usermanagement/userInfo.php', 1727963273, 1727963274, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(10, '/testlink/lib/usermanagement/userInfo.php', 1727963278, 1727963279, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(11, '/testlink/lib/plan/planEdit.php', 1727963383, 1727963383, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(12, '/testlink/lib/plan/planEdit.php', 1727963454, 1727963454, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(13, '/testlink/lib/plan/planEdit.php', 1727963473, 1727963474, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(14, '/testlink/logout.php', 1727963486, 1727963486, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(15, '/testlink/firstLogin.php', 1727963488, 1727963488, 0, NULL),
(16, '/testlink/firstLogin.php', 1727963538, 1727963538, 0, NULL),
(17, '/testlink/login.php', 1727963550, 1727963550, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(18, '/testlink/lib/usermanagement/userInfo.php', 1727963567, 1727963567, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(19, '/testlink/lib/usermanagement/userInfo.php', 1727963569, 1727963569, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(20, '/testlink/logout.php', 1727963584, 1727963584, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(21, '/testlink/login.php', 1727963590, 1727963590, 2, 'n8pflubnk97bbkl3k22h8qb1io'),
(22, '/testlink/logout.php', 1727963604, 1727963604, 2, 'n8pflubnk97bbkl3k22h8qb1io'),
(23, '/testlink/login.php', 1727963610, 1727963610, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(24, '/testlink/logout.php', 1727963641, 1727963641, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(25, '/testlink/login.php', 1727963647, 1727963647, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(26, '/testlink/lib/project/projectEdit.php', 1727963684, 1727963684, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(27, '/testlink/lib/project/projectEdit.php', 1727963788, 1727963788, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(28, '/testlink/lib/general/navBar.php', 1727963792, 1727963792, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(29, '/testlink/lib/plan/planEdit.php', 1727963795, 1727963795, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(30, '/testlink/lib/project/projectEdit.php', 1727963935, 1727963935, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(31, '/testlink/lib/plan/planEdit.php', 1727963940, 1727963940, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(32, '/testlink/lib/plan/planEdit.php', 1727964030, 1727964030, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(33, '/testlink/lib/project/projectEdit.php', 1727964249, 1727964249, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(34, '/testlink/lib/general/navBar.php', 1727964254, 1727964254, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(35, '/testlink/lib/plan/planEdit.php', 1727964258, 1727964258, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(36, '/testlink/lib/project/projectEdit.php', 1727964309, 1727964309, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(37, '/testlink/lib/plan/planEdit.php', 1727964327, 1727964327, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(38, '/testlink/lib/plan/planEdit.php', 1727964351, 1727964351, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(39, '/testlink/lib/project/projectEdit.php', 1727964533, 1727964533, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(40, '/testlink/lib/general/navBar.php', 1727964539, 1727964539, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(41, '/testlink/lib/plan/planEdit.php', 1727964543, 1727964543, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(42, '/testlink/lib/plan/planEdit.php', 1727965191, 1727965191, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(43, '/testlink/lib/project/projectEdit.php', 1727965331, 1727965331, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(44, '/testlink/lib/general/navBar.php', 1727965336, 1727965336, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(45, '/testlink/lib/plan/planEdit.php', 1727965352, 1727965352, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(46, '/testlink/lib/plan/planEdit.php', 1727965476, 1727965476, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(47, '/testlink/lib/plan/planEdit.php', 1727965497, 1727965497, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(48, '/testlink/lib/plan/planEdit.php', 1727965571, 1727965571, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(49, '/testlink/lib/plan/planEdit.php', 1727965585, 1727965585, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(50, '/testlink/lib/plan/planEdit.php', 1727965597, 1727965597, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(51, '/testlink/login.php', 1727969795, 1727969795, 1, 'n8pflubnk97bbkl3k22h8qb1io'),
(52, '/testlink/login.php', 1730733022, 1730733022, 1, 'n30utkta0sblablda0r8bcmd63'),
(53, '/testlink/login.php', 1730806630, 1730806630, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(54, '/testlink/lib/plan/planEdit.php', 1730807511, 1730807511, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(55, '/testlink/lib/plan/planEdit.php', 1730808395, 1730808395, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(56, '/testlink/lib/plan/buildView.php', 1730808450, 1730808450, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(57, '/testlink/lib/plan/buildEdit.php', 1730808453, 1730808453, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(58, '/testlink/lib/plan/buildEdit.php', 1730808477, 1730808477, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(59, '/testlink/lib/platforms/platformsView.php', 1730808542, 1730808542, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(60, '/testlink/lib/platforms/platformsEdit.php', 1730808549, 1730808549, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(61, '/testlink/lib/platforms/platformsEdit.php', 1730808590, 1730808590, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(62, '/testlink/lib/platforms/platformsView.php', 1730808791, 1730808791, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(63, '/testlink/lib/platforms/platformsView.php', 1730808843, 1730808843, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(64, '/testlink/lib/platforms/platformsView.php', 1730808861, 1730808861, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(65, '/testlink/lib/platforms/platformsEdit.php', 1730808863, 1730808863, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(66, '/testlink/lib/testcases/listTestCases.php', 1730808961, 1730808963, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(67, '/testlink/lib/testcases/containerEdit.php', 1730809021, 1730809021, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(68, '/testlink/lib/testcases/listTestCases.php', 1730809021, 1730809021, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(69, '/testlink/lib/testcases/tcEdit.php', 1730809172, 1730809172, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(70, '/testlink/lib/testcases/tcEdit.php', 1730809279, 1730809282, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(71, '/testlink/lib/testcases/listTestCases.php', 1730809282, 1730809282, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(72, '/testlink/lib/testcases/tcEdit.php', 1730809761, 1730809762, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(73, '/testlink/lib/testcases/listTestCases.php', 1730809824, 1730809824, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(74, '/testlink/lib/plan/planAddTCNavigator.php', 1730809845, 1730809845, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(75, '/testlink/lib/plan/planAddTC.php', 1730809848, 1730809849, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(76, '/testlink/lib/plan/planAddTCNavigator.php', 1730809873, 1730809873, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(77, '/testlink/lib/plan/planAddTC.php', 1730809875, 1730809875, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(78, '/testlink/lib/plan/planAddTC.php', 1730809875, 1730809875, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(79, '/testlink/lib/plan/planAddTC.php', 1730809892, 1730809892, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(80, '/testlink/lib/plan/planAddTCNavigator.php', 1730809892, 1730809892, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(81, '/testlink/lib/execute/execNavigator.php', 1730809910, 1730809910, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(82, '/testlink/lib/execute/execDashboard.php', 1730809910, 1730809911, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(83, '/testlink/lib/execute/execDashboard.php', 1730809911, 1730809911, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(84, '/testlink/lib/testcases/listTestCases.php', 1730810007, 1730810007, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(85, '/testlink/lib/testcases/listTestCases.php', 1730810046, 1730810046, 1, 'ullml3eeijo49oec1j51hi6vkm'),
(86, '/testlink/login.php', 1730810630, 1730810630, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(87, '/testlink/lib/plan/buildView.php', 1730812530, 1730812530, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(88, '/testlink/lib/plan/buildEdit.php', 1730812540, 1730812540, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(89, '/testlink/lib/plan/buildEdit.php', 1730812555, 1730812555, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(90, '/testlink/lib/plan/buildEdit.php', 1730812557, 1730812557, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(91, '/testlink/lib/plan/buildView.php', 1730812564, 1730812565, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(92, '/testlink/lib/plan/buildEdit.php', 1730812568, 1730812568, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(93, '/testlink/lib/platforms/platformsView.php', 1730812661, 1730812661, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(94, '/testlink/lib/platforms/platformsEdit.php', 1730812675, 1730812675, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(95, '/testlink/lib/platforms/platformsEdit.php', 1730812706, 1730812706, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(96, '/testlink/lib/platforms/platformsView.php', 1730813168, 1730813168, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(97, '/testlink/lib/platforms/platformsEdit.php', 1730813173, 1730813173, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(98, '/testlink/lib/platforms/platformsEdit.php', 1730813185, 1730813185, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(99, '/testlink/lib/platforms/platformsView.php', 1730813205, 1730813205, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(100, '/testlink/lib/platforms/platformsEdit.php', 1730813225, 1730813225, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(101, '/testlink/lib/platforms/platformsEdit.php', 1730813244, 1730813244, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(102, '/testlink/lib/testcases/listTestCases.php', 1730813489, 1730813489, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(103, '/testlink/lib/testcases/archiveData.php', 1730813489, 1730813489, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(104, '/testlink/lib/testcases/listTestCases.php', 1730813498, 1730813498, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(105, '/testlink/lib/testcases/listTestCases.php', 1730813768, 1730813768, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(106, '/testlink/lib/testcases/listTestCases.php', 1730813786, 1730813786, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(107, '/testlink/lib/testcases/listTestCases.php', 1730813822, 1730813822, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(108, '/testlink/lib/testcases/containerEdit.php', 1730813847, 1730813847, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(109, '/testlink/lib/testcases/listTestCases.php', 1730813847, 1730813847, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(110, '/testlink/lib/testcases/tcEdit.php', 1730813999, 1730813999, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(111, '/testlink/lib/testcases/tcEdit.php', 1730814038, 1730814038, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(112, '/testlink/lib/testcases/listTestCases.php', 1730814038, 1730814038, 1, 'dlfhfcml8vcb5540rn9lo9rshp'),
(113, '/testlink/lib/testcases/tcEdit.php', 1730814142, 1730814142, 1, 'dlfhfcml8vcb5540rn9lo9rshp');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `tsuites_tree_depth_2`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `tsuites_tree_depth_2`;
CREATE TABLE `tsuites_tree_depth_2` (
`prefix` varchar(16)
,`testproject_name` varchar(100)
,`level1_name` varchar(100)
,`level2_name` varchar(100)
,`testproject_id` int(10) unsigned
,`level1_id` int(10) unsigned
,`level2_id` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(100) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `role_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `email` varchar(100) NOT NULL DEFAULT '',
  `first` varchar(50) NOT NULL DEFAULT '',
  `last` varchar(50) NOT NULL DEFAULT '',
  `locale` varchar(10) NOT NULL DEFAULT 'en_GB',
  `default_testproject_id` int(10) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `script_key` varchar(32) DEFAULT NULL,
  `cookie_string` varchar(64) NOT NULL DEFAULT '',
  `auth_method` varchar(10) DEFAULT '',
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `expiration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User information';

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `role_id`, `email`, `first`, `last`, `locale`, `default_testproject_id`, `active`, `script_key`, `cookie_string`, `auth_method`, `creation_ts`, `expiration_date`) VALUES
(1, 'root', '$2y$10$Lix0n0OoKmSxQmFq9w79E.nq7OVQgfurFYc1UWDmqM7DHxYyFBviW', 8, 'user@example.com', 'UserName LastName', 'Administrator', 'pt_BR', NULL, 1, NULL, '1a9f5ff432da66703672a53d6e8a4776694f8cff5202b44a038ab2d38a50de73', '', '2022-12-14 13:37:15', NULL),
(2, 'user', '$2y$10$vZgM6QeMiWui.7j1AtHUZ.J2wZ18K5WeTQRi5.V6gSE1qh6X6A4By', 5, 'user@gmail.com', 'UsuarioTeste', 'UserTeste', 'pt_PT', NULL, 1, NULL, '59a823e09e437efc95b17df46690ee50ca386d4e9c07b55f687428c68f0b0616', '', '2024-10-03 13:52:18', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_assignments`
--

DROP TABLE IF EXISTS `user_assignments`;
CREATE TABLE `user_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `feature_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED DEFAULT 0,
  `build_id` int(10) UNSIGNED DEFAULT 0,
  `deadline_ts` datetime DEFAULT NULL,
  `assigner_id` int(10) UNSIGNED DEFAULT 0,
  `creation_ts` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` int(10) UNSIGNED DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_group`
--

DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_group_assign`
--

DROP TABLE IF EXISTS `user_group_assign`;
CREATE TABLE `user_group_assign` (
  `usergroup_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_testplan_roles`
--

DROP TABLE IF EXISTS `user_testplan_roles`;
CREATE TABLE `user_testplan_roles` (
  `user_id` int(10) NOT NULL DEFAULT 0,
  `testplan_id` int(10) NOT NULL DEFAULT 0,
  `role_id` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `user_testproject_roles`
--

DROP TABLE IF EXISTS `user_testproject_roles`;
CREATE TABLE `user_testproject_roles` (
  `user_id` int(10) NOT NULL DEFAULT 0,
  `testproject_id` int(10) NOT NULL DEFAULT 0,
  `role_id` int(10) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para vista `exec_by_date_time`
--
DROP TABLE IF EXISTS `exec_by_date_time`;

DROP VIEW IF EXISTS `exec_by_date_time`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `exec_by_date_time`  AS   (select `nhtpl`.`name` AS `testplan_name`,date_format(`e`.`execution_ts`,'%Y-%m-%d') AS `yyyy_mm_dd`,date_format(`e`.`execution_ts`,'%Y-%m') AS `yyyy_mm`,date_format(`e`.`execution_ts`,'%H') AS `hh`,date_format(`e`.`execution_ts`,'%k') AS `hour`,`e`.`id` AS `id`,`e`.`build_id` AS `build_id`,`e`.`tester_id` AS `tester_id`,`e`.`execution_ts` AS `execution_ts`,`e`.`status` AS `status`,`e`.`testplan_id` AS `testplan_id`,`e`.`tcversion_id` AS `tcversion_id`,`e`.`tcversion_number` AS `tcversion_number`,`e`.`platform_id` AS `platform_id`,`e`.`execution_type` AS `execution_type`,`e`.`execution_duration` AS `execution_duration`,`e`.`notes` AS `notes` from ((`executions` `e` join `testplans` `tpl` on(`tpl`.`id` = `e`.`testplan_id`)) join `nodes_hierarchy` `nhtpl` on(`nhtpl`.`id` = `tpl`.`id`)))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_exec_by_context`
--
DROP TABLE IF EXISTS `latest_exec_by_context`;

DROP VIEW IF EXISTS `latest_exec_by_context`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_context`  AS SELECT `executions`.`tcversion_id` AS `tcversion_id`, `executions`.`testplan_id` AS `testplan_id`, `executions`.`build_id` AS `build_id`, `executions`.`platform_id` AS `platform_id`, max(`executions`.`id`) AS `id` FROM `executions` GROUP BY `executions`.`tcversion_id`, `executions`.`testplan_id`, `executions`.`build_id`, `executions`.`platform_id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_exec_by_testplan`
--
DROP TABLE IF EXISTS `latest_exec_by_testplan`;

DROP VIEW IF EXISTS `latest_exec_by_testplan`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_testplan`  AS SELECT `executions`.`tcversion_id` AS `tcversion_id`, `executions`.`testplan_id` AS `testplan_id`, max(`executions`.`id`) AS `id` FROM `executions` GROUP BY `executions`.`tcversion_id`, `executions`.`testplan_id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_exec_by_testplan_plat`
--
DROP TABLE IF EXISTS `latest_exec_by_testplan_plat`;

DROP VIEW IF EXISTS `latest_exec_by_testplan_plat`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_exec_by_testplan_plat`  AS SELECT `executions`.`tcversion_id` AS `tcversion_id`, `executions`.`testplan_id` AS `testplan_id`, `executions`.`platform_id` AS `platform_id`, max(`executions`.`id`) AS `id` FROM `executions` GROUP BY `executions`.`tcversion_id`, `executions`.`testplan_id`, `executions`.`platform_id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_req_version`
--
DROP TABLE IF EXISTS `latest_req_version`;

DROP VIEW IF EXISTS `latest_req_version`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_req_version`  AS SELECT `rq`.`id` AS `req_id`, max(`rqv`.`version`) AS `version` FROM ((`nodes_hierarchy` `nhrqv` join `requirements` `rq` on(`rq`.`id` = `nhrqv`.`parent_id`)) join `req_versions` `rqv` on(`rqv`.`id` = `nhrqv`.`id`)) GROUP BY `rq`.`id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_req_version_id`
--
DROP TABLE IF EXISTS `latest_req_version_id`;

DROP VIEW IF EXISTS `latest_req_version_id`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_req_version_id`  AS SELECT `lrqvn`.`req_id` AS `req_id`, `lrqvn`.`version` AS `version`, `reqv`.`id` AS `req_version_id` FROM ((`latest_req_version` `lrqvn` join `nodes_hierarchy` `nhrqv` on(`nhrqv`.`parent_id` = `lrqvn`.`req_id`)) join `req_versions` `reqv` on(`reqv`.`id` = `nhrqv`.`id` and `reqv`.`version` = `lrqvn`.`version`)) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_rspec_revision`
--
DROP TABLE IF EXISTS `latest_rspec_revision`;

DROP VIEW IF EXISTS `latest_rspec_revision`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_rspec_revision`  AS SELECT `rsr`.`parent_id` AS `req_spec_id`, `rs`.`testproject_id` AS `testproject_id`, max(`rsr`.`revision`) AS `revision` FROM (`req_specs_revisions` `rsr` join `req_specs` `rs` on(`rs`.`id` = `rsr`.`parent_id`)) GROUP BY `rsr`.`parent_id`, `rs`.`testproject_id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_tcase_version_id`
--
DROP TABLE IF EXISTS `latest_tcase_version_id`;

DROP VIEW IF EXISTS `latest_tcase_version_id`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_tcase_version_id`  AS SELECT `ltcvn`.`testcase_id` AS `testcase_id`, `ltcvn`.`version` AS `version`, `tcv`.`id` AS `tcversion_id` FROM ((`latest_tcase_version_number` `ltcvn` join `nodes_hierarchy` `nhtcv` on(`nhtcv`.`parent_id` = `ltcvn`.`testcase_id`)) join `tcversions` `tcv` on(`tcv`.`id` = `nhtcv`.`id` and `tcv`.`version` = `ltcvn`.`version`)) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `latest_tcase_version_number`
--
DROP TABLE IF EXISTS `latest_tcase_version_number`;

DROP VIEW IF EXISTS `latest_tcase_version_number`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `latest_tcase_version_number`  AS SELECT `nh_tc`.`id` AS `testcase_id`, max(`tcv`.`version`) AS `version` FROM ((`nodes_hierarchy` `nh_tc` join `nodes_hierarchy` `nh_tcv` on(`nh_tcv`.`parent_id` = `nh_tc`.`id`)) join `tcversions` `tcv` on(`nh_tcv`.`id` = `tcv`.`id`)) GROUP BY `nh_tc`.`id` ;

-- --------------------------------------------------------

--
-- Estrutura para vista `tcversions_without_keywords`
--
DROP TABLE IF EXISTS `tcversions_without_keywords`;

DROP VIEW IF EXISTS `tcversions_without_keywords`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tcversions_without_keywords`  AS SELECT `nhtcv`.`parent_id` AS `testcase_id`, `nhtcv`.`id` AS `id` FROM `nodes_hierarchy` AS `nhtcv` WHERE `nhtcv`.`node_type_id` = 4 AND !exists(select 1 from `testcase_keywords` `tck` where `tck`.`tcversion_id` = `nhtcv`.`id` limit 1) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `tcversions_without_platforms`
--
DROP TABLE IF EXISTS `tcversions_without_platforms`;

DROP VIEW IF EXISTS `tcversions_without_platforms`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tcversions_without_platforms`  AS SELECT `nhtcv`.`parent_id` AS `testcase_id`, `nhtcv`.`id` AS `id` FROM `nodes_hierarchy` AS `nhtcv` WHERE `nhtcv`.`node_type_id` = 4 AND !exists(select 1 from `testcase_platforms` `tcpl` where `tcpl`.`tcversion_id` = `nhtcv`.`id` limit 1) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `tsuites_tree_depth_2`
--
DROP TABLE IF EXISTS `tsuites_tree_depth_2`;

DROP VIEW IF EXISTS `tsuites_tree_depth_2`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `tsuites_tree_depth_2`  AS SELECT `tprj`.`prefix` AS `prefix`, `nhtprj`.`name` AS `testproject_name`, `nhts_l1`.`name` AS `level1_name`, `nhts_l2`.`name` AS `level2_name`, `nhtprj`.`id` AS `testproject_id`, `nhts_l1`.`id` AS `level1_id`, `nhts_l2`.`id` AS `level2_id` FROM (((`testprojects` `tprj` join `nodes_hierarchy` `nhtprj` on(`tprj`.`id` = `nhtprj`.`id`)) left join `nodes_hierarchy` `nhts_l1` on(`nhts_l1`.`parent_id` = `nhtprj`.`id`)) left join `nodes_hierarchy` `nhts_l2` on(`nhts_l2`.`parent_id` = `nhts_l1`.`id`)) WHERE `nhtprj`.`node_type_id` = 1 AND `nhts_l1`.`node_type_id` = 2 AND `nhts_l2`.`node_type_id` = 2 ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `assignment_status`
--
ALTER TABLE `assignment_status`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `assignment_types`
--
ALTER TABLE `assignment_types`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attachments_idx1` (`fk_id`);

--
-- Índices para tabela `baseline_l1l2_context`
--
ALTER TABLE `baseline_l1l2_context`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `udx1_context` (`testplan_id`,`platform_id`,`creation_ts`);

--
-- Índices para tabela `baseline_l1l2_details`
--
ALTER TABLE `baseline_l1l2_details`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `udx1_details` (`context_id`,`top_tsuite_id`,`child_tsuite_id`,`status`);

--
-- Índices para tabela `builds`
--
ALTER TABLE `builds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`testplan_id`,`name`),
  ADD KEY `testplan_id` (`testplan_id`);

--
-- Índices para tabela `cfield_build_design_values`
--
ALTER TABLE `cfield_build_design_values`
  ADD PRIMARY KEY (`field_id`,`node_id`),
  ADD KEY `idx_cfield_build_design_values` (`node_id`);

--
-- Índices para tabela `cfield_design_values`
--
ALTER TABLE `cfield_design_values`
  ADD PRIMARY KEY (`field_id`,`node_id`),
  ADD KEY `idx_cfield_design_values` (`node_id`);

--
-- Índices para tabela `cfield_execution_values`
--
ALTER TABLE `cfield_execution_values`
  ADD PRIMARY KEY (`field_id`,`execution_id`,`testplan_id`,`tcversion_id`);

--
-- Índices para tabela `cfield_node_types`
--
ALTER TABLE `cfield_node_types`
  ADD PRIMARY KEY (`field_id`,`node_type_id`),
  ADD KEY `idx_custom_fields_assign` (`node_type_id`);

--
-- Índices para tabela `cfield_testplan_design_values`
--
ALTER TABLE `cfield_testplan_design_values`
  ADD PRIMARY KEY (`field_id`,`link_id`),
  ADD KEY `idx_cfield_tplan_design_val` (`link_id`);

--
-- Índices para tabela `cfield_testprojects`
--
ALTER TABLE `cfield_testprojects`
  ADD PRIMARY KEY (`field_id`,`testproject_id`);

--
-- Índices para tabela `codetrackers`
--
ALTER TABLE `codetrackers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `codetrackers_uidx1` (`name`);

--
-- Índices para tabela `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_custom_fields_name` (`name`);

--
-- Índices para tabela `db_version`
--
ALTER TABLE `db_version`
  ADD PRIMARY KEY (`version`);

--
-- Índices para tabela `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `fired_at` (`fired_at`);

--
-- Índices para tabela `executions`
--
ALTER TABLE `executions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `executions_idx1` (`testplan_id`,`tcversion_id`,`platform_id`,`build_id`),
  ADD KEY `executions_idx2` (`execution_type`),
  ADD KEY `executions_idx3` (`tcversion_id`);

--
-- Índices para tabela `execution_bugs`
--
ALTER TABLE `execution_bugs`
  ADD PRIMARY KEY (`execution_id`,`bug_id`,`tcstep_id`);

--
-- Índices para tabela `execution_tcsteps`
--
ALTER TABLE `execution_tcsteps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `execution_tcsteps_idx1` (`execution_id`,`tcstep_id`);

--
-- Índices para tabela `execution_tcsteps_wip`
--
ALTER TABLE `execution_tcsteps_wip`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `execution_tcsteps_wip_idx1` (`tcstep_id`,`testplan_id`,`platform_id`,`build_id`);

--
-- Índices para tabela `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_idx1` (`testproject_id`);

--
-- Índices para tabela `issuetrackers`
--
ALTER TABLE `issuetrackers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `issuetrackers_uidx1` (`name`);

--
-- Índices para tabela `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `keyword_testproject_id` (`keyword`,`testproject_id`),
  ADD KEY `testproject_id` (`testproject_id`),
  ADD KEY `keyword` (`keyword`);

--
-- Índices para tabela `milestones`
--
ALTER TABLE `milestones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_testplan_id` (`name`,`testplan_id`),
  ADD KEY `testplan_id` (`testplan_id`);

--
-- Índices para tabela `nodes_hierarchy`
--
ALTER TABLE `nodes_hierarchy`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid_m_nodeorder` (`parent_id`,`node_order`),
  ADD KEY `nodes_hierarchy_node_type_id` (`node_type_id`);

--
-- Índices para tabela `node_types`
--
ALTER TABLE `node_types`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `object_keywords`
--
ALTER TABLE `object_keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `udx01_object_keywords` (`fk_id`,`fk_table`,`keyword_id`);

--
-- Índices para tabela `platforms`
--
ALTER TABLE `platforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_platforms` (`testproject_id`,`name`);

--
-- Índices para tabela `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `plugins_configuration`
--
ALTER TABLE `plugins_configuration`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `reqmgrsystems`
--
ALTER TABLE `reqmgrsystems`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reqmgrsystems_uidx1` (`name`);

--
-- Índices para tabela `requirements`
--
ALTER TABLE `requirements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `requirements_req_doc_id` (`srs_id`,`req_doc_id`);

--
-- Índices para tabela `req_coverage`
--
ALTER TABLE `req_coverage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_coverage_full_link` (`req_id`,`req_version_id`,`testcase_id`,`tcversion_id`);

--
-- Índices para tabela `req_monitor`
--
ALTER TABLE `req_monitor`
  ADD PRIMARY KEY (`req_id`,`user_id`,`testproject_id`);

--
-- Índices para tabela `req_relations`
--
ALTER TABLE `req_relations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `req_revisions`
--
ALTER TABLE `req_revisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_revisions_uidx1` (`parent_id`,`revision`);

--
-- Índices para tabela `req_specs`
--
ALTER TABLE `req_specs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_spec_uk1` (`doc_id`,`testproject_id`),
  ADD KEY `testproject_id` (`testproject_id`);

--
-- Índices para tabela `req_specs_revisions`
--
ALTER TABLE `req_specs_revisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `req_specs_revisions_uidx1` (`parent_id`,`revision`);

--
-- Índices para tabela `req_versions`
--
ALTER TABLE `req_versions`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `rights`
--
ALTER TABLE `rights`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rights_descr` (`description`);

--
-- Índices para tabela `risk_assignments`
--
ALTER TABLE `risk_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `risk_assignments_tplan_node_id` (`testplan_id`,`node_id`);

--
-- Índices para tabela `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_rights_roles_descr` (`description`);

--
-- Índices para tabela `role_rights`
--
ALTER TABLE `role_rights`
  ADD PRIMARY KEY (`role_id`,`right_id`);

--
-- Índices para tabela `tcsteps`
--
ALTER TABLE `tcsteps`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tcversions`
--
ALTER TABLE `tcversions`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `testcase_keywords`
--
ALTER TABLE `testcase_keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx01_testcase_keywords` (`testcase_id`,`tcversion_id`,`keyword_id`),
  ADD KEY `idx02_testcase_keywords` (`tcversion_id`);

--
-- Índices para tabela `testcase_platforms`
--
ALTER TABLE `testcase_platforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx01_testcase_platform` (`testcase_id`,`tcversion_id`,`platform_id`),
  ADD KEY `idx02_testcase_platform` (`tcversion_id`);

--
-- Índices para tabela `testcase_relations`
--
ALTER TABLE `testcase_relations`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `testcase_script_links`
--
ALTER TABLE `testcase_script_links`
  ADD PRIMARY KEY (`tcversion_id`,`project_key`,`repository_name`,`code_path`);

--
-- Índices para tabela `testplans`
--
ALTER TABLE `testplans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `testplans_api_key` (`api_key`),
  ADD KEY `testplans_testproject_id_active` (`testproject_id`,`active`);

--
-- Índices para tabela `testplan_platforms`
--
ALTER TABLE `testplan_platforms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_testplan_platforms` (`testplan_id`,`platform_id`);

--
-- Índices para tabela `testplan_tcversions`
--
ALTER TABLE `testplan_tcversions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `testplan_tcversions_tplan_tcversion` (`testplan_id`,`tcversion_id`,`platform_id`);

--
-- Índices para tabela `testprojects`
--
ALTER TABLE `testprojects`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `testprojects_prefix` (`prefix`),
  ADD UNIQUE KEY `testprojects_api_key` (`api_key`),
  ADD KEY `testprojects_id_active` (`id`,`active`);

--
-- Índices para tabela `testproject_codetracker`
--
ALTER TABLE `testproject_codetracker`
  ADD PRIMARY KEY (`testproject_id`);

--
-- Índices para tabela `testproject_issuetracker`
--
ALTER TABLE `testproject_issuetracker`
  ADD PRIMARY KEY (`testproject_id`);

--
-- Índices para tabela `testproject_reqmgrsystem`
--
ALTER TABLE `testproject_reqmgrsystem`
  ADD PRIMARY KEY (`testproject_id`);

--
-- Índices para tabela `testsuites`
--
ALTER TABLE `testsuites`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `text_templates`
--
ALTER TABLE `text_templates`
  ADD UNIQUE KEY `idx_text_templates` (`type`,`title`);

--
-- Índices para tabela `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_login` (`login`),
  ADD UNIQUE KEY `users_cookie_string` (`cookie_string`);

--
-- Índices para tabela `user_assignments`
--
ALTER TABLE `user_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_assignments_feature_id` (`feature_id`);

--
-- Índices para tabela `user_group`
--
ALTER TABLE `user_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `idx_user_group` (`title`);

--
-- Índices para tabela `user_group_assign`
--
ALTER TABLE `user_group_assign`
  ADD UNIQUE KEY `idx_user_group_assign` (`usergroup_id`,`user_id`);

--
-- Índices para tabela `user_testplan_roles`
--
ALTER TABLE `user_testplan_roles`
  ADD PRIMARY KEY (`user_id`,`testplan_id`);

--
-- Índices para tabela `user_testproject_roles`
--
ALTER TABLE `user_testproject_roles`
  ADD PRIMARY KEY (`user_id`,`testproject_id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `assignment_status`
--
ALTER TABLE `assignment_status`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `assignment_types`
--
ALTER TABLE `assignment_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `attachments`
--
ALTER TABLE `attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `baseline_l1l2_context`
--
ALTER TABLE `baseline_l1l2_context`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `baseline_l1l2_details`
--
ALTER TABLE `baseline_l1l2_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `builds`
--
ALTER TABLE `builds`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `codetrackers`
--
ALTER TABLE `codetrackers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `events`
--
ALTER TABLE `events`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=277;

--
-- AUTO_INCREMENT de tabela `executions`
--
ALTER TABLE `executions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `execution_tcsteps`
--
ALTER TABLE `execution_tcsteps`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `execution_tcsteps_wip`
--
ALTER TABLE `execution_tcsteps_wip`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `issuetrackers`
--
ALTER TABLE `issuetrackers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `milestones`
--
ALTER TABLE `milestones`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `nodes_hierarchy`
--
ALTER TABLE `nodes_hierarchy`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `node_types`
--
ALTER TABLE `node_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `object_keywords`
--
ALTER TABLE `object_keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `platforms`
--
ALTER TABLE `platforms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `plugins_configuration`
--
ALTER TABLE `plugins_configuration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `reqmgrsystems`
--
ALTER TABLE `reqmgrsystems`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `req_coverage`
--
ALTER TABLE `req_coverage`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `req_relations`
--
ALTER TABLE `req_relations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `rights`
--
ALTER TABLE `rights`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT de tabela `risk_assignments`
--
ALTER TABLE `risk_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `testcase_keywords`
--
ALTER TABLE `testcase_keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `testcase_platforms`
--
ALTER TABLE `testcase_platforms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `testcase_relations`
--
ALTER TABLE `testcase_relations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `testplan_platforms`
--
ALTER TABLE `testplan_platforms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `testplan_tcversions`
--
ALTER TABLE `testplan_tcversions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `user_assignments`
--
ALTER TABLE `user_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `user_group`
--
ALTER TABLE `user_group`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

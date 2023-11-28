-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 27-Nov-2023 às 23:40
-- Versão do servidor: 10.4.27-MariaDB
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sistema`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `facilities`
--

CREATE TABLE `facilities` (
  `facility_id` int(11) NOT NULL,
  `facility_type_code` int(11) DEFAULT NULL,
  `access_count` int(11) DEFAULT NULL,
  `facility_name` varchar(255) NOT NULL,
  `facility_description` varchar(255) DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `facility_functional_areas`
--

CREATE TABLE `facility_functional_areas` (
  `functional_area_code` int(11) NOT NULL,
  `facility_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `functional_areas`
--

CREATE TABLE `functional_areas` (
  `functional_area_code` int(11) NOT NULL,
  `parent_functional_area_code` int(11) DEFAULT NULL,
  `functional_area_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ref_facility_types`
--

CREATE TABLE `ref_facility_types` (
  `facility_type_code` int(11) NOT NULL,
  `facility_type_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `roles`
--

CREATE TABLE `roles` (
  `role_code` int(11) NOT NULL,
  `role_description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `role_facility_access_rights`
--

CREATE TABLE `role_facility_access_rights` (
  `facility_id` int(11) NOT NULL,
  `role_code` int(11) NOT NULL,
  `CRUD_value` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `role_code` int(11) DEFAULT NULL,
  `user_first_name` varchar(255) NOT NULL,
  `user_last_name` varchar(255) NOT NULL,
  `user_login` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `other_details` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`facility_id`),
  ADD KEY `facility_type_code` (`facility_type_code`);

--
-- Índices para tabela `facility_functional_areas`
--
ALTER TABLE `facility_functional_areas`
  ADD PRIMARY KEY (`functional_area_code`,`facility_id`),
  ADD KEY `facility_id` (`facility_id`);

--
-- Índices para tabela `functional_areas`
--
ALTER TABLE `functional_areas`
  ADD PRIMARY KEY (`functional_area_code`),
  ADD KEY `parent_functional_area_code` (`parent_functional_area_code`);

--
-- Índices para tabela `ref_facility_types`
--
ALTER TABLE `ref_facility_types`
  ADD PRIMARY KEY (`facility_type_code`);

--
-- Índices para tabela `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_code`);

--
-- Índices para tabela `role_facility_access_rights`
--
ALTER TABLE `role_facility_access_rights`
  ADD PRIMARY KEY (`facility_id`,`role_code`),
  ADD KEY `role_code` (`role_code`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `role_code` (`role_code`);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `facilities`
--
ALTER TABLE `facilities`
  ADD CONSTRAINT `facilities_ibfk_1` FOREIGN KEY (`facility_type_code`) REFERENCES `ref_facility_types` (`facility_type_code`);

--
-- Limitadores para a tabela `facility_functional_areas`
--
ALTER TABLE `facility_functional_areas`
  ADD CONSTRAINT `facility_functional_areas_ibfk_1` FOREIGN KEY (`functional_area_code`) REFERENCES `functional_areas` (`functional_area_code`),
  ADD CONSTRAINT `facility_functional_areas_ibfk_2` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`facility_id`);

--
-- Limitadores para a tabela `functional_areas`
--
ALTER TABLE `functional_areas`
  ADD CONSTRAINT `functional_areas_ibfk_1` FOREIGN KEY (`parent_functional_area_code`) REFERENCES `functional_areas` (`functional_area_code`);

--
-- Limitadores para a tabela `role_facility_access_rights`
--
ALTER TABLE `role_facility_access_rights`
  ADD CONSTRAINT `role_facility_access_rights_ibfk_1` FOREIGN KEY (`facility_id`) REFERENCES `facilities` (`facility_id`),
  ADD CONSTRAINT `role_facility_access_rights_ibfk_2` FOREIGN KEY (`role_code`) REFERENCES `roles` (`role_code`);

--
-- Limitadores para a tabela `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_code`) REFERENCES `roles` (`role_code`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

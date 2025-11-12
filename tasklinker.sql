-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : mer. 12 nov. 2025 à 00:55
-- Version du serveur : 8.0.35
-- Version de PHP : 8.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `tasklinker`
--

-- --------------------------------------------------------

--
-- Structure de la table `creneau`
--

CREATE TABLE `creneau` (
  `id` int NOT NULL,
  `tache_id` int NOT NULL,
  `employe_id` int NOT NULL,
  `debut` datetime NOT NULL,
  `fin` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

CREATE TABLE `employe` (
  `id` int NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('chef_de_projet','collaborateur') NOT NULL,
  `type_contrat` varchar(255) DEFAULT NULL,
  `date_arrivee` date NOT NULL,
  `actif` tinyint(1) DEFAULT '1',
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `etiquette`
--

CREATE TABLE `etiquette` (
  `id` int NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `couleur` varchar(255) DEFAULT NULL,
  `projet_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

CREATE TABLE `projet` (
  `id` int NOT NULL,
  `nom` varchar(255) NOT NULL,
  `date_demarrage` date NOT NULL,
  `deadline` date NOT NULL,
  `archive` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `projet_employe`
--

CREATE TABLE `projet_employe` (
  `projet_id` int NOT NULL,
  `employe_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `statut`
--

CREATE TABLE `statut` (
  `id` int NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `projet_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tache`
--

CREATE TABLE `tache` (
  `id` int NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `description` text,
  `date_debut` datetime DEFAULT NULL,
  `date_fin` datetime DEFAULT NULL,
  `statut_id` int NOT NULL,
  `projet_id` int NOT NULL,
  `employe_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tache_etiquette`
--

CREATE TABLE `tache_etiquette` (
  `tache_id` int NOT NULL,
  `etiquette_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `creneau`
--
ALTER TABLE `creneau`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tache_id` (`tache_id`),
  ADD KEY `employe_id` (`employe_id`);

--
-- Index pour la table `employe`
--
ALTER TABLE `employe`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `etiquette`
--
ALTER TABLE `etiquette`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projet_id` (`projet_id`);

--
-- Index pour la table `projet`
--
ALTER TABLE `projet`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `projet_employe`
--
ALTER TABLE `projet_employe`
  ADD PRIMARY KEY (`projet_id`,`employe_id`),
  ADD KEY `employe_id` (`employe_id`);

--
-- Index pour la table `statut`
--
ALTER TABLE `statut`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projet_id` (`projet_id`);

--
-- Index pour la table `tache`
--
ALTER TABLE `tache`
  ADD PRIMARY KEY (`id`),
  ADD KEY `statut_id` (`statut_id`),
  ADD KEY `projet_id` (`projet_id`),
  ADD KEY `employe_id` (`employe_id`);

--
-- Index pour la table `tache_etiquette`
--
ALTER TABLE `tache_etiquette`
  ADD PRIMARY KEY (`tache_id`,`etiquette_id`),
  ADD KEY `etiquette_id` (`etiquette_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `creneau`
--
ALTER TABLE `creneau`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `employe`
--
ALTER TABLE `employe`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `etiquette`
--
ALTER TABLE `etiquette`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `projet`
--
ALTER TABLE `projet`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `statut`
--
ALTER TABLE `statut`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tache`
--
ALTER TABLE `tache`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `creneau`
--
ALTER TABLE `creneau`
  ADD CONSTRAINT `creneau_ibfk_1` FOREIGN KEY (`tache_id`) REFERENCES `tache` (`id`),
  ADD CONSTRAINT `creneau_ibfk_2` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `etiquette`
--
ALTER TABLE `etiquette`
  ADD CONSTRAINT `etiquette_ibfk_1` FOREIGN KEY (`projet_id`) REFERENCES `projet` (`id`);

--
-- Contraintes pour la table `projet_employe`
--
ALTER TABLE `projet_employe`
  ADD CONSTRAINT `projet_employe_ibfk_1` FOREIGN KEY (`projet_id`) REFERENCES `projet` (`id`),
  ADD CONSTRAINT `projet_employe_ibfk_2` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `statut`
--
ALTER TABLE `statut`
  ADD CONSTRAINT `statut_ibfk_1` FOREIGN KEY (`projet_id`) REFERENCES `projet` (`id`);

--
-- Contraintes pour la table `tache`
--
ALTER TABLE `tache`
  ADD CONSTRAINT `tache_ibfk_1` FOREIGN KEY (`statut_id`) REFERENCES `statut` (`id`),
  ADD CONSTRAINT `tache_ibfk_2` FOREIGN KEY (`projet_id`) REFERENCES `projet` (`id`),
  ADD CONSTRAINT `tache_ibfk_3` FOREIGN KEY (`employe_id`) REFERENCES `employe` (`id`);

--
-- Contraintes pour la table `tache_etiquette`
--
ALTER TABLE `tache_etiquette`
  ADD CONSTRAINT `tache_etiquette_ibfk_1` FOREIGN KEY (`tache_id`) REFERENCES `tache` (`id`),
  ADD CONSTRAINT `tache_etiquette_ibfk_2` FOREIGN KEY (`etiquette_id`) REFERENCES `etiquette` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

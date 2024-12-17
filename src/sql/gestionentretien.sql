-- Création de la base de données
CREATE DATABASE IF NOT EXISTS `gestionentretien` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `gestionentretien`;

-- Configuration initiale
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- --------------------------------------------------------
-- Structure de la table `avion`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `avion`;
CREATE TABLE IF NOT EXISTS `avion` (
  `immatriculation` varchar(20) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `modele` varchar(50) NOT NULL,
  PRIMARY KEY (`immatriculation`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------
-- Structure de la table `entretien`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `entretien`;
CREATE TABLE IF NOT EXISTS `entretien` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `immatriculation` varchar(20) DEFAULT NULL,
  `dateEntretien` date NOT NULL,
  `typeEntretien` varchar(20) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `idTechnicien` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idTechnicien` (`idTechnicien`),
  KEY `immatriculation` (`immatriculation`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------
-- Structure de la table `technicien`
-- --------------------------------------------------------

DROP TABLE IF EXISTS `technicien`;
CREATE TABLE IF NOT EXISTS `technicien` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `specialisation` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------
-- Insertion des données dans les tables
-- --------------------------------------------------------

-- Insertion des données dans la table `avion`
INSERT INTO `avion` (`immatriculation`, `nom`, `modele`) VALUES
('F-HBLA', 'Airbus A320', 'A320-200'),
('G-EZBZ', 'Boeing 737', '737-800'),
('D-ABCD', 'Cessna Citation', 'Citation XLS+'),
('N12345', 'Gulfstream G650', 'G650ER'),
('CS-DLH', 'Dassault Falcon', 'Falcon 7X');

-- Insertion des données dans la table `technicien`
INSERT INTO `technicien` (`id`, `nom`, `prenom`, `specialisation`) VALUES
(1, 'Dupont', 'Jean', 'Systèmes avioniques'),
(2, 'Smith', 'Alice', 'Moteurs'),
(3, 'Brown', 'Robert', 'Structures'),
(4, 'Lemoine', 'Clara', 'Maintenance générale'),
(5, 'García', 'Carlos', 'Hydraulique et carburant');

-- Insertion des données dans la table `entretien`
INSERT INTO `entretien` (`id`, `immatriculation`, `dateEntretien`, `typeEntretien`, `note`, `idTechnicien`) VALUES
(1, 'F-HBLA', '2024-01-15', 'Révision générale', 'Aucun problème détecté. Vérifications effectuées sur les systèmes avioniques et hydrauliques.', 1),
(2, 'G-EZBZ', '2024-02-20', 'Changement de moteur', 'Moteur droit remplacé. Test de performance effectué avec succès.', 2),
(3, 'D-ABCD', '2024-03-10', 'Inspection structurelle', 'Microfissures détectées sur l’aile droite. Réparations effectuées.', 3),
(4, 'N12345', '2024-04-05', 'Contrôle hydraulique', 'Révision des circuits hydrauliques. Aucun défaut majeur.', 5),
(5, 'CS-DLH', '2024-05-12', 'Révision générale', 'Entretien complet effectué. Tous les systèmes fonctionnent normalement.', 4);

-- Validation des transactions
COMMIT;

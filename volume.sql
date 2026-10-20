-- Ajoute 1 000 000 de clientes et clients pour mesurer un index sur customer.last_name.
-- À charger après schema.sql et seed.sql. Pour revenir à la petite base : recharger schema.sql puis seed.sql.
USE candle_shop;
SET NAMES utf8mb4;

-- Par défaut, MySQL arrête une CTE récursive à 1 000 tours
SET SESSION cte_max_recursion_depth = 1000000;

INSERT INTO customer (email, first_name, last_name, password_hash)
WITH RECURSIVE n (i) AS (
  SELECT 1
  UNION ALL
  SELECT i + 1 FROM n WHERE i < 1000000
)
SELECT
  CONCAT('client', i, '@exemple.fr'),
  ELT(1 + i % 20,
    'Inès', 'Lucas', 'Chloé', 'Hugo', 'Léa', 'Nathan', 'Manon', 'Théo', 'Jade', 'Louis',
    'Emma', 'Gabriel', 'Zoé', 'Arthur', 'Alice', 'Jules', 'Sarah', 'Adam', 'Lina', 'Paul'),
  -- 100 noms de famille, environ 10 000 personnes chacun ; aucun n'est celui d'une cliente de seed.sql
  ELT(1 + (i * 7) % 100,
    'Martin', 'Carpentier', 'Thomas', 'Petit', 'Robert', 'Richard', 'Durand', 'Deschamps', 'Hubert', 'Laurent',
    'Simon', 'Michel', 'Huet', 'Leroy', 'Boucher', 'David', 'Bertrand', 'Prévost', 'Fournier', 'Hamon',
    'Jacob', 'Dupont', 'Fleury', 'Charpentier', 'Rousseau', 'Vincent', 'Muller', 'Lefèvre', 'Germain', 'André',
    'Poirier', 'Collet', 'Guérin', 'Boyer', 'Lebrun', 'Breton', 'François', 'Legrand', 'Gauthier', 'Garcia',
    'Perrin', 'Robin', 'Clément', 'Morin', 'Nicolas', 'Henry', 'Roussel', 'Mathieu', 'Gautier', 'Masson',
    'Marchand', 'Duval', 'Denis', 'Dumont', 'Marie', 'Lemaire', 'Noël', 'Meyer', 'Dufour', 'Meunier',
    'Brun', 'Blanchard', 'Giraud', 'Joly', 'Rivière', 'Lucas', 'Brunet', 'Gaillard', 'Barbier', 'Arnaud',
    'Martinez', 'Gérard', 'Roche', 'Renard', 'Schmitt', 'Roy', 'Leroux', 'Colin', 'Vidal', 'Caron',
    'Picard', 'Roger', 'Fabre', 'Aubert', 'Lemoine', 'Renaud', 'Dumas', 'Lacroix', 'Olivier', 'Philippe',
    'Bourgeois', 'Pierre', 'Benoît', 'Rey', 'Leclerc', 'Payet', 'Rolland', 'Leclercq', 'Guillaume', 'Lecomte'),
  -- une seule empreinte bcrypt pour tout le monde : le volume sert à mesurer, pas à se connecter
  '$2a$10$mWhoMBaMsqWKKEtNUKZDmMP15T5Gaqae0.NfucJQ7KihfOQS/K5tB'
FROM n;

-- Met à jour les statistiques que MySQL consulte pour choisir son plan
ANALYZE TABLE customer;

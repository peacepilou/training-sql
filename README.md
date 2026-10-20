# training-sql : la base de la boutique de Camille

La base `candle_shop`, tirée du MPD du module Conception (chapitre 09), pour le module SQL.

| Fichier      | Contenu |
| ------------ | ------- |
| `schema.sql` | Supprime puis recrée la base `candle_shop` et ses 7 tables : `customer`, `candle`, `address`, `customer_order`, `order_line`, `review`, `favorite`. |
| `seed.sql`   | Les données de la boutique : 15 clientes et clients, 20 bougies, 17 adresses, 35 commandes et leurs 65 lignes, 25 avis, 20 favoris. Toutes les dates sont en 2026. |
| `volume.sql` | Ajoute 1 000 000 de clientes et clients pour mesurer un index sur `customer.last_name`. Environ 7 secondes. |

## Charger la base

Dans un terminal ouvert dans ce dossier, dans cet ordre :

```bash
mysql -u root -p < schema.sql
mysql -u root -p < seed.sql
```

Pour le chapitre sur les index seulement :

```bash
mysql -u root -p < volume.sql
```

Sous Windows, PowerShell refuse le `<`. Écris à la place :

```bash
mysql -u root -p -e "source schema.sql"
```

## Repartir de zéro

`schema.sql` efface toute la base. Recharge `schema.sql` puis `seed.sql` : tu retrouves la petite base, sans le million de lignes.

//********** Imports **********/
import { pool } from "./bdd";
import { Entretien } from "../utils/types/types";

//********** Model **********//
export const EntretienModel = {
  // Récupère tous les enregistrements de la table "entretien".
  getAll: async () => {
    let connection;
    try {
      connection = await pool.getConnection();
      const rows = await connection.query("SELECT * FROM entretien");
      return rows;
    } catch (error) {
      throw error;
    } finally {
      if (connection) connection.release();
    }
  },

  // Récupère un enregistrement d'entretien en fonction de son ID.
  getById: async (id: string) => {
    let connection;
    try {
      connection = await pool.getConnection();
      const rows = await connection.query(
        "SELECT * FROM entretien WHERE id = ?",
        [id]
      );
      return rows[0];
    } catch (error) {
      throw error;
    } finally {
      if (connection) connection.release();
    }
  },

  // Récupère les entretiens en fonction des filtres fournis (paramètres dynamiques).
  getWithFilters: async (
    params: Record<string, string | number | undefined>
  ) => {
    let connection;
    try {
      connection = await pool.getConnection();

      let query = "SELECT * FROM entretien";
      const conditions: string[] = [];

      Object.keys(params).forEach((key) => {
        if (params[key] !== undefined) {
          conditions.push(`${key} = ?`);
        }
      });

      if (conditions.length > 0) {
        query += " WHERE " + conditions.join(" AND ");
      }

      const rows = await connection.query(query, Object.values(params));
      return rows;
    } catch (error) {
      return error;
    } finally {
      if (connection) connection.release();
    }
  },

  // Ajoute un nouvel entretien dans la base de données.
  addOne: async (entretien: Entretien) => {
    let connection;
    try {
      connection = await pool.getConnection();
      const result = await connection.query(
        "INSERT INTO entretien (idTechnicien, immatriculation, dateEntretien, typeEntretien, note) VALUES (?, ?, ?, ?, ?)",
        [
          entretien.idTechnicien,
          entretien.immatriculation,
          entretien.dateEntretien,
          entretien.typeEntretien,
          entretien.note,
        ]
      );
      return result;
    } catch (error) {
      throw error;
    } finally {
      if (connection) connection.release();
    }
  },

  // Supprime un entretien en fonction de son ID.
  delete: async (id: string) => {
    let connection;
    try {
      connection = await pool.getConnection();
      const result = await connection.query(
        "DELETE FROM entretien WHERE id = ?",
        [id]
      );
      return result;
    } catch (error) {
      throw error;
    } finally {
      if (connection) connection.release();
    }
  },

  // Met à jour un entretien en fonction de son ID et des paramètres fournis.
  update: async (id: string, params: Record<string, any>) => {
    let connection;
    try {
      if (id) {
        let query = "UPDATE entretien SET ";
        const updates: string[] = [];

        // Construction dynamique de la requête SQL pour les colonnes à mettre à jour.
        Object.keys(params).forEach((item) => {
          if (item !== "id") {
            updates.push(`${item} = ?`);
          }
        });

        query += updates.join(", ") + " WHERE id = ?";
        const values = [
          ...Object.values(params).filter((value) => value !== undefined),
          id,
        ];

        connection = await pool.getConnection();
        const result = await connection.query(query, values);
        return result; 
      }
    } catch (error) {
      throw error;
    } finally {
      if (connection) connection.release();
    }
  },
};

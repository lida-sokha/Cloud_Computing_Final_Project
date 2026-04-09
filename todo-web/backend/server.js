import express, { json } from "express";
import cors from "cors";
import mysql from "mysql2";

const app = express();
app.use(cors());
app.use(json());

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "todo",
});

app.get("/tasks", (req, res) => {
  db.query("SELECT * FROM tasks", (err, result) => {
    if (err) return res.send(err);
    res.json(result);
  });
});

app.post("/tasks", (req, res) => {
  const { title } = req.body;
  db.query("INSERT INTO tasks (title) VALUES (?)", [title], (err) => {
    if (err) return res.send(err);
    res.send("Task added");
  });
});

app.put("/tasks/:id", (req, res) => {
  const { status } = req.body;
  db.query(
    "UPDATE tasks SET status=? WHERE id=?",
    [status, req.params.id],
    (err) => {
      if (err) return res.send(err);
      res.send("Updated");
    },
  );
});

app.delete("/tasks/:id", (req, res) => {
  db.query("DELETE FROM tasks WHERE id=?", [req.params.id], (err) => {
    if (err) return res.send(err);
    res.send("Deleted");
  });
});

app.listen(3000, () => console.log("Server running on port 3000"));

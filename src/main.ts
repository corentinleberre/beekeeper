import express from "express";
import { Request, Response } from "express";

const app = express();
const port = process.env.PORT || 3000;

const bees = (n: number): string => Array(n).fill("🐝").join("");

const getHives = (req: Request, res: Response): void => {
  const hives = {
    "🇫🇷": bees(150),
    "🇨🇦": bees(40),
    "🇯🇵": bees(10),
  };
  res.status(200).json(hives);
};

app.get("/api/hives", getHives);

app.listen(port, () =>
  console.log(`🍯 Beekeeper is running on http://localhost:${port}`)
);
